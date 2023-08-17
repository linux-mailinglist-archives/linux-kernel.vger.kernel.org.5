Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C377F1C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348716AbjHQIEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348711AbjHQIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:03:46 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A4E48;
        Thu, 17 Aug 2023 01:03:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA4E86000E;
        Thu, 17 Aug 2023 08:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692259423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NewrycBMfOvEw8n3qpWjyuFw5739An2QT3kzbqN3OEA=;
        b=fnJLVJOPqNtuL6+g+Jnv7gP6dy7wUMYE6pOS55QRoU8FCqVmK9GLtDsl6JI5ZZuNGd6jad
        pXekBeN+3BPGj6fVDjEto6VhZ0h0VJH0A/jJtxgIiEyM6DS/5ZtlE16wUI/aKcLMXt8NUC
        9o+ZQvgZ8+tDkum2qfh7GHpPVH7kHp02Edl2HPiyxEtpLywY9g3PxYyMK5r6Q5LlxTvdJB
        H4AKoFWiGuxiYUY2veyO7AyDJNBvPa0PcmU7uUzE+Jqc/ST794f7vTFfVJYkHVFTFDQenN
        cUlkqDJiA55IUxJ6dGGKTsz93/GB0Ip+3M3oJI/JiTUX+dnJ9GpLKOKOOOFG2w==
Date:   Thu, 17 Aug 2023 10:03:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 7/7] rtc: rzn1: Report maximum alarm limit to rtc core
Message-ID: <20230817100341.15867e4d@xps-13>
In-Reply-To: <20230816133936.2150294-8-linux@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
        <20230816133936.2150294-8-linux@roeck-us.net>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

linux@roeck-us.net wrote on Wed, 16 Aug 2023 06:39:36 -0700:

> RZN1 only supports alarms up to one week in the future.
> Report the limit to the RTC core.
>=20
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/rtc/rtc-rzn1.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index dca736caba85..c2cc3774ebb8 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -351,6 +351,7 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
> =20
>  	rtc->rtcdev->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
>  	rtc->rtcdev->range_max =3D RTC_TIMESTAMP_END_2099;
> +	rtc->rtcdev->range_max_offset =3D 7 * 86400;

When we set the alarm, we use:

	farest =3D rtc_tm_to_time64(&tm_now) + (7 * 86400);

What about using range_max_offset (whatever its final name) in this
calculation as it will be now set in probe? It would further clarify
its purpose.

>  	rtc->rtcdev->ops =3D &rzn1_rtc_ops;
>  	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
>  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);

With the above change,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
