Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2D7B9E01
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjJEN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjJEN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:56:19 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B434693
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 21:55:50 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3aec067556dso373438b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 21:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696481749; x=1697086549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qTkmLJbkNoH1DEt071Z4Lj6n0F0uZ101JE698BdGD4=;
        b=WnudJe1bYEmqh6BpAvVgjxOCcYYaNDC48bvl4Byn5OG7VzY1wDDFbdVqvBnGqTpuhF
         WYKtiSLBdwoIgYq3DAFJ6DETUj260vaG5bDR/pkhwhYGvWG/zFka+8jgI2lW40HI33V0
         PlDmcbMs9G11G9G7y5FP2QcJXRBwgxWKUFu8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696481749; x=1697086549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qTkmLJbkNoH1DEt071Z4Lj6n0F0uZ101JE698BdGD4=;
        b=mrzEJlCybaeosBJh2sYqEMSDMMZQSJB4y5oZAv469j5rA0TAYd33zOdqwPjCPGXS2g
         WHDnnylbgyIXI0AU19iyM9FZzggX0A60U/9bPV2zl8eK6siqmlal0O90aPCujINFgQTD
         1sERmVPwNQZrLNK7n9EjK9lse1EE1bsaJ4K/nyW/GD1Vus7d19WuwyVzvDQdPIQ9obkS
         Dgmw2f1R2o/+zxvSvELXmDiZlqkv5+4NrGqv5+oOckZ3vIxdWgZUO5QWM7g2AH1cpecZ
         S+F36Az6ZM7RmHqSbZdAY4cRUsZbBUPs5Ub2EF0Va0WHikmW1c/mC/5caZLbe5J+3cmk
         LOwQ==
X-Gm-Message-State: AOJu0Yz0eqFvV+ixaI78eFaeX7Q2TkLbYWg0iHy1D5X5R8iL2iXyNe9h
        sEFFu22vJttcRO8R+JgGUdWTlA==
X-Google-Smtp-Source: AGHT+IHoPEyS18WZeo7CvnM9KyZsJnDedFeLw5UokGAmsFPXerM25wZNgmkPytL1cmoHB1Stp2V7dw==
X-Received: by 2002:a54:4e8c:0:b0:3ae:5e0e:1671 with SMTP id c12-20020a544e8c000000b003ae5e0e1671mr4451630oiy.4.1696481749435;
        Wed, 04 Oct 2023 21:55:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a63be4c000000b00577e62e13c5sm369420pgo.32.2023.10.04.21.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 21:55:48 -0700 (PDT)
Date:   Wed, 4 Oct 2023 21:55:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ax88796c: replace deprecated strncpy with strscpy
Message-ID: <202310042155.BDF8674@keescook>
References: <20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-v1-1-6fafdc38b170@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-v1-1-6fafdc38b170@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 01:06:26AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> It should be noted that there doesn't currently exist a bug here as
> DRV_NAME is a small string literal which means no overread bugs are
> present.
> 
> Also to note, other ethernet drivers are using strscpy in a similar
> pattern:
> |       dec/tulip/tulip_core.c
> |       861:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> |
> |       8390/ax88796.c
> |       582:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> |
> |       dec/tulip/dmfe.c
> |       1077:   strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> |
> |       8390/etherh.c
> |       558:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, this looks like the others.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
