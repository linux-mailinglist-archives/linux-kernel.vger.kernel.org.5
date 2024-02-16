Return-Path: <linux-kernel+bounces-69243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0632858625
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009331C220DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4441369AA;
	Fri, 16 Feb 2024 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bx0qnEWu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E41350C7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111678; cv=none; b=iptjPSo5Mi3qdAQeHfcWyQTp2S0DBfXOtt+0/RuNfCVDZ4jEJZ5mU7meZIA8jGi9TnN92DFh88KXKNv+q0Kfn+goQTCpTIlp1RiUL2AbliPHAGvmJwu4iQYRNEMKZmjBM8x4NOkYk+wjw3xKLe6RMx8bKg7VMizWQ1pKJHvqDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111678; c=relaxed/simple;
	bh=XP2Ssr0W0KNb2mAoZruawTcIJ4iNSskUZ5SyEGo6zp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVs66wto0V+OwnlVi4NTKdG+3c+dLPjh48RggHDNzYNPDb/VNwGG9eOc0d7uLGycEmbspRgCJVp67DO7vdaMxg+QuAp1eXJnE3nHWofjzhjUhWRoGhix/o8K7dKBxGRLVDg3KRaPXYWlZeCP7yg6WctXpE2/T2N3FGzskfnBJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bx0qnEWu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708111675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZg13zy2f1Sjq+lnFutMGVWrvXXPTszj/Aro7n4Wj44=;
	b=bx0qnEWuPM7OCZDm2tlPJPNMN5ISnLD+BPIgaYOg2q6Vx9f4vjeyBZt4BND64EADorlS2x
	tlqrokGfqSi2mLnxt2UgPzpZUDpLaVugJKlBz9gydvoaDQBWqbAmXbSAIOsIMvFSdTFRLb
	4cdc+hqOlgW48VdRKhQ58vFXRP7y6iM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Qt_hdGC9PoqqjFlICWX9PQ-1; Fri, 16 Feb 2024 14:27:53 -0500
X-MC-Unique: Qt_hdGC9PoqqjFlICWX9PQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68efdf7e047so27874396d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708111673; x=1708716473;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZg13zy2f1Sjq+lnFutMGVWrvXXPTszj/Aro7n4Wj44=;
        b=ila98qMZmfNj5hPhMUdKCAsqKJDw+Gpb14vgDzcZCco2ExLPtFiWV19ZCqXao85mf6
         rb1il00VU8PtNeN6CX3ozLu65W6bmtlhAbVjnAWdzI5IlnP5LYrXwVrjr654yh/vYLOi
         4zklAtpN1Fu149eXNOutoz9jvVhYchv2KbdupvMU9Hceqmf+2QGCnnO4wCGBLc4hGH9x
         yv8JG5QCUjDYLzTgRs2gpb/QJgkCIf5k3gduTO9FaxrYdfei7XEg6r/q8xo/PQGB7Fxx
         yxMIKZDtpC4tuKznRdT4thhqM3+xa90PGV14KgNaIBHMp+ss49Ier67MNxgH/dHDL/E/
         0vDA==
X-Gm-Message-State: AOJu0YyjWA0zybQIj7HvjjlHZ+9GSAicHoHBF42lSGQA8dLynK8lPxop
	kBkjG40qG76jfPm83LvMvw89FUERvnR3bVpYB7bYLjDKGSLHpQEmmKUVbUNtjMNefpEPICt0nyA
	RyDUidfCx7w7vy4IvG0d0ABxFN8zQUyFGXBprttJVP794+nAOhAtNptHGNaGBvQ==
X-Received: by 2002:a0c:dd14:0:b0:68c:8ae0:b413 with SMTP id u20-20020a0cdd14000000b0068c8ae0b413mr5065348qvk.30.1708111673382;
        Fri, 16 Feb 2024 11:27:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqU6XR/z9mwRIQJ7tr+JE349ec9y1ODAUhvAln7TN8nTq+gbx6ljtRTRkaleeA0q3SRdU/gg==
