Return-Path: <linux-kernel+bounces-135925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE889CD22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B427128293C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A74F1482F5;
	Mon,  8 Apr 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="mK3NbKZb"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5414601C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609673; cv=none; b=JZLKLa9EqPU/MxW3n+KQQjkn17Xpib30/fPaYPVOhUuPCNfZhwDjHyv5hoZxoRoMa2uT6eJXi4cBgW4z6FxGAtnPzhKpsjsenA0kyrajAb3fCzMMuUrDr9BSRKWLhR0zB7Xyho6R4ivxcBQ/iNbGQ4I/bVTRBqk+1bE8A/j+OaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609673; c=relaxed/simple;
	bh=FWzuTDS/0jE8Zj1WSIL/PuE/iPyHj5EpRy5w5pnchQw=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=Jp+1KLfrwOfQls5kuJjxAYJzHvidKldXIj8s6848EphtOnGasE3OvqArjLD6YA6jFeqWCefqYTkE0noDSCNIa/y7vRHbGj96aSnBp/ZdqvYhF/v35HrEp2Hjh/482OjTOOkXGLGbX62lalYWA0ZC3XOMSACbpAmwKwwW9Xiy/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=mK3NbKZb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecfeefe94cso2321739b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712609669; x=1713214469; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXo0bBXwc68qEXAAMO2s2pb6MbtWIrtXNEI/+8vfi7s=;
        b=mK3NbKZb/t5APRnXCYLsSRrIO1lsEKQCCDP0H/DrH8zGgomMmxy/Gxdb8OhIVOmIjf
         8Qt+PLfM+jLVpu9YASQRBYA6yXkCmq3OLtFbH9/1gF/lDYuYW0Ov3QxrIhvqiUcIAFme
         rhPwG6nxcxg2aYKkgl+sv/Bq8BT58JNdlCl7bJL54knwp4LTPOBZMEgQMjTT4a0Kgh3Z
         4OuqWGtsthZvEPmls+3jI05FByTd8/6s+SyPwKJn6ubwRjyOvtGUIrrCaaK+XlDNkRyj
         sV3JZ18jOmWjpFfETpjWtA/vnuB0P9XSoVir60hiVYxVISMlgfbqcEGpc8x9tmTMJtul
         z+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712609669; x=1713214469;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXo0bBXwc68qEXAAMO2s2pb6MbtWIrtXNEI/+8vfi7s=;
        b=tGLKdUZP82vIhSwQC3+Sr0VDjORuxldGGbwVu169G8cXsaC9uavgowgNr+HjpyEY4e
         K0x8hB1pSf+IuJn6A9ssn7sSK3OzttunrnAQjTYbYNBU47P8yV6ZsYnbmZCRxm0L1rrH
         ZU0V0JN8nTMBNAcHKGH5KuRWH4YZWmFnFhUke9ywp9liV2vl3WrcXsUYWnpIFwLz2lOc
         vRkz57c0sGSv8uSYd0h2bWrB+syI5rDLy2CdJmzo7qDv5zLE1bvnHZb5WJff9/9L0I52
         IrB1H81kxaYw1Eo/Bu+iHHy21vIbYJzMuLdwnJY1vJi1PthceI0BZELg1XtUT8oRRLiO
         QijQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9PT6fzzPqlJWw/wShzS13Hjyt+ur4GjkXIXK62c84MyGN6prkHadEqYVUetMxjg5kfQ0/I99JIzKQ0MLCJOumSY4Ar2G5YpC+tDJh
X-Gm-Message-State: AOJu0YzvOzSpmKS2kT+D1RbVmceTIyy4kO/f1Xr5i9+juNXJyKoOkTCK
	2usRsgeUOGsMV1yswV7DNU0k8K6SC8hvTWs8TZJq4Vbpj3RhcELzDzsBW60+qjA=
