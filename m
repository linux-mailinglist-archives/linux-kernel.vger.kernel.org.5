Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09507B1B58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjI1Lnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjI1Lni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:43:38 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C4B7;
        Thu, 28 Sep 2023 04:43:37 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fa7e33573so362495139f.0;
        Thu, 28 Sep 2023 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695901416; x=1696506216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhAcDN4K7D/vTmH1Qkl5/PH1ae9Q+7eDYlNx5SqvDps=;
        b=JK4xMvO713wbZpuywukP4wEEYTKdVYapfpxMiGjToCMj01MA73F58KPa0y+ZhgLe6a
         ZwbgSqFnhNvLDPZQeZtmBvyxZde/pNchhA35KL7+WFPm7SUWPGAqn0h0FIJhHOR02Z0Q
         v8JrBePdqOfo8dKYgxDlo9wlKFotj4MfQZb+RFv9BxthldaaSe65cb59hpLFiF7gOc7A
         jcyy+YMv4zlOMk7G7Q/OrjwvpQvMPc7TugVt+wj1et+7mbRt6Me4+loOlfSntTJecHXO
         2BHREHuuqWBR09FSNR+xhH3tDzywYfaG4PQ4bb6yZHlrG9g7qJpYLW2IS/fH0SQuNBCg
         Dowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695901416; x=1696506216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhAcDN4K7D/vTmH1Qkl5/PH1ae9Q+7eDYlNx5SqvDps=;
        b=kg/IrXCwwqOqfQs66hzDfDUBY93y2hjP86VYmDp8773NCqvJUHydSw6VPAFmKoBnaI
         /NZ1GhUeaHktbngm6wziOWU1a7AwzTv/GDc9iYdDJRuUdPhP07K+keCIfbsY0np52rjG
         fr4Kn/sRGBfNrsl7I85oXsjoVwaIzZnXfR9bMD+EVJJCPIkOc5vdMZVobthpb2pD1TMY
         32rmw572NQgRQI126URSQWbmzOxMD8vnPPu1pYn2IoSS+xlFNhm4nSq2duEhThMESwY8
         w/Ezd9kRWXyrJFLsq4S6WiAG2yvGIZvReAIQVf22Lv2ePLdOGr+Jt/f9R2rfsKnjkj4F
         BhxA==
X-Gm-Message-State: AOJu0Yzyh++3jmxG9RP71o/TnvhwtQ2V8FDRbl5MhL8unIhm/M6OBZ15
        m9IZvxPvyZ94IKmUPeAYmmA=
X-Google-Smtp-Source: AGHT+IHv4Y+EOxcAPosS0sv0p0W1NVztEVlhV40SdyBD4tFtuVkRgoUeCMOYryXEi5Pq3F84FjIAmg==
X-Received: by 2002:a6b:6608:0:b0:787:4f3c:730d with SMTP id a8-20020a6b6608000000b007874f3c730dmr752837ioc.18.1695901416583;
        Thu, 28 Sep 2023 04:43:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cg11-20020a0566381bcb00b0042b3dcb1106sm4596901jab.47.2023.09.28.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 04:43:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Sep 2023 04:43:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-hwmon@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Add Hal as one of the maintainers of
 SFCTEMP HWMON DRIVER
Message-ID: <dc5e9253-5d82-4def-b6ff-038b29bf99ab@roeck-us.net>
References: <20230928075249.109459-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928075249.109459-1-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 03:52:49PM +0800, Hal Feng wrote:
> As he is the submitter of this driver, add his mail so he can
> maintain the driver and easily reply in the mailing list.
> 
> Acked-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
> 
> History:
> v1: https://lore.kernel.org/all/20230718034937.92999-4-hal.feng@starfivetech.com/

The change log should describe your changes, not just point to earlier
versions of your patch. Please do not expect maintainers to fetch old
versions of your patches and compare them manually.

Did anything change besides the Acked-by: ?

Guenter

> 
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b19995690904..2376272bbe20 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19402,6 +19402,7 @@ F:	drivers/net/ethernet/sfc/
>  
>  SFCTEMP HWMON DRIVER
>  M:	Emil Renner Berthing <kernel@esmil.dk>
> +M:	Hal Feng <hal.feng@starfivetech.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> 
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> -- 
> 2.38.1
> 
