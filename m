Return-Path: <linux-kernel+bounces-41623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2383F581
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7323B217DC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2B23779;
	Sun, 28 Jan 2024 12:36:31 +0000 (UTC)
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9423761
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706445390; cv=none; b=OX3j9ulMB8G+1L0s09NS37uUY4VHoL0LkZBe11sZnc8N/NnEPqaTtClNZSQgkOr/4WS7YTokVDCxypJjcoQY4Z+Q3SOudqWA0r755K2b87xFnBsG1sQ0MQH4AaCdziyaf4GhDlCHgdqgkDtsFs9FrFPRz2rSb4OhA1YxS5rIPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706445390; c=relaxed/simple;
	bh=c1+LDDtW52Mdi+O0WFO7kYLUFHSb/KiaVRBVuzuOfhc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=rfasQ6/BDBWKKIPxV+dJp0lmJM/iTRYp9OrPAR9+QGyeJit73E1S1foRz7NOfdCzCf4rKwvJa2pzHIFZz5ny0+3Lg2FphvhlJcNUMQNVngVG97eBdwZEW6Blp9MiCARe64F8qoUdUS7c1Ox6kh+Jiu6T+TjZixE/XyjINkfWjDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
	by mailout08.t-online.de (Postfix) with SMTP id DEFACD830
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:26:30 +0100 (CET)
Received: from [10.2.3.136] ([80.145.193.127]) by fwd77.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rU4F3-222Ang0; Sun, 28 Jan 2024 13:26:29 +0100
Message-ID: <dfe9213bb86939ca4502b5b3fdd3ab77ef1b6f1b.camel@t-online.de>
Subject: Western Digital SSD freezes on power saving
From: Frank Tornack <f-tornack@t-online.de>
Reply-To: f-tornack@t-online.de
To: linux-kernel@vger.kernel.org
Cc: f-tornack@t-online.de
Date: Sun, 28 Jan 2024 13:26:23 +0100
Autocrypt: addr=f-tornack@t-online.de; prefer-encrypt=mutual;
 keydata=mDMEYPp0PBYJKwYBBAHaRw8BAQdA9MoQWxT+PljXoionhEHpIAuLlhUME07Jht42EmJS9/K0f0ZyYW5rIEVja2hhcmQgVG9ybmFjayAodGhpcyBrZXkgaXMgdXNlZCBhZnRlciAyMy4wNy4yMDIxLiBBbiBhdHRlbXB0IHdhcyBtYWRlIHRvIGludmFsaWRhdGUgb3RoZXIga2V5cykgPGYtdG9ybmFja0B0LW9ubGluZS5kZT6JAoYEExYIAi4CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4ACGQFEFIAAAAAAEAArcHJvb2ZAYXJpYWRuZS5pZGh0dHBzOi8vdHViZS50Y2huY3MuZGUvYS9ib2xsZXJ3YWdlbnBpY2FyZC9iFIAAAAAAEgBHcHJvb2ZAbWV0YWNvZGUuYml6aHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vZnJhbmtlbnN0ZWluOTEvOGE2ZmEwNmMxM2ZiY2VlZjhhMjRmZDFiNmRlNzIyYmFFFIAAAAAAEgAqcHJvb2ZAbWV0YWNvZGUuYml6aHR0cHM6Ly9tYXN0b2RvbnRlY2guZGUvQEJvbGxlcndhZ2VuUGljYXJkqhSAAAAAABIAj3Byb29mQG1ldGFjb2RlLmJpem1hdHJpeDp1L0Bib2xsZXJ3YWdlbnBpY2FyZDp0Y2huY3MuZGU/b3JnLmtleW94aWRlLnI9IWRCZlFaeENvR1ZtU1R1amZpdjptYXRyaXgub3JnJm9yZy5rZXlveGlkZS5lPSRjWGVqcnQ3dWJ1RUF5aTNsaFVDeWFEUUlBa0lnRktHMnF3TF8yTXl6MDY0UxSAAAAAABIAOHByb29mQG1ldGFjb2RlLmJpemh0dHBzOi8vZ2l0LmdnYy1wcm9qZWN0LmRlL0JvbGxlcndhZ2VuUGljYXJkL2dpdGVhX3Byb29mFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmR3n
	hEFCQWlCuQACgkQVa3qmdMF6s3KvgD+O46flI8ye2GWKixgtdQz4aDS78b+LES2ROInCv7N9IwA/ihgH1BlnCypJ4oXSb4KoPmC2M/HLfjtN/kG8x9B6VAPtFBGcmFua2Vuc3RlaW45MSAoRGllcyBpc3QgbWVpbmUgU3BhbSBFLU1haWwpIDxmcmFua2Vuc3RlaW45MS5pbmZvQGdvb2dsZW1haWwuY29tPojQBBMWCAB4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAORSAAAAAABIAHnByb29mQG1ldGFjb2RlLmJpemh0dHBzOi8vbGljaGVzcy5vcmcvQC9NVExGcmFuaxYhBIqzlkn93enweqtxJlWt6pnTBerNBQJkd54XBQkFpQrkAAoJEFWt6pnTBerNBPYBAPQqJRcB3bXZBZMBkWvYRPf44BZeYZPikE0jWpzmvil7AP4372uJBCKvTDX/v3ONDVBxK5kDn96yKTMVmm1PsJZVCrRMRnJhbmtlbnN0ZWluOTEgPGZyYW5rZW5zdGVpbjkxLmluZm9AZ21haWwuY29tPiAoc2hvcnQgdmVyc2lvbiBvZiBHb29nbGVtYWlsKYiWBBMWCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmR3nhcFCQWlCuQACgkQVa3qmdMF6s3FegD9EF0ViEKoXrUtjeyxTNr7TZybm0C72s73E0cVLZnjfXYA/3XPhEYxgcKxLQ8Ee9vg20C7QwtumLf4dewXSjE+3jEJ
