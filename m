Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9296277875F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjHKGVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHKGVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:21:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A9B2D4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:21:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso24915671fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691734896; x=1692339696;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuAO1E207/gHZlOH9l2mKHOIX33TBkAWPXkHI4xFLyc=;
        b=RBV6Et5hPIkmdmg+i1/xC9JOWow8/E/bVJQtCB+WWLptCa34BkIYaKB4vCvNuLNqtH
         6+kn6Xqvlh8jsOQVjBYt7YFiza+rqLzcFBz6z9o3xPJ2D4yRRNJ4HEjaBP267clKfWpX
         p16v3aQcWcdZS9IHhLiQHCRF/tpUgZxPcjc44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691734896; x=1692339696;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuAO1E207/gHZlOH9l2mKHOIX33TBkAWPXkHI4xFLyc=;
        b=G/XDUWl0kaYToMRCWTVaUvIx8eMoNqIFA+dAnZ8l4ediiY0t7KSahQDdWtuJYlRhTI
         DkXpjLD3kxYDbsqRTqe018llyAOZl/HyYwKiibavzhclv/7agbp/TYCNJj1+r/OT6U5K
         XsE0GJjP0zuLIwTqP45C+tJ1fmLZHx/cQLXG4hwn9Ggb+BFYKI7UOQv4whUXrxm/ekzN
         wzdStEGqHteKOziUaYEVbRNTxR6X8kcswNQHEzBMe2wL9xvO9TB1A93IZ1ckD+VK0XSA
         Jn6Ipaw/VAsKLvp8RJgKYnS/ngvowvq8kqPnl5Zf9JZq8OlpfjQyxgdYjb0FaBILMgOZ
         NWtQ==
X-Gm-Message-State: AOJu0YxwUN875KSiZupfHSCe6YrdptM6mlUF57ez8G2qHgP+AZT4AlNH
        Axfmt0pxLIY/6AR74ZzSDASO5g==
X-Google-Smtp-Source: AGHT+IEqwUNV0XddLsfcUI5eGeQUdOX/cpHw7MEqvc9B/pl6fFE8wv1DtiEaKeAMcgFVSBqaDBa/TQ==
X-Received: by 2002:ac2:4e8f:0:b0:4fe:3724:fdb1 with SMTP id o15-20020ac24e8f000000b004fe3724fdb1mr593214lfr.41.1691734895562;
        Thu, 10 Aug 2023 23:21:35 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r25-20020aa7da19000000b005233625e7a5sm1636191eds.75.2023.08.10.23.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 23:21:35 -0700 (PDT)
Message-ID: <25deb65e-a8f3-957b-9e4f-759604111d50@rasmusvillemoes.dk>
Date:   Fri, 11 Aug 2023 08:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with
 bitmap_set()
Content-Language: en-US, da
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230811005732.107718-1-yury.norov@gmail.com>
 <20230811005732.107718-3-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230811005732.107718-3-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 02.57, Yury Norov wrote:
> _reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Fix it.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/bitmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 3a589016f5e0..c9afe704fe4b 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -1352,9 +1352,12 @@ EXPORT_SYMBOL(bitmap_release_region);
>   */
>  int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
>  {
> +	unsigned int nbits = pos + BIT(order);
> +

That really doesn't sound right. Have you added self-tests for these
functions first and then used those to catch regressions?

Rasmus

