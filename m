Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E557EC8A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjKOQbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjKOQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:31:22 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8671994;
        Wed, 15 Nov 2023 08:31:04 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d190a8f87so40218496d6.0;
        Wed, 15 Nov 2023 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700065864; x=1700670664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+INF42k1XG4+6QzaNisuOEUhiKYehEiojUz+F/VMRXU=;
        b=K/aErExJvYgXc45ckszJGSWC9EyIuuFbXt6BCQ/ozGRj5UFyQfbGKzi5ZTrkQ3dMRe
         pYSp50RcP/vHiNP/2DMmZ4re5ZhXFJjP72d+eGqJcHuTDUcjGhADot+npIIT4IwcgBPQ
         DrFhsTnwu1Q/vuA1QYpq1Ihyz79/vPy/MEQ9Wc1lUsXQB8ilq5Yw2McQJJY8CLjoJQoL
         910ZDlQlo5uBsEVBDz90mo9aSlOcqbeKTULVv7u5zG6+by4tpRnsOTrtgVlNjkIMGkr9
         RGBJBvLg3iBnBMVvNeCrLk8yOGi1sb6yZtQHoctLuTUEuqpHwdtm2+9f36lnRA9ujcq2
         HAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065864; x=1700670664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+INF42k1XG4+6QzaNisuOEUhiKYehEiojUz+F/VMRXU=;
        b=P73yNDHGuf6Y5rFszBWOm8uxmHN3kjwbGK+ClfDmTazlqkREyc4/UleXAkz7/PUSAm
         xs+wHSgGLT4vhGGeV+D8OD+TbBod6dXO8ds8L53ESU+KTPSs10+0xQPFtxua4vREYd5H
         u+n74PNkKR4YnyZupypmBG3wFnDrfbDYn+kLCDoaQDV4Yocg+ofidFny6/GxTbRr9OQc
         boKxYrBN+WYr0IMKXfqHnsoxCzyEZfwJwHnQtjuG2nP+R8gz9pvFuhGus5zfBCXrlEzQ
         tar4Q5W5jgDxZXhVEceXOkTu4cLVQWCetUFYFYNXP1CD9EceUGW2loFAWiIYshr4YWOc
         V+ZA==
X-Gm-Message-State: AOJu0YwBVYpsT6ttfYwweFvRhnqsL79L2KB15+5mtEMdfTiBXocoDmVd
        5N5/k9AH+U9uU4ySKBMxQMQIh5A6dv0=
X-Google-Smtp-Source: AGHT+IEn/2rz+rcSYv3U4p1KtnF5wJpHNs7HX9mybwVu8k08zuexww2lEBpj2J9tC2zhD37VjYepbA==
X-Received: by 2002:a05:6214:560c:b0:66d:6388:bb2c with SMTP id mg12-20020a056214560c00b0066d6388bb2cmr4834783qvb.54.1700065863627;
        Wed, 15 Nov 2023 08:31:03 -0800 (PST)
Received: from google.com ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id l16-20020ad44d10000000b00656e2464719sm650908qvl.92.2023.11.15.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:31:03 -0800 (PST)
Date:   Wed, 15 Nov 2023 16:30:59 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: samsung,s6sy761: convert to DT schema
Message-ID: <ZVTyQx7hpADGGk8l@google.com>
References: <20231111143221.55452-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111143221.55452-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 03:32:21PM +0100, Krzysztof Kozlowski wrote:
> Convert Samsung  S6SY761 touchscreen controller bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Applied, thank you.

-- 
Dmitry
