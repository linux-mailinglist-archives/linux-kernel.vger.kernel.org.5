Return-Path: <linux-kernel+bounces-52217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E52849589
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CCC1C21FED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C971125A7;
	Mon,  5 Feb 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="USQm8JgA"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1141411CAD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122365; cv=none; b=pcDD9ssDQpc/Z+XnBtywA7kT7VPoHZEsJk8Uy+6ZMELRWN7TW70iPet1Iv7wxrzygLM1EkrHmoSs4/oPVYzxG4CtTsgb7GVg7yz+CfgbBA00JU5PUOi+hFkHPCwong3aXdioyWGRo87Yu2+FH8E6P/Kx/s3zf9UzGm6x6dBlHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122365; c=relaxed/simple;
	bh=vWCUg5e3ZEMZK/WPs6t0bqEagLm8F2BxIwdVLhxnKZU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kIRE1Fl9pjHtgm8gvWBLvN7pmr43fYoASLgLNy4+L6oe6YDZTRenXqA5BI7SkxMeHrfB7GJ4ODr6YzkbK68+ASnUyiGdSU/vYz/Zpy+Ndbq4h98Y7TmkNKlWWgz+uYh4XtT/oWkEQWmUzojuYQYYoLLtKo5D4UaS4eCBoHE3+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=USQm8JgA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a363961b96aso518611866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1707122360; x=1707727160; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fYC3H+9fhYO7ZOc/qX6rq1afQIQ11uUH5tLK3IWpXc=;
        b=USQm8JgAsU+bvggwhfSL5ljcQ5Z14tU+aidl4amOwC7ZtSddvc9cEIU5FQDAtpdiZt
         00xL062bRmN7OPRxqr9e3hhhQP2KxWABZr8Ma9bEsukUP/+XfBdKrxS8u8xvWWr8r2VP
         UxZhDLZ4BtL4L3Hy+SGvRO9Zo7LX77N1QosSuLMUgDOa7fp2NEBZlRX8TlRHzfj2xsHg
         ruw24jXiiwcaiq+nC/CJZi0HDUybbK0aKr+39odEyNF9Ke1tux69a9NVWHrTn2sGHRUW
         SZ6dIdM1EKfOG0F+J9NXyLx/pz+JwMNCxlMay3J1rr9zgJTm+WrXQnjvV4L2LLRkUFpB
         W1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707122360; x=1707727160;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fYC3H+9fhYO7ZOc/qX6rq1afQIQ11uUH5tLK3IWpXc=;
        b=OO7CppcFDfloYlBdXcCrrflgu2aJBi//WaDg5MGeNO0S/M8zMQ7vPHF2Qa7XhQpwlk
         ny3QiGsFvIsamlTWHcyq4O6wmV9PwNQb0e+xUKzxhiulxe5OawVvTzFC5FFI88M8VMS5
         8fiaqu5eyLb4ezYQztB3pdg1wj4nT41GGEZ8jrq5oo6qgekgYRnhZcMZCX767raSMxmG
         MaE8X8slhrm5wNsRfSM+k4Ed6Dh8kzPn37ezBU1HQFN86TbVVXNhi0RKmf4/Fo7LvAyg
         iPQrzXhs6Fu0h/VD0I8QG7kLZPx3W3uHZrodhtrXnUv/ajx2I4mDTD1U+oNGrvh51B4e
         qyMQ==
X-Gm-Message-State: AOJu0YxoJXzMxMnLzMySF7KVYybM/5kPlpQmpgXVR1B/qYFW76HcWWy5
	0CBLL3b3LfBqkCAzVE20E254LHB0XN1zzzjFuDz/c37mIGTjuG0/HjotZkxZrsc=
