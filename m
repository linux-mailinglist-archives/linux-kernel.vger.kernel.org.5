Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A3B7A716D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjITEKH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 00:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITEKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:10:05 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B63B0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 21:09:59 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qioWz-0007rh-32;
        Wed, 20 Sep 2023 00:09:41 -0400
Message-ID: <7ddc6ba18b3fef3ed637dcd9a85e90cf4ca6ca7d.camel@surriel.com>
Subject: Re: [PATCH 1/2] hugetlbfs: extend hugetlb_vma_lock to private VMAs
From:   Rik van Riel <riel@surriel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, leit@meta.com
Date:   Wed, 20 Sep 2023 00:09:41 -0400
In-Reply-To: <ZQptrdK69wvJ2NXP@casper.infradead.org>
References: <20230920021811.3095089-1-riel@surriel.com>
         <20230920021811.3095089-2-riel@surriel.com>
         <ZQptrdK69wvJ2NXP@casper.infradead.org>
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

On Wed, 2023-09-20 at 04:57 +0100, Matthew Wilcox wrote:
> On Tue, Sep 19, 2023 at 10:16:09PM -0400, riel@surriel.com wrote:
> > From: Rik van Riel <riel@surriel.com>
> > 
> > Extend the locking scheme used to protect shared hugetlb mappings
> > from truncate vs page fault races, in order to protect private
> > hugetlb mappings (with resv_map) against MADV_DONTNEED.
> > 
> > Add a read-write semaphore to the resv_map data structure, and
> > use that from the hugetlb_vma_(un)lock_* functions, in preparation
> > for closing the race between MADV_DONTNEED and page faults.
> 
> This feels an awful lot like the invalidate_lock in struct
> address_space
> which was recently added by Jan Kara.
> 
Indeed it does.

It might be even nicer if we could replace the hugetlb_vma_lock
special logic with the invalidate_lock for hugetlbfs.

Mike, can you think of any reason why the hugetlb_vma_lock logic
should not be replaced with the invalidate_lock?

If not, I'd be happy to implement that.

-- 
All Rights Reversed.
