Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FBE7A14CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjIOEaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjIOEau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:30:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2EC270C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:30:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fb79ef55eso1570647b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694752245; x=1695357045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsL0E9wvxns4U7l/ZwCaHkG93dEorgZ6k1wpN9ixUXY=;
        b=DIsqJTf82JyWJW+1mtEnCHlHX8ditJOAKl2Cywbw9IDfq5uBjzayUiv/0aWJpsdrxJ
         KlecA9RgYU53Xkp5udIoKF+uxbQsymlMDjyUFUlweie7itLUD+WAR9HzA/9RvMRX6+jw
         n/MPpEJ80XS0QgizDQSobUcehFRSyTVk2A40Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694752245; x=1695357045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsL0E9wvxns4U7l/ZwCaHkG93dEorgZ6k1wpN9ixUXY=;
        b=m8EO8MG0r/bkeBwgusu01R4W6HMm4pCj26KCjY9+w75Z7ItJKKbMxc99qBQOCB7QBX
         NTz3Po2hQwDmzBjCQMJ5zcVbaj2kuZGHUqQQbXo0oM3TMCGi281eGz/rfNrN3rGHFGCz
         A1K4qemS0jBg0s7N2WXG+chWCNi9n9eU4HDgZN81JQ2pSbirSeKMiFfgSR/lsvHuzTwy
         p31Zr5kkx5VtxCxPOint/4iqn1LcFQzCZPIkd43uJseLKCSjuFrwP3gWbgnW1P72p7jM
         zMxbeomj790B5VEyhMySbkNxkFQI9tVrSTJFKf/AlPnNg5or/w2oRavDCr9uNXltqb7f
         ndVQ==
X-Gm-Message-State: AOJu0YyQxh9ljptIByWEV/shm04sVicFZ6S5W46lkS7twe72rLZZQ3bX
        qwt1OpmZXbX8Wfqv1XcZ/HpbWA==
X-Google-Smtp-Source: AGHT+IHQxJBzE959LD14CEM1tohj88xdcd7+u7zKv8kSGIXuEzf6ekyCP/qKCPCuomlgXxkHpjJDxg==
X-Received: by 2002:a05:6a20:3255:b0:14d:6309:fc94 with SMTP id hm21-20020a056a20325500b0014d6309fc94mr747971pzc.36.1694752244954;
        Thu, 14 Sep 2023 21:30:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0069026841829sm2049947pfo.113.2023.09.14.21.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:30:44 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:30:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>
Subject: Re: [PATCH] drm/modes: refactor deprecated strncpy
Message-ID: <202309142129.46C1EAE2E2@keescook>
References: <20230914-strncpy-drivers-gpu-drm-drm_modes-c-v1-1-079b532553a3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-drm_modes-c-v1-1-079b532553a3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 06:08:44PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer and doesn't incur the
> performance loss of unnecessarily NUL-padding.

How did you decide it didn't need %NUL padding?

I suspect it should have it, as I see what looks like full struct copies
happening in places:

        struct drm_mode_modeinfo umode;

	...
                struct drm_property_blob *blob;

                drm_mode_convert_to_umode(&umode, mode);
                blob = drm_property_create_blob(crtc->dev,
                                                sizeof(umode), &umode);

Can you send a v2 using strscpy_pad() instead?

Thanks!

-Kees

-- 
Kees Cook
