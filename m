Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965977574E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGRHEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjGRHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:04:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289391BE;
        Tue, 18 Jul 2023 00:04:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8bbce9980so31220425ad.2;
        Tue, 18 Jul 2023 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689663857; x=1692255857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Axjn/sYToZar4H60yNlZc/j45/MEqGujqOR5kJMzvQ0=;
        b=syzFUPiuhKsHj/zRkF4XZWy3HiXxr1fNbAK0cu1r4Jl0h56tac84Lll2SB1AN7aPCn
         mTv5xSMW3CQBvvKoNc0KDskxHstGj7iIyJS1f8oJaztk95QjaDhhgPmQkc9zekHrlAXz
         IePwGL70kBs11M9sdeJGusbs/4livWRpu+nlIIAospZpRfEgjAUNweonSW6belL4MeS1
         bzxDry1QiGyqxPhr26G85KiasmJvkWxLToROvKpPZ5DIwhWrQrDHpaXZXQGi5T5iUSek
         q86SCq12X5DnfziKkGg7nC10pHX6EgGm74coSguJo1zOIHSe63GNYXRyn2xmn9peuxe8
         DnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689663857; x=1692255857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axjn/sYToZar4H60yNlZc/j45/MEqGujqOR5kJMzvQ0=;
        b=WjD0sex//KpqMQe1BPw5Re2NnZpwDKcr/yssJXYqhCkQn5gn7CG/JU3fdqBkQK5ok9
         tTr38e+8McorP3K0JTYWe4sHf71H/4xUljv2GWIcQDXCo2walDBontPWq/lyRcmQ3zPG
         aYcrB8bT483T0cJjZtPsIdGE8SmXwkSs07j1VG7NYUDcVZzh6UHLz8QZpMWaIUH+DtGu
         Bd7vZWBAFX1GhaDrtlSe6g9LKkPAEvCdpgzAvQN59w9m9m2lWx1AGGNB80YiDpWCaSjg
         kf+DVvO8vNb88lm89ffqO9NeP8oGvSJ+DE6A/SPe1X8Tf9G4/VvLqETuUik4Lz9PTqkp
         5xWQ==
X-Gm-Message-State: ABy/qLYgq7960Pcau2wvLKw6L4dnytqoFVtim9MXamW/Nhjv8BivfDwH
        7cDFzhzuNvWb9zoiMKLSaJo=
X-Google-Smtp-Source: APBJJlFWRwBzYYJtipfyQ3793K1v9vPM0jcqBgO6bDamwOYRvtq2qTt+gU9+hQGIPLxW03UhNqBcjQ==
X-Received: by 2002:a17:902:d3c6:b0:1b8:9552:2249 with SMTP id w6-20020a170902d3c600b001b895522249mr12243330plb.43.1689663857458;
        Tue, 18 Jul 2023 00:04:17 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a22-20020a170902b59600b001b86dd825e7sm1053041pls.108.2023.07.18.00.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:04:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 985AA8191864; Tue, 18 Jul 2023 14:04:13 +0700 (WIB)
Date:   Tue, 18 Jul 2023 14:04:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
Message-ID: <ZLY5bHubtrAsw1MF@debian.me>
References: <20230717201608.814406187@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1sg3vSecY7TDSFAN"
Content-Disposition: inline
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1sg3vSecY7TDSFAN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 10:34:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--1sg3vSecY7TDSFAN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZLY5ZwAKCRD2uYlJVVFO
o58xAQCNWexAdaOo/Wb5FVc2wvy9z6YkjgytmGLRAcgWggQmpAD+Ml/DN22Di3F3
Zd/xTggvE2JYL0wtbF3i9CyU7mYJzg4=
=usL+
-----END PGP SIGNATURE-----

--1sg3vSecY7TDSFAN--
