Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E180A80A377
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjLHMiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:37:58 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C8A1989
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:38:03 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5d8ddcc433fso16988147b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702039083; x=1702643883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IR7p3VCuqTrXdfqqAHl0q0Bm2x8PVy01TiFzisyyuoQ=;
        b=U3xKEXqqOqr8kYcSF8ySZC1idHPI678Z8Hv6U2cYF+aOvzbHT7nVWHGXY4w0C5Lmqd
         jVK2iC42/uQf5jGO3daHIizo7iBfhTpBllT9GD2WuSNJYJHJO17YopQd4l3tTeEpBKg2
         j8oThaJ48fgdN75HWqiPEsXO9N04Wjr2UtvuCqpEocQPOFku5PlVT+I3M0tehzNlyeuK
         225f35ntPlfnqeCOWQQFJ3L3PQB994R80H37DUA6hwjhjwPnXOSxKgEam0KvlPmjcvkb
         Q1g+5DJx7LJUZndgHJBJKu9QEG9pdTehTZxIaVm4Ehrly7lRkT3bK52HTrAkxgEev/yE
         ymUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702039083; x=1702643883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IR7p3VCuqTrXdfqqAHl0q0Bm2x8PVy01TiFzisyyuoQ=;
        b=nc0LIad4AkmrYw3+5OtMxpwGQZo6nafRCYXeRucR6AbdXuOZjMy+UNMnksDZLxZ/qJ
         CZxvJCmqve4eh+clEGQL4YAr1ggcWO35bAmz9I4OZvDhZr4hnIjAOiPzOM32kkSu9IFz
         oSTO7JYwnYJP0595X94L+U5KKK8PXM/GYdDiLzC/ChuG711hcafxyMKxc3apfJ2+1xTh
         J0/p9Wi7TdNEGxvnXvs5L9k/aIgmaBK/donBmQTB3SnSoOHUo5qQkyE9gMOcx3dFkjal
         bGDBB31+ATOJ3gsJVRCrj+YhNQhdgppQ1INPcTvm1cLvITCoGuYfI74ZMeu2yomhb10+
         SQbg==
X-Gm-Message-State: AOJu0YxZP2QUzucCexa+mMRZHuxxE7gM5gcNEm8mT1iLvgSxPtRs5ST/
        EVZUs1CY+z34phzeGPM7/f2n4q15xf/e84s7iQdAAQ==
X-Google-Smtp-Source: AGHT+IF0UH2sSQEBhchSZl4V91/za1XaFiXUOZ2Bew0ljWKjs7t8gKn2zMfV8GKpJyu2LPXASRcEXFTBMQVPbMqgbkw=
X-Received: by 2002:a05:690c:fc2:b0:5d7:1940:8dd9 with SMTP id
 dg2-20020a05690c0fc200b005d719408dd9mr3633060ywb.64.1702039083054; Fri, 08
 Dec 2023 04:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20231208123603.29957-1-johan+linaro@kernel.org>
In-Reply-To: <20231208123603.29957-1-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 14:37:52 +0200
Message-ID: <CAA8EJppxG36=dRHkpuZfUu-H2L93iTU3fY1bdA0gN5w6KW3x2Q@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: fix gpio-based orientation detection
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 14:37, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Fix the recently added connector sanity check which was off by one and
> prevented orientation notifications from being handled correctly for the
> second port when using GPIOs to determine orientation.
>
> Fixes: c6165ed2f425 ("usb: ucsi: glink: use the connector orientation GPIO to provide switch events")
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>
> I found this one through inspection when skimming the driver.
>
> Johan
>
>
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index db6e248f8208..4853141cd10c 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -228,7 +228,7 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>
>         con_num = UCSI_CCI_CONNECTOR(cci);
>         if (con_num) {
> -               if (con_num < PMIC_GLINK_MAX_PORTS &&
> +               if (con_num <= PMIC_GLINK_MAX_PORTS &&
>                     ucsi->port_orientation[con_num - 1]) {
>                         int orientation = gpiod_get_value(ucsi->port_orientation[con_num - 1]);
>
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