X-Google-Smtp-Source: AGHT+IE6cOZM6q49ZFC8gRWK5IYFXUAJRq+PgMphvdKuZ2sd8FJbt5ggg5OMa8Y/mo6Kml0BMTRBtw==
X-Received: by 2002:a05:6a00:14ca:b0:6ed:21b2:ca54 with SMTP id w10-20020a056a0014ca00b006ed21b2ca54mr1122436pfu.17.1712609669451;
        Mon, 08 Apr 2024 13:54:29 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00098e00b006e5af565b1dsm6996684pfg.201.2024.04.08.13.54.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2024 13:54:28 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <4E5BC096-0EEC-467E-8C6B-276CF5BED332@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_63F7C3C4-1B33-4AA2-B964-892D266A9523";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: =?utf-8?Q?Re=3A_=5BPATCH=5D_ext4=3A_block=5Fvalidity=3A_Remove_un?=
 =?utf-8?Q?necessary_=E2=80=98NULL=E2=80=99_values_from_new=5Fnode?=
Date: Mon, 8 Apr 2024 14:54:27 -0600
In-Reply-To: <20240402022300.25858-1-zeming@nfschina.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Li zeming <zeming@nfschina.com>
References: <20240402022300.25858-1-zeming@nfschina.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_63F7C3C4-1B33-4AA2-B964-892D266A9523
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 1, 2024, at 8:23 PM, Li zeming <zeming@nfschina.com> wrote:
>=20
> new_node is assigned first, so it does not need to initialize the
> assignment.
>=20
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
> fs/ext4/block_validity.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 6fe3c941b5651..87ee3a17bd29c 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -72,7 +72,7 @@ static int add_system_zone(struct ext4_system_blocks =
*system_blks,
> {
> 	struct ext4_system_zone *new_entry, *entry;
> 	struct rb_node **n =3D &system_blks->root.rb_node, *node;
> -	struct rb_node *parent =3D NULL, *new_node =3D NULL;
> +	struct rb_node *parent =3D NULL, *new_node;

This one is more compact and doesn't have the issue with
the "cleanup" label at the end.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas






--Apple-Mail=_63F7C3C4-1B33-4AA2-B964-892D266A9523
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYUWYMACgkQcqXauRfM
H+COAQ//fd/+Y1hjlh0ZAn9FQop1SO9vmwog5pcjqcyg+JKlMJOu0Fi1UkgsHknj
K27qtRDzkX9BeqjKmzAykyVKNUrORnycZeSAz3vx3xTJN+NLjRkggeXX7EvqeZH9
J82FO2IA2TQSY0d87hXyfXPEqNlIqw11jLL2QV76vF68THRgDiZ5pt29qYOdPvx0
CJDtxEqh7xfspPy1clj7JbHjcJdVy9CQnUW+3sxm/SXV5N5jMopl6UcUPMhdQCTr
sCOgngYhBw5KNDBH/hui+0KruqGW6+rwVxvKs08E7NMMc6dNXGF0LxUhpAF7CXGm
HyJimemGhsw0dLzUzEQgQlv8/uFPs8dzRRCBgUxvYNPFkZA6Y8zCHne6dObcR1oR
oWVgGbh183tZRoREFQek1leCiAiA5e4sW/xxEUFDsVE0WCLQiSRiHRPJPwerkATn
WiB9NFOopFETY4FtKPq5OxOv0ovzmDezZLaSl7/o3kWdy7kQMz8xNrN+4X+i2W+P
uUs8oVsd3PH5Vt6ypRIKJVzszMeg6qrbXHgqMUZSzbpPiGoV+0aJ68O1xijG8WOZ
+1abvJjvyH/NxDmoOgae+Mv+fYXThSS8EqMths0y89wfCobGUO2FttusRwSicq1p
WyG+xYGVZPyBU0k8cVsvXzLuEuwgCR9iN+eWkStVK4YZ7cnSvCo=
=kjFk
-----END PGP SIGNATURE-----

--Apple-Mail=_63F7C3C4-1B33-4AA2-B964-892D266A9523--

