Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD037C6FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379009AbjJLN4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbjJLN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:56:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA1B7;
        Thu, 12 Oct 2023 06:56:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a9f139cd94so160089066b.2;
        Thu, 12 Oct 2023 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697118966; x=1697723766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjN/leU6hHga1VJbp/k1GeVSvjqHWD0kEl+gNxvSlyw=;
        b=Q5nM0cuP6sQ7R5JC9QKgxcr0S94i911qdunBxAayfMcazSltDw3VZK68Ng6gfZE+h9
         J1GYNwCFEkeHIgXPoFK3DJo9pymQCdUDtb1tkSgujULW6avihbnRSL63TFKuqv/4Hf9d
         nSmDcmQ+kYcdjC827FhOnF3le5z5x84GbJyQc5QY4t7oiBUqzb04F+uJ9GXmnVeXvD+d
         Alp47GRHodAxEmafFtSWniYEYU++fFr9Qxef+6qClZRAornC9V0DMdR7eefsavReIgbt
         Ga804o1dj53uIJxols+csZhppND4KlqPsOQGxtU/NLHXypsnVFzj++1WmVq9IQQ4WN4q
         FoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118966; x=1697723766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjN/leU6hHga1VJbp/k1GeVSvjqHWD0kEl+gNxvSlyw=;
        b=L8YHdj4uTteFuDvHp7tGl2ChnK2CVMktzDeARXWUa0rmWbF2yEsPTz3UAo6e18aEwM
         eAoeDENKBWFOVZpY0YSiBapmJH5Q+hoRbazAh59OQtxOiWhplyw4IRu5xAdN4QehXNoy
         jHYymZAvBKPlqFBHDpDfpO51xa31kmQgfPa6Se6jBmsc41ecrQPm4Wrw1FqLlfftcNQC
         9VMjvvWJ8s5ajL8lOFM80eHM/pzqJWZxt7I/fEluKDP44nmlyMs3zLcZKVAM51TirARz
         xS8ip5OqUmxwKNBdmXyQz5v4xRRkOdTXLJ2JVJE3jBDL/Xyo6CB6gZER3EZMjbNDSVtz
         AKcw==
X-Gm-Message-State: AOJu0YxoH7P8G357pVh59bTarObnhnr0ONqXeycaUcGFuM+4bZ8t6lEa
        4aHAZwbfVzCudAcCvAqUFEo=
X-Google-Smtp-Source: AGHT+IFXiAVyrkcSF7Sf+Zwh6DqmLVpzql4cQTG1Bi0zWHwC3own8KWj+twCMcMwB6Ur4OnDIH0IJA==
X-Received: by 2002:a17:906:fe4a:b0:9ae:5120:5147 with SMTP id wz10-20020a170906fe4a00b009ae51205147mr25971061ejb.38.1697118966425;
        Thu, 12 Oct 2023 06:56:06 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090617c200b009ad8084e08asm10948942eje.0.2023.10.12.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:56:06 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: pxa: Explicitly include correct DT includes
Date:   Thu, 12 Oct 2023 15:55:59 +0200
Message-ID: <169711894375.3084011.3279568774230686712.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009172923.2457844-22-robh@kernel.org>
References: <20231009172923.2457844-22-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Oct 2023 12:29:17 -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] pwm: pxa: Explicitly include correct DT includes
      commit: 1d1d7ed2fb47b83496bb708eca0974a2741eb8ca

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
