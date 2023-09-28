Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40537B26FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjI1VEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjI1VEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:04:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB01AD;
        Thu, 28 Sep 2023 14:04:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA80C433C8;
        Thu, 28 Sep 2023 21:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695935077;
        bh=M/5ZU8g6yA4315it+eEcyz6qGTDOsNSnU7hBp/ukGEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GifZoq+S91dlVSa8ba0LZTxOnoK6itojp7KAx0aHws8HEpKAazauz/F7V6ey4j4aZ
         ReTk2p58whVPBqxUi1p8nECtD32BcYK73OW0ypmbynywHszkqFvjSs9Oanu2jEsaJf
         G2yVpCNxUtxC8A1bekl8OOXosCFSPGeKVbuU8aa2DjyYdH093YRAdDshO9jwS33at2
         oxSPfIWR3UiZOcRFOkd9hnM9jS7+/E7fgt2pcbQ0kh3te4uvyOrY27twx+VsJBFGTG
         /48cAHA4N/1KsXPkSE+TxA7p91cxibX7Ttw+GQgRBcX8caNe3WmJLWqoObJ0VsYqM2
         hLjyiaOnF9dVg==
Date:   Thu, 28 Sep 2023 14:04:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: BUG: MADV_COLLAPSE doesn't work for XFS files]
Message-ID: <20230928210436.GG11456@frogsfrogsfrogs>
References: <4d6c9b19-cdbb-4a00-9a40-5ed5c36332e5@arm.com>
 <ZRVbV6yJ-zFzRoas@debian.me>
 <54e5accf-1a56-495a-a4f5-d57504bc2fc8@arm.com>
 <CAAa6QmRbDbEamFgEDbgVhwKOf1GHNa90COuyz29BmduOAjbmyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAa6QmRbDbEamFgEDbgVhwKOf1GHNa90COuyz29BmduOAjbmyA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 12:43:57PM -0700, Zach O'Keefe wrote:
> Hey Ryan,
> 
> Thanks for bringing this up.
> 
> On Thu, Sep 28, 2023 at 4:59 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> >
> > On 28/09/2023 11:54, Bagas Sanjaya wrote:
> > > On Thu, Sep 28, 2023 at 10:55:17AM +0100, Ryan Roberts wrote:
> > >> Hi all,
> > >>
> > >> I've just noticed that when applied to a file mapping for a file on xfs, MADV_COLLAPSE returns EINVAL. The same test case works fine if the file is on ext4.
> > >>
> > >> I think the root cause is that the implementation bails out if it finds a (non-PMD-sized) large folio in the page cache for any part of the file covered by the region. XFS does readahead into large folios so we hit this issue. See khugepaged.h:collapse_file():
> > >>
> > >>              if (PageTransCompound(page)) {
> > >>                      struct page *head = compound_head(page);
> > >>
> > >>                      result = compound_order(head) == HPAGE_PMD_ORDER &&
> > >>                                      head->index == start
> > >>                                      /* Maybe PMD-mapped */
> > >>                                      ? SCAN_PTE_MAPPED_HUGEPAGE
> > >>                                      : SCAN_PAGE_COMPOUND;
> > >>                      goto out_unlock;
> > >>              }
> > >
> 
> Ya, non-PMD-sized THPs were just barely visible in my peripherals when
> writing this, and I'm still woefully behind on your work on them now
> (sorry!).
> 
> I'd like to eventually make collapse (not just MADV_COLLAPSE, but
> khugepaged too) support arbitrary-sized large folios in general, but
> I'm very pressed for time right now. I think M. Wilcox is also
> interested in this, given he left the TODO to support it :P

Is the point of MADV_COLLAPSE to replace base pages with PMD-sized pages
in the pagecache for faster lookups?  Or merely to replace them with
something larger, even if it's not PMD sized?

As of 6.6, XFS asks for folios of size min(read/readahead/write_len,
ondisk_mapping_length), so in theory the folio size should roughly
follow the access patterns.  If the goal is merely larger folios, then
we are done here and can move on to some other part of the collapse.

OTOH if the goal is TLB savings, then I suppose you'd actually /want/ to
select a large (but not PMD) folio for collapsing into a PMD sized
folio, right?

