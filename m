Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FE27B18B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjI1K62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjI1K6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:58:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0F1A4;
        Thu, 28 Sep 2023 03:58:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68bed2c786eso10281197b3a.0;
        Thu, 28 Sep 2023 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695898700; x=1696503500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8FHvQbj7rNmFiJppzUFr2acXChGkldi3IkyP6IO254=;
        b=W+P3fJZYXpew8PWTo68+E8PFtJa+tP90X13cTMIJ1qKWCfnC798VXWeucUujKcbsfu
         pi0fVgDVHHUYMTbDlbSLRxI6DLQEoiB6zixBytMQDUu5KU5U0Si2zlpph6zwPUfuBj67
         5C6AfaskKMDmFjzf4bOp0Hj5EhspUMT00ZgJWre8r+MUobEI2RUpt4TB0RJbeMCe9dol
         DuMGee9A7qIzaefECJLLSZPliaQXJTQY3wFwUGGL2qYbMiX+3WfkrSKr/4puPm2DH8RX
         QuzaUZliI9Xcn1KoPxLRWMQApbZnop+atuZPKxJX9ArZbmXAarlrG34TymhGpFfvFtnc
         7V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695898700; x=1696503500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8FHvQbj7rNmFiJppzUFr2acXChGkldi3IkyP6IO254=;
        b=R7tvPFbz9qGd4FIOAYT04jpxjrwo0cjFZ4/rr+uoxWMX+uZ+xTGrMZsjCU7qLBO+V3
         cHpgSVwLL14UAwiWyz4vBqLKe2fB1jtbMCfwhUdhhFtd6kqv2vBmCBrAl243TJ74LEKj
         Ub5agSG1jpPs/sVD6h6c74jr3komW58hSnBcjyySlts+jrf2/5y2Kx/BDBfqmwohQWpe
         H5CTXXET3DFXb2KfBHnBo0qzWy5BIGYWzzSYgj13JA/0831jPHVSDca3J6prIv6HbeF6
         Edns8CizSyzwcNUHgQ4SPKwicEp2EP+L+Ob2Lt+mmzTKQnf2j+xMqrgOJzhVtn82hyc0
         yqiQ==
X-Gm-Message-State: AOJu0YxCflwL+GtaG5AgK+3jMVyZa+qRsA+RVKFpR0dIACZ5ekOG2Z7k
        V19vTXW51D09k6he1QzVB0s=
X-Google-Smtp-Source: AGHT+IGkoIlqHRlYP7Pacij/Tt4HsEzkQDrH/+yO9n+fWmRgJ9u+9+0jz+4WLeu2VEe9Tec0P8kfbA==
X-Received: by 2002:a05:6300:8004:b0:13d:5b70:17da with SMTP id an4-20020a056300800400b0013d5b7017damr804292pzc.26.1695898700374;
        Thu, 28 Sep 2023 03:58:20 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001a9b29b6759sm9449520plb.183.2023.09.28.03.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:58:19 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 78E8C81C9B1B; Thu, 28 Sep 2023 17:58:16 +0700 (WIB)
Date:   Thu, 28 Sep 2023 17:58:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Heiko Carstens <hca@linux.ibm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Chiu <andy.chiu@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH] docs: move riscv under arch
Message-ID: <ZRVcSDkMmWaePqaL@debian.me>
References: <20230928103134.2779459-1-costa.shul@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ix2tTzAorCIauNUV"
Content-Disposition: inline
In-Reply-To: <20230928103134.2779459-1-costa.shul@redhat.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ix2tTzAorCIauNUV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 01:29:42PM +0300, Costa Shulyupin wrote:
> and fix all in-tree references.
>=20
> Architecture-specific documentation is being moved into Documentation/arc=
h/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Ix2tTzAorCIauNUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRVcSAAKCRD2uYlJVVFO
oxopAQDpgNiTTDa6zSkvdGa04UmmwznBVnQSr7ZXi8fu4RKxpgD/dDib4v3kjHl7
o8u4EurgRVctwGPMU1PvkP2OK6s6ygs=
=e+Pu
-----END PGP SIGNATURE-----

--Ix2tTzAorCIauNUV--
