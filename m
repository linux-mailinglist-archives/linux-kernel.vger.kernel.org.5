Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EB37EC7DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjKOPwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjKOPvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE951AD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700063462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1fbGF7Qkv7teUuJLTRPkGkYvp5FXnG2+paeUI2HZvM=;
        b=KP6SFsLq4nTWfJBS1spXofdJpb0kLamsgh9qo27QAGdkb2Btwp6uzJmuKsgXHPj7U6+loo
        JsOPyjclY0ippurhGofmPL5ijLpLesCtnNt3+l2+itzoVXiuqNOcQT1//FqldH/xYbYKFO
        6QziJQ8NfJVvn2uel13NKwkP9qQovcM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-LPp7aBYMPcmWOsrrr11xIA-1; Wed, 15 Nov 2023 10:50:59 -0500
X-MC-Unique: LPp7aBYMPcmWOsrrr11xIA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507cee14477so7503470e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063458; x=1700668258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1fbGF7Qkv7teUuJLTRPkGkYvp5FXnG2+paeUI2HZvM=;
        b=ce1KmCY9fescYbGY+oJWPDwsrw2IpmooQS+XgJorEkgBkEmxQcybXkbL5LfK6XGYvX
         snCjXwNd1Sf/CndFJsN0QkGNQrkmNrpa1CnRppz1Cjq1XzipusdjzKwfdx8Tfagy6epl
         nIuKIVbrBS2EYVnz23M1KECqo5irey5oHJHweAk0Ru7UiuXsmjWJHMH8uLkosGOZ2jM8
         92cj0CKpAsJZpQl4EGWpgaS4nX68jyt/O1cpD385xkVYqaMGbknpxuHnuOc9arue1goe
         P6i88Y+y0z8LlXXkq1sNn54m60VCFoSMlnRv+5ZryQXiejpblHjIgiZME0XpkbkRXM9M
         otGA==
X-Gm-Message-State: AOJu0YxrnDFahkdWEB/on+lwhVkLsa/d+UsifDG1eQQtrF6JGSXlaP9K
        vjV+sulrmEimzb1nEqSolb7V74y8v7tDolrccnd187gP0vtpjjTzvRJq+wPfSmbwahiNxwJoKD6
        tQ1fcKCAAyJJsGPUtSEDBTbWbxbvew/j5
X-Received: by 2002:a19:2d59:0:b0:507:984b:f174 with SMTP id t25-20020a192d59000000b00507984bf174mr8384273lft.48.1700063458231;
        Wed, 15 Nov 2023 07:50:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL1znuxl2ULUiExZruoVbV/H+47fM+nDMFfZuJyFLjC1AAX5XUVosc+FBmsmiqu+o1APToBQ==
X-Received: by 2002:a19:2d59:0:b0:507:984b:f174 with SMTP id t25-20020a192d59000000b00507984bf174mr8384254lft.48.1700063457912;
        Wed, 15 Nov 2023 07:50:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b009b95787eb6dsm7216951ejb.48.2023.11.15.07.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 07:50:57 -0800 (PST)
Message-ID: <4570d94e-b446-4fd1-a24a-db11a87846c4@redhat.com>
Date:   Wed, 15 Nov 2023 16:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel-orientation-quirks: add Lenovo Legion Go
Content-Language: en-US, nl
To:     Brenton Simpson <appsforartists@google.com>
Cc:     Allen Ballway <ballway@chromium.org>,
        Patrick Thompson <ptf@google.com>,
        Jared Baldridge <jrb@expunge.us>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231114233859.274189-1-appsforartists@google.com>
 <70f12e96-0fcc-4954-8507-27cf5e15a3b2@redhat.com>
 <CAAL3-=9YYQBV-T-KhHdYrtGHH1RC29uzTuQ98roAY9GwrNrwmg@mail.gmail.com>
 <CAAL3-=-b3-RZNNfQEYzQxK=SW4PPJ7cmrX8omBniec+tgC2frw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAAL3-=-b3-RZNNfQEYzQxK=SW4PPJ7cmrX8omBniec+tgC2frw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/15/23 16:48, Brenton Simpson wrote:
> Resending from the email address linked to my GitHub account.

Ok, this doesn't really help. I'll just fix-up the author
field of the original patch.

Do understand correctly that both the author and the Signed-off-by
should be set to:

Brenton Simpson <appsforartists@google.com>

?

Regards,

Hans



> 
> -- >8 --
> 
> The Legion Go has a 2560x1600 portrait screen, with the native "up" facing =
> the right controller (90=C2=B0 CW from the rest of the device).
> 
> Signed-off-by: Brenton Simpson <appsforartists@google.com>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/d=
> rm/drm_panel_orientation_quirks.c
> index d5c1529..3d92f66 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -336,6 +336,12 @@ static const struct dmi_system_id orientation_data[] =
> =3D {
>  =09=09  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
>  =09=09},
>  =09=09.driver_data =3D (void *)&lcd1200x1920_rightside_up,
> +=09}, {=09/* Lenovo Legion Go 8APU1 */
> +=09=09.matches =3D {
> +=09=09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +=09=09  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
> +=09=09},
> +=09=09.driver_data =3D (void *)&lcd1600x2560_leftside_up,
>  =09}, {=09/* Lenovo Yoga Book X90F / X90L */
>  =09=09.matches =3D {
>  =09=09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> --=20
> 2.43.0.rc0.421.g78406f8d94-goog
> 

