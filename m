Return-Path: <linux-kernel+bounces-44895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006138428A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258E11C241DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351641272D6;
	Tue, 30 Jan 2024 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyRCmpb2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB31272A3;
	Tue, 30 Jan 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630535; cv=none; b=WqYZHoN+6TPFXM7lNKkPR5PwRZtReTwSqP7mApUf7VNPOyataaTPkKkBLY1AxcwtDzIoUaeWMNxjiicubY5zavTAqXlx7IqWjIOQQGGgwMzTqBDIw/gbU33uB7qLiC9OL8NfJkbDkcppaoicSWXQL7ztxdT3Cmj7AEDQEUa2hL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630535; c=relaxed/simple;
	bh=6AyaDJwd1sc4HKIf54mJ2fAVwmOtAbULU8y4KjsSRL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt8KSW/756SDDCp94cP5F9mZ9LJ6q/ta71/2zZdHkRA1d3S5SCuwPzqr+LenOx/ObM2+Kf/zloZvvXKYWOCQ10zBsw26ZPtgGAUl+yistvmxR6Gz0urahG2op0bG02+TkOa4oKM9r9m/0M4wWF/7/NmXHhZHH/gAD2rAGtsU5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyRCmpb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CDBC433C7;
	Tue, 30 Jan 2024 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630534;
	bh=6AyaDJwd1sc4HKIf54mJ2fAVwmOtAbULU8y4KjsSRL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OyRCmpb2uVuSl7Apfk3AeEPrXL52NPhXFkwtVrLT/ultTeCvWdCD43P3kNXtSwrc4
	 ivaHARnlwl3MA7ZI/DteRSPjQpPhsY/+lmF60MVUt0mbvACxRTfU94rKHcsu+XJIIu
	 htKgYgCbf67lmZKBZntG/RLgyHjG6JxzoZc32rsp/Hi1ktFJqkWGDvTi9kaNUU+wDk
	 PcAHrVvbhKH8yCRYMjQGM7OhFFHoh+zppYxMFgB5icPCWQOdmSpNnT6ob1Yx0zy3Yb
	 SSKOIgcduL+IBylk3v3hQPpFzdaysVkkXJpBi8T8kyZ6LIIR8q5LGi9gu6EcvI78mQ
	 tMam2MUSjQg8A==
Date: Tue, 30 Jan 2024 08:02:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Daniel Golle
 <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Message-ID: <20240130080213.0c3b65c1@kernel.org>
In-Reply-To: <8b7e1d9d-70ec-4664-be04-48a2e2877891@arinc9.com>
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
	<20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
	<20240129125241.gu4srgufad6hpwor@skbuf>
	<431750cc-fb6b-4f7a-9123-b6986d359742@arinc9.com>
	<20240129083152.34d899cd@kernel.org>
	<20240129165201.s4oiuk3sxtk6zcsw@skbuf>
	<20240129090034.01c11667@kernel.org>
	<8b7e1d9d-70ec-4664-be04-48a2e2877891@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jan 2024 17:26:29 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> I don't claim to be an email expert. I've received Vladimir's email with
> the "Content-Transfer-Encoding: 8bit" header. The body was plaintext, not
> base64 encoded. I have checked how the netdev mailing list distributed
> Vladimir's email, its body is plaintext as well, not base64 encoded. Only
> the linux-arm-kernel mailing list distributed the body base64 encoded, the
> header is "Content-Transfer-Encoding: base64".
>=20
> And the attachment you've provided seems to be from the raw output of
> lore.kernel.org/all which seems to put together the email distribution fr=
om
> all mailing lists.
>=20
> raw from all:
>=20
> https://lore.kernel.org/all/20240129125241.gu4srgufad6hpwor@skbuf/raw
>=20
> raw from netdev:
>=20
> https://lore.kernel.org/netdev/20240129125241.gu4srgufad6hpwor@skbuf/raw
>=20
> raw from linux-arm-kernel:
>=20
> https://lore.kernel.org/linux-arm-kernel/20240129125241.gu4srgufad6hpwor@=
skbuf/raw
>=20
> I don't know which mailing list mailbot looks at in case of an email is
> sent with multiple mailing lists being CC'd or TO'd. It seems to be that =
it
> looked at linux-arm-kernel in this instance.

