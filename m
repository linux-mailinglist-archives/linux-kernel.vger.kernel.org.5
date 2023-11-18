Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6646A7F030C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 22:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjKRVuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 16:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 16:49:58 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BD9182;
        Sat, 18 Nov 2023 13:49:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so8243884a12.0;
        Sat, 18 Nov 2023 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700344194; x=1700948994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu8B/DrosgiV85GSiOsUY9FsBSgQ5Nsx1mRRxIDJDOU=;
        b=YdS/6sVMQ60XA+ogF1yphuhWdZol+UlrJRCJnQ3Nt0ljfdbf57bPBTXJWlnMWZNiwZ
         7NV6dIIt+jG8MuVfOcSgs7JCxAqrzGy53bPjzOg9kCbWmqnwKRg3OCU8V3WZGw7W0qSK
         CyWTQMvw3LOeNBCSfppDK3ajn4nd9Lu2ueCA78ltnbLIoAnBeFRJ9r+Uo/ZnRK7/FHLp
         j2I4/DyhGTEbbLRHZY0TBjJqByPhdWdp3vs9qkoy0lgKRLUZpWVKRIiaTT4SOPDIzbIY
         CAEXEgdZ0aMWLKTXzGUfsoL7VwymZohPSCgcI/u5zI/ADmdfwBFtrPz4jDa67vkrh8Kk
         qiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700344194; x=1700948994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu8B/DrosgiV85GSiOsUY9FsBSgQ5Nsx1mRRxIDJDOU=;
        b=jLrj7ZVKjT5CaNaX4lEdvsjCXgH//4sFJLbeYw2QDxXVJc/MVeVsTs1RU0nEmCOK3j
         Z3pBOPmHiaFZOSS6VGjouVIe8LkPW2q1KSLa3vMWTAnt4YKVgZiHD2F9c6qooJRdB59P
         xOadtdCNBxL7oExnk6w3Jgu+r2iAjf5Bl3Srq4I3eJZyYwz6n1JPwY2YOdOPul1VpUsc
         xFvcwqBXUI+5ywSFbRBjW5eE+e8qNkldG5xJtd33pFs+RSICcbSpcg/XOH5No6N9No7S
         V0+rJtwCU1FgjFWa3XxmhjXtqBBZztdu+1cbPkp1kn141sgtGXwqfVljBe0boEz6WWPv
         EiSQ==
X-Gm-Message-State: AOJu0YyrJzZTJMHhESXwENkg7mZr8c+AM64o63FEWoScUUqJLY/LF8f/
        vBq/hkOKZdGWbCl+RXpmquU=
X-Google-Smtp-Source: AGHT+IGvGe/YhVqfTTgGOZH6rxAZKgoCFGPA+F4kHVoXMK1rmU/eIymVSurR+kzjcJHGaQ8dnTci8A==
X-Received: by 2002:a17:906:38da:b0:9ae:50ec:bd81 with SMTP id r26-20020a17090638da00b009ae50ecbd81mr6889839ejd.21.1700344193504;
        Sat, 18 Nov 2023 13:49:53 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id cm7-20020a170906f58700b009e5e1710ae7sm1028955ejd.191.2023.11.18.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 13:49:52 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/20] drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c: remove
 I2C_CLASS_DDC support
Date:   Sat, 18 Nov 2023 22:49:51 +0100
Message-ID: <2705713.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20231118174221.851-5-hkallweit1@gmail.com>
References: <20231118174221.851-1-hkallweit1@gmail.com>
 <20231118174221.851-5-hkallweit1@gmail.com>
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

Dne sobota, 18. november 2023 ob 18:42:04 CET je Heiner Kallweit napisal(a):
> After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
> olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
> Class-based device auto-detection is a legacy mechanism and shouldn't
> be used in new code. So we can remove this class completely now.
> 
> Preferably this series should be applied via the i2c tree.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
> index d1a65a921..f5f62eb0e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
> @@ -302,7 +302,6 @@ int sun4i_hdmi_i2c_create(struct device *dev, struct sun4i_hdmi *hdmi)
>  		return -ENOMEM;
>  
>  	adap->owner = THIS_MODULE;
> -	adap->class = I2C_CLASS_DDC;
>  	adap->algo = &sun4i_hdmi_i2c_algorithm;
>  	strscpy(adap->name, "sun4i_hdmi_i2c adapter", sizeof(adap->name));
>  	i2c_set_adapdata(adap, hdmi);
> 
> 




