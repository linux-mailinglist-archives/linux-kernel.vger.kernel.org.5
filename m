Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791797A4A46
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjIRM5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbjIRM5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:57:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE4A8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9XDsDeK220CTPqxHjZSibpxURfNBC/aG4oAlkDI8JTU=; b=sI1T5llGcQNIAw6gwKHoFy/lHm
        8Rn3JWtMNlyuhJpaTt2HjwukPbrpQkBCILHYg/MYefRkJEO5BVSBYjaxKloU3JTQyeYFSRNz15fBx
        g7AgdV1uaDbIOJPfgiBplpsa5Pi++EoJAQ0zNp2d3HaCIF+h315VMbktFcWIUiR7XGzqxvio1+KMb
        h1dQRoUE2Q5UVpAj34Vy2avSSbQ1lksc7d2G0p7fPHsFNszG5TulMIS9kupTIuOvAyg3+elr3+GLh
        VVCA/s1Dvb0q9jdh7Ce4RiVBxMOElqqUpZREjyeoePSR9xjh0q0b6hPNGHilxEJvcCmGupuyl0HO+
        +7+d0X0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiDoG-00B7La-2R; Mon, 18 Sep 2023 12:57:04 +0000
Date:   Mon, 18 Sep 2023 13:57:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        david@redhat.com, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, hughd@google.com
Subject: Re: [PATCH 0/6] mm: convert numa balancing functions to use a folio
Message-ID: <ZQhJIDXO1m5XFYH4@casper.infradead.org>
References: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 06:32:07PM +0800, Kefeng Wang wrote:
> The do_numa_pages only handle non-compound page, and only PMD-mapped THP
> is handled in do_huge_pmd_numa_page(), but large, PTE-mapped folio will
> be supported, let's convert more numa balancing functions to use/take a
> folio in preparation for that, no functional change intended for now.
> 
> Kefeng Wang (6):
>   sched/numa, mm: make numa migrate functions to take a folio
>   mm: mempolicy: make mpol_misplaced() to take a folio
>   mm: memory: make numa_migrate_prep() to take a folio
>   mm: memory: use a folio in do_numa_page()
>   mm: memory: add vm_normal_pmd_folio()
>   mm: huge_memory: use a folio in do_huge_pmd_numa_page()

This all seems OK.  It's kind of hard to review though because you change
the same line multiple times.  I think it works out better to go top-down
instead of bottom-up.  That is, start with do_numa_page() and pass
&folio->page to numa_migrate_prep.  Then do vm_normal_pmd_folio() followed
by do_huge_pmd_numa_page().  Fourth would have been numa_migrate_prep(),
etc.  I don't want to ask you to redo the entire series, but for future
patch series.

Also, it's nce to do things like remove the unnecessary 'extern' from
function declarations when you change them from page to folio.  And
please try to stick to 80 columns; I know it's not always easy/possible.
