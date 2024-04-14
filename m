Return-Path: <linux-kernel+bounces-135917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF589CD0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA931F2289A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811BF1474AF;
	Mon,  8 Apr 2024 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="jxx1QSbd"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15331433BD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609492; cv=none; b=P9EkYa3MPhdNebOTbuBjQKnv9jbsSF2OsUS2qDnNtmzzGdcEtM/ghKPGFjOlaN5oVjU3nzpdbC0FHD844DE1RD7iQTBfdYqxACq/5AuQVnVLZQv9Wnnzu1t3b0VGmcGbrQcc+8uJK9ppFEP3NY46vHcSVz2bDAd9YJzniGPC5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609492; c=relaxed/simple;
	bh=gA5+mgRbd8KHD3NrqPJs62fIL5mvl9EFenbUqxGvdPQ=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=r379TChfEwBguQoM5ZmMNPk2yqJi6gTnIdpHvIA6HtClFug/6u/sHj3kp+Md0J3NCY8OW1+KiGn9KrW9/sh92LPcidBEN3QLzfZzdmbq8KnEWbBtxXZZwq5slZDJMD3HEzeNRhckwk+kptzPyp6JySLB8V0srgmCXH+WVxJsJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=jxx1QSbd; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8ae457b27so136521139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712609488; x=1713214288; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GQJkNeijGqducYJoywocnozwcnYBFnNqziHT4xxFK0=;
        b=jxx1QSbd6VrgPfPWT00RK2FMXT3MNuwb9pMOgnk8NTkcl0mqw3eV3kfuM9l97aZ4OK
         1z2xB3BHdG1PaEm228/8Nv7W/G9Dk3aB0SY9rGweWo6oYC4aVZ+AUhhpZwLgaAbdtJhT
         HQgR+/E3rAJTA6qLvbZvPoh6t/KDMzYWbufYA8/0b7GMfETT2IBsEs44f/OUR9OjD5oi
         UO6QevG8TlEUzsNdLnasReSDbqPJs+yazAFG2P2huqRskQ7fXy1o92XkjCt9IYKeFM3S
         a7vfXKw4cEVaJcMprdGAMB5/57eajnC6LHKXWBex2poMwXS4hQmWgQjeL5YZSMtIf89a
         0Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712609488; x=1713214288;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GQJkNeijGqducYJoywocnozwcnYBFnNqziHT4xxFK0=;
        b=r3w+k8iVrPWU3Xp/Tk5ftASEUdyJf3tTQh4EKuSnkx57q10F0LhcPgBKGlIaoi6g9l
         TtYRBi/wy7sVGaPEpZbIK0jL+ll7v35gbTLHUTXmZCpFLBPsooccHQeJo+n5DvzlXSlb
         pOyQSrjtle4s0QmZGeN8UUN4wKzXpE0t1iD9HNZzp98vZL9fTgOanphqnfxFwfiUX1LW
         qWwM7g19CL2EP427+1in4qZS9YKFoMVnVbJlE0d74pO2Zrt9evwf28Fvxe5JKz4w9J14
         djvPTXMmzUF7hg2dpY8k19yiV5IPNOUnTjWtZGbcFqTWSuIyL06UZzY+KNzOMgDhBOZr
         ulag==
X-Forwarded-Encrypted: i=1; AJvYcCU2S3WFzU4Z7i78B1LES31ypTP6Bhk3Op65YOn10STn3RXQpUSBV7jlJOj/sgURt4z2TK1UsgnbGCpOnml1LI/7lH842R05jb7LtzDP
X-Gm-Message-State: AOJu0Yw0cgoxtUuEbLbCOCnIcIz2UYXIQ6+QFEbsrrxSr6iX6Li4c93R
	8uhXtn+ouqmAvzOQ7HmQJjKqa9CAcgHPcD97IN5ZyVrk9aM+1ZxH/l6d+21BNomxheNlmwMWmCr
	r
X-Google-Smtp-Source: AGHT+IF4QJqYVi9ApOkA8E3b9TSz96XIMFC1mOP6p8SxBzZGQ9WTobj9E5A0oxjNQskr+m4Qbmk+Zg==
X-Received: by 2002:a05:6e02:160f:b0:36a:12d5:d422 with SMTP id t15-20020a056e02160f00b0036a12d5d422mr10788232ilu.27.1712609487957;
        Mon, 08 Apr 2024 13:51:27 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id b29-20020a63715d000000b005dc507e8d13sm6783905pgn.91.2024.04.08.13.51.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2024 13:51:27 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <9859512C-90E0-42AE-BF14-71E4D28B7A1D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CCF1F3B7-06D4-4FB8-818C-06A6DC175F1B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: =?utf-8?Q?Re=3A_=5BPATCH=5D_ext4=3A_extents=3A_Remove_unnecessary?=
 =?utf-8?Q?_=E2=80=98NULL=E2=80=99_values_from_ablocks?=
