Return-Path: <linux-kernel+bounces-9524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E881C6FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9EC1F26491
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692B1125BE;
	Fri, 22 Dec 2023 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4teFydU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946F611704;
	Fri, 22 Dec 2023 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3e05abcaeso11557525ad.1;
        Fri, 22 Dec 2023 00:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703235472; x=1703840272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJgbG+f/SZv2UFHQARjYL9zgX07zGjOA9Aqji87Qpjg=;
        b=O4teFydUD+xbllYBXJaPJG21d76p07fYXjPx3GEhtpx0E7kGq4w/P5LFVI7Q4rxSHW
         1l5fJSkORg+Zxu+c8SHDfFKDg82ZnSqWrstbNNaUN1UAPCK5lsTCK8p4FtFXbZ/vzJcz
         o9nG9Km1SqiY92zEVREeCwzcKrgr2ztgXsLB7L5XW0euSlVU2uB7YAUie7mCzyZJiTeu
         ZDZJxu+jwt4pJqLN7GIJAnH3zV1Vq7za3vfV4sE6eAPUN49RDtInzZmnZM0xMvLxJCSI
         r1e7HN7d1zUxkDmSc1T0UnoEPwqb4MGBYkMc85xJ4bqoH2yifStH6+1f7gsevQUfF90X
         DU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703235472; x=1703840272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJgbG+f/SZv2UFHQARjYL9zgX07zGjOA9Aqji87Qpjg=;
        b=ITl4GFjdnQvLsjsLi3+iQ7K/84qHkDCP/1dPlnMqbETg2MAqb3sPFTq7nMk9i1yKug
         VFjwQqiW9JVyPQzrhPH5AB7iHxLHkGb9wW+T0P+NBGG16HG/+H4MPRXNYvh9oP0lvfH5
         fgNVMXQQjMht/Cdi1fT3IdUIACkrEU3GxOwf6ezbdqdfvGhcsqx8pN8cX64Xzs1x0s3+
         JpDkvokPU+3nlfGc7qTUWQVSLo734nVq5TpGKLnImpZYtvhdMgaJynH2Gdu+fWX44JHn
         xAuW3RWj+uB2PiflpMi+IX7UC9luL0tLsdU3DluOUq0VCzfFTEfIMSQiyjaatbRbpvXy
         TXng==
X-Gm-Message-State: AOJu0YzzhvVSkAUQpTbdSDgjO/0tPz78RoCn7aNlEw3yLuhlEjYs2Xcw
	duZhVBhFpRzte4kBzcm/i/E=
X-Google-Smtp-Source: AGHT+IF8xT9B8t8qqVo9I+qNDR3QKW6M6ipbW8efexi4szFO4FxpMRMIx4zJoYDGD4zeAoB6kVw4kA==
X-Received: by 2002:a17:902:d50f:b0:1d3:fa6a:fc88 with SMTP id b15-20020a170902d50f00b001d3fa6afc88mr808399plg.17.1703235471780;
        Fri, 22 Dec 2023 00:57:51 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c21-20020a170902c1d500b001d39a728499sm2971395plc.77.2023.12.22.00.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:57:51 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EEC981188811C; Fri, 22 Dec 2023 15:57:47 +0700 (WIB)
Date: Fri, 22 Dec 2023 15:57:47 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Ruipeng Qi <ruipengqi7@gmail.com>, corbet@lwn.net,
	rafael.j.wysocki@intel.com, gregkh@linuxfoundation.org,
	carlos.bilbao@amd.com, vegard.nossum@oracle.com
Cc: skhan@linuxfoundation.org, srinivas.pandruvada@linux.intel.com,
	qiruipeng@lixiang.com, linux@leemhuis.info,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] doc: Add osdump guide
Message-ID: <ZYVPixP3BqonexaP@archie.me>
References: <20231221132943.653-1-ruipengqi7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IzAAchqv1y/jPfiw"
Content-Disposition: inline
In-Reply-To: <20231221132943.653-1-ruipengqi7@gmail.com>


--IzAAchqv1y/jPfiw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 09:29:43PM +0800, Ruipeng Qi wrote:
> From: qiruipeng <qiruipeng@lixiang.com>
>=20
> Add osdump guide for the users who try to compile with osdump enabled,
> use, and analysis real system problem.
>=20
> Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
> ---

Why is this [3/7] only posted on mailing lists (aka why LKML only have
this patch instead of full RFC series)?

--=20
An old man doll... just what I always wanted! - Clara

--IzAAchqv1y/jPfiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYVPiAAKCRD2uYlJVVFO
o0RtAP9L7Ig3wRKYsLuZpjagxOSSf7naM39FRX8lsyNwl3t4mwD/YQNu0a6pbNBp
1/sNnDoukRNHgpag/a1Nu7NDteL0IQ4=
=I03D
-----END PGP SIGNATURE-----

--IzAAchqv1y/jPfiw--