It's the Python library that base-encodes it for some reason :o

>>>>> $ tail -20 raw.5=20
> mt7530_setup_port5() from mt753x_phylink_mac_config() won't run.
>=20
> The commit ("net: dsa: mt7530: improve code path for setting up port 5")
> makes so that mt7530_setup_port5() from mt7530_setup() runs only on
> non-phylink cases.
>=20
> Get rid of unnecessarily setting priv->p5_interface under
> mt7530_setup_port5() as port 5 phylink configuration will be done by
> running mt7530_setup_port5() from mt753x_phylink_mac_config() now.
>=20
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I hope this moves the patch set out of the 'deferred' state.

---
pw-bot: under-review


>>>>> $ cat /tmp/p.py
#!/bin/env python3

import email
from email.policy import default
import sys

with open(sys.argv[1], 'rb') as fp:
    raw =3D fp.read()

msg =3D email.message_from_bytes(raw, policy=3Ddefault)
print(msg.get_body())


>>>>> $ /tmp/p.py  raw.5 | tail -20
 <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>

T24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgMDg6MzU6NTdBTSArMDMwMCwgQXLEsW7DpyDDnE5BTCB2
aWEgQjQgUmVsYXkgd3JvdGU6Cj4gRnJvbTogQXLEsW7DpyDDnE5BTCA8YXJpbmMudW5hbEBhcmlu
YzkuY29tPgo+IAo+IFJ1bm5pbmcgbXQ3NTMwX3NldHVwX3BvcnQ1KCkgZnJvbSBtdDc1MzBfc2V0
dXAoKSB1c2VkIHRvIGhhbmRsZSBhbGwgY2FzZXMKPiBvZiBjb25maWd1cmluZyBwb3J0IDUsIGlu
Y2x1ZGluZyBwaHlsaW5rLgo+IAo+IFNldHRpbmcgcHJpdi0+cDVfaW50ZXJmYWNlIHVuZGVyIG10
NzUzMF9zZXR1cF9wb3J0NSgpIG1ha2VzIHN1cmUgdGhhdAo+IG10NzUzMF9zZXR1cF9wb3J0NSgp
IGZyb20gbXQ3NTN4X3BoeWxpbmtfbWFjX2NvbmZpZygpIHdvbid0IHJ1bi4KPiAKPiBUaGUgY29t
bWl0ICgibmV0OiBkc2E6IG10NzUzMDogaW1wcm92ZSBjb2RlIHBhdGggZm9yIHNldHRpbmcgdXAg
cG9ydCA1IikKPiBtYWtlcyBzbyB0aGF0IG10NzUzMF9zZXR1cF9wb3J0NSgpIGZyb20gbXQ3NTMw
X3NldHVwKCkgcnVucyBvbmx5IG9uCj4gbm9uLXBoeWxpbmsgY2FzZXMuCj4gCj4gR2V0IHJpZCBv
ZiB1bm5lY2Vzc2FyaWx5IHNldHRpbmcgcHJpdi0+cDVfaW50ZXJmYWNlIHVuZGVyCj4gbXQ3NTMw
X3NldHVwX3BvcnQ1KCkgYXMgcG9ydCA1IHBoeWxpbmsgY29uZmlndXJhdGlvbiB3aWxsIGJlIGRv
bmUgYnkKPiBydW5uaW5nIG10NzUzMF9zZXR1cF9wb3J0NSgpIGZyb20gbXQ3NTN4X3BoeWxpbmtf
bWFjX2NvbmZpZygpIG5vdy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBcsSxbsOnIMOcTkFMIDxhcmlu
Yy51bmFsQGFyaW5jOS5jb20+Cj4gLS0tCgpSZXZpZXdlZC1ieTogVmxhZGltaXIgT2x0ZWFuIDxv
bHRlYW52QGdtYWlsLmNvbT4KCkkgaG9wZSB0aGlzIG1vdmVzIHRoZSBwYXRjaCBzZXQgb3V0IG9m
IHRoZSAnZGVmZXJyZWQnIHN0YXRlLgoKLS0tCnB3LWJvdDogdW5kZXItcmV2aWV3Cgo=3D


