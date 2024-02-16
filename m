Return-Path: <linux-kernel+bounces-69251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0337858643
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3301F23B06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D4138496;
	Fri, 16 Feb 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrNflfaR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03CB1353FF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112430; cv=none; b=OpXp3oGJ12XDD81qCWHEsvXCyUSvZ+2Gh8kqB049I/i1qL8oakcJ7byN1xkrfCOSqc9vqYF9pjzlNcFBDQAA8exaI3NpdP1YKs5mkNzGSQRULEFvOOyhFYHYZy1Wh6q2vjCBx+dLESPzzGNvQAf0UM3VXQ3SuyIZNkjOkw0diJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112430; c=relaxed/simple;
	bh=2kEtxKUR+YXMyVhQ0XNlntdk3ty7ZikevcYC5ACSZCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bduHMa+WASpv1tadHxFfvKaZD0gsYsTcAL+frnHOVbhX48i/UZ1usGdu76vfTobe9+Pijl4wYZyE3sGL/Tm2wNBuDVaDher7drBNn3hcdOdWOpjEJzxUQfncyyui8p4sPhMJHXrResYQ1h10wnNX+1cLK4HGyBrzP2Mk3KE9bXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrNflfaR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708112427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3XNc86fIkfMukvVvTcsnQ6iarjT+k2RqqCdbeeV/AY=;
	b=IrNflfaRxRGcajOh1Bq9ni7C3uh9FZu109RU++bZ/RstL06UK02mgEoxwl8LFW8X5DQX+C
	oSVrp1x22LfrpM4m4O7VGzlVE7hoB4GD2tiiq17fgcsWorOY+NRTaqHPCoViN5qoZRSNbq
	xi9STXuqt9AMsoz4FLikgm8YQVLhdls=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-Fer2LpSKNFOZKNJsrj6Ojg-1; Fri, 16 Feb 2024 14:40:25 -0500
X-MC-Unique: Fer2LpSKNFOZKNJsrj6Ojg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42c709698f8so59652801cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112425; x=1708717225;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3XNc86fIkfMukvVvTcsnQ6iarjT+k2RqqCdbeeV/AY=;
        b=jiUblCm/GlooeB/qnthUNMT+pksBLv9tUH4ub3kC6ZH+tptGptlxM46x7Q1z7yxk0v
         evvgWHYdP0XiKqrytlmJVGvNlUj8Mc6aE9JVF79j9NdnKinctLwn4tXgCfYra5Ivr3lV
         drnVtuHQgp3EgTV+mDdkGsHei96QHTRdILk7zTqIf8lp+cfQLuaxQhr2dvZ9sM2B0bwP
         HAyIuZ0eD8CUrepGvTow3mXY9v0uVeqiFQoFHQQ2D+KulQWFayptXtBrMP/SrM4O3tWs
         AVBGbW9oA/Yxu8RSh7F4g9asR1d5De5KNDHvwAtybx2e4UWgy8NXX7vSReRKboXjzMcb
         pUdA==
X-Gm-Message-State: AOJu0YzTkQybOstqmRvYFYK07RD836eQKcQQizDExO7aQO8g1G5/26ya
	IJUTxO+rNoBMsLDq3QTDbVWEc3OcaZ4uhzN7Js+zAqKVI8IL7ZiiKWKxnGxXVna5Pb5egMJvK3V
	f1Q54q4wJ1SY3ZyHiT5c8gVlQQitKL4zi/1k0y5U3wEJb7ZaC5MIUuLQWJl01gQ==
X-Received: by 2002:ac8:584e:0:b0:42d:ac7d:a334 with SMTP id h14-20020ac8584e000000b0042dac7da334mr10657991qth.33.1708112424924;
        Fri, 16 Feb 2024 11:40:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGT33+1/X1VeKyj5dxhhKselaG7Wc6wazzQ604JXGpTkd5+Zr2xU/Dyyx1tXCNah0WjW6nkg==
X-Received: by 2002:ac8:584e:0:b0:42d:ac7d:a334 with SMTP id h14-20020ac8584e000000b0042dac7da334mr10657964qth.33.1708112424634;
        Fri, 16 Feb 2024 11:40:24 -0800 (PST)
