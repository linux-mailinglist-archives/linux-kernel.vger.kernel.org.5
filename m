Return-Path: <linux-kernel+bounces-154756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DB8AE095
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C34B258D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075E858100;
	Tue, 23 Apr 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iflF0VWL"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80C1C2BD;
	Tue, 23 Apr 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863200; cv=none; b=VJr4LcWOOOwlqo8Bxs9QYLLMw8nNUcc1+UEJN1Tgef7yQXHHnZZV+V0SwqnI4syxgYKVoFM+MeHDWo1LXy4EzoC7KyFICk0EyQ9utSRzfND9UTi1eVZgzwm4dGf4MhHQeYivHylR8jVwz9xyrGc0fLuBOlfZAf+WNaBR4ZDt9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863200; c=relaxed/simple;
	bh=hBMX3crxCRLA2bQd9l2D7waR99WWWl46lNZUjk53ts0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oryk4LW914T3akavsnoG/il/IRnbHO1UMGQK7rZ5FwbkMsse/Yh6IOz4mHFHOnP3Io7t78/zyw+yxPnjjs+VC2OMxZT97FEUiee9MtKv5g7Fi5nDmxjbKE54FREBTo1w/KZlQHH0esFbRGajDkMtvAsSwgYJALahpHHjdK3cpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iflF0VWL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hBMX3crxCRLA2bQd9l2D7waR99WWWl46lNZUjk53ts0=;
	t=1713863197; x=1715072797; b=iflF0VWLqfuD3fFaVwfDhsg8z6c7P/9mudHKdMY5qoCDiPk
	gaNPGc/9BzQzAupMqpPP2Ld2YGcjxL9j23HABx8mgWmxOXhZcRpFv0tfrk0g2KeERZ5+9Ci0r7B9K
	6QYt0y3IkHhFxcUa6CbMnbCUnyn5OWnFj827+aO2XK6J6dlQq0x5RINGxhO6YUG6RY3auo5zvRmDa
	NshXI2Tuc5ypdvZBohpFBLIieOq+9CcaVMyaxPvt91q+8RCl6NFJES7cR/YZG9QiaJDnio4vQPE7e
	xSbN7LgmBRJWJnx9ubLzLj4Kgz9UXxjqL2/rGl+UhP6WaiqadI9VwcPzA6gXnssw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzC6d-0000000214s-2LmM;
	Tue, 23 Apr 2024 11:06:27 +0200
Message-ID: <8ab88be5de30bcbd0d1cac3cfde6b2085dcfc8fb.camel@sipsolutions.net>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Miri
	Korenblit <miriam.rachel.korenblit@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, Ben
 Greear <greearb@candelatech.com>, Lee Jones <lee@kernel.org>
Date: Tue, 23 Apr 2024 11:06:26 +0200
In-Reply-To: <bc420f3a-5809-4c4a-80ad-ccd8a46853b6@leemhuis.info>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
	 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
	 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
	 <20240411070718.GD6194@google.com>
	 <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
	 <8736ebc8881e1e0cabfbbf033725a3123a5e8e90.camel@sipsolutions.net>
	 <bc420f3a-5809-4c4a-80ad-ccd8a46853b6@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-04-23 at 11:00 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
> On 16.04.24 08:17, Johannes Berg wrote:
> > On Mon, 2024-04-15 at 13:37 -0700, Ben Greear wrote:
> > >=20
> > > Johannes, you had another suggestion: changing iwlwifi's request_modu=
le() to request_module_nowait() in
> > > iwl_req_fw_callback()
> > >=20
> > > Is that still best thing to try in your opinion?
> >=20
> > I guess so, I don't have any better ideas so far anyway ...
>=20
> [adding the iwlwifi maintainer; thread starts here:
> https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candela=
tech.com/
>=20
> ]
>=20
> Johannes, Miri, what's the status wrt to this regression? From here
> things look somewhat stalled -- but maybe there was progress and I just
> missed it.

What do you want? It got bisected to an LED merge, but you ping _us_?
Way to go ...

johannes

