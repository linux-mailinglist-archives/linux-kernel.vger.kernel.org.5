Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200847B3ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjI2Thi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjI2Thd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:37:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F61B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-692d2e8c003so765029b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696016248; x=1696621048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pz6XxrokHS8tD3oX5YP+XUhcoroypZl9efJWa+Ud3No=;
        b=i5UNO6IicrDU38SjFqnx8ZSKG8LC+34CX3yvrdXgpLQ/GZkqJKAHlsWIqAJJMMAK2l
         9LgOSriZcDVECFjg+6DSX14LWYALdrPyTwHCVM4Pgavlah6DsislwFVwPNboVJGsVCvI
         GN9Ojr3nO8VtQ476zOqxJFNzVuavvmxegsRGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016248; x=1696621048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pz6XxrokHS8tD3oX5YP+XUhcoroypZl9efJWa+Ud3No=;
        b=Xo/ylM8xfTjLhAdWGddaIMGIYCsNFoA09CQ3kxHBfEp4a8+LrwtlbNJm9rfOicGe/p
         oDh+MGHUKx9MLlatPmm1Fi6gfXDKSrBCvmN6G4s9i7iOP+CO9luXYQywYcWUvAj7JXBX
         Ua+S79OfgqCdX8EPAKX1iCqUk+UO9Xq2wdU0qErQzn6y1CCwl7+Q74IQOdaL0MPKrPk/
         sIxRd4G19U4Rsd7Wyvhfaz8Lkaacw5itJEgur+lUMefPo8c6efSVEc+KDk26vDMcQ16P
         NI/F99sXfm00QSAbUBToIosNq7pucLGi3Dn/VeUTTppO/DQjXi3CN808ySwZzbb7oovx
         Ncpw==
X-Gm-Message-State: AOJu0YwSQV96zfQscRivjTe8zCeSUmIgLtWaUKjzt/0F6IX3v16Us1+6
        2Sx2rxJc7X/3pFAun6X79+EbEw==
X-Google-Smtp-Source: AGHT+IEnN6bxYqpGvl9ktJGtLQQ5mwKyJ3TeMFdfpa66gryjMY4jCfgv/JejeF1KEVIKsl05FW+Sew==
X-Received: by 2002:a05:6a20:4420:b0:13e:debc:3657 with SMTP id ce32-20020a056a20442000b0013edebc3657mr7894820pzb.30.1696016248658;
        Fri, 29 Sep 2023 12:37:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i17-20020aa78b51000000b0066a4e561beesm15931376pfd.173.2023.09.29.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:37:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Karsten Keil <isdn@linux-pingi.de>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] isdn: kcapi: replace deprecated strncpy with strscpy_pad
Date:   Fri, 29 Sep 2023 12:37:25 -0700
Message-Id: <169601624548.3016093.6534786691169747871.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922-strncpy-drivers-isdn-capi-kcapi-c-v1-1-55fcf8b075fb@google.com>
References: <20230922-strncpy-drivers-isdn-capi-kcapi-c-v1-1-55fcf8b075fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 11:49:14 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `buf` is used in this context as a data buffer with 64 bytes of memory
> to be occupied by capi_manufakturer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] isdn: kcapi: replace deprecated strncpy with strscpy_pad
      https://git.kernel.org/kees/c/69cee158c9b0

Take care,

-- 
Kees Cook

