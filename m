Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEEF759D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGSSMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSSME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:12:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1311C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kk5QZGiEytes23SJ/m2wKXRoxkJuL/JZms+EeEgVKw4=; b=PJd5FNKRXZKyTYWisyfy2NiVoe
        gqzEp7xcgDWlfvS2a+/NENi9SLDV2i/4q7lpc6XjgtMb75W1ZwcKwTI8mdJ0k1aCZXg9Fp4uC6hI6
        nj10NeHuhL6YZdEN61ddSwQdmROSfNP7KPWMta0t+l7ExQgZmZYw32Tx5/6sh+9YQfQdzNvlW6i5M
        bpdiamNgi/5f4hZTqQ8QQb83Qcq/xxZrJtVZh86PyriSORqjInSDccs8fjdKbiqo/0mz5EfllgmaD
        rTquyBURcDtxKOD7RwUA6RNG94HS+71a+6UT8g2eCDBDj4ngC4KAapfTdA97wzwJ9hexQVewdo3Yw
        kQmYfzIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMBeW-006LLw-9E; Wed, 19 Jul 2023 18:11:56 +0000
Date:   Wed, 19 Jul 2023 19:11:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Subject: Re: [PATCH] mm/hugetlb: get rid of page_hstate()
Message-ID: <ZLgnbMet0jgxbak/@casper.infradead.org>
References: <20230719175944.292929-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719175944.292929-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:59:44AM -0700, Sidhartha Kumar wrote:
> -			skip_pages = compound_nr(head) - (page - head);
> +			skip_pages = folio_nr_pages(folio) - (page - &folio->page);

It turns out that you can't do (page - head) under all configs.  It
works on all common ones, but the safe way to do what you want here is:

			skip_pages = folio_nr_pages(folio) -
					folio_page_idx(folio, page);
