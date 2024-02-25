Return-Path: <linux-kernel+bounces-80321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00834862D67
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571DE1F219E6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593EF1BC39;
	Sun, 25 Feb 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ZWzz/A1+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F95D2EE
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708899639; cv=none; b=p4XCxKppMEZxnoYlT4fhCp3r8GXl+sdP0K/rG8nsq3zGDBCKp8Z7bjINqVdstR7ztVVCVLzwVLdksOa+Mr6gaSjkMzWfeQ1fiPuawr/28xvnMGDK0I9DFAB/AxOROK3L/2Z3pbR80gEw4JGu2sY63oP1MU19R60ozp3i6i5Zq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708899639; c=relaxed/simple;
	bh=UXS6o52/gxylcEk77QTCs8vWUzpJEIdKr/eTjoCMKJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6ZNsWGk36G8AuR2Vflo78boDfwkH6VFrynqSxtJ1H0LB12DBMHW1JapmsrjUu+mrIB260Vphk3MezImIJ8uZ+tw9nSCE6i2ovG9ISmdKcOUEwUkYRbkQra3GbrGFs7XOlWM4P7pUx23q8lzP9K5PG/6mRf7wn+feM++5n5ndtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ZWzz/A1+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a293f2280c7so335549266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 14:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1708899634; x=1709504434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcAAMbo5fPSeSlUc+G3Ds0RoWmjIC7d5lnGAqCLP7+0=;
        b=ZWzz/A1+/0hUq9nDjW7N3dGG7LW0a25pVAl4SI7JWbix8Ltz4Y5g7CQa0X19SpZvrt
         m0GmEH/4k1aw2+YaXYQWzMvA49bfciqVUt/kubYMWAfGocim+0pbUwS4a90JpIm+UucR
         rdSrZ1sCdsthEBmpbj9+wTzVstNYGC3tqeE5NZ7Temc2jwHK6oo5aHlSF8hvuMrITMcu
         5l9wPI4BUwWVFm9OQP+ykoWDa0GS+o/3IPjv+EWumaiPBhxHrDdk1HvypueugaWP8lA6
         e17B5V0hWi03vQZfx1NVYorirpMQDGTkg/zoCRONcwXcJLnRJgbr96bJ39Hv7REZ5rX+
         00jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708899634; x=1709504434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcAAMbo5fPSeSlUc+G3Ds0RoWmjIC7d5lnGAqCLP7+0=;
        b=U+n4+cNRtSAWCjLOj8qVLlsvZisuB18N6srA7R6dkqhTjR9szUeSU2tB3Q3MBLtaZn
         iHXIHBm0cuLMDYGb5LZUZWFDHZukIqusEPCUzcku4zTkqSdgrR/AU+qBFwoLmdr4D6mS
         5+/ak/P8amDBLQoR4C4TutTy3+2yL3q9i+6o0lQrn0EDHLffo7xO/4we1U3Db4Vmzbm/
         Y/cn/QB+L7TK8AamIPG/G0OajMspNg+tJK5JcUCZ5iBt0AmxiapTvoLS3Z5Br7/gw+ig
         PFItnQRTRqQXYJNKBfa749OvZe9EXGCtbQaOHixMlgfGW0iPnc9RuOkIP/LJF83ofyol
         YMbw==
X-Forwarded-Encrypted: i=1; AJvYcCWhXoEBTrId8yDisiblTbP+naJzuaBPiZvqEZv1dPLP18FJJNriQ4RRoSuZewxiAj8X9Vv+xOK182RRgwwyKfe6HWXznwWy8hrnz8MC
X-Gm-Message-State: AOJu0YwAob1ALoaPHK3sJ0yQIFeqCbgAKjU9f6Oo68GUGP9augzj4gnd
	QWqofL8cSDt4lr7rClEaXHV+SyI039BUxo7KMT2lvn/ZZgn8U0dHmfFjeN7YBow=
X-Google-Smtp-Source: AGHT+IG5bJ/fK8sFX2rG8b+VDYEkiBFr76ZXZ4JyDKWlPw45GhDGbdPCrTlUaWepqwiGPkAAQmeUww==
X-Received: by 2002:a17:906:3c18:b0:a3e:d5ac:9995 with SMTP id h24-20020a1709063c1800b00a3ed5ac9995mr3150880ejg.59.1708899633957;
        Sun, 25 Feb 2024 14:20:33 -0800 (PST)
Received: from blindfold.localnet (84-115-239-180.cable.dynamic.surfer.at. [84.115.239.180])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709062dc400b00a3f355aeb0bsm1828968eji.131.2024.02.25.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 14:20:33 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, upstream@sigma-star.at, David Howells <dhowells@redhat.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Sascha Hauer <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	sigma star Kernel Team <upstream+dcp@sigma-star.at>, Li Yang <leoyang.li@nxp.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tejun Heo <tj@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, linux-doc@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, David Gstir <david@sigma-star.at>
Subject: Re: [PATCH v5 0/6] DCP as trusted keys backend
Date: Sun, 25 Feb 2024 23:20:31 +0100
Message-ID: <1733761.uacIGzncQW@somecomputer>
In-Reply-To: <47439997.XUcTiDjVJD@somecomputer>
References: <20231215110639.45522-1-david@sigma-star.at> <7AED262F-9387-446D-B11A-C549C02542F9@sigma-star.at> <47439997.XUcTiDjVJD@somecomputer>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Mimi, James, Jarkko, David,

