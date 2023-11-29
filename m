Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223597FD149
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjK2IqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjK2IqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D43AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701247585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=indM6A7jagYAttzowg4VetKQUeiDwWNMdMnxfV2PQvg=;
        b=OFsLIro+PJ4yg3itEHUHdSCrJWHZ3Exj6b8zVmpdn6aQV+QTvThc74ePSJ3cuCIt6zf4nD
        qsDg43L8x1cZYrXfdjbD+avpbYa9q4+ehEf9DIaZndUonpfhH2CPzQNQ0M2LQtrFhJI3AK
        OPc1q9Q2S1vLUsEhz81qWB/ng+A3IVI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-QMU15WU0MGCJvQmpGlmIBw-1; Wed, 29 Nov 2023 03:46:24 -0500
X-MC-Unique: QMU15WU0MGCJvQmpGlmIBw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a0bdc9cefedso101788266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701247583; x=1701852383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=indM6A7jagYAttzowg4VetKQUeiDwWNMdMnxfV2PQvg=;
        b=j9BpMWhmP0fg9Mphq360hRBiBmkQUowgmuHjMdVxf3ILiPS7hWPu1x+p51sm2/DqNd
         ShbMIszmJTyN6pPDhYjLXVpIf6cFag0NOEFOZVnmuCb/2Nh1JUkCs1WIYEcSesjGQqMW
         uBZXa4VxD7/zU+ODuA2RA3Ml+WZfhMlBkOjPBcTn0qr6aaT7f/wOIOU9p0kyT/kKCPCS
         nukA0IbJm/6mMJFk8dCDuDOu5AHey4nC3Qz8O/7MPcP6zTw3CJwOY9FzFGwXPmdVWKdy
         wcxVkHN/IT/VhSh/2Xy+aeGCYH670FwrSXLeUee2hV+8Rh2y59xvdeDO2nzoNj2C0Z1C
         inIQ==
X-Gm-Message-State: AOJu0Yy+F0lc6ipMp0Oi1Ojtc/McGYu5D8IS9JXtzlxhNWcPwX5fFu+U
        1I7DmFx3t0+utV/42rOwtn1spPJstNgp47iJOcu3Vz7FFQzSOw9g+q6jrL47DakjcZ9kkZWHlZc
        tBpmz+aOcs2Fe4WFP6J+0zXtP
X-Received: by 2002:a17:906:5302:b0:a16:1b4a:a6fa with SMTP id h2-20020a170906530200b00a161b4aa6famr3270621ejo.8.1701247583358;
        Wed, 29 Nov 2023 00:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF42YJl8n/EKC89NE1fnwbQAbIP2q6bWuq/t/5wnOzJVB0yvVZWMFK+uZ+Ydv5Bp6I6YSE+rQ==
X-Received: by 2002:a17:906:5302:b0:a16:1b4a:a6fa with SMTP id h2-20020a170906530200b00a161b4aa6famr3270607ejo.8.1701247583081;
        Wed, 29 Nov 2023 00:46:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id pw10-20020a17090720aa00b0099cce6f7d50sm7681353ejb.64.2023.11.29.00.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 00:46:22 -0800 (PST)
Message-ID: <5b02572b-1be2-41e4-9959-a811ca02fb54@redhat.com>
Date:   Wed, 29 Nov 2023 09:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: i8042 - add noloop quirk for Acer P459-G2-M
To:     Esther Shimanovich <eshimanovich@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Denose <jdenose@chromium.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Werner Sembach <wse@tuxedocomputers.com>
References: <20231128214851.1.Ibc66f1742765467808fb28a394f8f35af920aa49@changeid>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231128214851.1.Ibc66f1742765467808fb28a394f8f35af920aa49@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/28/23 22:48, Esther Shimanovich wrote:
> On the Acer P450-G2-M, after the user opens the laptop lid and the device
> resumes from S3 deep sleep, the screen remains dark for a few seconds.
> If the user presses a keyboard key while the screen is still dark, the
> mouse and keyboard stop functioning.
> 
> To fix this bug, enable the noloop quirk.
> 
> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



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

