Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A750D7B71D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbjJCTfw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 15:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbjJCTfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:35:50 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7D93
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:35:47 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qnlAz-0000RR-1g;
        Tue, 03 Oct 2023 15:35:25 -0400
Message-ID: <8d19b6d092b7b5d9b1d0829e0d99c9915db3ed61.camel@surriel.com>
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and
 page fault
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Date:   Tue, 03 Oct 2023 15:35:25 -0400
In-Reply-To: <20231002043958.GB11194@monkey>
References: <20231001005659.2185316-1-riel@surriel.com>
         <20231001005659.2185316-3-riel@surriel.com> <20231002043958.GB11194@monkey>
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

On Sun, 2023-10-01 at 21:39 -0700, Mike Kravetz wrote:
> 
> Something is not right here.  I have not looked closely at the patch,
> but running libhugetlbfs test suite hits this NULL deref in misalign
> (2M: 32).

Hi Mike,

fixing the null dereference was easy, but I continued running
into a test case failure with linkhuge_rw. After tweaking the
code in my patches quite a few times, I finally ran out of
ideas and tried it on a tree without my patches.

I still see the test failure on upstream
2cf0f7156238 ("Merge tag 'nfs-for-6.6-2' of git://git.linux-
nfs.org/projects/anna/linux-nfs")

This is with a modern glibc, and the __morecore assignments
in libhugetlbfs/morecore.c commented out.


HUGETLB_ELFMAP=R HUGETLB_SHARE=1 linkhuge_rw (2M: 32):	Pool state:
(('hugepages-2048kB', (('free_hugepages', 1), ('resv_hugepages', 0),
('surplus_hugepages', 0), ('nr_hugepages_mempolicy', 1),
('nr_hugepages', 1), ('nr_overcommit_hugepages', 0))),)
Hugepage pool state not preserved!
BEFORE: (('hugepages-2048kB', (('free_hugepages', 1),
('resv_hugepages', 0), ('surplus_hugepages', 0),
('nr_hugepages_mempolicy', 1), ('nr_hugepages', 1),
('nr_overcommit_hugepages', 0))),)
AFTER: (('hugepages-2048kB', (('free_hugepages', 0), ('resv_hugepages',
0), ('surplus_hugepages', 0), ('nr_hugepages_mempolicy', 1),
('nr_hugepages', 1), ('nr_overcommit_hugepages', 0))),)


It may take a little while to figure this one out. I did some
bpftracing, but don't have a real smoking gun yet. The trace
certainly shows the last user of the leaked huge page going
into __unmap_hugepage_range.

-- 
All Rights Reversed.
