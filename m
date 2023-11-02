Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A284D7DFC86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377533AbjKBWml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377532AbjKBWmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:42:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE17DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:42:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso2001006e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698964954; x=1699569754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLk43lN0/decQge2BDqiqpNvO2C3WW2dXE9OlxquTBg=;
        b=F7+YAVHl84fP2hJQ9ALQWGTiPYRUl7h3MT8vtSVEck25vf5ieotbtu3QEpS/G2Pzyt
         0vjn8KMnUrAcrZO5/YBMSu/w7Z7crYiQnLYj80z/AgdZ7s4XnETaRKB97Gvg8/wG7al4
         22gPNK39tkpAx0KhsPZqlPEc37FKPVcsPbV4twVW4Vy4mSyo9/6lHwEXg8rXVNzjkPZ7
         UdlStXPwfgnBKJyC2wQ0RgLrE4zVuOmx8l3oQRwmgsxbp2dROGafBtzeduh71LkpgO9y
         USPqXXiKQ4QmKxHb3GkKwAxHhkMZ5IAuGum7M7xnliAyeobB8MZEmt/4NXSXHzgwCBvT
         RLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698964954; x=1699569754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLk43lN0/decQge2BDqiqpNvO2C3WW2dXE9OlxquTBg=;
        b=Y4v/j/w/szFz+9LzN+aZpLKOqxEclWCQryUDCZyuZbJ3ReyHVPfNXDgPkQd49i/fxe
         651yXmzWTIGmNzEQdSbzyif/QHLHYtyr2IQm7Ke6b4tsevBwqgjt0PPMZq0Ci9yzmx7j
         y3MCf+Unm2mXOLti6vohMseCHQmmNNYJal+c1iX99HgSBFEFEKXOzRrUPDeLxlA5FjH7
         bd5Eqd25PELPyM3u4c2HiQamjYAF8Y9Ydfm2dpPPn+mLT7HtzSdNG+5cd4Q6S3tK5qI2
         ogWfj06ydKA74b5nn9HZskdgKL2xIEt/XdovBmjW3+ZBXoAk6uT5gJ+lpiqzBk1qJA6w
         b4HA==
X-Gm-Message-State: AOJu0Yz5NfluE8pa+ySAoS7g/n8DypCgrxOm5pN3WI1fvYQQC4RnReIx
        Ov+/jkZR1/W/Xi73kj571RXV6ILK69lNPFC+Q5xZxA==
X-Google-Smtp-Source: AGHT+IFzQD/VoMKgUQZ1/ELVgYegKEHGfIHsT6o8UwNGVxE+fI/gR7xwT4rAgd7EQ8711sNoWsVmNHBhhi5Rc1TmdJM=
X-Received: by 2002:a05:6512:69:b0:502:d743:9fc4 with SMTP id
 i9-20020a056512006900b00502d7439fc4mr14246766lfo.37.1698964954318; Thu, 02
 Nov 2023 15:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230915184904.1976183-1-evan@rivosinc.com>
In-Reply-To: <20230915184904.1976183-1-evan@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 2 Nov 2023 15:41:58 -0700
Message-ID: <CALs-Hsu_1x2FpjWXbmioSi6x30NXdNgrQ=t=EBknB0O06DA12A@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Probe misaligned access speed in parallel
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:49=E2=80=AFAM Evan Green <evan@rivosinc.com> wro=
te:
>
> Probing for misaligned access speed takes about 0.06 seconds. On a
> system with 64 cores, doing this in smp_callin() means it's done
> serially, extending boot time by 3.8 seconds. That's a lot of boot time.
>
> Instead of measuring each CPU serially, let's do the measurements on
> all CPUs in parallel. If we disable preemption on all CPUs, the
> jiffies stop ticking, so we can do this in stages of 1) everybody
> except core 0, then 2) core 0.
>
> The measurement call in smp_callin() stays around, but is now
> conditionalized to only run if a new CPU shows up after the round of
> in-parallel measurements has run. The goal is to have the measurement
> call not run during boot or suspend/resume, but only on a hotplug
> addition.
>
> Signed-off-by: Evan Green <evan@rivosinc.com>

Shoot, I saw the other thread [1] where it seems like my use of
alloc_pages() in this context is improper? I had thought I was
alright, as Documentation/core-api/memory-allocation.rst says:

 > If the allocation is performed from an atomic context, e.g interrupt
 > handler, use ``GFP_NOWAIT``.

Any tips for reproducing that splat? I have CONFIG_DEBUG_ATOMIC_SLEEP
on (it's in the defconfig), and lockdep, and I'm on Conor's
linux-6.6.y-rt, but so far I'm not seeing it.

-Evan

[1] https://lore.kernel.org/linux-riscv/ZUPWc7sY47l34lV+@xhacker/T/#t
