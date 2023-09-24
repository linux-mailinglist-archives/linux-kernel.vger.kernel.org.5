Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418AE7AC666
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 05:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjIXDBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 23:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjIXDBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 23:01:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B348136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:01:43 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4142ca41b89so30717091cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695524502; x=1696129302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8GXhdXaI2PB2O/8obE4EjH0QyOha/I4HQFMH4noGYrw=;
        b=ZSoWx61DOY0tCZM20uS7xApziM0s6Wzv9VrYt/xEc01XaEpCJdsWe7te6me+otFG2Z
         30tRbC3C+4CPnK2Mm8HSSM30nOEWTckFv6BmGTtIy2UPKm7AoB3S8kwbe2xWYHCVn5Gd
         ULcoPy0vv+R2wDSuX8q+OszHQEsIm4hDhB5/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695524502; x=1696129302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GXhdXaI2PB2O/8obE4EjH0QyOha/I4HQFMH4noGYrw=;
        b=VTO7UBgKxSpvw+zXPOkHf/3Yt49BDoSP0auKY6KbpVw2KFJ5fmZlfEL/TfPS88Bnz1
         LynVEWZf/SeRmVu7VItzfAvwOliQ1ye/y8YhkJQTuqK7u7O1u5y8IRYcV+93me0V3OGM
         l3ZtHOt3Z0OFTtp+3azn4ZL9uh6Zx8t6Y4PvbknRfxjYlTizy6otMEUZ/YhSDXV+lq4f
         4r5MD4eXVlm9vUBDTnG2Aw7P+0IQinAMy4bqAswQt0emard7gwANwnHpzLQEAtBDnTpv
         J2rzOSucX0TWhxyDPiEkQS7VMnXGtE5PXkIH2ZeGbYRMQOTOqGMgPQu7ZkWKJPOULXQj
         0pWw==
X-Gm-Message-State: AOJu0YxYQSE9PSLWWhdzbtKAv3UwO8V60ngSwyiaqw3K+2qFi5BI0ZWW
        8xc3O0HcqHj9LO3mUn23WvM8Zg==
X-Google-Smtp-Source: AGHT+IGr9Of4kfacxpIKInFWXLzjnKSPS5GSoT5UjUfjr++q5sAWMQH24+jZaDPQ+nAE/RwJWzNCOw==
X-Received: by 2002:a05:620a:16b9:b0:76f:1dd4:101f with SMTP id s25-20020a05620a16b900b0076f1dd4101fmr3430900qkj.39.1695524502575;
        Sat, 23 Sep 2023 20:01:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x26-20020aa784da000000b0068c0fcb40d3sm5568979pfn.211.2023.09.23.20.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:01:41 -0700 (PDT)
Date:   Sat, 23 Sep 2023 20:01:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drm/gma500: refactor deprecated strncpy
Message-ID: <202309232000.E307B49B@keescook>
References: <20230919-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v2-1-9ebe6983b4cb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v2-1-9ebe6983b4cb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 04:41:16AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> Since `chan->base.name` is expected to be NUL-terminated, a suitable
> replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without also unnecessarily
> NUL-padding (since `chan` is kzalloc'd already).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks, looks good. If a v3 is needed, Subject can be improved to be
"...: Replace strncpy with strscpy".

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
