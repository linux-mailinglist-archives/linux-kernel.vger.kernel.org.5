Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A1C7C97F9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjJOFOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJOFOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:14:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0BFB7;
        Sat, 14 Oct 2023 22:14:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so1459759b3a.0;
        Sat, 14 Oct 2023 22:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697346846; x=1697951646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+WDk3/mBm7uAe+u8znmKpDcmMQhVxbylz6EuuqaKXY=;
        b=WOrAGgvBQwGu9OroYH1HUwpA7IE59B3L1osh4W0hakKjJN8FIJPcQeyJ/LzqThEnH9
         bWdIeCDfBSbb0qBVdiLct7j31pw6AuCWQ+2jcEs7kbvybfxI+z9ZL5lnazAxgvH1bb+Y
         MrNbXCBqgvpGi+tN8eKMo1cTMFfAO20xvkRhEZs4i4Z7vXrxdKqX3fPfJ7bemYjXNxSw
         bX+4IsCtsz1bImfL+dtdR08pKvrcQlCVpgRSlQGFNZHPSlWZA61VyWcveX/zvxB/sCr3
         BtjDBHYM1sJFsNQFK+1dbHwC+YWVRyPAxSIWBpAB8PrBp56syUsm0ijw+fu470+DCC1l
         uYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697346846; x=1697951646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+WDk3/mBm7uAe+u8znmKpDcmMQhVxbylz6EuuqaKXY=;
        b=fVyjRtUfaSX9QFio2oYlXRLsXI0wy/FEwj9rE26ma3l2L7Uivts5rDn6nIJ9Ywro/Q
         9ObpdnBzn2+p4qzIi1yRcqUrw98Canlvqt7LSbVKVyz0eSJLWBy2OTBSnGpHJnTrcMoj
         Db49zhQ7FOo6ycfr7WiYPrjKLBvPNEzVeOBif08Ufd+10rxIUdzr+VEyMEr/qxgKPl/M
         mTcy0NUye+t77kbdr+jRagFjWL8WN+JlTtU4Vi/YsvRYzLoNsXxxQqWRsw227ruCuJue
         CxvU7ax2dOlDZENUKnulV33kz0U847Vs8p6weDqVRWTV1WnuBCdKgBaD0BvuVNvyR7Bf
         rlQg==
X-Gm-Message-State: AOJu0Yyfl4BWjPAuR1FqOo/vXyk6ccGJjMY8LN98pT+xHO2Znp7m0kg+
        UGLq1/F1AzeG0Jk2E67v+PKylOZowBg=
X-Google-Smtp-Source: AGHT+IFPYNO7aeSI01N8jGv3l6yrQeaszyKagpcRglFXE3YzTUrlgadgDCS5iFPaoBIOErN37Pt65A==
X-Received: by 2002:a05:6a00:214a:b0:6bc:e7f8:821e with SMTP id o10-20020a056a00214a00b006bce7f8821emr1899469pfk.10.1697346846107;
        Sat, 14 Oct 2023 22:14:06 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e7-20020a62ee07000000b006879493aca0sm15531275pfi.26.2023.10.14.22.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 22:14:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DAC739E897CB; Sun, 15 Oct 2023 12:14:02 +0700 (WIB)
Date:   Sun, 15 Oct 2023 12:14:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     chenguohua@jari.cn, linux@armlinux.org.uk
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: Clean up errors in sfp.h
Message-ID: <ZSt1GkmyO_6iit3-@debian.me>
References: <1a7c167f.942.18b26fb3ec9.Coremail.chenguohua@jari.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v4L48laAikyil5vP"
Content-Disposition: inline
In-Reply-To: <1a7c167f.942.18b26fb3ec9.Coremail.chenguohua@jari.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v4L48laAikyil5vP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 11:01:21AM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
>=20
> ERROR: spaces required around that '=3D' (ctx:VxW)
>=20
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>
> ---
>  include/linux/sfp.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/sfp.h b/include/linux/sfp.h
> index 9346cd44814d..725c8381a347 100644
> --- a/include/linux/sfp.h
> +++ b/include/linux/sfp.h
> @@ -289,10 +289,10 @@ enum {
>  	SFF8024_ENCODING_8B10B		=3D 0x01,
>  	SFF8024_ENCODING_4B5B		=3D 0x02,
>  	SFF8024_ENCODING_NRZ		=3D 0x03,
> -	SFF8024_ENCODING_8472_MANCHESTER=3D 0x04,
> +	SFF8024_ENCODING_8472_MANCHESTER =3D 0x04,
>  	SFF8024_ENCODING_8472_SONET	=3D 0x05,
>  	SFF8024_ENCODING_8472_64B66B	=3D 0x06,
> -	SFF8024_ENCODING_8436_MANCHESTER=3D 0x06,
> +	SFF8024_ENCODING_8436_MANCHESTER =3D 0x06,
>  	SFF8024_ENCODING_8436_SONET	=3D 0x04,
>  	SFF8024_ENCODING_8436_64B66B	=3D 0x05,
>  	SFF8024_ENCODING_256B257B	=3D 0x07,
> @@ -306,11 +306,11 @@ enum {
>  	SFF8024_CONNECTOR_MT_RJ		=3D 0x08,
>  	SFF8024_CONNECTOR_MU		=3D 0x09,
>  	SFF8024_CONNECTOR_SG		=3D 0x0a,
> -	SFF8024_CONNECTOR_OPTICAL_PIGTAIL=3D 0x0b,
> +	SFF8024_CONNECTOR_OPTICAL_PIGTAIL =3D 0x0b,
>  	SFF8024_CONNECTOR_MPO_1X12	=3D 0x0c,
>  	SFF8024_CONNECTOR_MPO_2X16	=3D 0x0d,
>  	SFF8024_CONNECTOR_HSSDC_II	=3D 0x20,
> -	SFF8024_CONNECTOR_COPPER_PIGTAIL=3D 0x21,
> +	SFF8024_CONNECTOR_COPPER_PIGTAIL =3D 0x21,
>  	SFF8024_CONNECTOR_RJ45		=3D 0x22,
>  	SFF8024_CONNECTOR_NOSEPARATE	=3D 0x23,
>  	SFF8024_CONNECTOR_MXC_2X16	=3D 0x24,

To be consistent, other enum's indentation should also be aligned to match
the longest ones (MANCHESTER and PIGTAIL).

In netdev, though, checkpatch fixes are not welcome (auto-rejected) as these
make stable backports more convoluted.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--v4L48laAikyil5vP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSt1GgAKCRD2uYlJVVFO
o32hAP9QYVZ7joG4QINC/SIgwAKup3NqZVPF6Nd+fO62v8gFhwEAikdG0aJCslJx
37l5zFrIz6QL6e2JYEElblDRIDNp4gc=
=mbEP
-----END PGP SIGNATURE-----

--v4L48laAikyil5vP--
