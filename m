Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F374F7E02CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376377AbjKCM3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376270AbjKCM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:28:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3161B2;
        Fri,  3 Nov 2023 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a77meOT79I7dsPYCFbUcAK9S3K/ZvqB8pXsH6tW8Eq8=; b=cD5iKM/B6l25pNkN82s2dlw0zo
        2JuheD/f34EG4MV2LGnlMzHIBWbW+dvhH3ikgmnDuwj812/djsSe/ZDt03LwgJJZ1/DBWMYAwf9/P
        djFt50UfGn0D9q5o81C2B9/5kJHlU8d+WWH+UL/EIxODhmO8e0EZeeWZYZRKS84230nuufL8PD5LH
        tl/0Lqf1KHEPNn69kV705BodIWmWmerpZtPeb9YbM3YCL7QzXXgC48Qle84woCcv60Dqt4uiwrNQ8
        u5bGqSpKVseETjeTyLB4nAKnzRvSdTM7+Kx5rigI4sCjGhkGJa90SXMkA00ZYKltV8uIJj8vz4+u/
        Zyf435Eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qytI7-005Lgd-4u; Fri, 03 Nov 2023 12:28:47 +0000
Date:   Fri, 3 Nov 2023 12:28:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] fs/proc/page: use a folio in stable_page_flags()
Message-ID: <ZUTnf/hnbPqI9HSB@casper.infradead.org>
References: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
 <20231103072906.2000381-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103072906.2000381-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 03:29:05PM +0800, Kefeng Wang wrote:
> Replace ten compound_head() calls with one page_folio().

This is going to conflict with Gregory Price's work:

https://lore.kernel.org/linux-mm/ZUCD1dsbrFjdZgVv@memverge.com/

Perhaps the two of you can collaborate on a patch series?

>  	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
> -	if (PageTail(page) && PageSlab(page))
> +	if (PageTail(page) && folio_test_slab(folio))
>  		u |= 1 << KPF_SLAB;

This doesn't make sense ...
