Return-Path: <linux-kernel+bounces-16259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4F823BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D511C24C24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518A18640;
	Thu,  4 Jan 2024 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9zCPk0X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DF18EC3;
	Thu,  4 Jan 2024 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ec3db764so501585ad.2;
        Wed, 03 Jan 2024 21:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704345615; x=1704950415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3NzzRz631nrmHxCWhVwS62FIh58ttvyDrTrVUoW0lw=;
        b=O9zCPk0Xfh54Yy3nhnIRrDiQl07u0CF+2rNsog28dHrn3LW/hScCEq84hxlbQxtB1T
         VDQb1zRJ+1AcPifRAbNortLahwLDdbuq7WuLBAM6uOiMqmUKG4PwW2wOjDNNy38/AFLa
         CoLBXnd7qoa6pgsMsucNDzDLwRrYlde3VItAEg4OBVc85AWvrka2Ndfnd1WmTLf/SzkF
         4BNRFwmmYM5RpoIkxjBrPK8SqoZqT9J/0iRUQZzwZWpsLdkDH/WpiMpH4NxNvoAu58bq
         /ihUS2apFyqTui/rgPv7gC1tlDp9SHyotmtJETJ0EASK2X+0NPXnvLrAI+7l86NFdZxi
         z5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704345615; x=1704950415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3NzzRz631nrmHxCWhVwS62FIh58ttvyDrTrVUoW0lw=;
        b=bI2eo9sdSNmw+thD2EcMPSQRxJbLRpEYQOeCVJ1vqDdzPJTHxL74LzouHYF4O2tmuk
         zCiKLghvVFF4oCFt/h9gSMFccQFw0RFKk1wnKUmyCjiUU7QLfNh5HONb2S2t6VbL24bU
         MfYdsD+aasrRSaDxJ6upbrlrtcaVbgWZNsvgOXa7QVqta11utECIEmSx4IwBOTf1L7P7
         IarTH8kSgSd3G/xFjRlg+viLZ0k8WwrIN7hm5R4nOje4GG0Tyw4MFMr5O4ZgurY0e54H
         x9pnUigTBDalTE2LTcIEOwv9mCHKpKONNh0DrU9SNsNWIhyF6I6TOpHM6atKo7h1kBOL
         N5Fg==
X-Gm-Message-State: AOJu0Yzo3fpQO44KIiZgxgOHFuiLo6SB0D3CTMCvwdAAVDS2UnJGCgAn
	EZVcUSuelemLItsVH8B32dnSiE93MQnihQ==
X-Google-Smtp-Source: AGHT+IHjISQRzYh9tkBeu5tmOF7gvQHMQ0tUCQ/ANdl6BpSWfWZ36Dbys8MO+YxDFI819ttVLUoMWw==
X-Received: by 2002:a17:902:db07:b0:1d4:cbfc:1ccb with SMTP id m7-20020a170902db0700b001d4cbfc1ccbmr56654plx.64.1704345615332;
        Wed, 03 Jan 2024 21:20:15 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001d395d3df30sm24573015plj.130.2024.01.03.21.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 21:20:14 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 118BC184790CB; Thu,  4 Jan 2024 12:20:10 +0700 (WIB)
Date: Thu, 4 Jan 2024 12:20:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Message-ID: <ZZZACjAEBXL0DvO2@archie.me>
References: <20240103164834.970234661@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gCL66V2puD9uMZI8"
Content-Disposition: inline
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>


--gCL66V2puD9uMZI8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 05:55:20PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--gCL66V2puD9uMZI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZY/+gAKCRD2uYlJVVFO
o+iSAQDVZqyJauaNs1nMTVxRDf7yh24q/4XMnshBmztqxidgwgD9H7p1j+LlAuUX
0EiwvKAigIjgLEgD+gp0nUlBby33pAc=
=cKlU
-----END PGP SIGNATURE-----

--gCL66V2puD9uMZI8--

