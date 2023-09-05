Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6566792BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349951AbjIEREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347370AbjIEE2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:28:11 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319311B6;
        Mon,  4 Sep 2023 21:28:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76df3d8fb4eso126439485a.1;
        Mon, 04 Sep 2023 21:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693888087; x=1694492887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWgaTVmGKK/1LEN6gPVAr1vwp0h/BBNqjSFG08wB/fM=;
        b=TEvtPcyKRTrCKgVJxO2F2cHv6qwFtgK1b+TyzheKEVAxuOt1j7/QgQjsf1TUz7iL7i
         sMZ9yTeUNndOd+ggtSiucMW1s6LGVSedJT8RGMJqtAMa5G1fN4/LSysETsankTHvhF7g
         gXrWKddQCJv8mr3MHDGnHhLk1H2z7+8jAMw/0LI8BVSK7DkS7Di9yJjHqdZuloGfqT0c
         D+2yiysTjzgarH6LockWrwcUvrf5+ccQ8VI9e9LTvNJ8qnVepWNfSuHcS3UlIjNL5dWD
         zQj4PCIFGlj5J8QsUZ+y09UfRTAR+XfMY9vdQtaWYqiQo28W9BVn+nTm2zhRPIAAQ3gn
         hmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693888087; x=1694492887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWgaTVmGKK/1LEN6gPVAr1vwp0h/BBNqjSFG08wB/fM=;
        b=JHrpJ7qQXPw87HMsjrNjZA4JGIAgV+2zcRA2BKqcqr2DsWqJBUvEsMvffSoMhqQsUg
         p2CzPyVkhxDxA99DA7Ig0M/FFOshf42UttEQ68/l3GWGRB/OhcfkAwpyIeejLlDiijlj
         xqrzAMnJJM191VzTPp4cR5eO+7qK3T/0vbx7J5plUOs5Ub9vzGkjV9HkoLIXw/yGFq4Q
         sxZJLpG29P0ixLPc6M5G8gTixsWIm8Wuh/7+4pi+FTDlgphHb/Ke1zO5oQnBedN3jqNS
         MG9013cpqToD+/x6Ndd4IK6kNW+kGybcEKdfmJm6/PCXDVtgPJEwwaCFkyY6y5dA5ZvK
         6OzA==
X-Gm-Message-State: AOJu0YzUCaMTsm+jgBBtMvCOI32HSr0mcIJdnNsHoX5b7dymm/PFa5MH
        WIF5ttBgPhoLoyzm7oVH8j4=
X-Google-Smtp-Source: AGHT+IHYmroJtrEm5/Z1B1aI2s4sLP9zuqfgFu+4gX/0vKDvIhcALhkfGYKpGlwOu0KgUF+GqAZXUg==
X-Received: by 2002:a05:620a:461f:b0:767:de7c:b60 with SMTP id br31-20020a05620a461f00b00767de7c0b60mr15733201qkb.9.1693888087229;
        Mon, 04 Sep 2023 21:28:07 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id y27-20020a63b51b000000b0056606274e54sm8377370pge.31.2023.09.04.21.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 21:28:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EC2DC83750AD; Tue,  5 Sep 2023 11:28:03 +0700 (WIB)
Date:   Tue, 5 Sep 2023 11:28:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 00/32] 6.4.15-rc1 review
Message-ID: <ZPauU72HlP_dvnGy@debian.me>
References: <20230904182947.899158313@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yVkkHyRm0iPHqxli"
Content-Disposition: inline
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yVkkHyRm0iPHqxli
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 07:29:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.15 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--yVkkHyRm0iPHqxli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPauTQAKCRD2uYlJVVFO
o3r+AP9h62zr6s9K35mx/rdIZyM29OCsEzKqH6W8hX9yxhlWaAD9Fb7Nd9yAp6+L
95NzBDP+jkfCfOLwYTv5g/bX6/ANoQM=
=db7D
-----END PGP SIGNATURE-----

--yVkkHyRm0iPHqxli--
