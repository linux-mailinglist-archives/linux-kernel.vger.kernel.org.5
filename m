Return-Path: <linux-kernel+bounces-104563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09C87CFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAA22835B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05873D54D;
	Fri, 15 Mar 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6UQVzJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9CA3BB52;
	Fri, 15 Mar 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515762; cv=none; b=d2wUuUQFC1S+dfcUYm6l+GBUAZu48vEXc306cWCCFblzk1xr5261YwMPtoXuKhabXgjWE7RawCH5SJSx7xGNRlWp6H6S+pzL7XqzGRdBDUC/UieIYv9M8xkNOBhwwM04H1mE9aCrwSZPVMLO2FiWXyZNVr54JBb3SqjesbHfAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515762; c=relaxed/simple;
	bh=JetYKg36RGIdkXrH8sSoGmguKkbdT3c+edAG3vVoLks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP03OoGsfNTos+fpoLxNwmigWUjU0NFnkgEIJHGJ38kRbcjGcEbvytLGEvo/2ZCvVPRLVU8N65q7YnzCNxkTHRrs6JulUiE5oUqo9wbIrIgoZ9srUK6onQ9av2sWDdxYvjls1Sr+W0rDeJi4do83O8K4tYXfl2WrEpqccEoc1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6UQVzJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C680C433F1;
	Fri, 15 Mar 2024 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515761;
	bh=JetYKg36RGIdkXrH8sSoGmguKkbdT3c+edAG3vVoLks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6UQVzJDHdLFI/FI8NYnDUEw4xnU4jAVfiYnJa7PImFmHArIldd+gIV3Sv2UQwCGZ
	 9Ax3SpbT9vkcMC7t4p3Zfj1jIn4bGhzHu4dq2KCraI7LAE/NU3z54DZji/qrZXXo61
	 sptSTer//vPtvWSriM+ymuqmO77T0AvZg1YzEQw/BPikvjeE+M1R/KsxX/MLlKhBzY
	 jbHmdHzfeyUuZoWykiI8NkuSojEMzfOk4bj14VxQxqGF5lq2Wd6y+agWxXx+vx29oh
	 BWLxPgFUv8c8QrU2p+BHTR1HgmqxOZM93ujA2zaLrLXUvLusk84biWueGVvifRqFhn
	 SwYBfpHlb7iKw==
Date: Fri, 15 Mar 2024 15:15:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH 12/18] ASoC: codecs: mt6357: add MT6357 codec
Message-ID: <0a41b498-5cca-4487-a0e0-0df749f6e796@sirena.org.uk>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-12-4fa1cea1667f@baylibre.com>
 <9891855d-2284-42e4-9d3a-35ba406540e8@sirena.org.uk>
 <c441a132-b16b-4244-a712-8971c902d4d7@baylibre.com>
 <ff3d2db1-697b-42c6-a0f2-74276e9fc098@sirena.org.uk>
 <dda0e6ba-4538-47a0-95e9-6adcfd4169a7@baylibre.com>
 <0d31ffb2-9df5-4c3e-a728-902b71a1a713@sirena.org.uk>
 <fd53a0e7-fa70-4c0d-b578-393183487335@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgDyTJrdbX73HLO7"
Content-Disposition: inline
In-Reply-To: <fd53a0e7-fa70-4c0d-b578-393183487335@baylibre.com>
X-Cookie: A well-known friend is a treasure.


--fgDyTJrdbX73HLO7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 04:05:21PM +0100, Alexandre Mergnat wrote:
> On 15/03/2024 15:30, Mark Brown wrote:

> > > Let me know, when you change de gain to do a ramp down (start from user gain
> > > to gain=-40db), next time for the ramp up, how/where do you find the user
> > > gain ?

> > In the register.  You only need to reset the gain to -40dB at the start
> > of the ramp.

> Sorry but I don't understand your logic, I'm not able to implement it...
> If I'm at -10dB and doing a ramp to reach -40dB, next time I will read the
> register the value will be -40dB.

After we've done the ramp and turned the amplifier off we can just
restore the desired value?  The hardware is not going to care what the
volume is while it's not enabled.

> This implementation is also done in other MTK audio codec drivers.

Perhaps they should be updated too?

> > > When microphone isn't capturing, the gain read back from the register is
> > > 0dB. I've put some logs in my code and do capture to show how it works:

> > Is this a property of the hardware or a property of your driver?

> At the end of the capture, the gain is set to 0dB by the driver.
> At the start of the capture, the gain is set to the setup gain.

So that's a property of the driver then?

> AFAII from the comment in the code, it's done to avoid the "pop noises".

Yes, that's the usual reason to ramp gains.  Though if you've just
copied the code without checking that it's needed it's possible that
this is something that's been fixed in current hardware.

--fgDyTJrdbX73HLO7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0ZikACgkQJNaLcl1U
h9ANMQf7BdfrOiW1Xoo2hUjwcif1X0ikLf9S3dwVoevqKNXQHOBvrNlZo0hx8Lpc
cb7BxhcMn0yDAdJKRd5N4p/THoafHtJ/+pYuLVB1xyz9W0OB/x+RZEMBDUv+AOIG
gN4Pb9xiFL55ELmhLXdQcmyccdi3RjnnGK07tD3gwqiHgilNQazB2sqKf+bUrs0f
P5pJpmnh6QWxyMnyI9Mby7N/c4LDtVKMyBeptA631XeUyiPnlhN2Y8E4aZo0u5+p
qg/zSbEy39TWoCI69lQkJX7MYeoTDzuKCmaGdolnVUjOsm0ZWpxt5iuxdyq4Yhl/
65is6JhRr0irTBQKv824acHouSjrkw==
=GmOx
-----END PGP SIGNATURE-----

--fgDyTJrdbX73HLO7--

