Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB2B802654
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjLCSlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjLCSlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:41:16 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3014F2;
        Sun,  3 Dec 2023 10:41:21 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a9febb2bfso21049266d6.1;
        Sun, 03 Dec 2023 10:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701628881; x=1702233681; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rzC7AwiD2ism0BxvRNDBrlamkH0SDA4Mgg+tSEpn4KM=;
        b=JZMz6ZrCkrBaBoghweWud+IKuqmKQLSd66UjL3r85WewIebA5/io1+i1cpZt46WOFC
         YVkM2Lwiq0cypixi0TApUDjp4p5Q6F60CLB63T0fAmCpMcU1RAgKxK93BvuTnX7hJVQK
         DfMxX9Zbtlx08jBe783/roxQHiwGWyAE2tBbaJgGBE/tzcQY96fqJU31qRtiRoV4X1ed
         BMPffpCfJsds2vMe6VuDZi2zjsq6qMHP6+sZxL/ZSRnr7ol2tJrnKX1PJPk0e2Kgct4S
         zdFINI2TwjHMKS+t/NqlzRIhF26kJaHSZ0dgJQ7Y4NaQBklJnv52zap2Ei5x2c+4SN9v
         Vuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701628881; x=1702233681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzC7AwiD2ism0BxvRNDBrlamkH0SDA4Mgg+tSEpn4KM=;
        b=TD8HEWN65OC8Rrlgk822xww1sRSVVcDHiifucta1D880pUVNvZpxV7hJ0HAaZIRxIE
         S96NC5QWxCCpUIS1Tsc60svBHpvCOT8KeyESArghJi6OCP2u4JmQSym5k7JH4eJaJNwd
         jr7V7v+0ySo5CL25mERiRYYc73Mxi4vKPc4MlR/je8+rVdcrNcINIEOtRq6uzuy0V73e
         1N71IZI8FnICFml3jAR+Ujxje+r2eECKJjrdItrSSBdvKSF4Ej/G+NPFq6Rq+RLdGnhM
         BVVgH/YD9FjGiYrLI2DsCbNTmTK26qezDsvVHbXG+ny7Mz2DwqNs4XhWQNyrae8kEq3H
         ncmg==
X-Gm-Message-State: AOJu0YwHE97jCEfUVV8/Kwm1WIjRtCRGG/T42a5ZGWVi9Fi0jtu4cA5c
        x6Ttkv/RZYYgr1DVk6aKLKAIWYrOkBA=
X-Google-Smtp-Source: AGHT+IFs+Co89rErLNgDcRCheppvJbtSWAU1FkM4VY58FH9EAJcEoMh9F1GymIDLR707WGu/vSV90Q==
X-Received: by 2002:ad4:5892:0:b0:67a:a721:f319 with SMTP id dz18-20020ad45892000000b0067aa721f319mr3303529qvb.89.1701628880675;
        Sun, 03 Dec 2023 10:41:20 -0800 (PST)
Received: from google.com ([205.220.129.26])
        by smtp.gmail.com with ESMTPSA id t20-20020a0cde14000000b0067abc8a1e44sm750086qvk.91.2023.12.03.10.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 10:41:20 -0800 (PST)
Date:   Sun, 3 Dec 2023 18:41:01 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Zack Rusin <zackr@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Raul Rangel <rrangel@chromium.org>,
        linux-input@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] input/vmmouse: Fix device name copies
Message-ID: <ZWzLvctpo1nNTMOo@google.com>
References: <20231127204206.3593559-1-zack@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127204206.3593559-1-zack@kde.org>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zack,

On Mon, Nov 27, 2023 at 03:42:06PM -0500, Zack Rusin wrote:
> From: Zack Rusin <zackr@vmware.com>
> 
> Make sure vmmouse_data::phys can hold serio::phys (which is 32 bytes)
> plus an extra string, extend it to 64.
> 
> Fixes gcc13 warnings:
> drivers/input/mouse/vmmouse.c: In function ‘vmmouse_init’:
> drivers/input/mouse/vmmouse.c:455:53: warning: ‘/input1’ directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
>   455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
>       |                                                     ^~~~~~~
> drivers/input/mouse/vmmouse.c:455:9: note: ‘snprintf’ output between 8 and 39 bytes into a destination of size 32
>   455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   456 |                  psmouse->ps2dev.serio->phys);
>       |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Zack Rusin <zackr@vmware.com>
> Fixes: 8b8be51b4fd3 ("Input: add vmmouse driver")
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Raul Rangel <rrangel@chromium.org>
> Cc: linux-input@vger.kernel.org
> Cc: <stable@vger.kernel.org> # v4.1+
> ---
>  drivers/input/mouse/vmmouse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
> index ea9eff7c8099..7248cada4c8c 100644
> --- a/drivers/input/mouse/vmmouse.c
> +++ b/drivers/input/mouse/vmmouse.c
> @@ -72,7 +72,7 @@
>   */
>  struct vmmouse_data {
>  	struct input_dev *abs_dev;
> -	char phys[32];
> +	char phys[64];

This simply wastes 32 bytes. It is perfectly fine to truncate phys
(which does not happen in real life).

-Wformat-truncation is disabled in normal builds, folks should stop
using it with W=1 as well.

Thanks.

-- 
Dmitry
