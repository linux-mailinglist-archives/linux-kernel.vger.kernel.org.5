Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA77BEFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379254AbjJJAu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379232AbjJJAuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:50:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7440A4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98410C433C8;
        Tue, 10 Oct 2023 00:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696899023;
        bh=brn88RJjJuKKgJQGW/M890oBv/KfzhxS4pbmrlft3p0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aE58UT4SGSfG/ipnw4qwYpdepUogGvd/+lQgfqMw1jGWPxKSVT1pULPO95KuUXzRk
         eQMuDQHjcnpAyXF9J2ZOVmJpnevzvGDeSlSByfZXgmd+41wBDeldv/sni8bzRkFhU7
         f7isjEh5+wjndBzMnONhoN3EqFiqGLvFhJRRsmeg=
Date:   Mon, 9 Oct 2023 17:50:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lucy Mielke <lucymielke@icloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH] mm: add printf attribute to shrinker_debugfs_name_alloc
Message-Id: <20231009175006.326e61e6c0e46e6ce78699ff@linux-foundation.org>
In-Reply-To: <ZSBue-3kM6gI6jCr@mainframe>
References: <ZSBue-3kM6gI6jCr@mainframe>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 22:30:51 +0200 Lucy Mielke <lucymielke@icloud.com> wrote:

> This fixes a compiler warning when compiling an allyesconfig with W=1:
> 
> mm/internal.h:1235:9: error: function might be a candidate for ‘gnu_printf’
> format attribute [-Werror=suggest-attribute=format]

Thanks.  I added

Fixes: c42d50aefd17 ("mm: shrinker: add infrastructure for dynamically allocating shrinker")

to this.

> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1229,8 +1229,8 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>  			  int priority);
>  
>  #ifdef CONFIG_SHRINKER_DEBUG
> -static inline int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
> -					      const char *fmt, va_list ap)
> +static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
> +			struct shrinker *shrinker, const char *fmt, va_list ap)
>  {
>  	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
>  
> -- 
> 2.42.0