e.g.

	if (PageTransCompound(page)) {
		struct page *head = compound_head(page);

		if (head->index != start) {
			/* not sure what _COMPOUND means here... */
			result = SCAN_PAGE_COMPOUND;
			goto out_unlock;
		}

		if (compound_order(head) == HPAGE_PMD_ORDER) {
			result = SCAN_PTE_MAPPED_HUGEPAGE;
			goto out_unlock;
		}

		/* result is still SCAN_SUCCEED, keep going */
	}

I /think/ that would work?  If the largefolio is dirty or not fully
uptodate then collapse won't touch it; and I think fs/iomap handles this
in a compatible way because it won't mark the folio uptodate until all
the blocks have been read, and it marks the folio dirty if any of the
blocks are dirty.

(says me, who doesn't really understand this part of the code.)

--D

> Thank you for the reproducer though! I haven't run it, but I'll
> probably come back here to steal it when the time comes.
> 
> > > I don't see any hint to -EINVAL above. Am I missing something?
> >
> > The SCAN_PAGE_COMPOUND result ends up back at madvise_collapse() where it
> > eventually gets converted to -EINVAL by madvise_collapse_errno().
> >
> > >
> > >>
> > >> I'm not sure if this is already a known issue? I don't have time to work on a fix for this right now, so thought I would highlight it at least. I might get around to it at some point in the future if nobody else tackles it.
> 
> My guess is Q1 2024 is when I'd be able to look into this, at the
> current level of urgency. It doesn't sound like it's blocking anything
> for your work right now -- lmk if that changes though!
> 
> Thanks,
> Zach
> 
> 
> 
> > >>
> > >> Thanks,
> > >> Ryan
> > >>
> > >>
> > >> Test case I've been using:
> > >>
> > >> -->8--
> > >>
> > >> #include <stdio.h>
> > >> #include <stdlib.h>
> > >> #include <sys/mman.h>
> > >> #include <sys/types.h>
> > >> #include <sys/stat.h>
> > >> #include <fcntl.h>
> > >> #include <unistd.h>
> > >>
> > >> #ifndef MADV_COLLAPSE
> > >> #define MADV_COLLAPSE                25
> > >> #endif
> > >>
> > >> #define handle_error(msg)    do { perror(msg); exit(EXIT_FAILURE); } while (0)
> > >>
> > >> #define SZ_1K                        1024
> > >> #define SZ_1M                        (SZ_1K * SZ_1K)
> > >> #define ALIGN(val, align)    (((val) + ((align) - 1)) & ~((align) - 1))
> > >>
> > >> #if 1
> > >> // ext4
> > >> #define DATA_FILE            "/home/ubuntu/data.txt"
> > >> #else
> > >> // xfs
> > >> #define DATA_FILE            "/boot/data.txt"
> > >> #endif
> > >>
> > >> int main(void)
> > >> {
> > >>      int fd;
> > >>      char *mem;
> > >>      int ret;
> > >>
> > >>      fd = open(DATA_FILE, O_RDONLY);
> > >>      if (fd == -1)
> > >>              handle_error("open");
> > >>
> > >>      mem = mmap(NULL, SZ_1M * 4, PROT_READ | PROT_EXEC, MAP_PRIVATE, fd, 0);
> > >>      close(fd);
> > >>      if (mem == MAP_FAILED)
> > >>              handle_error("mmap");
> > >>
> > >>      printf("1: pid=%d, mem=%p\n", getpid(), mem);
> > >>      getchar();
> > >>
> > >>      mem = (char *)ALIGN((unsigned long)mem, SZ_1M * 2);
> > >>      ret = madvise(mem, SZ_1M * 2, MADV_COLLAPSE);
> > >>      if (ret)
> > >>              handle_error("madvise");
> > >>
> > >>      printf("2: pid=%d, mem=%p\n", getpid(), mem);
> > >>      getchar();
> > >>
> > >>      return 0;
> > >> }
> > >>
> > >> -->8--
> > >>
> > >
> > > Confused...
> >
> > This is a user space test case that shows the problem; data.txt needs to be at
> > least 4MB and on a mounted ext4 and xfs filesystem. By toggling the '#if 1' to
> > 0, you can see the different behaviours for ext4 and xfs -
> > handle_error("madvise") fires with EINVAL in the xfs case. The getchar()s are
> > leftovers from me looking at the smaps file.
> >
