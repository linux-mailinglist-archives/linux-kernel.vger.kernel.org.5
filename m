Return-Path: <linux-kernel+bounces-107669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B24C87FFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2C7B22490
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A0256776;
	Tue, 19 Mar 2024 14:44:46 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBB23A8;
	Tue, 19 Mar 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859485; cv=none; b=NN9imhUuPNwsjh7L+72dxvQQ7NROetZNmwV2eyNt2RX76/ux5oJtqN/tScQTFybfy2TokZWJZuv62aLsvdLaihpvnhdEXPSczxgJgZ+tcsjrcEMzh5aIYLiH7Zax3IuBmDo+bIBfECbLBHizhVGkEVzy3pSm+lwjO/2KAVycSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859485; c=relaxed/simple;
	bh=P40Vdq5Nbbd2vIKB85O00otSW5GtKAMdXan8b0B8sCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J88m519p4Cg4lzPdNVHcmqNRrj7Ny8gSORrEWk4YymyO5OZwl4bv1QdscrCO+d81avSKhTpb7dxubbwkFnzCv1OD9f7ETiaPAGHgTETV5WTcdc5taHOkqFzXdGtFJa6ixDy0nGhZIZ2AVPJJUc2ymrIMD0yZZv/JrHqsWChbexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 19 Mar
 2024 17:44:35 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Tue, 19 Mar 2024 17:44:35 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Jarkko Sakkinen <jarkko@kernel.org>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Andrew Zaborowski <andrew.zaborowski@intel.com>
CC: "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "Sergey
 Shtylyov" <s.shtylyov@omp.ru>
Subject: Re: [PATCH] KEYS: prevent NULL pointer dereference in
 find_asymmetric_key()
Thread-Topic: [PATCH] KEYS: prevent NULL pointer dereference in
 find_asymmetric_key()
Thread-Index: AQHadsRHcr0dJekxEkCC6oTcOjjyP7E9+xQAgAEukF0=
Date: Tue, 19 Mar 2024 14:44:35 +0000
Message-ID: <b5f21d1175c142efb52e68a24bc4165a@omp.ru>
References: <20240315103320.18754-1-r.smirnov@omp.ru>,<CZX9T3TU6YU0.3JE9M7M3ENUE0@kernel.org>
In-Reply-To: <CZX9T3TU6YU0.3JE9M7M3ENUE0@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/19/2024 12:55:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 19 Mar 2024 01:39:00 +0200 Jarkko Sakkinen wrote:
> On Fri Mar 15, 2024 at 12:33 PM EET, Roman Smirnov wrote:
> > With the current code, in case all NULLs are passed in id_{0,1,2},
>=20
> "current code" is not unambigious reference of any part of the kernel
> tree. Please just write down the function name instead.
>=20
> > the kernel will first print out a WARNING and then have an oops
> > because id_2 gets dereferenced anyway.
>=20
> Would be more exact":
>=20
> s/print out a WARNING/emit WARN/

Okay, I'll prepare a second version of the patch.

> > Note that WARN_ON() is also considered harmful by Greg Kroah-
> > Hartman since it causes the Android kernels to panic as they
> > get booted with the panic_on_warn option.
>=20
> Despite full respect to Greg, and agreeing what he had said about
> the topic (which you are lacking lore link meaning that in all
> cases the current description is incomplete), the only thing that
> should be documented should be that since WARN_ON() can emit
> panic when panic_on_warn is set in the *kernel command-line*
> (not "option") this condition should be relaxed.

Here's a link to the discussion:
https://lore.kernel.org/all/2024011213-situated-augmented-64a4@gregkh/
From the context, I thought WARN_ON() would be better removed.

> >
> > Found by Linux Verification Center (linuxtesting.org) with Svace.
>=20
> I'm not sure if this should be part of the commit message.

I have already submitted patches with this line, some have been
accepted. It is important for the Linux Verification Center to mark
patches as closing issues found with Svace.

> >
> > Fixes: 7d30198ee24f ("keys: X.509 public key issuer lookup without AKID=
")
> > Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>=20
> Should be reported-by.

The suggested-by tag belongs to Sergey because he suggested the fix,
subject/description of the patch. The tag reported-by belongs to
Svace tool.

Thank you for the reply.=

