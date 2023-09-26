Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9CE7AF6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjIZXyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjIZXwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:52:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84619E9E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:44:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5041335fb9cso15700098e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695764665; x=1696369465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7VhIC7MPBFXpVR7FFEbYlo6XAUw3yl/JVeppNvmRog=;
        b=sJzRlbelvLtcKFZwts95KO1oBqJLlAIbLmH6YMMWapWbJejaKa73Lx70QTXv7oed3X
         h7PjUj9uwgaL6tsxo2gjuitXJSWDLoltaTY/btaq+PE/zfDr1lz49tk89kjikAk3dN3d
         OoLwqNh4V1Hw4jxGuxZqDX4NVKcxPNmEh4ZoNAB/s6FU+h2HECnyhDIBKBUB5SgKDwg/
         QgbLJMn/WQVwHCq6kVY+y88cCLFZuN5JcUKduVY4sXVfXtmcOua6yOdkDCvSDAB7hF3I
         qvJI/ItXyVQDv5RnEl/YtL/ygdNodJERwF4VS/MTXLBWqYzOunjSJxiPNuo8gviHoIZE
         aCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695764665; x=1696369465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7VhIC7MPBFXpVR7FFEbYlo6XAUw3yl/JVeppNvmRog=;
        b=rJdBmNpwclAG8ESb2rzcNljfuFgonUxPcYg7NoQF7UpaBg9Kzs7lKr7GqhkSlgzSgZ
         71zJll1aVzV/NakLNpBfljIGeOTsh+PwvhjDXgM1pEMyxzHZB6Zs1DH5o3Hz2lG7sYtD
         2bn65azhTDXd8ai3UAH4kYdrKlduxp03MdK0SAsfhr24+jiHshf/+TGe80hWOQyXxjpQ
         g+JY4Kfv1G3WmXXEXsvadodfAOzu38YbOiaPA1eNr+1xiJqt7bSVePp6yLYlYyYeYNBA
         gbZH2+zDGS5qXs9fnGjKu22anhW5tntYs3jMUeprKlhSF2u1eNC6S/ipzEyZITfopusR
         nB0g==
X-Gm-Message-State: AOJu0YytMBtFpFg9TPl+AnUZV1vw8Cnhzt4ZFqtboo0JuCw/K06tvy8L
        3hoE/9VxrMpiiVqkRxAbWDgxWdqKOyEEM6F2Yy2nlyyM5z8h2mD6
X-Google-Smtp-Source: AGHT+IFUe4OXQrOywucEgxAU9oFTIqCD6Pj6P3s5airMHJJmqoktJErzvmPUON/DDlodShPgnaFkP9Gb4cOPlW2JAR8=
X-Received: by 2002:a19:5e55:0:b0:4ff:9efd:8a9e with SMTP id
 z21-20020a195e55000000b004ff9efd8a9emr45660lfi.7.1695764665489; Tue, 26 Sep
 2023 14:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230926150316.1129648-1-cleger@rivosinc.com>
In-Reply-To: <20230926150316.1129648-1-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 26 Sep 2023 14:43:49 -0700
Message-ID: <CALs-Hss+OK-vJy_ZKjVbGh7rTBZA+GditWcdM1XjDDskGF76Dw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 8:03=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Since commit 61cadb9 ("Provide new description of misaligned load/store
> behavior compatible with privileged architecture.") in the RISC-V ISA
> manual, it is stated that misaligned load/store might not be supported.
> However, the RISC-V kernel uABI describes that misaligned accesses are
> supported. In order to support that, this series adds support for S-mode
> handling of misaligned accesses as well support for prctl(PR_UNALIGN).
>
> Handling misaligned access in kernel allows for a finer grain control
> of the misaligned accesses behavior, and thanks to the prctl call, can
> allow disabling misaligned access emulation to generate SIGBUS. User
> space can then optimize its software by removing such access based on
> SIGBUS generation.
>
> Currently, this series is useful for people that uses a SBI that does
> not handled misaligned traps. In a near future, this series will make
> use a SBI extension [1] allowing to request delegation of the
> misaligned load/store traps to the S-mode software. This extension has
> been submitted for review to the riscv tech-prs group. An OpenSBI
> implementation for this spec is available at [2].

For my own education, how does the new SBI call behave with respect to
multiple harts? Does a call to change a feature perform that change
across all harts, or just the hart the SBI call was made on? If the
answer is "all harts", what if not all harts are exactly the same, and
some can enable the feature switch while others cannot? Also if the
answer is "all harts", does it also apply to hotplugged cpus, which
may not have even existed at boot time?

What happens if a hart goes through a context loss event, like
suspend/resume? Is the setting expected to be sticky, or is the kernel
expected to replay these calls?

-Evan
