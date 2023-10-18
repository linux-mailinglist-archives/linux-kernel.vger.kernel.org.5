Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69537CD1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjJRBpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJRBpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:45:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40793F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:45:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9daca2b85so47899955ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1697593536; x=1698198336; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIoyMcQHZ0Qpe7BKvINLbeGCoM4NhndfXHONk8A0DuA=;
        b=ff/gZ9bw0UNlmX9LRwzlObgx1Nn0oDNWNqhn6focVKW/InbdoeBzX9etFkTiG8idD4
         06/QHNFGW/PpAx15kGyXh4jLErgMUJvANiHbz/vp+4JmwqQ74evtHZKrOEKJ5o9YkgPQ
         fAYZS+uvNgtk4MjuVEvTl2xKdN+1+YIvCKoc/JZW9goYG5iFzopPb7g2ucqvtCr53/Lb
         OUMLtA7Yd7rYGgpE7CGFIIZGrJfQ2JbvetAMb2uMpDzqugoUVs5UBV7UbmlbGJHvrM+/
         S0nFwJ+taEODed2M0Aaa36NRBZgvfWsNdD1P3jzdEJs9E787CR+2bqxW6cwTEtY3GviW
         AsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697593536; x=1698198336;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIoyMcQHZ0Qpe7BKvINLbeGCoM4NhndfXHONk8A0DuA=;
        b=o0BwmQ1tbnf6ghtvJ+TQY9eG5xDvL8oLvZIbvugdYnPCQhu5Qc2mHmXNz+y+hW9fN/
         FKbKelG9eNJJW9Ey1InPJ1nAqlaYlHpPcMNx1cr8oPHQtOyurEiSLf2n8jwibzL2OXHu
         eA7kg3qT7vHb91UwB7S6mhIHyFXDs3oKbZe96fxDtsW812QMWYDFane5/6kaKkUUr3uV
         gpN2eRf9YJnH8WUp4QLF3ro9FhZQlt6zVhXY8TCJ1T+OokQisyile6XhxhgFvScaLPf8
         JAu708imVZlYlEGqAtVwuGOB6kpWhJg5TAv2aRsoXws3oV5USzrMREK7VBShF1zEPGwn
         zrEw==
X-Gm-Message-State: AOJu0YwYU5EoHNgacQcNRyztKGbQ1JbTz9VgJ2MWU5OwCiqcZd2ZocwM
        Rj/FWRyENjndUJC3KLfBQkWsrg==
X-Google-Smtp-Source: AGHT+IEhf4Aw5KzsP/CJeC+Xlre2SWvSR0H6szLH78PgMiwD0/+840q7dozZd2G8H0QR1O26UaYkUA==
X-Received: by 2002:a17:902:e5c3:b0:1b0:3ab6:5140 with SMTP id u3-20020a170902e5c300b001b03ab65140mr5806185plf.4.1697593536621;
        Tue, 17 Oct 2023 18:45:36 -0700 (PDT)
Received: from ?IPv6:2402:7500:5ce:a18a:d02c:5aee:75ae:ccc2? ([2402:7500:5ce:a18a:d02c:5aee:75ae:ccc2])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902dacb00b001c746b986e5sm2247981plx.45.2023.10.17.18.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2023 18:45:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 05/19] riscv: add ISA extension parsing for vector
 crypto extensions
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231017131456.2053396-6-cleger@rivosinc.com>
Date:   Wed, 18 Oct 2023 09:45:30 +0800
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Reply-To: 20231017131456.2053396-6-cleger@rivosinc.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA8B4610-D514-4733-B875-C247FFCCC7AA@sifive.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-6-cleger@rivosinc.com>
To:     =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17, 2023, at 21:14, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> =
wrote:
> @@ -221,6 +261,22 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> 	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> 	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> 	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> +	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
> +	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
> +	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),

The `Zvkb` is the subset of `Zvbb`[1]. So, the `Zvkb` should be bundled =
with `Zvbb`.

+	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
+	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVKB),
+	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),

or

+	__RISCV_ISA_EXT_BUNDLE(zvbb, riscv_zvbb_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),

[1]
=
https://github.com/riscv/riscv-crypto/blob/main/doc/vector/riscv-crypto-ve=
ctor-zvkb.adoc

-Jerry=
