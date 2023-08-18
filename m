Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F17804C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357727AbjHRDgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357752AbjHRDgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:36:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC56F3A9A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:36:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf092a16c9so4214465ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692329771; x=1692934571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m40FRUJpIDHL/YXHaQLM+AuAcFnZMVMgTICBVKdbro=;
        b=C4jGlUfJkXgxD3An6hmhtU+KPQE93MPQPa1EESR+R+1bT9Dxwv4Sn6rSvGVDoUJduM
         7Hthw0xCVjJ5GzPopB6xwOI41P+/W18OQNkVANAOKoITPr913xgHZcyps5dO0PuJGHHG
         tYetDjTlGqErp2xRLc8ct6/Y6FBtj7r+pEago=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692329771; x=1692934571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m40FRUJpIDHL/YXHaQLM+AuAcFnZMVMgTICBVKdbro=;
        b=aYmU4pWFEDw7N84EPeWdj/vDbzhpFxkj4nPraVj14iqLxG1rM79S7oXsmZdYLRX19O
         8S+JLH9H/KpegAxnM+IuQw45g1+KUGjQIwziSSIamNgOMuHyzqngCukZbZSt7xYImztW
         PSLPqyFuG4raun6PwrbB04ZRHLCExlDTAxqdb3Muu/0tpR7VhOCHuOCVIlYww5uzsQig
         QqECeK7IIIOzpNshzlKMvATlBLNANPhXRytRToU1sxqH7TbMNAh9gI0UCzD7B26g6Uej
         618wZTrZaedra7fPHHA9utR1/LmGrFVEGiwqsRcMFsxefTBWlVo/lrGsJ9h7Ivkt8+Q+
         wHiQ==
X-Gm-Message-State: AOJu0YzFSy2O+bkfCrUIQw3BDHH+QmlPmHC3tH4kaATEkgEgp9ANskp7
        Ho99BMLKbiWAM1J0yZQdKxLsAA==
X-Google-Smtp-Source: AGHT+IG5DCHR6i3h9KLfRF1clc8LUV/IbwFQyEkyPLkU6zwgsv75e3f+gu3tO2G3UUs7+4te0SOZIQ==
X-Received: by 2002:a17:903:44c:b0:1bb:ce4a:5893 with SMTP id iw12-20020a170903044c00b001bbce4a5893mr1331720plb.30.1692329771277;
        Thu, 17 Aug 2023 20:36:11 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001b857352285sm521228pll.247.2023.08.17.20.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 20:36:10 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     marius.vlad@collabora.com
Cc:     corbet@lwn.net, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, jshargo@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mairacanal@riseup.net, melissa.srw@gmail.com, mripard@kernel.org,
        rodrigosiqueiramelo@gmail.com, tzimmermann@suse.de
Subject: Re: [PATCH v2 2/6] drm/vkms: Support multiple DRM objects (crtcs, etc.) per VKMS device
Date:   Fri, 18 Aug 2023 03:36:05 +0000
Message-ID: <20230818033605.2910699-1-brpol@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <ZNthoImm48DYrBJx@xpredator>
References: <ZNthoImm48DYrBJx@xpredator>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking the time, everyone! Sorry it took so long, we had some
internal shuffling etc going on and I was building out what we needed these
chagnes for in the first place, this will be the first of a few replies
followed by a new version of the series to be sent out.

First up is a respons to Maria, Marius to follow.

---

Maria,

> -	if (vkms->output.composer_workq)
> -		destroy_workqueue(vkms->output.composer_workq);
> +	for (int i = 0; i < vkms->output.num_crtcs; i++)
> +		destroy_workqueue(vkms->output.crtcs[i].composer_workq);

I don't believe there is any need for a null check.  If you look in the
crtc_init, it is zero'd before returning any errors and that is the only place
it is set.  I don't believe that release can be called by an interrupt/async
(and if it did it would need a mutex/lock anyway).

>
>   static const struct drm_plane_funcs vkms_plane_funcs = {
> -	.update_plane		= drm_atomic_helper_update_plane,
> -	.disable_plane		= drm_atomic_helper_disable_plane,
> -	.reset			= vkms_plane_reset,

Yeah these do seem weirdly formatted on devices that don't treat tabs well.
The default formatter on my editor has a few suggestions for this file, but
they are all optional.  I'll send an extra patch that formats stuff and see
what people think, but ill make it seperate after all this is done. 
For now I reverted this.

>> -	if (IS_ERR(plane))
>> -		return plane;
>> +	if (output->num_planes >= VKMS_MAX_PLANES)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	plane = &output->planes[output->num_planes++];
>> +	ret = drm_universal_plane_init(dev, &plane->base, 0, &vkms_plane_funcs,
>> +				       vkms_formats, ARRAY_SIZE(vkms_formats),
>> +				       NULL, type, NULL);
>
>Wouldn't be possible to use drmm_universal_plane_alloc?

Maybe, but the *_init pattern allows these things to be inline in the struct as
they are now, and consistent with the other drm kernel objects in the
vkms_output struct.  There are also a few other places we could use drmm,
surely, but to limit the scope/risk why don't we do that as a followup?

---

Marius,

Yeah those values could safely be completely removed.  Good catch :)
