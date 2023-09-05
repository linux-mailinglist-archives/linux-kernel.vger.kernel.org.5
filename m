Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF44793010
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbjIEUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbjIEUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:33:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440ACE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:33:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991c786369cso460427066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693945996; x=1694550796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGd37heVkKpNeW2/JaXN+6U9D28h1iXnKKCdvuTuCX4=;
        b=KLjwoIvLvbcwG8LNgTcr+FPI3NQNNPzY/ulVirwGWiQ85Qf9vxxBKCfEc1Hy3hzGxR
         IV8nIqrRlJg/mZoJRxjT+X4TUdQCmbX146fNFOsrlLEwfMuzcsBWDxgDMNFgJn+Po3hR
         oxiKovHdy/7t0TJTs54zgN9LsJ3khCDIQt4hGKCDGI4eMPVzPu7zGrW2QC/uaO6Cltdo
         /6FFnvIYkZj52FsWqI4ATUpVu7hmYJkhVttXd1y4NSxqkhao/SH/DT5SNpqqEEvJy8Hn
         zZmwv0hTuZ2dH6yaqtuDGqoqxD0+u0e/oDxeMi9C7bR4Fqb1esbVWZ0Pp8ySXPN9tGgL
         alow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945996; x=1694550796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGd37heVkKpNeW2/JaXN+6U9D28h1iXnKKCdvuTuCX4=;
        b=V6tgarndHlxhJeDfAMtRLJEBgFy+yGCqAck+llaPubvXH7z3XNsqRegejG1Vlfj9be
         TPx7bxKbNDOkHjgy3sSPIfIlNiJzsP3BTXl4nDDEhrZYGPnfTRgNcXfibItaVMOaFSmQ
         nG0BxY7LYInlfzDyuBhsZYjdjbyYQjskk+RgFfqOgqT5YTIPbAxLh2P8JYkkA3tTo3Bt
         HuUnI9qSIFg7xeHga5DBlGmxIwCh79fJhzyvt+Q3RAsiku6IGb3C0ax5NTDYMNk3jeZD
         SMVuCtXFMGNTV4B4gFndfvg4uSQmrio0d2FinoybO9WP03ySQ9QzUOOgwn/0XK/1eBND
         592A==
X-Gm-Message-State: AOJu0Yyt3zDIY864N0GMCdShsgle03TOQOdJeO4SJ+srUC1MaoQLv171
        m04v4TBcTRn/2TK4FCf9QkE=
X-Google-Smtp-Source: AGHT+IENZGk26Bm3PR5lydcBmGnBLfg4yzMPCxRYm/sOmVPlXgIH6rG0SRwq7IEeS0NdXyk/8TrfhA==
X-Received: by 2002:a17:906:314f:b0:9a1:fc1e:19ac with SMTP id e15-20020a170906314f00b009a1fc1e19acmr714243eje.33.1693945995700;
        Tue, 05 Sep 2023 13:33:15 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709061c1700b00992b71d8f19sm7964262ejg.133.2023.09.05.13.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:33:15 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     samuel@sholland.org, wens@csie.org,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] clocksource/drivers/sun5i: Remove surplus dev_err() when
 using platform_get_irq()
Date:   Tue, 05 Sep 2023 22:33:14 +0200
Message-ID: <8307837.NyiUUSuA9g@archlinux>
In-Reply-To: <20230831041414.66434-1-yang.lee@linux.alibaba.com>
References: <20230831041414.66434-1-yang.lee@linux.alibaba.com>
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

On Thursday, August 31, 2023 6:14:14 AM CEST Yang Li wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> ./drivers/clocksource/timer-sun5i.c:260:2-9: line 260 is redundant because
> platform_get_irq() already prints an error
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej
> ---
>  drivers/clocksource/timer-sun5i.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-sun5i.c
> b/drivers/clocksource/timer-sun5i.c index 69fee3540d37..0d229a9058da 100644
> --- a/drivers/clocksource/timer-sun5i.c
> +++ b/drivers/clocksource/timer-sun5i.c
> @@ -256,10 +256,8 @@ static int sun5i_timer_probe(struct platform_device
> *pdev) }
> 
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "Can't get IRQ\n");
> +	if (irq < 0)
>  		return irq;
> -	}
> 
>  	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk)) {




