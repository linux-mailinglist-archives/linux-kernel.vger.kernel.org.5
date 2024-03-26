Return-Path: <linux-kernel+bounces-119005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0E88C27F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07D0304B51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BD56CDA8;
	Tue, 26 Mar 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="x2NCnf0T"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4914A8E;
	Tue, 26 Mar 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457156; cv=none; b=Zgz84EnC3aljxKmngRqWfVBBanzo6lhvgBlNe5BDyAc6rBCHg3vIM8Psl8xQTMFFnTSmbVbmR6j7oC2d3acsy1dGK9Gw8Ak8OYss+4l9pCuSmqqtFGZ3/dY54HR9aL7ABqMHcaZO5WZdVSZdHtXLCUKrjcMymv4VRxvPrNMeSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457156; c=relaxed/simple;
	bh=kAjbfsWCA0P/0WTi+Ef+KQC9azoUS+EIibi6oFpBxqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dceU/MRwm/JQvUT8KNiOyhu6nKml9ah7kYNOe5B2nqxIY74kCzlyCZo7YdgyyD18bR/ZGh9o6Sf26ZMLh+OIBw/U1qbFvzsptdjYFr5lA/M2VMySEwbkPTW0+xRmtlhm6e/qPnzhTst3C1rpmAJ1DFGvrOGO57L83SCHSRGkGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=x2NCnf0T; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711457152;
	bh=kAjbfsWCA0P/0WTi+Ef+KQC9azoUS+EIibi6oFpBxqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x2NCnf0TZ+FrTHmf0E7bqYIfH72qz8S3RCLeAVJlk6sbNGsYTba+wb04bwTx9TxoM
	 El0oxmG+wAK04cWtqxLzsWWQpYftCoQ7I2ReWeeLCYFEWGWb153H6waD7/Cdz9FL26
	 4SeNZK4n491Zxgx1YWv+7rAFU26EtyZpE6RjZ/9ZOVj4dbzI4Hs7CaDAt8edZyJ6f7
	 3MHlCirXc3QsAFurX/GOicluCrUcRljYdl/9bLDTis7PrtcsmteMQ1CEX0ReZJwFMN
	 C3vby2xIroUQv4N0zu/ZdNBKTyxracEJT6ywr2wEoI5rNhLuaEt8eV1bpnc7GfjGD7
	 hcrkR6hN7gV4g==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82AAF378209A;
	Tue, 26 Mar 2024 12:45:52 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 198051060700; Tue, 26 Mar 2024 13:45:52 +0100 (CET)
Date: Tue, 26 Mar 2024 13:45:52 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: hsi: hsi-client: convert to YAML
Message-ID: <hz4fbdix5yaz2wtdkjkf23pc3m4kbeavynvjagundqvv3bisor@lc7dev4667i5>
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
 <20240325-hsi-dt-binding-v1-1-88e8e97c3aae@collabora.com>
 <2905247d-03b0-45c1-add5-d3c2a986d87c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mpopjza7py23aeu"
Content-Disposition: inline
In-Reply-To: <2905247d-03b0-45c1-add5-d3c2a986d87c@linaro.org>


--5mpopjza7py23aeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 26, 2024 at 08:18:39AM +0100, Krzysztof Kozlowski wrote:
> On 25/03/2024 22:45, Sebastian Reichel wrote:
> > Convert the legacy txt binding to modern YAML and rename from
> > client-devices to hsi-client. No semantic change.
>=20
> There is semantic change: missing example (which is reasonable for
> shared schema)

Right, I should have mentioned that.

> but more importantly: some properties are now excluding each
> other.

I think that requirement was already there.

> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
>=20
> ...
>=20
> > diff --git a/Documentation/devicetree/bindings/hsi/hsi-client.yaml b/Do=
cumentation/devicetree/bindings/hsi/hsi-client.yaml
> > new file mode 100644
> > index 000000000000..df6e1fdd2702
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hsi/hsi-client.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hsi/hsi-client.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HSI bus peripheral
> > +
> > +description:
> > +  Each HSI port is supposed to have one child node, which
> > +  symbols the remote device connected to the HSI port.
> > +
> > +maintainers:
> > +  - Sebastian Reichel <sre@kernel.org>
> > +
> > +properties:
> > +  $nodename:
> > +    const: hsi-client
>=20
> Why? Does anything depend on this? It breaks generic-node-name rule. It
> seems you need it only to match the schema, but this just point to main
> problem - missing bus schema.

