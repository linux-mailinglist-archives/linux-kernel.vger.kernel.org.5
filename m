Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AC280AAAB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjLHRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjLHRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:23:46 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76871D54
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:23:53 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d2f1cecf89so4676185ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 09:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056233; x=1702661033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfBRrQiDkLBq4kbSWxx91dS9hun2XcIUpOw4uVoRhJU=;
        b=bjVfEERimN0gSZtQLetYbKdUOJykosXkQPNL+eoZeNSL9d0ZwIVoOMJPSWH5SRPuDz
         iSEEcn802Dqb0TzwNCcOVkE2pjAy5pujXmgfRRA96KSSETfRdA9Ss/3Hrz0bGPsCqkXi
         FcBqLB5j4QvlAIgKbsiIXvzhKFn4hpcwUU96g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056233; x=1702661033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfBRrQiDkLBq4kbSWxx91dS9hun2XcIUpOw4uVoRhJU=;
        b=OnjeV5kYZ4IObXR67kOInxrrmMVREFyxhxL8ZADNMpuBjNiJ9r7LfnNr6plrByzw46
         3TTSru3Wswye2io4EPM/jVfNio260DJ97tKwREThVEvH28PudgUmSiZ9Tl0e6/qbVC52
         1XO7oau3wDfYGYgDB8I3RnuNz84Lsj/TgeVPzm7sAMC2+W48LY7OD5tuQAOVKU5R59Te
         LRIQ1+uZLeDGvWp67RC5SJlbu4LKS3+smzjPbWa2hb4a4rcwtVjx7X4irefSsqBgXPoO
         FFHk29GhcLXE+2p3gQJDnUjT59+BlyBb0+YIH/u+BnriyjQv0ZesE026SJQoiIR4nOfU
         rHFg==
X-Gm-Message-State: AOJu0YwYS2P6FbnnXHy6c+bEe+fxtwooReJx2rIm68ggntZKMyQBso/H
        dORU5jpJRa/Tn+yPjzjKL0OMlA==
X-Google-Smtp-Source: AGHT+IE8qHxrXclJCxSH/90CYFEd1XJpiKFOZCPJsqVWaeyT4CeJLS6LsiCrvRpWVTVUVOL23Yqu1g==
X-Received: by 2002:a17:902:ab01:b0:1d0:c738:73b5 with SMTP id ik1-20020a170902ab0100b001d0c73873b5mr325670plb.0.1702056232945;
        Fri, 08 Dec 2023 09:23:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001d053ec1992sm1961580pld.83.2023.12.08.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:23:52 -0800 (PST)
Date:   Fri, 8 Dec 2023 09:23:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: mdio_bus: replace deprecated strncpy with strscpy
Message-ID: <202312080923.7F537BE03D@keescook>
References: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:57:50PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect mdiodev->modalias to be NUL-terminated based on its usage with
> strcmp():
> |       return strcmp(mdiodev->modalias, drv->name) == 0;
> 
> Moreover, mdiodev->modalias is already zero-allocated:
> |       mdiodev = kzalloc(sizeof(*mdiodev), GFP_KERNEL);
> ... which means the NUL-padding strncpy provides is not necessary.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, the subject is distinct now. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
