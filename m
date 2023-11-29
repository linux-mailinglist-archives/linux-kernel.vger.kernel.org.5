Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628A47FE054
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjK2Tbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjK2Tbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:31:40 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E34EA2;
        Wed, 29 Nov 2023 11:31:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso85416a12.3;
        Wed, 29 Nov 2023 11:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701286306; x=1701891106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Po/hmipXoYOdXNnwslR0sMGNfKwqPTuwnWmmGrhthl4=;
        b=Rp0zwUdC2Ih5czDlpmTYed+QvZ+eGxgivRk+PSTwE6fpRda3KZTVLwcHWejuwlqLbY
         qFWCCfoYqP6CTMyUnZ6baOWtu0aVNoME24MRRM6RkXCuCQO5bhgLMMoSbpAjRNzJuUHU
         3fybYMuw9c+e3moGOAV8WZ3VgufijZaAN2xs/+RZhXD0k6ClgjiaBjgo4eMQFgavlZQO
         8dtY7t0JPX4oRfAwOLFY4xhjQZFvKRY9COmaHbtp/Bw+ZLuW0NJTALkMU5KzxnaFzi2q
         jUJke4bCsgBQpsp26JG11xnS8t2UN4ni2dHxn5Ii4nNEL+ge+1wUoRedG/F/+wP/6MSw
         qjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701286306; x=1701891106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po/hmipXoYOdXNnwslR0sMGNfKwqPTuwnWmmGrhthl4=;
        b=ket7kBF0dSQ203sqopEU30LoJJfSK/7QxGg4JTt52VHY6FIsQImxnbhYWq6K4puWxa
         jE7nOvB9kPohRp4uOfZ/kcUDjcnmAJCHfzz3pidPhQ8CLWmIGgXVh5+jOMWlRjD0GDAl
         3cvEPrNqeLGEBISt0nRjgI9tsNHg+XsghkH8fUHAvvwvaRL4HsjJjDfEfrOcMffsbgpP
         6hYdz9G/QUk1Ekgbcxeq9zpjNHRDwTvopsLHLEqu7Cl7n+PSWt3BIYLm3M2vTVyiahF8
         wg4eVke0uvTH1PJdPgcs020XUmSoYirgdiVgIjsr4W2GDYXYfRcfRO+Y3V/mIqaw/mRa
         hXJw==
X-Gm-Message-State: AOJu0Yw0eR4Z6B3mfEmJUJBsRyKFdKINVBYZ48J9OU9XmBrz8UOEnEMD
        KI9J9/+C8/35gL9Qt2qDz6ZMtg4ZJLA=
X-Google-Smtp-Source: AGHT+IFhNL9RqqrG7BwEM9W271B23ceRVvjNk1A9AyXTnL/KTIq0h6qO03jCII2jAGMiXHmzfe7ezw==
X-Received: by 2002:a17:90b:3783:b0:285:81a9:4fb4 with SMTP id mz3-20020a17090b378300b0028581a94fb4mr22871311pjb.28.1701286306349;
        Wed, 29 Nov 2023 11:31:46 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:c00:48c1:860b:6458])
        by smtp.gmail.com with ESMTPSA id ep9-20020a17090ae64900b0027d0af2e9c3sm1755133pjb.40.2023.11.29.11.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:31:45 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:31:43 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Esther Shimanovich <eshimanovich@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jonathan Denose <jdenose@chromium.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH] Input: i8042 - add noloop quirk for Acer P459-G2-M
Message-ID: <ZWeRn8gI5msv1myw@google.com>
References: <20231128214851.1.Ibc66f1742765467808fb28a394f8f35af920aa49@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128214851.1.Ibc66f1742765467808fb28a394f8f35af920aa49@changeid>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:48:54PM +0000, Esther Shimanovich wrote:
> On the Acer P450-G2-M, after the user opens the laptop lid and the device
> resumes from S3 deep sleep, the screen remains dark for a few seconds.
> If the user presses a keyboard key while the screen is still dark, the
> mouse and keyboard stop functioning.
> 
> To fix this bug, enable the noloop quirk.

Are you sure that you want to disable loop and not mux mode? The only
time we issue the "AUX LOOP" command on resume is when we try to restore
MUX configuration...

> 
> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
> ---
> 
>  drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index 028e45bd050bf..b81539bacb931 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -941,6 +941,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		},
>  		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
>  	},
> +	{
> +		/* Acer TravelMate P459-G2-M */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate P459-G2-M"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
> +	},
>  	{
>  		/* ULI EV4873 - AUX LOOP does not work properly */
>  		.matches = {
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 

Thanks.

-- 
Dmitry
