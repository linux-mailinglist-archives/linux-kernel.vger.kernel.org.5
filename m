Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F9F7C7D08
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjJMFcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJMFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:32:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F4B8;
        Thu, 12 Oct 2023 22:32:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso330567b3a.3;
        Thu, 12 Oct 2023 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697175127; x=1697779927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nIvaPS82lenFE9njzHfPB1IlZ8+QONjjy7qyu3wWos4=;
        b=c4TV5Ip973ixvH3HjkaH6FrPe/5YhZX8ou4+wHdrfGzGwnyu/ljLVEEaDkJvcpXevK
         H0nknVXeQiyhZCV8o1mF0czjRYHMbbNjSeDFBY/pOwnGGl/SqvkHC02YQvdR59i1RKOh
         koOtd2+eDFEcDCNkteM0u3VrMKmjKBS8E3b43IbpVjqQTD5v3fLuauK5+vrv7Ww9WAy4
         grAnM6M9hynKbjCBXUUxljRjMEAom7Bnr7ZO9YqnKRoNL8stYIA2x7Hnrc/bCS8hfQqy
         f14MX1FsmpkrTzqo9U7RiQyogDTFZoUisLEW817/Fg0c5iQquhOcVfFWDilkN8//DhCB
         rgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697175127; x=1697779927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIvaPS82lenFE9njzHfPB1IlZ8+QONjjy7qyu3wWos4=;
        b=hSDFRb75sZsXQpwWSsQT36+AyDBWEKqKOdEPp1iYK5ZgXVIBCrB/dQmsW1whlXsEoc
         YoagCq3bYLFJ436xKFBoQRx3DM+va4E+JAszKFpPIT3+B9/jJmBNWPFw88/zk54asq5p
         viaU33TyaL8W3mLGby/lgEAxNsMwSRKAqdKXLwI5UfyMh1uPRAfKFWgbF4Y0P2Bi7Qak
         aSS7zW00LPsiJBsZINS1Wyvz/gc03hMEeZqR0puhSkTR18OTWY1NL7c9lFS+ovBQ0DG3
         UznjPkRoP2kS8JDKzjdnmX1oTm1l4XQMyR16PuVR9EdwUfnkjv/1mkkl3rul2g1voByh
         aZkg==
X-Gm-Message-State: AOJu0YxrBdgOnN8/sRWr/poRG/6FTEchBfP24Qzz+pNNOiB4zM4klAa7
        xBB93RmJx18nxIFuj7mHSLU=
X-Google-Smtp-Source: AGHT+IHF4II3VixwJFDR98pc7JU2m3Z7Qk8+kTLeK1ZUPjdx43t6VBQzk24AdOEBlcQKpZG63FOqsQ==
X-Received: by 2002:a05:6a20:d417:b0:15d:4a4d:ecf7 with SMTP id il23-20020a056a20d41700b0015d4a4decf7mr20773277pzb.36.1697175127387;
        Thu, 12 Oct 2023 22:32:07 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902ea0400b001bbab888ba0sm2903283plg.138.2023.10.12.22.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 22:32:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 35C2C83B4ED5; Fri, 13 Oct 2023 12:32:00 +0700 (WIB)
Date:   Fri, 13 Oct 2023 12:31:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 0/6] 6.1.58-rc1 review
Message-ID: <ZSjWT2w3uzRkRca_@debian.me>
References: <20231012180030.112560642@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DtwhJ4fBDgUKVjIt"
Content-Disposition: inline
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DtwhJ4fBDgUKVjIt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 08:00:42PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.58 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--DtwhJ4fBDgUKVjIt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSjWSQAKCRD2uYlJVVFO
owi7AP44/kvOHOX2rSJOHx3Y9NngBuPUkm+nr1XUfNc1uF+2AAD/Ybe4YrYRc0Ox
2KFxSLfx8e8LFkJB0//IMkRdyjvqlw0=
=VyG7
-----END PGP SIGNATURE-----

--DtwhJ4fBDgUKVjIt--
