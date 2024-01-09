Return-Path: <linux-kernel+bounces-20836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7171B8285E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AA7B21D43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29052381D5;
	Tue,  9 Jan 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Wgg6wF/Y"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4638F8A;
	Tue,  9 Jan 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1BB001C0050; Tue,  9 Jan 2024 13:15:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1704802521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhmmk20k+rX0c1WjGIu9zhcLkj4LuGk5mXhRFdHCwT8=;
	b=Wgg6wF/Ybo76dMzrukPWaRtTMu7leyzUfIdDlQfXEhmd2bKfW80R+otm7nEB8PHghBapgI
	qFUt5QvEBRCLOlz/H1TRTc77OV0soYdmd91idoZdkpSv4mzOMfEaGEHWKQJd5jiJkzDuvr
	XKpXULk0q4xpYnSq6nOjH5TdjnqwRH0=
Date: Tue, 9 Jan 2024 13:15:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bvanassche@acm.org,
	hch@lst.de, hare@suse.de, martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: scsi_get_lba breakage in 5.10 -- Re: Linux 5.10.206
Message-ID: <ZZ042FejzwMM5vDW@duo.ucw.cz>
References: <2024010527-revision-ended-aea2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MXcu7+91PUeNfjQF"
Content-Disposition: inline
In-Reply-To: <2024010527-revision-ended-aea2@gregkh>


--MXcu7+91PUeNfjQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm announcing the release of the 5.10.206 kernel.


> Martin K. Petersen (2):
>       scsi: core: Make scsi_get_lba() return the LBA

This is bad idea. This changes return value, but without fixing
callers; there will be subtle bugs somewhere.

At minimum, we need this:

87662a472a9d8980b26ba5803447df2c4981d467 scsi: iser: Use scsi_get_sector() =
instead of scsi_get_lba()

That will fix iser, but there's also:

drivers/s390/scsi/zfcp_fsf.c:           io->ref_tag_value =3D scsi_get_lba(=
scsi_cmnd) & 0xFFFFFFFF;
drivers/scsi/isci/request.c:            tc->ref_tag_seed_gen =3D scsi_get_l=
ba(scmd) & 0xffffffff;
drivers/scsi/isci/request.c:            tc->ref_tag_seed_verify =3D scsi_ge=
t_lba(scmd) & 0xffffffff;
drivers/scsi/lpfc/lpfc_scsi.c:  lba =3D scsi_get_lba(sc);
drivers/scsi/lpfc/lpfc_scsi.c:  reftag =3D (uint32_t)scsi_get_lba(sc); /* T=
runcate LBA */
drivers/scsi/lpfc/lpfc_scsi.c:  reftag =3D (uint32_t)scsi_get_lba(sc); /* T=
runcate LBA */
drivers/scsi/lpfc/lpfc_scsi.c:  reftag =3D (uint32_t)scsi_get_lba(sc); /* T=
runcate LBA */
drivers/scsi/lpfc/lpfc_scsi.c:  reftag =3D (uint32_t)scsi_get_lba(sc); /* T=
runcate LBA */
drivers/scsi/lpfc/lpfc_scsi.c:          start_ref_tag =3D (uint32_t)scsi_ge=
t_lba(cmd); /* Truncate LBA */
drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long)scsi=
_get_lba(cmd),
drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long)scsi=
_get_lba(cmd),
drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long)scsi=
_get_lba(cmd),
drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long=
)scsi_get_lba(cmd),
drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long=
)scsi_get_lba(cmd),
drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long=
)scsi_get_lba(cmd),
drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long=
)scsi_get_lba(cmd),
drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long=
)scsi_get_lba(cmd),
drivers/scsi/lpfc/lpfc_scsi.c:          failing_sector =3D scsi_get_lba(cmd=
);
drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long=
)scsi_get_lba(cmd),
drivers/scsi/lpfc/lpfc_scsi.c:                                   (unsigned =
long long)scsi_get_lba(cmnd),
drivers/scsi/lpfc/lpfc_scsi.c:                                   (unsigned =
long long)scsi_get_lba(cmnd),
drivers/scsi/qla2xxx/qla_iocb.c:                    (0xffffffff & scsi_get_=
lba(cmd)));
drivers/scsi/qla2xxx/qla_iocb.c:                    (0xffffffff & scsi_get_=
lba(cmd)));
drivers/scsi/qla2xxx/qla_iocb.c:                    (0xffffffff & scsi_get_=
lba(cmd)));
drivers/scsi/qla2xxx/qla_isr.c:     cmd->cmnd[0], (u64)scsi_get_lba(cmd), a=
_ref_tag, e_ref_tag,
drivers/scsi/qla2xxx/qla_isr.c:         sector_t lba_s =3D scsi_get_lba(cmd=
);
include/scsi/scsi_cmnd.h:static inline sector_t scsi_get_lba(struct scsi_cm=
nd *scmd)

That needs to be fixed somehow. This may be quite critical due to data
corruption...?

Best regards,
										Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--MXcu7+91PUeNfjQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZZ042AAKCRAw5/Bqldv6
8nutAJ9XN12LGj1gtySQhYo49aL6ZI3woACgtuWNLK74oIxA2iwhTXYN3Rgud5U=
=IrAN
-----END PGP SIGNATURE-----

--MXcu7+91PUeNfjQF--

