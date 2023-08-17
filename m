Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4345D77EF64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347692AbjHQDGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347882AbjHQDGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:06:45 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCEA2D69
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:06:32 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c0fff40ec6so4905866fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692241590; x=1692846390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2p3LkM2+1hMmzQH3J+BFjxfC28vADf3DXoxU36vbMDU=;
        b=YWRD5kZv7ZKqKBCnexiXsRnLveJ2OLY2djqkeNp76lKGKoV4Xn6ox3zkv0Np5p33rp
         ojV9KS9gmoNvHEJfB9xwad5gG4dmLujJHTgJSV5pahXa2FpoBgCsuBZ737hZPRrRCvGL
         LhcSb00jyJkEdKFGveAdxo2pRwaJLR4fAN0Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692241591; x=1692846391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p3LkM2+1hMmzQH3J+BFjxfC28vADf3DXoxU36vbMDU=;
        b=fNv5A0W/u8h22MnwjyHicuJNrT8+IessdRE+K645zaqY6MKpM3tbd+9C+NznXWF78G
         JjptEnt5t/tW00p7XKOSr1jflQTzcIDJ+e4P3s0k8F3oM7pR1XYoFQgmI8lYouGhx8HO
         keMRfF+g0oXOUMvUtbXbSRzkYoXJd3tBAMZEEHHcee9yjJhtDz0Gss4Kqpq+gUK574X8
         95WJfeiekVJUeARUaaS4pKQHFpiVlgGqL6rFQIRCAUUstw2Tt4ecYAYGioP9BlLSSuXX
         iJMxYgmp4bLQ8wL9SFOC9ZU2I/oYTrHYTsaFAF7bwBli2d3uvfZiAIBLHky0OUiwAiF1
         MWcg==
X-Gm-Message-State: AOJu0Yy+YZkPt0wAPN2Jap7J49Y/gkbi3ftcWtdQzFJYQlQYOCi6IRV+
        ZuZnw7g3BTXgL9HwmL6YSmQB/A==
X-Google-Smtp-Source: AGHT+IH1oVDvqjD3T3jAtvKneAa+KIiuN6VtidgwyIxoKunNFZPWMy7NBrz0MStgvao4aq4yjLarZA==
X-Received: by 2002:a05:6870:4713:b0:1bb:68ce:382c with SMTP id b19-20020a056870471300b001bb68ce382cmr4951014oaq.8.1692241590803;
        Wed, 16 Aug 2023 20:06:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a290300b00263f40cf83esm498114pjd.47.2023.08.16.20.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 20:06:30 -0700 (PDT)
Date:   Wed, 16 Aug 2023 20:06:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: refactor strncpy usage
Message-ID: <202308162006.497A819DC@keescook>
References: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:39:24PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `make_first_field()` should use similar implementation to `make_field()`
> due to memcpy having more obvious behavior here. The end result yields
> the same behavior as the previous `strncpy`-based implementation
> including the NUL-padding.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