X-Google-Smtp-Source: AGHT+IHLVlIqTHZQT4uS2cWMqHQ2/IKc/41epP/Cs1vBSz9FD6909OEjZv22ODsI8EUgs+fyzA4YHw==
X-Received: by 2002:a17:906:16c8:b0:a37:bdc2:e4e6 with SMTP id t8-20020a17090616c800b00a37bdc2e4e6mr1530645ejd.10.1707122360096;
        Mon, 05 Feb 2024 00:39:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUTINvkr7TdZxNV3zYWkm9NGPQZ3GBX+JIgmxygvgv41SJzvPqoxxCTp3Tc5PUMHqQw6PbrIpUJx88b3E4cjK5SpUhXe9GIOdkr+YAeq65K7GeGBl1IcKBE3vDLsUsnuV2IbaG0QNY2n7bIZmG6EvZe1SBcWh+cXAGLPTi+gsHzLIB4Ek4PUYTx4gU+ytkjrCv9icm50Zeb3mURGFiiEDIG7cEFIv8APYkltJkm2gyR7ujeOD214DLsYXioA4GA+mfSAn1zE6cUXN3gEY+rLpkmUpLjD2iJPbzDVzGNISNprHIg7SmguU4h2FdVVnwSTySpbdJdWbY3O73k0isTb+fW+2BhqgbYzLQP4Th8toVBowOkBsWLuiIMTWzYAOhJmk6ekd906b1/N5qCiiP0jMcDqGHNHD66is0Ey/uYHly9YuPt9eh1AjwKjjwF5b/qpsQ704D/FfKIJGUGgJ1LvvVEDZ4wkLobm4MWzCyKR42KQu0JY9qwDmsVCk+CmP2XiCJQ8kF2e1uHxU2m6jE1Jk/PCyOQgU3eOv7zuzVmmRlrTGC97+WwZ9lMD8jIvBNhTVIoLbb6F+28AgmyFJsGRwnuvmQaQIBSDluu/HVeamiL/BJF4j44dxmUseTJh1DPAFnwb8JEHWSiMWx8TUueFEYA879cQmBtXxDqUYJWkmFVkkCePJ36slN9TE80+JJXJ1Z0bJJAZkbT5axJshtLmW1nYM/cCaLufm5IJ62p4nLFPkfgMBdpMO6VDWIOUm45cYxAY+QEZfwBlvJpE8Lld5T1ciB/mRzSVLQhcT3wgMswJ4SIQG0CdlYdDMod8umwfxAvQ5eVNuJZUIxogGlCwuZkzTMDTNJW11/MvqvmrxyUY2liKdTG8Q37KBJklaQPX7hBwW80miWJmXOgOFH/ZR0c8gSG0jlvmwQvhcM3zN3VOh/65AVlQsT6eAoJaDQm1u4hW4
 /DnIJlK+OUtw19HfTP17A+oLh+MUcCC6cXuft5pI0Syr4CJfj5Mt2O/zB3IJax/LQQuYmm
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id vu11-20020a170907a64b00b00a37a38737d5sm1316761ejc.89.2024.02.05.00.39.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 00:39:19 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v5 0/6] DCP as trusted keys backend
From: David Gstir <david@sigma-star.at>
In-Reply-To: <20231215110639.45522-1-david@sigma-star.at>
Date: Mon, 5 Feb 2024 09:39:07 +0100
Cc: Shawn Guo <shawnguo@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 David Howells <dhowells@redhat.com>,
 Li Yang <leoyang.li@nxp.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tejun Heo <tj@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 linux-doc@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7AED262F-9387-446D-B11A-C549C02542F9@sigma-star.at>
References: <20231215110639.45522-1-david@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <jejb@linux.ibm.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
X-Mailer: Apple Mail (2.3774.400.31)

Hi,

