Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A477154D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjHFNdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHFNdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:33:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4312C127;
        Sun,  6 Aug 2023 06:33:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cd6a554cso56022401fa.3;
        Sun, 06 Aug 2023 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691328789; x=1691933589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM7OnaKmFiiSy0YU2WCKkAldSyarebqNo/myAZ18qU8=;
        b=FJfZuaM4j80QUdDjysNJZOw02GVH0GcWm7lp/coj/KtptlBxP8a6GNNgV/5TKV4+SD
         CQfj/rNryEbF5GyZskXib6qk02JT5OFf3urcA+N7jSMniHQJu2WwOsabSTFd7XAlYQGG
         9kOafQghRR6MtX1C8ni+Dn+oUSG10SMjR2gCh7yxx+zGkvtterCJ1PVQWsElaljWW/0Y
         KJe1jAN8hNkEBRx7owVUISMWPBF3zQmQ2xt5VOhjv+1DSkVSA00Uew14xnEmYHPBq/C2
         tq441o40Tti1ERPTlmub34tuklk3MxWvMFQFITM7t3uCsT+EpFwEBEi4Rj8EyheUAAF0
         +YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691328789; x=1691933589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hM7OnaKmFiiSy0YU2WCKkAldSyarebqNo/myAZ18qU8=;
        b=Fhjn+ivUudMz31JmdPELInkaeUK52EkGbVtTZ55qLKK9bEGMFaiplqePbPkohSc7/B
         y4ZzDidavraUxlylDS7ire6UeAwrDedzNm0DW3Y8Q7yjvw0s94gMMUI6PZ0HM0jo1hv5
         lgxMX8sLSsjkYmK6n+MMwCpPAto4m08wvj3IfRj9O+vPjbACEldYea7wegNprQN7X23M
         8ZICxn3/mfUu3wKPUG1rrR0Xbz1CMK5Ramh1HeQJ//pZJkcg/oF51wgrqDK0ocGzfMCo
         okN8xIzG35mFkkerdY7xT9FA39p96f7qvGBx7CMp5/thfPFkLCMsXHEDOor3iAZJ2Rtd
         z2pA==
X-Gm-Message-State: AOJu0YyIl9AG5LTQWVlRZ3AVCNQSqklAmLRB/B+rXb4qUdXLqBXXWwOy
        LvJZKFOwk3+mh6DJIm8spC7kasCXdiTB7g==
X-Google-Smtp-Source: AGHT+IHpsJxV8MF78Dy5TgBPH8NmXIYmknmepVRE2sYKgeBkvcU+vR0WIy+JY0Vy32lTiWtBkDtPhA==
X-Received: by 2002:a05:6512:311c:b0:4f6:3677:54e with SMTP id n28-20020a056512311c00b004f63677054emr3910959lfb.36.1691328789322;
        Sun, 06 Aug 2023 06:33:09 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id t18-20020aa7d712000000b0051e0be09297sm3946253edq.53.2023.08.06.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:33:09 -0700 (PDT)
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
Subject: Re: [PATCH v5 04/11] clk: sunxi-ng: Add feature to find closest rate
Date:   Sun, 06 Aug 2023 15:33:07 +0200
Message-ID: <5854308.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-4-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-4-db4f5ca33fc3@oltmanns.dev>
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

Dne nedelja, 06. avgust 2023 ob 15:06:49 CEST je Frank Oltmanns napisal(a):
> The default behaviour of clocks in the sunxi-ng driver is to select a
> clock rate that is closest to but less than the requested rate.
> 
> Add the CCU_FEATURE_CLOSEST_RATE flag, which can be used to allow clocks
> to find the closest rate instead.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_common.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_common.h
> b/drivers/clk/sunxi-ng/ccu_common.h index fbf16c6b896d..5ad219f041d5 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.h
> +++ b/drivers/clk/sunxi-ng/ccu_common.h
> @@ -18,6 +18,7 @@
>  #define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
>  #define CCU_FEATURE_SIGMA_DELTA_MOD	BIT(7)
>  #define CCU_FEATURE_KEY_FIELD		BIT(8)
> +#define CCU_FEATURE_CLOSEST_RATE	BIT(9)
> 
>  /* MMC timing mode switch bit */
>  #define CCU_MMC_NEW_TIMING_MODE		BIT(30)




