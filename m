Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C3771547
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjHFNbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:31:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE993B7;
        Sun,  6 Aug 2023 06:31:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso56259661fa.1;
        Sun, 06 Aug 2023 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691328667; x=1691933467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlHmBq49GaYoGsKWVnEVQtnIfJo6/Tl7AXvPxirTIGM=;
        b=aP9mO/RNoYrqvsVxNFMzVI5mJiIVtMZExIyHdSGTl+xTOp5qP40sGCS1cHkaIGHPlq
         iTNUmdWGHuMPb2tx8h4jEKouQ1bTPFdCczcS2ANtf+lmF8ji2zYQNModkrNOKU/oESl+
         zpaBOYOvWZ7evPf0UP8A8nrzRFYE+Spf5XdKSmGH1jBQj26d5REXl9tCUaE5h0ER0dNk
         7RJaYpPjvkCbv/XnejkZNtk3UUsWkpO1m6gYp2ZMBidYXJnNV+BOG/fy9fr5IIW/zJha
         2hCJdKQcWGbln0rnzjZie9B92sytoutlpX1F9Fr8CX7JKJrCPnMOZJj+K8q0e3Rkg0qM
         8wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691328667; x=1691933467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlHmBq49GaYoGsKWVnEVQtnIfJo6/Tl7AXvPxirTIGM=;
        b=QakqefQK+9QrUoutSI7qqmrZCow/17nHF7qKkNaNZ6yLeihTor8rvbnPphV+EyKYby
         fo+J6KCPDHC3mdUzoGOBs6owk97syAVU/dQuDq0kYQRIwfyj/Mk7pk4ZqExaVQF3REKg
         RJ7tmSMk1Sb/uIgHobSWi7Gf2V1OxqAo/Wd8afayj31PKfotWKGSGJTH0tEMu/osG7/h
         IthMMVrwjpQFC0Vis7uRQ+/pP3yV58hthl1okPdnGa6EkZSKdfH+CHsHGgSai0Y4viTp
         cloYIu4tNZqHWRRyGH/QTX4fjh05DVKC1BDS4T9cZMaYLL067O2I+ayOeuQtSkfBQNN0
         7RZg==
X-Gm-Message-State: AOJu0Yztgmxpl3YP2laYCD8uAFFtetPqjUadgyV/LKNDnLAYd3goYPv6
        kSulRJGUT7OP5tv7V4tofGs=
X-Google-Smtp-Source: AGHT+IGHmqd8RJE7eo0lPAWvv9e9ziWq0pJssJdhZwTmZ/sfB+1bkU9IRB/JQy5FEcgcRYO//Z0Fyw==
X-Received: by 2002:a2e:8195:0:b0:2b9:40c7:f5ed with SMTP id e21-20020a2e8195000000b002b940c7f5edmr4421264ljg.17.1691328666485;
        Sun, 06 Aug 2023 06:31:06 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id la1-20020a170906ad8100b0099b5a71b0bfsm3914500ejb.94.2023.08.06.06.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:31:06 -0700 (PDT)
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
Subject: Re: [PATCH v5 01/11] clk: sunxi-ng: nkm: Use correct parameter name for
 parent HW
Date:   Sun, 06 Aug 2023 15:31:04 +0200
Message-ID: <21967267.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-1-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-1-db4f5ca33fc3@oltmanns.dev>
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

Dne nedelja, 06. avgust 2023 ob 15:06:46 CEST je Frank Oltmanns napisal(a):
> ccu_nkm_round_rate() takes a clk_hw as parameter "hw". Since "hw" is the
> nkm clock's parent clk_hw, not the clk_hw of the nkm clock itself,
> change the parameter name to "parent_hw" to make it more clear what
> we're dealing with.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index a0978a50edae..f267142e58b3 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -106,7 +106,7 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw
> *hw, }
> 
>  static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
> -					struct clk_hw *hw,
> +					struct clk_hw 
*parent_hw,
>  					unsigned long 
*parent_rate,
>  					unsigned long rate,
>  					void *data)