Received: from m8.users.ipa.redhat.com (2603-7000-9400-fe80-0000-0000-0000-0154.res6.spectrum.com. [2603:7000:9400:fe80::154])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87c85000000b0042c6c5bc47fsm207931qtv.83.2024.02.16.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:40:24 -0800 (PST)
Message-ID: <c7feceb3a7816c2f8686a907fbea2028477464a0.camel@redhat.com>
Subject: Re: [PATCH v2 00/14] Add support for NIST P521 to ecdsa and ecdh
From: Simo Sorce <simo@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org, 
 linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
 davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Date: Fri, 16 Feb 2024 14:40:23 -0500
In-Reply-To: <b507fd52-a807-4325-981b-3852f4f6190b@linux.ibm.com>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
	 <3bdb1c9e0ac35c7dc3fbba1233bc7df80ac466a2.camel@redhat.com>
	 <b507fd52-a807-4325-981b-3852f4f6190b@linux.ibm.com>
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

On Fri, 2024-02-16 at 14:32 -0500, Stefan Berger wrote:
>=20
> On 2/16/24 14:27, Simo Sorce wrote:
> > On Thu, 2024-02-15 at 18:13 -0500, Stefan Berger wrote:
> > > This series of patches adds support for the NIST P521 curve to ecdsa =
and
> > > ecdh. Test cases for NIST P521 are added to both modules.
> > >=20
> > > An issue with the current code in ecdsa and ecdh is that it assumes t=
hat
> > > input arrays providing key coordinates for example, are arrays of dig=
its
> > > (a 'digit' is a 'u64'). This works well for all currently supported
> > > curves, such as NIST P192/256/384, but does not work for NIST P521 wh=
ere
> > > coordinates are 8 digits + 2 bytes long. So some of the changes deal =
with
> > > converting byte arrays to digits and digits to byte arrays.
> > >=20
> > >=20
> > > Regards,
> > >     Stefan
> > >=20
> > > v2:
> > >   - Reformulated some patch descriptions
> > >   - Fixed issue detected by krobot
> > >   - Some other small changes to the code
> > >=20
> > > Stefan Berger (14):
> > >    crypto: ecdsa - Convert byte arrays with key coordinates to digits
> > >    crypto: ecdsa - Adjust tests on length of key parameters
> > >    crypto: ecdsa - Extend res.x mod n calculation for NIST P521
> > >    crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
> > >    crypto: ecc - For NIST P521 use vli_num_bits to get number of bits
> > >    crypto: ecc - Add NIST P521 curve parameters
> > >    crypto: ecdsa - Register NIST P521 and extend test suite
> > >    x509: Add OID for NIST P521 and extend parser for it
> > >    crypto: ecdh - Use properly formatted digits to check for valid ke=
y
> > >    crypto: ecc - Implement ecc_digits_to_bytes to convert digits to b=
yte
> > >      array
> > >    crypto: Add nbits field to ecc_curve structure
> > >    crypto: ecc - Implement and use ecc_curve_get_nbytes to get curve'=
s
> > >      nbytes
> > >    crypto: ecdh - Use functions to copy digits from and to byte array
> > >    crypto: ecdh - Add support for NIST P521 and add test case
> > >=20
> > >   crypto/asymmetric_keys/x509_cert_parser.c |   3 +
> > >   crypto/ecc.c                              |  71 +++++--
> > >   crypto/ecc_curve_defs.h                   |  45 +++++
> > >   crypto/ecdh.c                             |  59 +++++-
> > >   crypto/ecdsa.c                            |  48 ++++-
> > >   crypto/testmgr.c                          |  14 ++
> > >   crypto/testmgr.h                          | 225 +++++++++++++++++++=
+++
> > >   include/crypto/ecc_curve.h                |   3 +
> > >   include/crypto/ecdh.h                     |   1 +
> > >   include/crypto/internal/ecc.h             |  61 +++++-
> > >   include/linux/oid_registry.h              |   1 +
> > >   11 files changed, 495 insertions(+), 36 deletions(-)
> >=20
> > Hi Stefan,
> > what kind of side-channel testing was performed on this code?
> > And what is the use case you are adding it for?
>=20
> We're using public keys for signature verification. I am not aware that
> public key usage is critical to side channels.
>=20
> The use case for adding it is primarily driven by closing a gap to=20
> complete the support for the common ECDSA NIST curves.

Is there an assumption the ECDH code uses exclusively ephemeral keys?

Simo.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc









