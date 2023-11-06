Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660DC7E2682
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjKFOVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjKFOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:21:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D634DC6;
        Mon,  6 Nov 2023 06:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/gY9fga25uHFBNLVOlYk1hPjkWgJ/qz19kZMBIAL1Vo=; b=CAdjhNR1EZ8085YVz3JlS3KoB/
        bBNrRZ8WgWC8elYdcpofIF/Zx535WalMf4qgPcvPIXHIgyxfpRw4t9Tu6X08E4Cg2j1B4xxiaNoPU
        nZYeYESZ3shQQC6Y7Ft8HYGMnM7MYBWRxSkgUV88zm6tfDZ83cWTLsQLIlvQtauYdtgeNpao8ovLY
        whVheuP+VGj9QRFsB56coApjfcJb3Nv2OYU26VobdO8e0EgCDeQljjDkDeads+NU0/ZoHAmOXzKJC
        M1jdC2J9KKUCE96EeKaDGMqRNCat8JZTPwm5G3fDAPp5SSQZqFv0cr11wXK1uuNUYSZRc2QW1pAMb
        O75yTjqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r00TI-006OrJ-2n; Mon, 06 Nov 2023 14:20:56 +0000
Date:   Mon, 6 Nov 2023 14:20:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 06/10] mm: memory: use a folio in zap_pte_range()
Message-ID: <ZUj2SCML4h7X5TWu@casper.infradead.org>
References: <20231104035522.2418660-1-wangkefeng.wang@huawei.com>
 <20231104035522.2418660-7-wangkefeng.wang@huawei.com>
 <ZUZ9dg4YHZdUKDqO@casper.infradead.org>
 <e3c275c3-e09d-4495-8132-9464133db283@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c275c3-e09d-4495-8132-9464133db283@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:30:59AM +0800, Kefeng Wang wrote:
> On 2023/11/5 1:20, Matthew Wilcox wrote:
> > > -				page_remove_rmap(page, vma, false);
> > > -			put_page(page);
> > > +				page_remove_rmap(&folio->page, vma, false);
> > > +			folio_put(folio);
> > 
> > This is wrong.  If we have a PTE-mapped THP, you'll remove the head page
> > N times instead of removing each of N pages.
> 
> This is device private entry, I suppose that it won't be a THP and large
> folio when check migrate_vma_check_page() and migrate_vma_insert_page(),
> right?

I don't want to leave that kind of booby-trap in the code.  Both places
which currently call page_remove_rmap() should be left as referring to
the page, not the folio.
