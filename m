Return-Path: <linux-kernel+bounces-47881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A3845418
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1318228184F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277AE15B10E;
	Thu,  1 Feb 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hRRznMot"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92494D9F6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779950; cv=none; b=RI7UTQ8CPfq+uqQFSHXVPEnNm/hSex2ZcZkBoI++Xaess0mJGQMsE2YyOTV24Sv93Uj9nqLAEvwKiVhjWftc+LcBeEgj798RB2RCeViu3zqebYcKVLkB3DGxDM4s6MHtgNKIlws8Jls4m1QBqL17KWfzqT1F1bjBYDwDbWXjRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779950; c=relaxed/simple;
	bh=mGbEKbRg3HRX1JJEx5Fmweb6LPOvKH+q8e4+jYDWBnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLOUNScjs20xeSUBwfhKa86ZEMpHjgoR/Yl1vzYYWT6rTpbkmWwegfg+Cs9eQ4oNaeBCTJa6dhlUW9NRVCMJgzD6pegXXFkdjQwQnLIDenD2Jap0nJMnpRqgCcCybNOyQicE/y8yg63QWmibI9KSVAfbKgXn/MfH0oSQP/L9JqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hRRznMot; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Cb3/
	O3cYgfvjgEQfrw9YH6eePZxbN6AMDZbUnR3SgPM=; b=hRRznMotmrGIfiAq9V2b
	rhASVA4bmrXckRh4j5NJDBNMAxkYTV+fx4gcKRBO1O5RbUnqU9z29MXuUzmyH5jH
	HTx3P+3ES0eET4cQErzYSysju8djxaFSMZ2k+VN0KEXdnZF0zMy4kiu01cLIuQai
	SAa/TR2bTyzG6LwrcPzb56faGl2cmRnq2TctvhfT/Gu59f5IXTvQZLGVFMY84HW3
	PHkhP5DAAIrNewtdRlwWr93hNGmjHAEa1YFGxWl5O/AVQZ0XXYvl3qVCZJlIgLVb
	MqhJA+5/zSB7ZkbRWAPxdVwcoDmBy06FcmXqnVaHu+9ST4Zv7FW/Jw3+IxpKYrAe
	kw==
Received: (qmail 3478403 invoked from network); 1 Feb 2024 10:32:24 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Feb 2024 10:32:24 +0100
X-UD-Smtp-Session: l3s3148p1@+plErE4QJtVehhtJ
Date: Thu, 1 Feb 2024 10:32:23 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: document a problemw with
 old firmware
Message-ID: <ZbtlJ-7UCPxgUXeS@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240130095222.11177-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUB_9TNzo+GFbDZO-gjBUGfk7O7aEyJYG5pCw-Z1nK-pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m5ayo9h/R03Rj0Ow"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUB_9TNzo+GFbDZO-gjBUGfk7O7aEyJYG5pCw-Z1nK-pw@mail.gmail.com>


--m5ayo9h/R03Rj0Ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

> I'd rather not add such comments (especially +6y after the fact), as
> this is the standard operating procedure in case something doesn't work.

Okay, can be argued.

> /* If secondary CPUs don't work, please update your firmware */
> /* If cpuidle crashes, please update your firmware */
> /* If watchdog restart doesn't work, please update your firmware */
> /* If PSCI reboot doesn't work, please update your firmware */

Actually, I wouldn't mind. It documents that we *know* updating firmware
helps in this particular case. But as said, I can see your point as
well. Let's drop this patch.

Happy hacking,

   Wolfram


--m5ayo9h/R03Rj0Ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmW7ZSQACgkQFA3kzBSg
KbawvxAAkU+UH6er8246WWvbhlx5F2otGXdN41eOjvKL8rr7GCEZE5zaIubaW8gK
QRweI+MMksGvVeI0dHmo/wx8g6nRrMLGn9qY8aUSLspD++3nZqUwn5Y3tx930/uW
XsmJrn1qO02Jda9mCIyZudeabQlOlt+qyVdjKAdVEIEbBdgkIcVg0hOGvVMesYrH
qRi/3ZWnm7ywc3J1E03a0kgylnYMmm3WpljPKGKnRNHHlkxKUBY8G21gCkvy4VnZ
aXAfyZrLCj9YVtODgjx6JWZz34pbut+p0LclgjTy6hj9tC+xdooKzpeTEhKwUFtQ
//fLFan8w4uz/LM70VElp5k62nYYbXHV0w3jfCivPAYucrTk16c+vzcW/hW9DGKV
9yXGZN8yWKqV3PwymFpm1iE9SrQJQZQe7joAgnsZ63tSo0eUTdxGgmx/BdbLI41y
UwnXIi7tDlk1YAjsYF1wU644tWdlaxQENLTPh++twauNM7SjuaB+dRySa5et8C2i
1ifogpTEpyCnmP5azFXUdpxEhPtTgDiEAFNn04gOZ9uB/ANQNamX41mdzywj5J6c
kg5tPiP+nx4lAZMgz1QxlLHM/ZCmJ49Zcd/9v4Oc7omec+GGVzEsHc8Ympdh8j5J
3U+WdlatFEfCyG8WasVizOYFC49ZczjEMtlX+0a7gym8ruBKbxA=
=Ccfm
-----END PGP SIGNATURE-----

--m5ayo9h/R03Rj0Ow--

