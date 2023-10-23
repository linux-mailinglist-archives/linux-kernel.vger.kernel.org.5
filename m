Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BFF7D41A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjJWV2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWV2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:28:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBAA97;
        Mon, 23 Oct 2023 14:28:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c51388ccebso56140641fa.3;
        Mon, 23 Oct 2023 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698096512; x=1698701312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/i5l9FjisPDPcqgMEOco4v6QQottzWN3f7xhyjrsuPE=;
        b=G9y1j0zA2TV8KTDCkf4OnLKCLlmYe6mXensXeu8TLs4jZmaNjrBj/1WOUodnIj0OdY
         nfkO8en8ClymXsOqQoPBT6zbUMORpYNerxdE5KEAxWwmd3yaFzh+DxIjvpnSF2Bhxj07
         VaUGO2dFzOzRLAy0VeyVxur7K2I0sJXkEy4RhdOxLJ4dfHtLkWiB12PiBlaheL7cOOC8
         KbZDtO4AoZM/RVnDO0sVQ1vTa4W+8iQuQWdHCG+E+GkOOcm3A9JKCtZZFp/+33mJiW0k
         eGPF2TW+C2VdqoOz4mCgIBQspFBiDmZ89mYRTHTZqG1eTfNgyJ5cU++IBwKagjObOmZN
         J1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698096512; x=1698701312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i5l9FjisPDPcqgMEOco4v6QQottzWN3f7xhyjrsuPE=;
        b=vQRyCAX3qBmG4Afco+I+ezojxE+pTHmb+fbdlnvfR0+W6IBg076MHzzuM76XWwQbU/
         tVWs57JDtvC24rhq3AUatglk2K+5okxSib9pJ3sLS4fpJVuqbWt9gWl9a2GVCJSE0C2E
         Xwt+FWZjh62im9Lz5zIqKANtiBezCHkyHUa5m0bGS4xufFTPOXQarx/mdaWqrFS3Z6D4
         wqGfGXsyMW1dW20BaK4xXuNywIujnBYotUJU/XaCBZ/pFxuFREthysUrww++k+bNzJxl
         TtZ9MK4Kl7piyGHWZ+edzdcK/P/0RfsKcjDjwxd182y1WEvt6E4OOCHec6nhs2ZjIlja
         8JEg==
X-Gm-Message-State: AOJu0YySf6wK7MV+2kBfaGuuJQCpQdmOEe/9gGFhtlBkKtgNxRdjO6Lf
        qscl75dlguHSj4slnGWKe+M=
X-Google-Smtp-Source: AGHT+IEf+hJBpR5SXhMS3VVLSjHNP/1//4tt9MjRaPhH6/m5DlgNbmQlN9gKwgp6ApxZyeAQlMzb+A==
X-Received: by 2002:a05:651c:2112:b0:2c5:1490:1687 with SMTP id a18-20020a05651c211200b002c514901687mr8100017ljq.33.1698096511675;
        Mon, 23 Oct 2023 14:28:31 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600c3d0900b003feae747ff2sm15256302wmb.35.2023.10.23.14.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:28:31 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] clk: sunxi-ng: nkm: remove redundant initialization of
 tmp_parent
Date:   Mon, 23 Oct 2023 23:28:29 +0200
Message-ID: <2924841.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20231023133502.666559-1-colin.i.king@gmail.com>
References: <20231023133502.666559-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 23. oktober 2023 ob 15:35:02 CEST je Colin Ian King napisal(a):
> Variable tmp_parent is being ininitialized with a value that is never
> read, the initialization is redundant and can be removed. Move the
> initialization and move the variable to the inner loop scope.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index eed64547ad42..853f84398e2b 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -21,17 +21,16 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common
>  						       unsigned long *parent, unsigned long rate,
>  						       struct _ccu_nkm *nkm)
>  {
> -	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
> +	unsigned long best_rate = 0, best_parent_rate = *parent;
>  	unsigned long best_n = 0, best_k = 0, best_m = 0;
>  	unsigned long _n, _k, _m;
>  
>  	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
>  		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
>  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
> -				unsigned long tmp_rate;
> +				unsigned long tmp_rate, tmp_parent;
>  
>  				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
> -
>  				tmp_rate = tmp_parent * _n * _k / _m;
>  
>  				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
> 




