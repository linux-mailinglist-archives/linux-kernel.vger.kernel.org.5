Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302B27FEC26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjK3Jtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3Jtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:49:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21BED54;
        Thu, 30 Nov 2023 01:49:55 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A8406602F1E;
        Thu, 30 Nov 2023 09:49:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701337794;
        bh=PZ4o18TmuhBsGGT4rtN1qfP0i7FFHevi8/u0G156Vwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dazRXuFLjVL+vCZngSiFfIivtpq4cARDWVINxmkd1/WHBa9mp1UWLCJYXSteKJ/XK
         QO4T+zlPKt7EgWlsbk1+Z7sKkI0cpHFsisFu82rwpPAvNc/HifnngDMPeqWZdOTcqP
         qrSI9BxNw6efehTOZB7WOlAWWSxBlu4Yv8u1S1HP98dpCCZHJ4LvNVU+nl2LmuG44w
         7e2l0YsRU0HFUUow9nWClhIaI4kx5FhssCvizVfr/YGzbJDbuyosVrksrMyN82ZJV+
         TjJ+BCghXsCK/wNl5kjq6c+mCJ1baQ0ioZmpnAMLcRnO0s95JkYwAMZCn4Llqx9Mzq
         9TEWqxlNkZA0A==
Date:   Thu, 30 Nov 2023 10:49:51 +0100
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mchehab@kernel.org, jackson.lee@chipsnmedia.com,
        nas.chung@chipsnmedia.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] media: chips-media: Remove surplus dev_err() when
 using platform_get_irq()
Message-ID: <20231130094951.dnhk6zy4zejgezxq@basti-XPS-13-9310>
References: <20231127010955.605-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20231127010955.605-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yang,

Thanks for the patch!

The commit subject line should point to the respective driver and you
can drop the brackets, so:
`media: chips-media: wave5: Remove surplus dev_err when using platform_get_irq`

Greetings,
Sebastian

On 27.11.2023 09:09, Yang Li wrote:
>There is no need to call the dev_err() function directly to print a
>custom message when handling an error from either the platform_get_irq()
>or platform_get_irq_byname() functions as both are going to display an
>appropriate error message in case of a failure.
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7636
>Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>---
> drivers/media/platform/chips-media/wave5/wave5-vpu.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>index bfe4caa79cc9..3f7c622e8d58 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>@@ -209,7 +209,6 @@ static int wave5_vpu_probe(struct platform_device *pdev)
>
> 	dev->irq = platform_get_irq(pdev, 0);
> 	if (dev->irq < 0) {
>-		dev_err(&pdev->dev, "failed to get irq resource\n");
> 		ret = -ENXIO;
> 		goto err_enc_unreg;
> 	}
>-- 
>2.20.1.7.g153144c
>
>