Organization: Privat
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TOI-EXPURGATEID: 150726::1706444789-3F7FD877-70A9FF13/0/0 CLEAN NORMAL
X-TOI-MSGID: e8d36ad7-195c-4e13-abc3-6231d56fac44

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Linux kernel developers and experts,

I have a question that I think is not tied to a specific distribution
and goes pretty deep into the Linux kernel. I hope you can help me
without subscribing to the mailing list and remember to include me in
the answer discussion.=20

In my old notebook I used an nvme-ssd from WD (wds500g1b0c-00s6u0),
which is affected by a well-known bug. I currently use the parameter
`nvme_core.default_ps_max_latency_us=3D0` to prevent the system from
freezing.=20

I would like to use a new SSD in my new notebook. However, as it is
difficult to sell used SSDs, I would like to continue using the old SSD
affected by the bug. I plan to move the SSD to a Thunderbolt enclosure
for this purpose. I think since Thunderbolt is based on PCIe, the same
energy saving measures and the associated bugs will probably apply.

In the hope that my new SSD doesn't have the same bug, I would prefer
not to disable the Powersafe in the laptop. Is there a way to set this
flag only for a specific SSD? By identifying it by name or serial
number?=20

I apologise prophylactically if my question is completely out of place
and thank you for your help. As a long-time Linux user, I would also
like to thank you in general. If you have any follow-up questions,
please do not hesitate to contact me.

- --=20
Frank Tornack <f-tornack@t-online.de>
Privat
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSKs5ZJ/d3p8HqrcSZVreqZ0wXqzQUCZbZH7wAKCRBVreqZ0wXq
zcQkAPwMA+J3eO/S6T92Gsz9YBamYVHhwLlcUAG3qsYM2g8sRAD/UY+If8RlsT5V
uKg89rhH2bnWrVF9PKGU4ZamfHo8eQ0=3D
=3Dgfie
-----END PGP SIGNATURE-----

