Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5BB75982B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGSOYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGSOYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:24:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188A61731
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JC/eCR674tDcgmpCVJw/UxLXLL972fZka0yLGt+KBbk=; b=Zbo7rd5McHqDmFlDZ5rQNL6/bv
        Jg6pY42ISXHQ1rU7Ebn2LQ4FMnOhlv9Av9yQ9sATcZk36LGrp/4e11S/hSJIqaz9V+dSmQKa66R1A
        KK5NGxcrT5vn7etCln+whJhXRO1TqugX6HA4XAOCWJRhpwotqGHfF418Si6BUNW1iA4kKiqciVmke
        eVR4wPkdcjSSFxygY2pJywn+ZjyVm9qENYjYjs8VST+Mk+RvIarCAeRlyW2jq7x/sDWBYl3WrmQyt
        a2AE2yHUNYTmEwaOHUNh9VMmVRO3HpRF7mVesNI/jfxNi27kPfVeWzAZvWD1TetGDx7KG2iVjkdPu
        QIvAH6Ag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qM86A-0068WO-4k; Wed, 19 Jul 2023 14:24:14 +0000
Date:   Wed, 19 Jul 2023 15:24:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v2 8/9] mm/page_io: convert count_swpout_vm_event() to
 take in a folio
Message-ID: <ZLfyDvSgFxkX6Z1Z@casper.infradead.org>
References: <20230719095848.3422629-1-zhangpeng362@huawei.com>
 <20230719095848.3422629-9-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719095848.3422629-9-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 05:58:47PM +0800, Peng Zhang wrote:
> -static inline void count_swpout_vm_event(struct page *page)
> +static inline void count_swpout_vm_event(struct folio *folio)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (unlikely(PageTransHuge(page)))
> +	if (unlikely(folio_test_pmd_mappable(folio)))
>  		count_vm_event(THP_SWPOUT);
>  #endif

As I said in my earlier response, you don't need the ifdefs.  Check
the definition of folio_test_pmd_mappable.

