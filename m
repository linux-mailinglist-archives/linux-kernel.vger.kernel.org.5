Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916817F7DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjKXS2p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 13:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjKXS2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:28:44 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019251BDA;
        Fri, 24 Nov 2023 10:28:51 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f947682bfdso249027fac.0;
        Fri, 24 Nov 2023 10:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700850530; x=1701455330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLMFfODH5jS5YDFDQszChNMcGREuaPeTgi8qOTAaUV4=;
        b=Dud0luotF7MeDx3pnMruQU57XyPHns2evqyITZ3plpa0J26zuCXq4X1nGCt5wS3ddu
         QDvSl1EeNo1/H/M2g1YwLedzjqQGMzcyi9CfNvz6qW2zrBs3O7nJe4kX1ztEYLWnn5be
         zvCQ9Q2jkUUup3NcYDDwHM0mamgp3B0liKA5sVAHfOrrz8yNA6AB0zcxqeKjuz2rYW1G
         95dxlWAbNrw55lNtVvznaxtQgyOuhs6DxuQcbM5H0EtLOjwKG4GwqJTSdBjAF9TSJCUt
         nlF2cE5XlJwfe5PhRt1nBIiFQ10lZ+XytLtdEh6beu1zJ4cWh4GqrtTDGSZBHNHUzzmp
         eCmQ==
X-Gm-Message-State: AOJu0YwnhntB6fZObdO/xLo3rop38pGun5wKZ/Vvzfk+VRkr6bYuz7Tz
        V+RThvFgFKuEmJIccsAg+hjhRwqtdgzmkqiq0DQ=
X-Google-Smtp-Source: AGHT+IFA23KXKUtBvwZXL0qoxd/H2xL519xL2sSsV0wJ/6Bp+k3CisKabYhut6LpNi87nfOtk/l9p04HId0O/+d5TrU=
X-Received: by 2002:a05:6870:d914:b0:1f9:602e:7b0d with SMTP id
 gq20-20020a056870d91400b001f9602e7b0dmr5597329oab.2.1700850530254; Fri, 24
 Nov 2023 10:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20231123070010.4013969-1-arnd@kernel.org>
In-Reply-To: <20231123070010.4013969-1-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Nov 2023 19:28:39 +0100
Message-ID: <CAJZ5v0gNE8expsADwoTgDEoTa_5G-R_sBobFEiqLOh0VS5yVug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal_lib: include "internal.h" for function prototypes
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 8:00 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added functions are declared in a header that is not included
> before the definition:
>
> drivers/acpi/thermal_lib.c:46:5: error: no previous prototype for 'acpi_active_trip_temp' [-Werror=missing-prototypes]
>    46 | int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
>       |     ^~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/thermal_lib.c:57:5: error: no previous prototype for 'acpi_passive_trip_temp' [-Werror=missing-prototypes]
>    57 | int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/thermal_lib.c:63:5: error: no previous prototype for 'acpi_hot_trip_temp' [-Werror=missing-prototypes]
>    63 | int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
>       |     ^~~~~~~~~~~~~~~~~~
> drivers/acpi/thermal_lib.c:69:5: error: no previous prototype for 'acpi_critical_trip_temp' [-Werror=missing-prototypes]
>    69 | int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 6908097aa5a7 ("ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/thermal_lib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/thermal_lib.c b/drivers/acpi/thermal_lib.c
> index 646ff6bda6dd..4e0519ca9739 100644
> --- a/drivers/acpi/thermal_lib.c
> +++ b/drivers/acpi/thermal_lib.c
> @@ -9,6 +9,7 @@
>  #include <linux/acpi.h>
>  #include <linux/units.h>
>  #include <linux/thermal.h>
> +#include "internal.h"
>
>  /*
>   * Minimum temperature for full military grade is 218°K (-55°C) and
> --

Applied, thanks!
