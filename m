Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FED7A8889
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbjITPhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbjITPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:37:00 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F647DD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:36:53 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c07e122a78so4559609a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224212; x=1695829012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqOVsBfHNygg8CIdhGnCqNhF4RLjlnuHSz1CJHC5ok=;
        b=gfb0x5RPkwjsO6E5uQGEJ/gGgzoFgjRyRWwj4KbQ3uFBen15i19BWd6Hrpng8HZlTu
         /9PCwEkCxTCpugQjy6PI6hyIqUskzUJd0rbdnxuqVjGh2f+FEWI6RCfezgFEcrCVcmIv
         OoY4b/9XSeS+wXIWkwpG/laIX49C69xcsXXWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224212; x=1695829012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEqOVsBfHNygg8CIdhGnCqNhF4RLjlnuHSz1CJHC5ok=;
        b=ClEQxFY+9GwwFaC0NfDzu1bMn6yPrSrbzgUph/i2BssbtYaVsGHANZulEQSHvh0SEb
         ZSC0MzaqnDXM2n0/fqQh6Og4GtrYFxX9fX+nAY4M63tapqiGOXsUQn6yiV6jkGCRCfaO
         ev8e2wGFOLKlqWPQwuibO5LpKX7z460VS/4aEY21NS6pS8Sqm4kZ6ir7mLCYnM93kmlR
         zlts11HeTVOwPCwFzEucblP3aObt9W9V7bXRPNsio9MNJPOCy4PuXU5Y0NklYDlZR5Ov
         H08/aE8tgdI0HZ7i2uLLdJHUKKZ2RHWrrYmJQ/hGlF2h2pdDnBA8DwGG46OnW5O3s+WQ
         ++KA==
X-Gm-Message-State: AOJu0YzJYXadwTjXufcf1MC+a+OWx1qKUNbvNWaMiBUNMnbwUIkn7iMX
        67QO9Dnn9JkWkUobTGkcxH+kNg==
X-Google-Smtp-Source: AGHT+IGWSCopskarNhSyAkg0IaQsmJYsTyHTBcKn23oo3w5SI0EhhW3Si5DpZmqWvoMoEIJfEqxaPA==
X-Received: by 2002:a05:6358:52cb:b0:142:dfc2:a441 with SMTP id z11-20020a05635852cb00b00142dfc2a441mr4203742rwz.8.1695224212579;
        Wed, 20 Sep 2023 08:36:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j24-20020a633c18000000b00565009a97f0sm1133706pga.17.2023.09.20.08.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:36:52 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:36:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>
Subject: Re: [PATCH v2] aoe: replace strncpy with strscpy
Message-ID: <202309200836.372F9757@keescook>
References: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 05:27:45AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `aoe_iflist` is expected to be NUL-terminated which is evident by its
> use with string apis later on like `strspn`:
> | 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
> 
> It also seems `aoe_iflist` does not need to be NUL-padded which means
> `strscpy` [2] is a suitable replacement due to the fact that it
> guarantees NUL-termination on the destination buffer while not
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Xu Panda <xu.panda@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks right. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
