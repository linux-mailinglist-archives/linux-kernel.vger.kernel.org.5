Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51796771568
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjHFNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHFNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:43:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C172CF;
        Sun,  6 Aug 2023 06:43:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so5014510a12.0;
        Sun, 06 Aug 2023 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691329432; x=1691934232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LahOmtw+dOqGhFwzPmluy7sMbX8L+Z01CVnjmnkuSGE=;
        b=EQs5tl40ZqlRkOieUvmpt+4gweDpn3uaZuMfP/5OPhZkcxAMbtjuu55ZriQ/hNBd7O
         gAw61tFcAkK/P7taebAR/DCYAqXAi/fHayaI1/+l8bSDplGZT569mM2lgoXECLKAUQWv
         Zi7qe0lyAngrCZAmXm2pesi+iLRuzZwZ5PRJoEZpxleytAb5pwVECvER1ZCRLweVtoq5
         HyEoiXVE4eopy22W3K8IfQ6PqyHq6K9W91kY8x+pNOj6RIrt8v9vkbrq3DjNemHqlPIv
         cHRHpyA5mNLIcOMA80n4ZQl5kOEFJp+D/MTIA7IBtiswANmmEtgobgxRO0s5MxBLEbBs
         BBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691329432; x=1691934232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LahOmtw+dOqGhFwzPmluy7sMbX8L+Z01CVnjmnkuSGE=;
        b=Pb+rko1kESwhWvbYwb3JO4Vl+o6mTtv876u47TLjUn8i0QBMdBsCJs4B2HRsziUUi5
         r/WAu7v31BP4sjsfEf0vBntBDKVPdXDJR25+Xldwpq2x8Dg2n00L/tve2uuvHQ/Y5hBM
         VM57ogxpFaeG7p/dYtCtx3bEkJY+buQlO2fJHKXwH0qcpETrai9K449McmQQNqHHSA1N
         UDJcRjcysmmUa61KAe7/v/I/sPOu/fMrwz21j9a6Fz+ziS0EAu+26auLDUF5F4LiZAWK
         mJWiLAZCxlCJeBVNby6ARL5ZaKG3nSQsgFTJeyzagQgO3/MZWZSCfg6Jl4D0sHXs2S01
         EPVQ==
X-Gm-Message-State: AOJu0YwjhZZhwqCcopOeT6eopsEfgNX6qr9qr97FhSCYmCe0EwHJ/8xb
        kKozMOy1x3mHgW6KKulGK5E=
X-Google-Smtp-Source: AGHT+IEBFtSKShfsGfbCpFMtiZEsrdUskRucT0bUssz2Grq5iCZlM9ACJ1wQ8XcSZrSneHMxv8mb6w==
X-Received: by 2002:a17:906:319b:b0:99c:bb4d:f5a0 with SMTP id 27-20020a170906319b00b0099cbb4df5a0mr3426696ejy.14.1691329431999;
        Sun, 06 Aug 2023 06:43:51 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id oz13-20020a170906cd0d00b00992b71d8f19sm1359086ejb.133.2023.08.06.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:43:51 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, Frank Oltmanns <frank@oltmanns.dev>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
Subject: Re: [PATCH v5 11/11] clk: sunxi-ng: nkm: Prefer current parent rate
Date:   Sun, 06 Aug 2023 15:43:50 +0200
Message-ID: <1904467.taCxCBeP46@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-11-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-11-db4f5ca33fc3@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 06. avgust 2023 ob 15:06:56 CEST je Frank Oltmanns napisal(a):
> Similar to ccu_mp, if the current parent rate allows getting the ideal
> rate, prefer to not change the parent clock's rate.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 896bb1ef8642..1e49444817cf 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -35,7 +35,8 @@ static unsigned long
> ccu_nkm_find_best_with_parent_adj(struct ccu_common *common
> 
>  				tmp_rate = tmp_parent * _n * _k / 
_m;
> 
> -				if (ccu_is_better_rate(common, 
rate, tmp_rate, best_rate)) {
> +				if (ccu_is_better_rate(common, 
rate, tmp_rate, best_rate) ||
> +				    (tmp_parent == *parent && 
tmp_rate == best_rate)) {
>  					best_rate = tmp_rate;
>  					best_parent_rate = 
tmp_parent;
>  					best_n = _n;




