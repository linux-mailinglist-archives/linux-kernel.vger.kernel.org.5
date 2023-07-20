Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E39575B75F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGTTDU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jul 2023 15:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGTTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:03:11 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB931BF7;
        Thu, 20 Jul 2023 12:03:03 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-98502b12fd4so37441766b.1;
        Thu, 20 Jul 2023 12:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879782; x=1690484582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwiGqJMiJAOcW8GMzi5J31EUeS5mMFiPqph2dNdcRYY=;
        b=hcNdCc1q4erVoBtEniEJFYWgmugXqcls77Ta3zSa7zc1czGTcJ/joAfTZb10eMBInm
         Ba3ba/MLW/t5/WqSMI0J+1nL+bWJy/2RY23Wmy1N0/EqaRHdtJ9UmYBRQwEs1bTjbzuG
         M8tItiSvwrHBNUzYZyxCYxixl5om+GPXp6ZbfxQKKPQEzc9ZkzeG58Ym/n1dEqFoRy/3
         RqVcPvon5VRqHIV24p9RCW5+rijLH96FeyndbC+KXAcpSdHOSQxQMOLe8kshgbKyxb0+
         vnrIa/GOXtmiOaAOIJERtjb9eQKbXYUdTnaUmcuTkvoh5jXgRLy0sspFURHqMEZpNq/g
         vyZA==
X-Gm-Message-State: ABy/qLZAApo7UG2uLCCM2nlbL+EHUqtufC22dOYcU3UlpojtY/Afp6As
        +0xHdGjyzJWgxZGQrND2zG3BmDzFQHf3S9mWHVw=
X-Google-Smtp-Source: APBJJlFwQXZXm8xMBtE8zQIz2LMHFKO+aPqFebqhBaXVkhPcfZhrQp2MEW+hzMFZ7Wf1iQl5kH2HxSVDVES6AYRxo5k=
X-Received: by 2002:a17:906:2205:b0:993:eed1:904 with SMTP id
 s5-20020a170906220500b00993eed10904mr10865844ejs.3.1689879782241; Thu, 20 Jul
 2023 12:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230719011636.2893238-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230719011636.2893238-1-peng.fan@oss.nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jul 2023 21:02:51 +0200
Message-ID: <CAJZ5v0g65YYjqKCgEh6793mhnG3+bbDy4vUbOty1Q71Pbn76eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/core: fix potential memory leak
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
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

On Wed, Jul 19, 2023 at 3:12 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> thermal_set_governor may allocate memory for tz->governor_data, so
> need free it in failure handling path.
>
> Addresses-Coverity: 25777220 ("Memory leak")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/thermal/thermal_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 842f678c1c3e..f633924406ad 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1355,6 +1355,9 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         return tz;
>
>  unregister:
> +       if (tz->governor && tz->governor->unbind_from_tz)
> +               tz->governor->unbind_from_tz(tz);
> +
>         device_del(&tz->device);
>  release_device:
>         put_device(&tz->device);
> --

Daniel, can you take a look at this series please and let me know what
you think?
