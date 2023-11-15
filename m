Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3505A7ED567
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbjKOVFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjKOVFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:05:15 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DCC2113
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:04:43 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77784edc2edso2420485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700082282; x=1700687082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR68rbCqUw8CtYPmfdb5YCDkKax7BnU7bOcQgQ7EGfk=;
        b=asAgb2ZbzVdqpzKnTb1wFtIn2jKtNIzr+5waCn4NwgrkfDFpntf4sIxoF1xlWNtSdT
         w5BJ1rytFwJQxkA5ci3MhADryCrSUqSF1Unj5ESBofp1A6Mmo4Nh9mXs17XxZXMWglVo
         qwZEwJtBtcMvr2ZPC+XgRiUIzYLIz+CriILtFd5BqDkR9MpUl6VkA/fkC8M74jZhX9Z0
         YO20HymLxfLSjhi1LmVLAVbPY57MK/cUzg06EzsSfJ+L3zMjGXjk8D9Fs07xsssE75+A
         mq/vwolxHETd4USCNdQPRTKZpy2BPrq9IhxgW4PtGJb4C2kfvwa+aYoArdJTIke0JdrU
         j6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082282; x=1700687082;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IR68rbCqUw8CtYPmfdb5YCDkKax7BnU7bOcQgQ7EGfk=;
        b=a85EGyO1QsvWysk32Hi9Ftw6d25ofskhD6ttmXDvUJ7A0PN2Ji7phuGirjHxs+DN55
         4SalVpZYWP4QXmU5+NK0CjhkY3/Id5nOGCqLefOL/Oh+S+/t8tR4t+i3jEnmVwMwQc+5
         AFBsHWYVAYn3MqMO9dsRzNVPyysI0Rd3zlN/Mj2VWD2C3QTMYp7obLgRkNBrEQmI1eFo
         dR/1Yp98xWcJ/4S0E9OW5mNEys9bu154vnGilwXMxaw9x+3ThXQ7cKmJPmZwWaTg1/I9
         BXoqQRj+L/tHGGVIemT56DeguOJa9wbsFpAtAOWH4E5wFiwfJNBpdw/vzrCd5KsAT2/y
         Hlyw==
X-Gm-Message-State: AOJu0Yy4H+9z4W0ge/kworR/0Jt7wopsjSvDlBCqve9+l/+/LoFrgTpC
        ae6HjpavFOzh/dL0yL53RgmR8xoTO0AE3GqQM78=
X-Google-Smtp-Source: AGHT+IH2GDwTuyCy4xkB7EKUOALCaivIacHBI9Ecram8jzDmeEaK9Si8AF1rguzBVaPxi+EqNG9aLg==
X-Received: by 2002:a05:620a:953:b0:77b:e020:2fcc with SMTP id w19-20020a05620a095300b0077be0202fccmr7517718qkw.31.1700082281899;
        Wed, 15 Nov 2023 13:04:41 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id i6-20020a37c206000000b007788d2f3d4asm3752793qkm.39.2023.11.15.13.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:04:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     thomas.delev@amd.com, michal.simek@amd.com, robh+dt@kernel.org,
        conor+dt@kernel.org, Kris Chaplin <kris.chaplin@amd.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
In-Reply-To: <20231107180814.615933-1-kris.chaplin@amd.com>
References: <20231107180814.615933-1-kris.chaplin@amd.com>
Subject: Re: [PATCH v3 0/2] w1: Add AXI 1-wire host driver for AMD
 programmable logic IP core
Message-Id: <170008228111.6293.10665140667009011469.b4-ty@linaro.org>
Date:   Wed, 15 Nov 2023 22:04:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Nov 2023 10:06:50 -0800, Kris Chaplin wrote:
> Changes since v2:
>  Updated binding patch commit description to specify that version is detected
>  using a register in IP.
> 
> Changes since v1:
>  Updated IP name and binding to axi-1wire-host and filenames to match. Comment
>  pruning where operation obvious, additional comments where not. Unwrapped
>  helper functions for register read/writes. Removed un-necessary device reset
>  on fail to add device. Fixed duplicate clock disable in remove function. Move
>  bus master structure to per instance. Improved hardware testing with multiple
>  w1 instances.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI w1 host and MAINTAINERS entry
      https://git.kernel.org/krzk/linux-w1/c/3427fa5b32bbf54e51a2fde347a88161ff16a641
[2/2] w1: Add AXI 1-wire host driver for AMD programmable logic IP core
      https://git.kernel.org/krzk/linux-w1/c/271c81935801d6449bb7bab5ccfc6cd38238c62b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