you remained silent for a whole release cycle.
Is there anything we can do to get this forward?

Thanks,
//richard

Am Dienstag, 13. Februar 2024, 10:59:56 CET schrieb Richard Weinberger:
> Am Montag, 5. Februar 2024, 09:39:07 CET schrieb David Gstir:
> > Hi,
> >=20
> > > On 15.12.2023, at 12:06, David Gstir <david@sigma-star.at> wrote:
> > >=20
> > > This is a revival of the previous patch set submitted by Richard Wein=
berger:
> > > https://lore.kernel.org/linux-integrity/20210614201620.30451-1-richar=
d@nod.at/
> > >=20
> > > v4 is here:
> > > https://lore.kernel.org/keyrings/20231024162024.51260-1-david@sigma-s=
tar.at/
> > >=20
> > > v4 -> v5:
> > > - Make Kconfig for trust source check scalable as suggested by Jarkko=
 Sakkinen
> > > - Add Acked-By from Herbert Xu to patch #1 - thanks!
> > > v3 -> v4:
> > > - Split changes on MAINTAINERS and documentation into dedicated patch=
es
> > > - Use more concise wording in commit messages as suggested by Jarkko =
Sakkinen
> > > v2 -> v3:
> > > - Addressed review comments from Jarkko Sakkinen
> > > v1 -> v2:
> > > - Revive and rebase to latest version
> > > - Include review comments from Ahmad Fatoum
> > >=20
> > > The Data CoProcessor (DCP) is an IP core built into many NXP SoCs such
> > > as i.mx6ull.
> > >=20
> > > Similar to the CAAM engine used in more powerful SoCs, DCP can AES-
> > > encrypt/decrypt user data using a unique, never-disclosed,
> > > device-specific key. Unlike CAAM though, it cannot directly wrap and
> > > unwrap blobs in hardware. As DCP offers only the bare minimum feature
> > > set and a blob mechanism needs aid from software. A blob in this case
> > > is a piece of sensitive data (e.g. a key) that is encrypted and
> > > authenticated using the device-specific key so that unwrapping can on=
ly
> > > be done on the hardware where the blob was wrapped.
> > >=20
> > > This patch series adds a DCP based, trusted-key backend and is similar
> > > in spirit to the one by Ahmad Fatoum [0] that does the same for CAAM.
> > > It is of interest for similar use cases as the CAAM patch set, but for
> > > lower end devices, where CAAM is not available.
> > >=20
> > > Because constructing and parsing the blob has to happen in software,
> > > we needed to decide on a blob format and chose the following:
> > >=20
> > > struct dcp_blob_fmt {
> > > __u8 fmt_version;
> > > __u8 blob_key[AES_KEYSIZE_128];
> > > __u8 nonce[AES_KEYSIZE_128];
> > > __le32 payload_len;
> > > __u8 payload[];
> > > } __packed;
> > >=20
> > > The `fmt_version` is currently 1.
> > >=20
> > > The encrypted key is stored in the payload area. It is AES-128-GCM
> > > encrypted using `blob_key` and `nonce`, GCM auth tag is attached at
> > > the end of the payload (`payload_len` does not include the size of
> > > the auth tag).
> > >=20
> > > The `blob_key` itself is encrypted in AES-128-ECB mode by DCP using
> > > the OTP or UNIQUE device key. A new `blob_key` and `nonce` are genera=
ted
> > > randomly, when sealing/exporting the DCP blob.
> > >=20
> > > This patchset was tested with dm-crypt on an i.MX6ULL board.
> > >=20
> > > [0] https://lore.kernel.org/keyrings/20220513145705.2080323-1-a.fatou=
m@pengutronix.de/
> > >=20
> > > David Gstir (6):
> > >  crypto: mxs-dcp: Add support for hardware-bound keys
> > >  KEYS: trusted: improve scalability of trust source config
> > >  KEYS: trusted: Introduce NXP DCP-backed trusted keys
> > >  MAINTAINERS: add entry for DCP-based trusted keys
> > >  docs: document DCP-backed trusted keys kernel params
> > >  docs: trusted-encrypted: add DCP as new trust source
> > >=20
> > > .../admin-guide/kernel-parameters.txt         |  13 +
> > > .../security/keys/trusted-encrypted.rst       |  85 +++++
> > > MAINTAINERS                                   |   9 +
> > > drivers/crypto/mxs-dcp.c                      | 104 +++++-
> > > include/keys/trusted_dcp.h                    |  11 +
> > > include/soc/fsl/dcp.h                         |  17 +
> > > security/keys/trusted-keys/Kconfig            |  18 +-
> > > security/keys/trusted-keys/Makefile           |   2 +
> > > security/keys/trusted-keys/trusted_core.c     |   6 +-
> > > security/keys/trusted-keys/trusted_dcp.c      | 311 ++++++++++++++++++
> > > 10 files changed, 562 insertions(+), 14 deletions(-)
> > > create mode 100644 include/keys/trusted_dcp.h
> > > create mode 100644 include/soc/fsl/dcp.h
> > > create mode 100644 security/keys/trusted-keys/trusted_dcp.c
> >=20
> > Jarkko, Mimi, David do you need anything from my side for these patches=
 to get them merged?
>=20
> Friendly ping also from my side. :-)
>=20
> Thanks,
> //richard
>=20
> --=20
> =E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bod=
em-Gasse 6, 6020 Innsbruck, AUT
> UID/VAT Nr: ATU 66964118 | FN: 374287y
>=20


=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



