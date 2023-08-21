Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6BF7821D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 05:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjHUDfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 23:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjHUDfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 23:35:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6263CA1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 20:35:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc63ef9959so22382295ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 20:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692588936; x=1693193736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=00sTKj6r29idEJKO1tqRjR2HLLSE0fyMr4hXBqiW47I=;
        b=EoyOxijThar9EAUzeD2tdAYhkNhVBKLl5DvbKipB5sV6cz6R9mEcIg+4Z8Z9okgZ2k
         YeZ2+ayHnz4AcanYdoMscZoQpZ7Te1XBrw3p9RyKA66C2vIxkEcpKYICCoALmRS3VlTM
         iRe2QuQTxYpQJTh5Hz17W91X7F5RoYaXw1JaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692588936; x=1693193736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00sTKj6r29idEJKO1tqRjR2HLLSE0fyMr4hXBqiW47I=;
        b=C1QNKQ7tNhPoMAwX/6q1DSuwwkC6js32bVsf/k4KEmxBf6EUkolFAOfGHZI4ZYCe7i
         jVPP7gKyi6JC3e1BKOMnYzC563HTqu3D8fy7aGMMMKAVWkDXFrQC1soFUaIvkUV7OU+b
         H9xl2z6+M43IAbl9CeF3KS3K79BD/J2WuByWxKbKK5ZOPgJ6j8giy2qVyr6VcNk+lbiK
         OO5DvjiyyJap8DFr2Uur99oXqMrG5o6HMZLjQfFeH/8CP+jBEpRoykuXpqDWW4sZqtRg
         dVHPiDnbRH8TAkQiTwEs8myldD1M6XP8ofEeqcj34+03Q49p5f1iC0P4/j9jmw/7Ghgd
         uixQ==
X-Gm-Message-State: AOJu0Yw2W0tvpY/6MZIeopL3eqLijT2e7ODPiZjCqLcJ0eDLIT0gQ6TJ
        pi1euaNkejoYd04lKhelPmj34Q==
X-Google-Smtp-Source: AGHT+IG5aGqs5D00DDjj7OJwcEOzDcmv6vQD+bo07/gyCLmBibr72UHzCi3wAuI/jaEHXPiLMS1QHg==
X-Received: by 2002:a17:903:2305:b0:1bf:cdc:f402 with SMTP id d5-20020a170903230500b001bf0cdcf402mr7301478plh.48.1692588935784;
        Sun, 20 Aug 2023 20:35:35 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:d88c:8ac2:1586:6240])
        by smtp.gmail.com with ESMTPSA id iz22-20020a170902ef9600b001b9da42cd7dsm5881881plb.279.2023.08.20.20.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 20:35:35 -0700 (PDT)
Date:   Mon, 21 Aug 2023 11:35:32 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Yu-Che Cheng <giver@chromium.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     James Lo <james.lo@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fei Shao <fshao@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spmi: mediatek: Fix UAF on device remove
Message-ID: <20230821033532.GA21555@google.com>
References: <20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:39:35PM +0800, Yu-Che Cheng wrote:
> The pmif driver data that contains the clocks is allocated along with
> spmi_controller.
> On device remove, spmi_controller will be freed first, and then devres
> , including the clocks, will be cleanup.
> This leads to UAF because putting the clocks will access the clocks in
> the pmif driver data, which is already freed along with spmi_controller.
> 
> This can be reproduced by enabling DEBUG_TEST_DRIVER_REMOVE and
> building the kernel with KASAN.
> 
> Fix the UAF issue by using unmanaged clk_bulk_get() and putting the
> clocks before freeing spmi_controller.
> 
> Reported-by: Fei Shao <fshao@chromium.org>
> Signed-off-by: Yu-Che Cheng <giver@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Stephen, could you pick this up?

> ---
> 
>  drivers/spmi/spmi-mtk-pmif.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
> index b3c991e1ea40..74b73f9bc222 100644
> --- a/drivers/spmi/spmi-mtk-pmif.c
> +++ b/drivers/spmi/spmi-mtk-pmif.c
> @@ -465,7 +465,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
>  	for (i = 0; i < arb->nclks; i++)
>  		arb->clks[i].id = pmif_clock_names[i];
>  
> -	err = devm_clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
> +	err = clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
>  	if (err) {
>  		dev_err(&pdev->dev, "Failed to get clocks: %d\n", err);
>  		goto err_put_ctrl;
> @@ -474,7 +474,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
>  	err = clk_bulk_prepare_enable(arb->nclks, arb->clks);
>  	if (err) {
>  		dev_err(&pdev->dev, "Failed to enable clocks: %d\n", err);
> -		goto err_put_ctrl;
> +		goto err_put_clks;
>  	}
>  
>  	ctrl->cmd = pmif_arb_cmd;
> @@ -498,6 +498,8 @@ static int mtk_spmi_probe(struct platform_device *pdev)
>  
>  err_domain_remove:
>  	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
> +err_put_clks:
> +	clk_bulk_put(arb->nclks, arb->clks);
>  err_put_ctrl:
>  	spmi_controller_put(ctrl);
>  	return err;
> @@ -509,6 +511,7 @@ static void mtk_spmi_remove(struct platform_device *pdev)
>  	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
>  
>  	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
> +	clk_bulk_put(arb->nclks, arb->clks);
>  	spmi_controller_remove(ctrl);
>  	spmi_controller_put(ctrl);

Maybe we need devres versions of spmi_controller_alloc and
spmi_controller_add to avoid this in the future? I'm sure
drivers put all sorts of stuff in their private data.

ChenYu

>  }
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
