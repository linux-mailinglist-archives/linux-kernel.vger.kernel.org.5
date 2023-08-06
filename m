Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A377154B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHFNcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHFNcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:32:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741ACA;
        Sun,  6 Aug 2023 06:32:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52227884855so5295149a12.1;
        Sun, 06 Aug 2023 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691328766; x=1691933566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ord0VE1gzw6fjyq/8Y2drSOTCzaAFST4WDc+L9TSzDw=;
        b=P4vCFPRCDkh/3Vge3m5VHzaX/BPWceyKv0EwV2HZD2tQf0/7W4pyu5BTIJ6lq9aH5h
         svQeFbnUIp8AEuQLiZ6a5tbfFglZrD4FrroBywBi+qup2AuEbuIrC7vJOHUufRexC2Is
         Q3zTfyma3RT0aF9OLXgf9lm0WYR8F3r/TuM8soTRLBVp4vIZm1Q4WEep4Yg0+T7pqUXU
         7QlgVIsVUOoXtz0WraCyPekV11YTqFRKSMzovkYCCNjHRVHH5DrwqFAHFfBy8LHqYY70
         TRn48waodP6Hk9AG1qRXFUOBh58zr4Tw7Dx29Y4PoP93ysY+tZgARU7B1MQcgd+e69aG
         oB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691328766; x=1691933566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ord0VE1gzw6fjyq/8Y2drSOTCzaAFST4WDc+L9TSzDw=;
        b=DV5v0zbacy92Uyj51a1slgYpbyMzApKYL1d+DDfF6khqmo/55HJoDxIlcOjG1ilN/f
         qtzI1kPSnACvq3cjy12hquHSeNrDxRKdScL+LFJmIkIxi4p3k0cEMYsgHxE9KRAaHf9o
         f5hzKqdAApLy+Fqao7LkqeWTtgAXP8acsYaRUkAU4QRcZGXl84fNirvyR62DPv6lVWud
         e9Nn8QB8K7+jkEHIVnslva8nwGELbxZMe/FI71i53F+Y27lQxcd+zl2M7+ZBM4ZI5IfO
         0TKq6dzAcPvvRd8Pq7K1Or2JHksvCG0ulQtQtC3W6gn0NopvJMPYLCiz2mFk66Zy2fj8
         Mpnw==
X-Gm-Message-State: AOJu0Yxm1LTAxUFrqy4IRU+pmIxjfpyihn7UzxGqHldHX+EV++XTJPhK
        VTpdwH8vAF2oMleyYq1RRYg=
X-Google-Smtp-Source: AGHT+IGNgKA2tggoo8ssFL0zKai5UNRF86d4MEDqV+zq9foUkTbJFcP6xe9KlyRCsLFBGoaFwvXwyg==
X-Received: by 2002:a17:906:3050:b0:99c:6692:7f76 with SMTP id d16-20020a170906305000b0099c66927f76mr6869185ejd.16.1691328765775;
        Sun, 06 Aug 2023 06:32:45 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id r4-20020a170906280400b00988e953a586sm3932281ejc.61.2023.08.06.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:32:45 -0700 (PDT)
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
Subject: Re: [PATCH v5 03/11] clk: sunxi-ng: a64: allow pll-mipi to set parent's rate
Date:   Sun, 06 Aug 2023 15:32:43 +0200
Message-ID: <9144277.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-3-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-3-db4f5ca33fc3@oltmanns.dev>
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

Dne nedelja, 06. avgust 2023 ob 15:06:48 CEST je Frank Oltmanns napisal(a):
> The nkm clock now supports setting the parent's rate. Utilize this
> option to find the optimal rate for pll-mipi.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c index 41519185600a..a139a5c438d4
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -179,7 +179,8 @@ static struct ccu_nkm pll_mipi_clk = {
>  	.common		= {
>  		.reg		= 0x040,
>  		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
> -					      &ccu_nkm_ops, 
CLK_SET_RATE_UNGATE),
> +					      &ccu_nkm_ops,
> +					      
CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
>  	},
>  };




