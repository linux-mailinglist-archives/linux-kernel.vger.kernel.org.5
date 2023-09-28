Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B847B1B92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjI1L7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjI1L7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:59:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA0A121;
        Thu, 28 Sep 2023 04:59:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A25D51FB;
        Thu, 28 Sep 2023 05:00:24 -0700 (PDT)
Received: from [10.1.37.161] (XHFQ2J9959.cambridge.arm.com [10.1.37.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF6F23F5A1;
        Thu, 28 Sep 2023 04:59:44 -0700 (PDT)
Message-ID: <54e5accf-1a56-495a-a4f5-d57504bc2fc8@arm.com>
Date:   Thu, 28 Sep 2023 12:59:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: MADV_COLLAPSE doesn't work for XFS files
Content-Language: en-GB
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, zokeefe@google.com,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4d6c9b19-cdbb-4a00-9a40-5ed5c36332e5@arm.com>
 <ZRVbV6yJ-zFzRoas@debian.me>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZRVbV6yJ-zFzRoas@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2023 11:54, Bagas Sanjaya wrote:
> On Thu, Sep 28, 2023 at 10:55:17AM +0100, Ryan Roberts wrote:
>> Hi all,
>>
>> I've just noticed that when applied to a file mapping for a file on xfs, MADV_COLLAPSE returns EINVAL. The same test case works fine if the file is on ext4. 
>>
>> I think the root cause is that the implementation bails out if it finds a (non-PMD-sized) large folio in the page cache for any part of the file covered by the region. XFS does readahead into large folios so we hit this issue. See khugepaged.h:collapse_file():
>>
>> 		if (PageTransCompound(page)) {
>> 			struct page *head = compound_head(page);
>>
>> 			result = compound_order(head) == HPAGE_PMD_ORDER &&
>> 					head->index == start
>> 					/* Maybe PMD-mapped */
>> 					? SCAN_PTE_MAPPED_HUGEPAGE
>> 					: SCAN_PAGE_COMPOUND;
>> 			goto out_unlock;
>> 		}
> 
> I don't see any hint to -EINVAL above. Am I missing something?

The SCAN_PAGE_COMPOUND result ends up back at madvise_collapse() where it
eventually gets converted to -EINVAL by madvise_collapse_errno().

> 
>>
>> I'm not sure if this is already a known issue? I don't have time to work on a fix for this right now, so thought I would highlight it at least. I might get around to it at some point in the future if nobody else tackles it.
>>
>> Thanks,
>> Ryan
>>
>>
>> Test case I've been using:
>>
>> -->8--
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <sys/mman.h>
>> #include <sys/types.h>
>> #include <sys/stat.h>
>> #include <fcntl.h>
>> #include <unistd.h>
>>
>> #ifndef MADV_COLLAPSE
>> #define MADV_COLLAPSE		25
>> #endif
>>
>> #define handle_error(msg) 	do { perror(msg); exit(EXIT_FAILURE); } while (0)
>>
>> #define SZ_1K			1024
>> #define SZ_1M			(SZ_1K * SZ_1K)
>> #define ALIGN(val, align)	(((val) + ((align) - 1)) & ~((align) - 1))
>>
>> #if 1
>> // ext4
>> #define DATA_FILE		"/home/ubuntu/data.txt"
>> #else
>> // xfs
>> #define DATA_FILE		"/boot/data.txt"
>> #endif
>>
>> int main(void)
>> {
>> 	int fd;
>> 	char *mem;
>> 	int ret;
>>
>> 	fd = open(DATA_FILE, O_RDONLY);
>> 	if (fd == -1)
>>         	handle_error("open");
>>
>> 	mem = mmap(NULL, SZ_1M * 4, PROT_READ | PROT_EXEC, MAP_PRIVATE, fd, 0);
>> 	close(fd);
>> 	if (mem == MAP_FAILED)
>>         	handle_error("mmap");
>>
>> 	printf("1: pid=%d, mem=%p\n", getpid(), mem);
>> 	getchar();
>>
>> 	mem = (char *)ALIGN((unsigned long)mem, SZ_1M * 2);
>> 	ret = madvise(mem, SZ_1M * 2, MADV_COLLAPSE);
>> 	if (ret)
>> 		handle_error("madvise");
>>
>> 	printf("2: pid=%d, mem=%p\n", getpid(), mem);
>> 	getchar();
>>
>> 	return 0;
>> }
>>
>> -->8--
>>
> 
> Confused...

This is a user space test case that shows the problem; data.txt needs to be at
least 4MB and on a mounted ext4 and xfs filesystem. By toggling the '#if 1' to
0, you can see the different behaviours for ext4 and xfs -
handle_error("madvise") fires with EINVAL in the xfs case. The getchar()s are
leftovers from me looking at the smaps file.

> 

