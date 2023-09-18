Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F507A417B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbjIRGoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbjIRGno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:43:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB3710F;
        Sun, 17 Sep 2023 23:42:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3f97f2239so37241595ad.0;
        Sun, 17 Sep 2023 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695019379; x=1695624179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNd4SPlO+Rpe4i36RjIqSfIzurzEIvdaKO8DkO9ug6s=;
        b=l3wYIQg6709PEcJ6VWv7/u1tODUr9/o64e5csudYMwloBEqHyDhcR0M7eezq0FJDKF
         w3lxdhn3fJtJnP29QQtOrbrSXD4jHk8CzWpMs46bmA+RMzUrcNPb8EO5lToJ18LSMpIZ
         pu9vJELoDDmVrsOWam7XnJQ6ZtqBtsHOH6X5flJ4XChnxQFxlE12wH4GB6dnCiwUwoX3
         IVeOVmZ8aJpOENOxjtvQURfMHKGjl8QawepyK18+rZk23dwMk7R4hPWFtqz1cuJDGafW
         9zZlAg6rrQ+g1mxFzIFGbHI/7PtkXlmCs5d2t9LMfRj3d/DSywDDInt9+fpTKwCraKdS
         2gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695019379; x=1695624179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNd4SPlO+Rpe4i36RjIqSfIzurzEIvdaKO8DkO9ug6s=;
        b=hCUttHQiTMFAmVIPd+cv3rT2vDyTBUeSy4BlcYJJchs5PKQFBwXG4xlddXMMRbBwe7
         a06Am0Je5Ohg4MN1O6wnFyqY3+Vz+WPNox2WN1myE1iAC4eZ2ngjVnXfDjxjG/XYzRN5
         DyK0lbSKqet8WkEOadvoN8qY9+fvr/rCCBng7mTTfTYfyKtSc6AfQmh7LhbtRHA27RAG
         aufa4rFLXnroNEWKxO47arrENfNQeYK7fyIA3DhYL0D/SvQ29b2qn7nrv8veSmc5DPse
         2Mjdh2FNy+jHHeXZOOZRENrmIySp7k0uHzLUs9KHsq6ZsPvjgRmBSRy2gM99s5xTPglw
         C6sQ==
X-Gm-Message-State: AOJu0YwvyGfX/RSTT+3P5NzmHKHOsc2DvUBv7pyqawXCTlbMUM10lDqS
        7imn9ub41VlqvHFSTsZpgM4=
X-Google-Smtp-Source: AGHT+IEnD5n3FcCcE7688chJ3+/GpYkXt9X70bgW58BVBwzVfAxeJj8nSoWzz0QMlhayEHfHna8QfA==
X-Received: by 2002:a17:902:e884:b0:1bb:2020:be0d with SMTP id w4-20020a170902e88400b001bb2020be0dmr10552787plg.14.1695019378648;
        Sun, 17 Sep 2023 23:42:58 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b001b895336435sm7640391plg.21.2023.09.17.23.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 23:42:57 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6AC5F8AB1A5C; Mon, 18 Sep 2023 13:42:54 +0700 (WIB)
Date:   Mon, 18 Sep 2023 13:42:53 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/219] 6.1.54-rc1 review
Message-ID: <ZQfxbToe2KuURGd9@debian.me>
References: <20230917191040.964416434@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3tVqIVmz1hZafmq2"
Content-Disposition: inline
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3tVqIVmz1hZafmq2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 09:12:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.54 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--3tVqIVmz1hZafmq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQfxaQAKCRD2uYlJVVFO
o8ypAQC8WmtBiUnzg9BbfeFLVTUbsooSNmHtb4hTqNmivddaOwD+ILCB/IhjJKqn
60oZ7p3L9cMkuyTLsVZxw9NrfYtPYQ4=
=K4KD
-----END PGP SIGNATURE-----

--3tVqIVmz1hZafmq2--
