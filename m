Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F807CC73C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344330AbjJQPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344309AbjJQPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:15:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6FF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:15:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so54290075e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697555751; x=1698160551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MistYT0O+xtFeV8eUpfzBrfB9PhBrhg1XC3ts6C8zrA=;
        b=ba+EgLgEMsdCYpB75EugSAFkfOElBrjMG9Bq9fITdgR4q5gnUlcoZWKNpeVQVVtdgG
         Wt90BSEReAS83L1oFSDcxbYFxTuZ+88c1zY16zhlI13P1fOEs4pHz5b8flesf9kqcYhl
         dSd1Bj7PJFsQPh+B1RtBaB8rfHT2FrZXpJLUCGcdoY52amfisInPiTT3H0qQOW3aRhuq
         l+vTnMnyADOVl7zTtxt++FZFImA86xRC/5XmkdO+4Q6cLzXQSsFQx7N7SSEp1ddw8Ms5
         rXONCg5OFMVog5NWFC34ArSmxs5tUwklMuJqMJnjbHOp88b4+/W20pZF/G/6Rjfr8VVh
         7/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697555751; x=1698160551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MistYT0O+xtFeV8eUpfzBrfB9PhBrhg1XC3ts6C8zrA=;
        b=f/+kWIAxY2TYz+uY57yO0tv8t72lcn5Gd0ElSqGIRSgDhQUOpSYwRWEpuj7x1M3qRj
         P8QOOKyDYsqYHzzvoClq9PDJlk6ufxPA5OjWnHL1wc1WxIB2+fk2xczkcKEO4qGHUAvN
         n0KpNgadYrt0UlUsDcpA01Fo4EXgD/lpASeRvD+xAKyM16T9m7UlCNIPvHpKwD2GMAdq
         yDtZbkuK1SK+SJqoRrfVM9hx69qaupwKZSim2zpGRKv9dK7TyyG0Bis790Y0+XJKFbv4
         L6ETisayCnAtTtR83ThmBhuRQaMQJQu+eYiZRY25Kr9IuI/dCdp/W5CVaVd5D2nSYlcz
         F7Vg==
X-Gm-Message-State: AOJu0YwyLsVMaadx7t4yXFrFT9ADsmHjTxlffHbz3+XTRoPPEZzwm1ad
        x8VdrzQe5p/GBCKeCaHwfpKP2NpkVWW0DLu1
X-Google-Smtp-Source: AGHT+IHKCbb3uQi1FPQV9CQjbREuImnNQIiDyC9e6aI9dmu1hJ097A01G1cubvCcq+5joxvCI0XhSw==
X-Received: by 2002:a05:600c:4585:b0:405:3e92:76db with SMTP id r5-20020a05600c458500b004053e9276dbmr1969534wmo.5.1697555750823;
        Tue, 17 Oct 2023 08:15:50 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id az15-20020a05600c600f00b004081a011c0esm1548772wmb.12.2023.10.17.08.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:15:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: Re: [PATCH] irqchip: Drop the custom fixes for the same irq_chip name
Date:   Tue, 17 Oct 2023 17:15:49 +0200
Message-ID: <5737787.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20231017122718.5062-1-keguang.zhang@gmail.com>
References: <20231017122718.5062-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 17. oktober 2023 ob 14:27:18 CEST je Keguang Zhang napisal(a):
> Since commit 021a8ca2ba23 ("genirq/generic-chip: Fix the irq_chip name
> for /proc/interrupts "), the chip name of all chip types are set to the
> same name by irq_init_generic_chip() now. Those custom fixes for
> the same irq_chip name are no longer needed.
> So drop them.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  drivers/irqchip/irq-sunxi-nmi.c | 1 -

For sunxi:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/irqchip/irq-tb10x.c     | 1 -
>  2 files changed, 2 deletions(-)



