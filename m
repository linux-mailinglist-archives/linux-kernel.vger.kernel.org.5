Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892857C45C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbjJJX7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344207AbjJJX7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:59:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32F91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:59:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5cd27b1acso49752995ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696982353; x=1697587153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqSRijF5ocWf9llqvklQyW3Wi+0XOkmzW4XQNxfluyk=;
        b=XR6IMS+gkfiwKqtsxSJF4Vcm0HKo0Y6oo38lcIgD6XeQqt7Yj559bQOm9TZEFE5Bg1
         AkhxZYp2t44sJL9y0/NvxPko2qIXPffLLjRSA77ELSzQ4ZyWnRlf+7fXTqr398ieZ9PA
         vBqvf3Knf6mPaYByYrP3BkGXk0KJavVmQ6Q+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982353; x=1697587153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqSRijF5ocWf9llqvklQyW3Wi+0XOkmzW4XQNxfluyk=;
        b=dg8bFz9CFzh7xbrE022MeEVFgnt2U5USW5pDlLWQivYuYJNPo7T4WygVOz1bNZvfAh
         lWs1eL4Gi7n3avF0vRf6k/1IFgVDaQwe/OcoxYpo2SJeJWZ48pCnAK0FguUr/riyl8yf
         bygT4KRQP9lyv7D1Te6317WY00jjWp2BBcuY7x4Cg1a5rqxWndymW6PrGqzdkkp55G9D
         3OQvPr2wK7Rt/3zwRHGXRV2x1fimhI4fuJkEijlvMJe3mikq3VpOv37IT14KmlzMn30i
         c6HlP1Jc4eFGLKZSzDcSCTa93FcbUWp9/+l0QKndVlQ7FGHjWd5qmIXGeaZ8HlHlQh7w
         70UA==
X-Gm-Message-State: AOJu0Yz0g1Yf16/otX+QuUDMEyzpqiv+KpHE8VwwyoIGEweyjW0jJtmF
        vEVb2d6D+Clag44wK/J71DjP+A==
X-Google-Smtp-Source: AGHT+IHsBKEhM8Jb2S10+0UBKcAaUvwNQ94/ERbNOjqhOH8T4jx/rmPG2GZ2PApSYSOqP4sqNCXXdg==
X-Received: by 2002:a17:902:7d92:b0:1c6:943:baca with SMTP id a18-20020a1709027d9200b001c60943bacamr19039967plm.28.1696982353259;
        Tue, 10 Oct 2023 16:59:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij15-20020a170902ab4f00b001c9c47d6cb9sm940689plb.99.2023.10.10.16.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:59:12 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:59:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: replace deprecated strncpy with strscpy
Message-ID: <202310101658.8D498F16F@keescook>
References: <20231010-strncpy-drivers-net-ethernet-marvell-mvpp2-mvpp2_main-c-v1-1-51be96ad0324@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-marvell-mvpp2-mvpp2_main-c-v1-1-51be96ad0324@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:24:42PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `irqname` to be NUL-terminated based on its use with
> of_irq_get_byname() -> of_property_match_string() wherein it is used
> with a format string and a `strcmp`:
> |       pr_debug("comparing %s with %s\n", string, p);
> |       if (strcmp(string, p) == 0)
> |               return i; /* Found it; return index */
> 
> NUL-padding is not required as is evident by other assignments to
> `irqname` which do not NUL-pad:
> |       if (port->flags & MVPP2_F_DT_COMPAT)
> |               snprintf(irqname, sizeof(irqname), "tx-cpu%d", i);
> |       else
> |               snprintf(irqname, sizeof(irqname), "hif%d", i);
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

Yup, direct replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
