Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC927CE46B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJRR2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjJRR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:28:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F34491
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:28:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5079f6efd64so6404691e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650094; x=1698254894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrEh3D+kI7ficihoTElbPnijf/y0H7CK010e9QE4avk=;
        b=prlSQ1zM5d2qNbRBOIJZ2EcigyeJonZjBFEeHaiJ+wAaIC6dN1zwoz7Tn0QvSrLJup
         BR6xp3HLh2Urg7Y782m3EMtmr/7AZZ1nqp0zmjuUUrVJvNMfeihRTngx8eA7ZblHZDmR
         I+mT7F5tykRePFoD/t0pEonYDOfb94leKDocrU3o7yL5nayiLfDCRLVwAsndsQ+M5sex
         wMmct2LZdSduwJveERuLzBOXe1ybLqYrgtK/llpI4txKoNKt4UtYjyqJzNBbBbO/KlYT
         okUcLQXFyS3Zn1DB74G4Rd5ahvGVYXfAlm76gKvDDKrb7T4ckQuxP9Fdat0VYg0FIyPH
         GMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650094; x=1698254894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrEh3D+kI7ficihoTElbPnijf/y0H7CK010e9QE4avk=;
        b=JsTL7CngiXHLzBIJp6xfowZhZhoEP1gB6XL9YOZ+GbYXNBtDX446ytquugb5Aa26dw
         yOeoufQnMnw6XPnGo6Vm1k6XEEWS7Z2uG5lJRmeu2jb+f+55tErdiPnLRcKf19cA4Far
         AWibzAtz9ElpiAsMTBjblSoCv7iN3HYODEoj++VYBD6SGphAetQVzzVIIz91mtUVN0ww
         KNCN8lQ4Axz9Sr2e9Mc908Vy1ztxh+Cka70EVrJyUQdv9d/qlXCQtoa8ITHCq02I/3Zu
         f/vtxrMt5u0l1XNXMir9t11B+V9I1cgtvcUQfNU+/xWUJKDnoE3uhRH6Pxk+hPhgPOre
         AUqg==
X-Gm-Message-State: AOJu0YyhQDs8MF6zD330RvxC8s1kfbujZ6eb5MmeQcT8ZBjJbrwVv7Db
        lMesZLLZxIgcDGFpX/TikJz/mYrCiI7aBFn72LY+Tg==
X-Google-Smtp-Source: AGHT+IGxURJL+uaaxpc+DcFmneehkFpVo2DZ+kcpkWCrSxLf8LioRAC7Aw8ZZqtta+v5ZKsd1Py4IEcwvCF/w36lIAw=
X-Received: by 2002:a19:2d4c:0:b0:504:7f58:6dfd with SMTP id
 t12-20020a192d4c000000b005047f586dfdmr4318597lft.2.1697650094002; Wed, 18 Oct
 2023 10:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-7-cleger@rivosinc.com>
In-Reply-To: <20231017131456.2053396-7-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:27:38 -0700
Message-ID: <CALs-HsvCGmo9N+cNUJwZmiHdd2N95nFFCxMfWRaOkWVg7v74Mw@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] riscv: hwprobe: export vector crypto ISA extensions
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
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

On Tue, Oct 17, 2023 at 6:15=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Export Zv* vector crypto ISA extensions that were added in "RISC-V
> Cryptography Extensions Volume II" specification[1] through hwprobe.
> This adds support for the following instructions:
>
> - Zvbb: Vector Basic Bit-manipulation
> - Zvbc: Vector Carryless Multiplication
> - Zvkb: Vector Cryptography Bit-manipulation
> - Zvkg: Vector GCM/GMAC.
> - Zvkned: NIST Suite: Vector AES Block Cipher
> - Zvknh[ab]: NIST Suite: Vector SHA-2 Secure Hash
> - Zvksed: ShangMi Suite: SM4 Block Cipher
> - Zvksh: ShangMi Suite: SM3 Secure Hash
> - Zvknc: NIST Algorithm Suite with carryless multiply
> - Zvkng: NIST Algorithm Suite with GCM.
> - Zvksc: ShangMi Algorithm Suite with carryless multiplication
> - Zvksg: ShangMi Algorithm Suite with GCM.
> - Zvkt: Vector Data-Independent Execution Latency.
>
> Zvkn and Zvks are ommited since they are a superset of other extensions.

s/ommited/omitted/, other than that:

Reviewed-by: Evan Green <evan@rivosinc.com>