> On 15.12.2023, at 12:06, David Gstir <david@sigma-star.at> wrote:
>=20
> This is a revival of the previous patch set submitted by Richard =
Weinberger:
> =
https://lore.kernel.org/linux-integrity/20210614201620.30451-1-richard@nod=
at/
>=20
> v4 is here:
> =
https://lore.kernel.org/keyrings/20231024162024.51260-1-david@sigma-star.a=
t/
>=20
> v4 -> v5:
> - Make Kconfig for trust source check scalable as suggested by Jarkko =
Sakkinen
> - Add Acked-By from Herbert Xu to patch #1 - thanks!
> v3 -> v4:
> - Split changes on MAINTAINERS and documentation into dedicated =
patches
> - Use more concise wording in commit messages as suggested by Jarkko =
Sakkinen
> v2 -> v3:
> - Addressed review comments from Jarkko Sakkinen
> v1 -> v2:
> - Revive and rebase to latest version
> - Include review comments from Ahmad Fatoum
>=20
> The Data CoProcessor (DCP) is an IP core built into many NXP SoCs such
> as i.mx6ull.
>=20
> Similar to the CAAM engine used in more powerful SoCs, DCP can AES-
> encrypt/decrypt user data using a unique, never-disclosed,
> device-specific key. Unlike CAAM though, it cannot directly wrap and
> unwrap blobs in hardware. As DCP offers only the bare minimum feature
> set and a blob mechanism needs aid from software. A blob in this case
> is a piece of sensitive data (e.g. a key) that is encrypted and
> authenticated using the device-specific key so that unwrapping can =
only
> be done on the hardware where the blob was wrapped.
>=20
> This patch series adds a DCP based, trusted-key backend and is similar
> in spirit to the one by Ahmad Fatoum [0] that does the same for CAAM.
> It is of interest for similar use cases as the CAAM patch set, but for
> lower end devices, where CAAM is not available.
>=20
> Because constructing and parsing the blob has to happen in software,
> we needed to decide on a blob format and chose the following:
>=20
> struct dcp_blob_fmt {
> __u8 fmt_version;
> __u8 blob_key[AES_KEYSIZE_128];
> __u8 nonce[AES_KEYSIZE_128];
> __le32 payload_len;
> __u8 payload[];
> } __packed;
>=20
> The `fmt_version` is currently 1.
>=20
> The encrypted key is stored in the payload area. It is AES-128-GCM
> encrypted using `blob_key` and `nonce`, GCM auth tag is attached at
> the end of the payload (`payload_len` does not include the size of
> the auth tag).
>=20
> The `blob_key` itself is encrypted in AES-128-ECB mode by DCP using
> the OTP or UNIQUE device key. A new `blob_key` and `nonce` are =
generated
> randomly, when sealing/exporting the DCP blob.
>=20
> This patchset was tested with dm-crypt on an i.MX6ULL board.
>=20
> [0] =
https://lore.kernel.org/keyrings/20220513145705.2080323-1-a.fatoum@pengutr=
onix.de/
>=20
> David Gstir (6):
>  crypto: mxs-dcp: Add support for hardware-bound keys
>  KEYS: trusted: improve scalability of trust source config
>  KEYS: trusted: Introduce NXP DCP-backed trusted keys
>  MAINTAINERS: add entry for DCP-based trusted keys
>  docs: document DCP-backed trusted keys kernel params
>  docs: trusted-encrypted: add DCP as new trust source
>=20
> .../admin-guide/kernel-parameters.txt         |  13 +
> .../security/keys/trusted-encrypted.rst       |  85 +++++
> MAINTAINERS                                   |   9 +
> drivers/crypto/mxs-dcp.c                      | 104 +++++-
> include/keys/trusted_dcp.h                    |  11 +
> include/soc/fsl/dcp.h                         |  17 +
> security/keys/trusted-keys/Kconfig            |  18 +-
> security/keys/trusted-keys/Makefile           |   2 +
> security/keys/trusted-keys/trusted_core.c     |   6 +-
> security/keys/trusted-keys/trusted_dcp.c      | 311 ++++++++++++++++++
> 10 files changed, 562 insertions(+), 14 deletions(-)
> create mode 100644 include/keys/trusted_dcp.h
> create mode 100644 include/soc/fsl/dcp.h
> create mode 100644 security/keys/trusted-keys/trusted_dcp.c

Jarkko, Mimi, David do you need anything from my side for these patches =
to get them merged?

Thanks,
- David