Date: Mon, 8 Apr 2024 14:51:23 -0600
In-Reply-To: <20240402024804.29411-1-zeming@nfschina.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Li zeming <zeming@nfschina.com>
References: <20240402024804.29411-1-zeming@nfschina.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_CCF1F3B7-06D4-4FB8-818C-06A6DC175F1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 1, 2024, at 8:48 PM, Li zeming <zeming@nfschina.com> wrote:
>=20
> ablocks is assigned first, so it does not need to initialize the
> assignment.

While it is true that "ablocks" is currently set before use,
this is happening a long way away from the variable declaration
and also "ablocks" is used after the "cleanup:" label error case:

cleanup:
        if (bh) {
                if (buffer_locked(bh))
                        unlock_buffer(bh);
                brelse(bh);
        }

        if (err) {
                /* free all allocated blocks in error case */
                for (i =3D 0; i < depth; i++) {
                        if (!ablocks[i])
                                continue;
                        ext4_free_blocks(handle, inode, NULL, =
ablocks[i], 1,
                                         EXT4_FREE_BLOCKS_METADATA);
                }
        }
        kfree(ablocks);

So there is definitely a risk that a code change in the future
would introduce hard-to-debug problems, crashes, or even just
spurious static code analysis warnings.  My recommendation would
be to keep this 1-cycle local variable initialization in place
rather than spend hours or days trying to debug and fix a crash
here in the future.

Cheers, Andreas

>=20
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
> fs/ext4/extents.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 4ab96f01a6f31..caace8c3fd3c1 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1061,7 +1061,7 @@ static int ext4_ext_split(handle_t *handle, =
struct inode *inode,
> 	int i =3D at, k, m, a;
> 	ext4_fsblk_t newblock, oldblock;
> 	__le32 border;
> -	ext4_fsblk_t *ablocks =3D NULL; /* array of allocated blocks */
> +	ext4_fsblk_t *ablocks; /* array of allocated blocks */
> 	gfp_t gfp_flags =3D GFP_NOFS;
> 	int err =3D 0;
> 	size_t ext_size =3D 0;
> --
> 2.18.2
>=20


Cheers, Andreas






--Apple-Mail=_CCF1F3B7-06D4-4FB8-818C-06A6DC175F1B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYUWMsACgkQcqXauRfM
H+AYaA//Rjy57wP3qnb5jAHgZuDjT3i/v8+fsVS1RgwE8rxxYv9/mYtKf61rYRDu
izHM2b6nfL7h6AhQ3FujUVeLjrls/cU37NEgRxVSk/WS2gEBEBeetkx1Si3Zf+n4
aYB28C5r9evolTzngj9J15z0bUWD3cLPxsChiso1C7nUgeLZAYZrKCbfOqlzEw1Y
Nr16drdtDmXO1mNO4Dy32CvmfNFOvC2OH/YE7XnXsXZUAFpEcYsu/pkT4i8VyHFr
3KkO/VidRvd3NMtFSNc8LDMeDSddkwOQ7/zotVg6fLaoTYYONrOG1onHdUAHcirz
o7y9CSLfr8njV/xSX4UAFM/hItkmS+2sqS8RhNqSNH7x44sGxgQzfW9L7lapavtp
LZElZe3ELP6s1V5ESDhyaa2aoI45JApSuyShH9SXIQy+ySW2irhhJ39VaZEISa1i
y8HsNUGMes2QnsfNPUoa8uKDKJSVWaARnc9lktoqSHJlACtIhyKaI+4hCC9ZAius
vJdEuYnAAapjl4V7ZGkiOmWtF0Lfhvg5Qv6ZSRjlCMFiSgM7EoTqfX4RXZD1/D6B
pZpQCmKciwPyUGpfE8LpY1QzTHX2Ww/0ApPqWXVXSCwpvG50k9H/X8WjovV2/p57
TFdXwvON3v8xfpascASCDRijVFvWnVZ3mp0Z+N26Kve+5prulaE=
=m3wu
-----END PGP SIGNATURE-----

--Apple-Mail=_CCF1F3B7-06D4-4FB8-818C-06A6DC175F1B--

