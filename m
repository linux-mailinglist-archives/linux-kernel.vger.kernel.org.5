Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3F7FCD03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376755AbjK2Cj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2Cj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:39:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D521707
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:40:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfa5840db3so41018385ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701225603; x=1701830403; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5x5B0c437a2X9lDq0UQuEQp64iHtOX/XVWyXOOCW84=;
        b=C1PiVOefUlAZHTQ0GuFJuT4q1hAhtdRFNnh1uRC3xtDYnehCo/BAcmzmQ/RFW2Z9tR
         14z5atUH8tfWWmrygjBafEcX0uN0bRTSU/sb0LQv6CRiM/azx4XyM8ZkG18HGOmCQ67q
         5y7MFsvYEcUZ4D/EFM3hjTL6lqFnb565zPwcyLYXUr03cx4Zf58eV44LFL8Zx9EniDrP
         Ey06cEt3wTVD8zfxqAQHE7WbDtKNBNJwLnlzeK7mlSM0cNfyAySsjxGrx2hyNSq1nJBt
         JVD8vUNhCZVH2HrGPnvedfg9NWK0U1wvKz4kpEHtTR4zm8m1Y6mYhIMqSLKSvysmuaSI
         NwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701225603; x=1701830403;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5x5B0c437a2X9lDq0UQuEQp64iHtOX/XVWyXOOCW84=;
        b=uccT7vT8p9ZICOaxdV6l9cBJYOPpbrFtGWyfKcyJ3IDiD22a5JtvTVEJZVCmK/nPir
         9oPOjjEBVRYtxUTDViK7zWNAcfAyNrv4nCl0cx7pIVZ/5HaOb1N+LeJ3aoBE0AfZVAg6
         nIaeFHM66Zc5pOqjr0yZtl2XgqTW6kyLvPD1N7V/Ozx/vEFKsleI0gUFhvLav2xuHwJ8
         ppblWqLiTh8gfh0bQJ5uZPiu6BPCs06WDlx6BCBsPd0CVLuE+YVTbz991Nq0qhofwqnz
         9ywmPDB3ZqqUCr0TCElr8564fv4RHmmkQB1q40YJI6lcCdLuBP4/xWFJ6eu55OnZLwLh
         wsSw==
X-Gm-Message-State: AOJu0Yw/LxcQ0bJY/lELLp3zBenEtM9zVrMbCW9lIeQNMdbr3Fj7EeKQ
        gIJ/hW1cEbe7tB87U/ELQpcD4w==
X-Google-Smtp-Source: AGHT+IHciKY2OrzZ9uzKYCblSTprxoTaxuGcqxj9qIEPOv32IWeYHV5K+GkoXvaXcNdlaGNzpGPu9g==
X-Received: by 2002:a17:902:ce84:b0:1cf:b7ea:fea with SMTP id f4-20020a170902ce8400b001cfb7ea0feamr15805442plg.1.1701225602758;
        Tue, 28 Nov 2023 18:40:02 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:5a34:50a0:78b5:5013:4cf4? ([2402:7500:4ce:5a34:50a0:78b5:5013:4cf4])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001cfcd4eca11sm4806771plg.114.2023.11.28.18.39.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2023 18:40:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 04/13] RISC-V: crypto: add Zvkned accelerated AES
 implementation
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231128201228.GE1148@sol.localdomain>
Date:   Wed, 29 Nov 2023 10:39:56 +0800
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E78B3BF9-8E49-417B-A89E-05F72690A92F@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-5-jerry.shih@sifive.com>
 <20231128-await-tipper-2094715466f2@spud>
 <20231128201228.GE1148@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2023, at 04:12, Eric Biggers <ebiggers@kernel.org> wrote:
> On Tue, Nov 28, 2023 at 05:54:49PM +0000, Conor Dooley wrote:
>>> +static inline bool check_aes_ext(void)
>>> +{
>>> +	return riscv_isa_extension_available(NULL, ZVKNED) &&
>>> +	       riscv_vector_vlen() >=3D 128;
>>> +}
>>=20
>> I'm not keen on this construct, where you are checking vlen greater =
than
>> 128 and the presence of Zvkned without checking for the presence of V
>> itself. Can you use "has_vector()" in any places where you depend on =
the
>> presence of vector please?
>=20
> Shouldn't both of those things imply vector support already?

The vector crypto extensions imply `V` extension. Should we still need =
to check
the `V` explicitly?
=
https://github.com/riscv/riscv-crypto/blob/main/doc/vector/riscv-crypto-sp=
ec-vector.adoc#1-extensions-overview

>> Also, there are potentially a lot of places in this drivers where you
>> can replace "riscv_isa_extension_available()" with
>> "riscv_has_extension_likely()". The latter is optimised with
>> alternatives, so in places that are going to be evaluated frequently =
it
>> may be beneficial for you.
>=20
> These extension checks are only executed in module_init functions, so =
they're
> not performance critical.

All `riscv_isa_extension_available()` calls in crypto drivers are called =
once
in the module init calls. Should we still need that =
`riscv_has_extension_likely()`
with a little more code size?

> - Eric

