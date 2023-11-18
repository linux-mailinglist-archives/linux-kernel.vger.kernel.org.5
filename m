Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5422E7F0322
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 23:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKRWVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 17:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 17:21:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88BE5;
        Sat, 18 Nov 2023 14:21:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9becde9ea7bso845754066b.0;
        Sat, 18 Nov 2023 14:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700346076; x=1700950876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B119josK+jVs2ecxhPEL/ZG53Ca65uQoC2aDhpf/ABs=;
        b=dmTRORBVfSzQhGzgDY+x2Ja8fTCSstsx2GUW6Tm6hhIu7bgUugai3CCn+sR900WK3M
         jw1A6sbHqywLfN/Ld1FvZfw+UIhe/MfDG5UoR/5YrlT7i7bvaIYzaIdjozU2gMH1H7/w
         PmHJkoJdsow1OzoQizdomp2aE+v9Oks8D/EOf3k3WS5GdvRsoT6in1F+xoc8TOMcJPBQ
         M2MhIQzBFtl+SS7yCvbQfy4BuVzAolhSmW4zQGuK1/en7C0RiFj5fBz8+pMmEf4W0f3b
         YtDdxzLP1hpvDQBO0CzdUxLDLrXslKl8sXGT7m3iBfL3Z28fRRoUVM+cIXtGucnjM78F
         99BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700346076; x=1700950876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B119josK+jVs2ecxhPEL/ZG53Ca65uQoC2aDhpf/ABs=;
        b=mel8Xjk51dE4uWzKuR4iagZBIX4howpnNF40hCKdPnEbN4UeJ6GQNsJ4IKdyDSJxOK
         Nd1ai+MwFWiSvBaiQ6oVImcOoR4lZ29tiqgX6C3T9qILcSQhl9RYz+P187MiFi/9PdT5
         SK+Xi+USqFhov2K928K8TiKPJ9pYXUUjUKim4WvR0cXBJdHBg55x2xzrXw5bkaNos6q1
         WBn7KXZJFgoGnczbw5g1QhcZWSwpQrPtIM4BUgu5nsf2d1XrKVRyCS5OwUxA4Jr3m37T
         km4PYbM0bY5ztH2//3Hu5tVd80FL99NLiz2KwBFjWF3E+jItS/KqGX7lIB31IDj1eLGm
         olLg==
X-Gm-Message-State: AOJu0Yx5BnYL/LCzyIju2AjgA1dFA6+xH6V6DVqjVP++fTEspnfyWTT4
        TCyO6Z2q55OoaPv3iXfyVAU=
X-Google-Smtp-Source: AGHT+IHfkQkjALlAHjgb+TbRxpaKzlxrqELSYFI1FqqjNE4iR+HkNWNz19BbiIKxjSub4XKj0ulFtQ==
X-Received: by 2002:a17:906:10d9:b0:9ef:b466:abe0 with SMTP id v25-20020a17090610d900b009efb466abe0mr3120554ejv.8.1700346076193;
        Sat, 18 Nov 2023 14:21:16 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id u1-20020a170906b10100b009b9977867fbsm2286388ejy.109.2023.11.18.14.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 14:21:15 -0800 (PST)
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
Date:   Sat, 18 Nov 2023 23:21:14 +0100
Message-ID: <13391015.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20231023133502.666559-1-colin.i.king@gmail.com>
References: <20231023133502.666559-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 23. oktober 2023 ob 15:35:02 CET je Colin Ian King napisal(a):
> Variable tmp_parent is being ininitialized with a value that is never
> read, the initialization is redundant and can be removed. Move the
> initialization and move the variable to the inner loop scope.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thanks!

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




