Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3C7B329D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjI2MdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjI2MdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:33:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C42D1AE;
        Fri, 29 Sep 2023 05:33:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA7D1FB;
        Fri, 29 Sep 2023 05:33:44 -0700 (PDT)
Received: from [10.57.66.194] (unknown [10.57.66.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6960C3F59C;
        Fri, 29 Sep 2023 05:33:04 -0700 (PDT)
Message-ID: <a140fb29-3b76-46b8-b7e8-0e89351ddfbd@arm.com>
Date:   Fri, 29 Sep 2023 13:33:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: MADV_COLLAPSE doesn't work for XFS files
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
References: <4d6c9b19-cdbb-4a00-9a40-5ed5c36332e5@arm.com>
 <ZRVbV6yJ-zFzRoas@debian.me> <54e5accf-1a56-495a-a4f5-d57504bc2fc8@arm.com>
 <CAAa6QmRbDbEamFgEDbgVhwKOf1GHNa90COuyz29BmduOAjbmyA@mail.gmail.com>
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAAa6QmRbDbEamFgEDbgVhwKOf1GHNa90COuyz29BmduOAjbmyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2023 20:43, Zach O'Keefe wrote:
> Hey Ryan,
> 
> Thanks for bringing this up.
> 
> On Thu, Sep 28, 2023 at 4:59 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 28/09/2023 11:54, Bagas Sanjaya wrote:
>>> On Thu, Sep 28, 2023 at 10:55:17AM +0100, Ryan Roberts wrote:
>>>> Hi all,
>>>>
>>>> I've just noticed that when applied to a file mapping for a file on xfs, MADV_COLLAPSE returns EINVAL. The same test case works fine if the file is on ext4.
>>>>
>>>> I think the root cause is that the implementation bails out if it finds a (non-PMD-sized) large folio in the page cache for any part of the file covered by the region. XFS does readahead into large folios so we hit this issue. See khugepaged.h:collapse_file():
>>>>
>>>>              if (PageTransCompound(page)) {
>>>>                      struct page *head = compound_head(page);
>>>>
>>>>                      result = compound_order(head) == HPAGE_PMD_ORDER &&
>>>>                                      head->index == start
>>>>                                      /* Maybe PMD-mapped */
>>>>                                      ? SCAN_PTE_MAPPED_HUGEPAGE
>>>>                                      : SCAN_PAGE_COMPOUND;
>>>>                      goto out_unlock;
>>>>              }
>>>
> 
> Ya, non-PMD-sized THPs were just barely visible in my peripherals when
> writing this, and I'm still woefully behind on your work on them now
> (sorry!).

Nothing to apologise for!

Although, this issue has no relation to the work I've been doing for anonymous large folios; It shows up for large _file_ folios. And it looks like the kernel was capable of doing large file folios for XFS before the collapse implementation went in, so I guess this behavior has always been the case:

git rev-list --no-walk=sorted --pretty=oneline \
	793917d997df2e432f3e9ac126e4482d68256d01 \
	6795801366da0cd3d99e27c37f020a8f16714886 \
	8549a26308f945bddb39391643eb102da026f0ef \
	e6687b89225ee9c817e6dcbadc873f6a4691e5c2 \
	7d8faaf155454f8798ec56404faca29a82689c77

7d8faaf155454f8798ec56404faca29a82689c77 mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse
793917d997df2e432f3e9ac126e4482d68256d01 mm/readahead: Add large folio readahead
6795801366da0cd3d99e27c37f020a8f16714886 xfs: Support large folios

So first, XFS supported it, then readahead actually started allocating large folios, then MADV_COLLAPSE came along.


> 
> I'd like to eventually make collapse (not just MADV_COLLAPSE, but
> khugepaged too) support arbitrary-sized large folios in general, but
> I'm very pressed for time right now. I think M. Wilcox is also
> interested in this, given he left the TODO to support it :P

Yes, I think this could be a useful capability. I'm currently investigating use of MADV_COLLAPSE as a work-around to get executable sections into large folios for file systems that don't natively support them (ext4 mainly). On arm64, having executable memory in 64K folios means we can make better use of the iTLB and improve performance.

> 
> Thank you for the reproducer though! I haven't run it, but I'll
> probably come back here to steal it when the time comes.
> 
>>> I don't see any hint to -EINVAL above. Am I missing something?
>>
>> The SCAN_PAGE_COMPOUND result ends up back at madvise_collapse() where it
>> eventually gets converted to -EINVAL by madvise_collapse_errno().
>>
>>>
>>>>
>>>> I'm not sure if this is already a known issue? I don't have time to work on a fix for this right now, so thought I would highlight it at least. I might get around to it at some point in the future if nobody else tackles it.
> 
> My guess is Q1 2024 is when I'd be able to look into this, at the
> current level of urgency. It doesn't sound like it's blocking anything
> for your work right now -- lmk if that changes though!

No - its not a blocker for me. I just wanted to highlight the issue.

> 
> Thanks,
> Zach
> 
> 
> 
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>> Test case I've been using:
>>>>
>>>> -->8--
>>>>
>>>> #include <stdio.h>
>>>> #include <stdlib.h>
>>>> #include <sys/mman.h>
>>>> #include <sys/types.h>
>>>> #include <sys/stat.h>
>>>> #include <fcntl.h>
>>>> #include <unistd.h>
>>>>
>>>> #ifndef MADV_COLLAPSE
>>>> #define MADV_COLLAPSE                25
>>>> #endif
>>>>
>>>> #define handle_error(msg)    do { perror(msg); exit(EXIT_FAILURE); } while (0)
>>>>
>>>> #define SZ_1K                        1024
>>>> #define SZ_1M                        (SZ_1K * SZ_1K)
>>>> #define ALIGN(val, align)    (((val) + ((align) - 1)) & ~((align) - 1))
>>>>
>>>> #if 1
>>>> // ext4
>>>> #define DATA_FILE            "/home/ubuntu/data.txt"
>>>> #else
>>>> // xfs
>>>> #define DATA_FILE            "/boot/data.txt"
>>>> #endif
>>>>
>>>> int main(void)
>>>> {
>>>>      int fd;
>>>>      char *mem;
>>>>      int ret;
>>>>
>>>>      fd = open(DATA_FILE, O_RDONLY);
>>>>      if (fd == -1)
>>>>              handle_error("open");
>>>>
>>>>      mem = mmap(NULL, SZ_1M * 4, PROT_READ | PROT_EXEC, MAP_PRIVATE, fd, 0);
>>>>      close(fd);
>>>>      if (mem == MAP_FAILED)
>>>>              handle_error("mmap");
>>>>
>>>>      printf("1: pid=%d, mem=%p\n", getpid(), mem);
>>>>      getchar();
>>>>
>>>>      mem = (char *)ALIGN((unsigned long)mem, SZ_1M * 2);
>>>>      ret = madvise(mem, SZ_1M * 2, MADV_COLLAPSE);
>>>>      if (ret)
>>>>              handle_error("madvise");
>>>>
>>>>      printf("2: pid=%d, mem=%p\n", getpid(), mem);
>>>>      getchar();
>>>>
>>>>      return 0;
>>>> }
>>>>
>>>> -->8--
>>>>
>>>
>>> Confused...
>>
>> This is a user space test case that shows the problem; data.txt needs to be at
>> least 4MB and on a mounted ext4 and xfs filesystem. By toggling the '#if 1' to
>> 0, you can see the different behaviours for ext4 and xfs -
>> handle_error("madvise") fires with EINVAL in the xfs case. The getchar()s are
>> leftovers from me looking at the smaps file.
>>

