Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81E17A6FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjITAMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjITAMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:12:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EEE95
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:12:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so10471226e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1695168730; x=1695773530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CviEhhoBlZKiA8T16gFI1fJMTl09yzCTO8KzCGSqRk=;
        b=hYWcC2IGPnNYvnqdaw67I8Vv39Vgo+M0I2LOUt9NM/Uxj/k4EYFtf4+pwnp9w7RqxS
         fGtuxenfZBJoR66WL+70p8rCJDOdWxtHZdsTmaXT/5WL3qnm4iu3JBrpLRBde88HXnh3
         kCMy5ntUhv1ATGGuHh9igu0rs4e9rKLctQLgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695168730; x=1695773530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CviEhhoBlZKiA8T16gFI1fJMTl09yzCTO8KzCGSqRk=;
        b=hQkb6+v/7atLNAeiIZEdIuvEUO50Zq6O4UVy7/GQDgEBcupbpxsVAk7N1phSxblmSa
         00kmtXY1QKFkZea12/ggxdYv5CxTf8ujjTE0pvZoR2x6aiSZtDxeJJAU+zsV1OGytlB5
         TZ/2RSqnMlUEhiHiBYEbWb7k0CYXvqxsniz7zU1zFVAbU2Hqq6WsFRuycEs7MxbLAK8q
         cFMnHRLH7sW1Ivd4SkUsEYFkc9UCpLtFES6oClIsJtpKqfhpxHmctUOnQLTDN8Ev+0Rx
         9albmVdcpfl98oqfuZfE28jQU8e2VJPrmXLmgjGqPRkmXOjF4hOQr0ZHP0msJIwo6X/9
         8c2w==
X-Gm-Message-State: AOJu0Yxty5OjA64laCqSYElzhrzKI6flH1nXfCKnQvFmKAyNaI83zJ75
        7q1Z9ho2PQHysWVPq2nrCEMhJhaDMX8VkOpdMJwn
X-Google-Smtp-Source: AGHT+IE8zP3BzZusNhL+aAwkiDwCmIGdHT4wX12zJCKO252ijdL/DxCfHuNz/3MG+5CSLu9l+w9+0x7JLX8hmpsYVXk=
X-Received: by 2002:a05:6512:3ca6:b0:501:c1d4:cf68 with SMTP id
 h38-20020a0565123ca600b00501c1d4cf68mr1309878lfv.15.1695168729533; Tue, 19
 Sep 2023 17:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230912174928.528414-1-apatel@ventanamicro.com> <20230912174928.528414-2-apatel@ventanamicro.com>
In-Reply-To: <20230912174928.528414-2-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 19 Sep 2023 17:11:58 -0700
Message-ID: <CAOnJCU+0iUR+ziwkPnEykoS+Ym8zkG-Afs_XyyCSD4fi8wjP6w@mail.gmail.com>
Subject: Re: [PATCH v8 01/16] RISC-V: Don't fail in riscv_of_parent_hartid()
 for disabled HARTs
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:50=E2=80=AFAM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> The riscv_of_processor_hartid() used by riscv_of_parent_hartid() fails
> for HARTs disabled in the DT. This results in the following warning
> thrown by the RISC-V INTC driver for the E-core on SiFive boards:
>
> [    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interru=
pt-controller
>
> The riscv_of_parent_hartid() is only expected to read the hartid from
> the DT so we should directly call of_get_cpu_hwid() instead of calling
> riscv_of_processor_hartid().
>
> Fixes: ad635e723e17 ("riscv: cpu: Add 64bit hartid support on RV64")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kernel/cpu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index c17dacb1141c..157ace8b262c 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -125,13 +125,14 @@ int __init riscv_early_of_processor_hartid(struct d=
evice_node *node, unsigned lo
>   */
>  int riscv_of_parent_hartid(struct device_node *node, unsigned long *hart=
id)
>  {
> -       int rc;
> -
>         for (; node; node =3D node->parent) {
>                 if (of_device_is_compatible(node, "riscv")) {
> -                       rc =3D riscv_of_processor_hartid(node, hartid);
> -                       if (!rc)
> -                               return 0;
> +                       *hartid =3D (unsigned long)of_get_cpu_hwid(node, =
0);
> +                       if (*hartid =3D=3D ~0UL) {
> +                               pr_warn("Found CPU without hart ID\n");
> +                               return -ENODEV;
> +                       }
> +                       return 0;
>                 }
>         }
>
> --
> 2.34.1
>

LGTM.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