Ah, that's a good point. It makes a lot more sense to get the
nodename from the actual client. I will work this over.

> > +
> > +  hsi-channel-ids:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 8
> > +
> > +  hsi-channel-names:
> > +    minItems: 1
> > +    maxItems: 8
> > +
> > +  hsi-rx-mode:
> > +    enum: [stream, frame]
> > +    description: Receiver Bit transmission mode
> > +
> > +  hsi-tx-mode:
> > +    enum: [stream, frame]
> > +    description: Transmitter Bit transmission mode
> > +
> > +  hsi-mode:
> > +    enum: [stream, frame]
> > +    description:
> > +      May be used instead hsi-rx-mode and hsi-tx-mode if the
> > +      transmission mode is the same for receiver and transmitter.
> > +
> > +  hsi-speed-kbps:
> > +    description: Max bit transmission speed in kbit/s
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  hsi-flow:
> > +    enum: [synchronized, pipeline]
> > +    description: RX flow type
> > +
> > +  hsi-arb-mode:
> > +    enum: [round-robin, priority]
> > +    description: Arbitration mode for TX frame
> > +
> > +additionalProperties: true
> > +
> > +required:
> > +  - compatible
> > +  - hsi-channel-ids
> > +  - hsi-speed-kbps
> > +  - hsi-flow
> > +  - hsi-arb-mode
> > +
> > +anyOf:
> > +  - required:
> > +      - hsi-mode
> > +  - required:
> > +      - hsi-rx-mode
> > +      - hsi-tx-mode
> > +
> > +allOf:
> > +  - if:
> > +      required:
> > +        - hsi-mode
> > +    then:
> > +      properties:
> > +        hsi-rx-mode: false
> > +        hsi-tx-mode: false
>=20
> I don't understand what you are trying to achieve here and with anyOf.
> It looks like just oneOf. OTOH, old binding did not exclude these
> properties.

So the anyOf ensures, that either hsi-mode or hsi-rx-mode +
hsi-tx-mode are specified. Those properties were previously
listed as required and they are indeed mandatory by the Linux
kernel implementation.

The old binding also has this:

hsi-mode:		May be used ***instead*** hsi-rx-mode and hsi-tx-mode

So it's either hsi-rx-mode + hsi-tx-mode OR hsi-mode, but not
all properties at the same time. That's what the allOf ensures:
if hsi-mode is specified, then hsi-rx-mode and hsi-tx-mode may
not be specified.

> > +  - if:
> > +      required:
> > +        - hsi-rx-mode
> > +    then:
> > +      properties:
> > +        hsi-mode: false
> >=20

Thanks for the review,

-- Sebastian

--5mpopjza7py23aeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYCw3QACgkQ2O7X88g7
+pr+7hAAm3CgYA0d2i7m5mUghwJdQR87bj9cVe1Dz9KXAp3l8Y3QeDjOSVQokyYF
p24x7hbHrUUxoaImYiWCR21YmfrToZuAzL6e1M+uLOh0hYamWwTMSbpqzI8xROkx
eNBLqE5kuqg7zH65RA6GxHZau8JWH3+S7qliQ+DIInXjauS60KBYiKeX96CywxFA
NpRDb0BUzuLF6vbU4HKnm2etTNLmGuXuZgoDMb9hh6Aw+J1dgYgQ47QZeKgovdWQ
i9/Enkg8bDkoZx7wrTBl6dNzPXW/EvJw46Pq7e7JPrglVa7BYRwobKh0jnhZ5U2N
2H/cFiU4vh3e3rXPQPcpWrSiH/qSpzoZEf+lYpJpgyvpQAYkyZLmcL9k0vrl4HOa
a4QTQEHUgJUGmtLaQ4HWIyrRdop13i+1KO6tEARWO4gKecvMwFYCGvhWm4aLsfOe
3YJA5fu461yrWDuDvkk2xoqKzW+jIpMkdLKbRd1LGk4lyI3UeEVV6aqFBTFrOsnR
4UZOgl22tuumLm42hEWwmCUnSzhkfHvCzdTaZJVV4hoGEdYUNnQb0Y1J+V0ulDaQ
k42by0nXOaAG1RH0gfjV1jNHophd+jMXI/Ku6ZnnS1JW/XaL8YmC0fIhkW0d9L4z
LxhFboD8M6XTlecvYVbHQ+YnqKsKw5WxBLHhgN3e2nHs656zXIw=
=9Gsy
-----END PGP SIGNATURE-----

--5mpopjza7py23aeu--

