Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E474B80F944
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377655AbjLLV0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377921AbjLLV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:26:10 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80882BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:26:16 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so5578965b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702416376; x=1703021176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5PlYZzo9vfTv/yv9EMUjQKbKWWq7A3gpV1Plw7Ax/Y=;
        b=KUf5HivlYL4ctCdp+SW+aRt+SMv/QY70kRXFLFAk41qCRZyj208eQV+tNJTJXFf44N
         UwWxEFLGWu1UskPYvENoFXxrz2T94Xs/qjlrTN68HVOAKnDaz0SX6oEPcgQD/jVoJnFc
         v+EfcOAyxQyAUYX/vnRufNDnMY3MVfHf91cq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416376; x=1703021176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5PlYZzo9vfTv/yv9EMUjQKbKWWq7A3gpV1Plw7Ax/Y=;
        b=OZbyLQZ70T7jBf9k8599BzUq6HnXGWAieGX+DBmQFyBibldASRJEYZckDSm4nEbOp0
         fOTXj9FunBXJQPMA5PGWYA2ZpDQgdDqV8n81p5P5pd+bJXTtPobOWJ9k7/YmfAtHP1NF
         QuU7+o8JBaay4ZyxuaKpUiPg+VzbteOb0VWkljVYi+Bv0vaAEajnmS0etBvLpWk90TEw
         m/LJQy/GLhHUJmzGv/9GMaS4dbNEA6Rt7+BOyDwN8+cBcGwctmki1vqyniIzjC5pVHiJ
         heN818ugmd3l+PPL7w+ahezBfPKWZbKOEv3KJq6n/X7nQxrtCtABSBYfUFY+7r1/Iqg/
         MaWA==
X-Gm-Message-State: AOJu0Yyvg+8Zy2tMkOY/O4juCHrHRzUvCd2Fb5baTqIlE+c81nKNEsE7
        R8IMlsky+DyI28Az8B3Axi2Xvg==
X-Google-Smtp-Source: AGHT+IECqwmYAGxNju9XRpHNOvS5qlW6o+Z0/xSSH+d6V94jzZqBhGBRMbJv+vZJSerO98ZHSCjsqQ==
X-Received: by 2002:a05:6a00:4601:b0:6cd:f91e:dfe4 with SMTP id ko1-20020a056a00460100b006cdf91edfe4mr6874221pfb.2.1702416375774;
        Tue, 12 Dec 2023 13:26:15 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a056a0010cc00b006ce61c9495fsm8571312pfu.206.2023.12.12.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:26:15 -0800 (PST)
Date:   Tue, 12 Dec 2023 13:26:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] iio: sx9324: avoid copying property strings
Message-ID: <202312121325.E29472E0C0@keescook>
References: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 12:42:52AM +0000, Justin Stitt wrote:
> We're doing some needless string copies when trying to assign the proper
> `prop` string. We can make `prop` a const char* and simply assign to
> string literals.
> 
> For the case where a format string is used, let's extract the parsing
> logic out into sx9324_parse_phase_prop(). We no longer need to create
> copies or allocate new memory.
> 
> sx9324_parse_phase_prop() will simply return the default def value if it
> fails.
> 
> This also cleans up some deprecated strncpy() uses [1].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, I like this approach. Totally removes the string copying and
creates a helper that does the "heavy lifting". :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
