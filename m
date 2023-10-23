Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2467D41B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjJWVaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjJWVa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1AC10C1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698096583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcPd91tcHUqGQ8cwQ4BFcEpBug5kyk/HqJ75ngdNbWY=;
        b=MrrWI9bXhRx4ECMrOu5GWgwm0JsZhbGv6jWnQfpue7j+bK3Y6CyWUn8F7Orh+PKQ+wH3bS
        VJQ0kFAUt6A+nfBc/QL+DxEwK9WoNl9qAn5TL/Yfd/6GkYR57wkr0M2iQVWjlbNvh+EdZM
        XO9dceu8FVwB3JWvolLjAAd6LjBTvLs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-CpHISZR-NaWBhFSTHmsbVQ-1; Mon, 23 Oct 2023 17:29:26 -0400
X-MC-Unique: CpHISZR-NaWBhFSTHmsbVQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5079fd9754cso3767202e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698096565; x=1698701365;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcPd91tcHUqGQ8cwQ4BFcEpBug5kyk/HqJ75ngdNbWY=;
        b=il1LAf8Bce3kZeTcraUPWBrW2Hj+SeVzBzbpYgHhKUpBzPWMVKaCu68jAlvSMgRca5
         X+t+UbxgtSfG5D2eR7pZthhnOut94oBPatEQjSgR1g0N0zpwv49digtXunCtuhR85AHx
         Uu/AsKEIYa2g8NGRMHPCDPZokIJUaCCRetXDLz7LbYqqODei6QDlTcJH15AIC6W5XMWc
         N1Jf/l80wzX2R6plqDj19fSEcruHpUrW7K3kqdFmIvUwpMRnoOzXRnngurxvjDoIdL2c
         JwbzkOfMsE9jF/QNiclIGIGGmaCK/BkswaoV9q7UlNODJBXxJY9kVyOn+YqyVkZOR3hL
         1Mww==
X-Gm-Message-State: AOJu0Yz1ZRKCNyvskweJrQKQ8+gmiOOuHV8jOci2/sAav2AcZPIsrgNW
        DXCL3mOrMCHEMpArbz/Tg+Sbbxt5mubO0bG0TDOUht3jpji2bHDycI5TXrn/ywACb5joXPVqytX
        JCkke/1jV6z9uoXBT0bFkDoEu
X-Received: by 2002:a05:6512:1382:b0:507:a1dd:5a86 with SMTP id fc2-20020a056512138200b00507a1dd5a86mr8401828lfb.13.1698096565321;
        Mon, 23 Oct 2023 14:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpnF8cqoxrlrOT9P0v4zs+TvviuGD1NXYsIxxUywKDSj03aKaf/bFvjifDaAO0+t237pvZMQ==
X-Received: by 2002:a05:6512:1382:b0:507:a1dd:5a86 with SMTP id fc2-20020a056512138200b00507a1dd5a86mr8401805lfb.13.1698096564991;
        Mon, 23 Oct 2023 14:29:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id vg18-20020a170907d31200b009adc77fe164sm7193030ejc.66.2023.10.23.14.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 14:29:24 -0700 (PDT)
Message-ID: <6ddcac19-70c1-4f94-ac11-9d864721ff62@redhat.com>
Date:   Mon, 23 Oct 2023 23:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Nouveau] [PATCH] drm/nouveau/dispnv04: fix a possible null
 pointer dereference
Content-Language: en-US
To:     Ma Ke <make_ruc2021@163.com>, kherbst@redhat.com, lyude@redhat.com,
        dakr@redhat.com, airlied@gmail.com, daniel@ffwll.ch,
        tzimmermann@suse.de, noralf@tronnes.org, mripard@kernel.org,
        jani.nikula@intel.com
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231013011850.103967-1-make_ruc2021@163.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20231013011850.103967-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 03:18, Ma Ke wrote:
> In nv17_tv_get_hd_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference on
> failure of drm_mode_duplicate(). The same applies to drm_cvt_mode().
> Add a check to avoid null pointer dereference.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

For this one and the previous patch, please add the corresponding
'Fixes:' [1] and stable [2] tags and split the commits accordingly.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
[2] https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

> ---
>   drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 670c9739e5e1..9c3dc9a5bb46 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -258,6 +258,8 @@ static int nv17_tv_get_hd_modes(struct drm_encoder *encoder,
>   		if (modes[i].hdisplay == output_mode->hdisplay &&
>   		    modes[i].vdisplay == output_mode->vdisplay) {
>   			mode = drm_mode_duplicate(encoder->dev, output_mode);
> +			if (!mode)
> +				continue;
>   			mode->type |= DRM_MODE_TYPE_PREFERRED;
>   
>   		} else {
> @@ -265,6 +267,8 @@ static int nv17_tv_get_hd_modes(struct drm_encoder *encoder,
>   					    modes[i].vdisplay, 60, false,
>   					    (output_mode->flags &
>   					     DRM_MODE_FLAG_INTERLACE), false);
> +			if (!mode)
> +				continue;
>   		}
>   
>   		/* CVT modes are sometimes unsuitable... */

