Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1607AB3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjIVOic convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Sep 2023 10:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjIVOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:38:30 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2031100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:38:24 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qjhI3-00082q-1q;
        Fri, 22 Sep 2023 10:37:55 -0400
Message-ID: <c3309a3486df6ad2901d4d5c23e7bc6f4b8a9a24.camel@surriel.com>
Subject: Re: [PATCH 1/2] hugetlbfs: extend hugetlb_vma_lock to private VMAs
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com
Date:   Fri, 22 Sep 2023 10:37:55 -0400
In-Reply-To: <20230921224201.GB21193@monkey>
References: <20230920021811.3095089-1-riel@surriel.com>
         <20230920021811.3095089-2-riel@surriel.com> <20230921224201.GB21193@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-21 at 15:42 -0700, Mike Kravetz wrote:
> On 09/19/23 22:16, riel@surriel.com wrote:
> > From: Rik van Riel <riel@surriel.com>
> > 
> > Extend the locking scheme used to protect shared hugetlb mappings
> > from truncate vs page fault races, in order to protect private
> > hugetlb mappings (with resv_map) against MADV_DONTNEED.
> > 
> > Add a read-write semaphore to the resv_map data structure, and
> > use that from the hugetlb_vma_(un)lock_* functions, in preparation
> > for closing the race between MADV_DONTNEED and page faults.
> > 
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  include/linux/hugetlb.h |  6 ++++++
> >  mm/hugetlb.c            | 36 ++++++++++++++++++++++++++++++++----
> >  2 files changed, 38 insertions(+), 4 deletions(-)
> 
> This looks straight forward.
> 
> However, I ran just this patch through libhugetlbfs test suite and it
> hung on
> misaligned_offset (2M: 32).
> https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/misaligned_offset.c


Speaking of "looks straightforward", how do I compile the
libhugetlbfs code?

The __morecore variable, which is pointed at either the
THP or hugetlbfs morecore function, does not seem to be
defined anywhere in the sources.

Do I need to run some magic script (didn't find it) to
get a special header file set up before I can build
libhugetlbfs?



$ make
	 CC32 obj32/morecore.o
morecore.c: In function ‘__lh_hugetlbfs_setup_morecore’:
morecore.c:368:17: error: ‘__morecore’ undeclared (first use in this
function); did you mean ‘thp_morecore’?
  368 |                 __morecore = &thp_morecore;
      |                 ^~~~~~~~~~
      |                 thp_morecore
morecore.c:368:17: note: each undeclared identifier is reported only
once for each function it appears in
make: *** [Makefile:292: obj32/morecore.o] Error 1
$ grep __morecore *.[ch]
morecore.c:		__morecore = &thp_morecore;
morecore.c:		__morecore = &hugetlbfs_morecore;



-- 
All Rights Reversed.