X-Received: by 2002:a0c:dd14:0:b0:68c:8ae0:b413 with SMTP id u20-20020a0cdd14000000b0068c8ae0b413mr5065333qvk.30.1708111673119;
        Fri, 16 Feb 2024 11:27:53 -0800 (PST)
Received: from m8.users.ipa.redhat.com (2603-7000-9400-fe80-0000-0000-0000-0154.res6.spectrum.com. [2603:7000:9400:fe80::154])
        by smtp.gmail.com with ESMTPSA id g5-20020a0cf845000000b0068ee3a50585sm206657qvo.38.2024.02.16.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:27:52 -0800 (PST)
Message-ID: <3bdb1c9e0ac35c7dc3fbba1233bc7df80ac466a2.camel@redhat.com>
Subject: Re: [PATCH v2 00/14]  Add support for NIST P521 to ecdsa and ecdh
From: Simo Sorce <simo@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org, 
 linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
 davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Date: Fri, 16 Feb 2024 14:27:52 -0500
In-Reply-To: <20240215231414.3857320-1-stefanb@linux.ibm.com>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 18:13 -0500, Stefan Berger wrote:
> This series of patches adds support for the NIST P521 curve to ecdsa and
> ecdh. Test cases for NIST P521 are added to both modules.
>=20
> An issue with the current code in ecdsa and ecdh is that it assumes that
> input arrays providing key coordinates for example, are arrays of digits
> (a 'digit' is a 'u64'). This works well for all currently supported
> curves, such as NIST P192/256/384, but does not work for NIST P521 where
> coordinates are 8 digits + 2 bytes long. So some of the changes deal with
> converting byte arrays to digits and digits to byte arrays.
>=20
>=20
> Regards,
>    Stefan
>=20
> v2:
>  - Reformulated some patch descriptions
>  - Fixed issue detected by krobot
>  - Some other small changes to the code
>=20
> Stefan Berger (14):
>   crypto: ecdsa - Convert byte arrays with key coordinates to digits
>   crypto: ecdsa - Adjust tests on length of key parameters
>   crypto: ecdsa - Extend res.x mod n calculation for NIST P521
>   crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
>   crypto: ecc - For NIST P521 use vli_num_bits to get number of bits
>   crypto: ecc - Add NIST P521 curve parameters
>   crypto: ecdsa - Register NIST P521 and extend test suite
>   x509: Add OID for NIST P521 and extend parser for it
>   crypto: ecdh - Use properly formatted digits to check for valid key
>   crypto: ecc - Implement ecc_digits_to_bytes to convert digits to byte
>     array
>   crypto: Add nbits field to ecc_curve structure
>   crypto: ecc - Implement and use ecc_curve_get_nbytes to get curve's
>     nbytes
>   crypto: ecdh - Use functions to copy digits from and to byte array
>   crypto: ecdh - Add support for NIST P521 and add test case
>=20
>  crypto/asymmetric_keys/x509_cert_parser.c |   3 +
>  crypto/ecc.c                              |  71 +++++--
>  crypto/ecc_curve_defs.h                   |  45 +++++
>  crypto/ecdh.c                             |  59 +++++-
>  crypto/ecdsa.c                            |  48 ++++-
>  crypto/testmgr.c                          |  14 ++
>  crypto/testmgr.h                          | 225 ++++++++++++++++++++++
>  include/crypto/ecc_curve.h                |   3 +
>  include/crypto/ecdh.h                     |   1 +
>  include/crypto/internal/ecc.h             |  61 +++++-
>  include/linux/oid_registry.h              |   1 +
>  11 files changed, 495 insertions(+), 36 deletions(-)

Hi Stefan,
what kind of side-channel testing was performed on this code?
And what is the use case you are adding it for?

Thanks,
Simo.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc









