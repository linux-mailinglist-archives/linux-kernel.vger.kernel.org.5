Return-Path: <linux-kernel+bounces-163737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682B58B6F00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB851C22E20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E317F129A77;
	Tue, 30 Apr 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KNvbA8vd"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3E3A8CB;
	Tue, 30 Apr 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471329; cv=none; b=bB3+f2UdjeA31lNQsmrba9ZDl6kpWNKTlaMNet6HFA0qX2h+OqJhn/0IUaGYVvvQawPA0WHwn3B50rL9tdzOvvEWWoXmEg5nBtzB9ENEcev4a0pWQsGeVI3c0V9m9RvQ35WNbdTOfbGRJzGiBXrmck/KQYWa27Jv6seFOQ2VDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471329; c=relaxed/simple;
	bh=RsGWFUaXZsIM9XF86rOQ2hjMpDFzHHbu7QElEsefk1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZtA74B3fcOJTn4OrqZg/hT8B0QUmytBm85YAZRG7iREL500yHPExeNPPcv7FrezqFNFH8+6enVb7aMTmLzDBGKik8sbwOUmr1Zxka4baWtUStpWNjsCLOWGiCWnU2ShD6b+cMMNuTHc3toQhUyA//uYftJUc6+fsMmMxEUt0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KNvbA8vd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nOTmeD3yZAzeGoMmikPvoxrLw1CeqyXxgI5qLq+cYSw=;
	t=1714471324; x=1715680924; b=KNvbA8vdM7Ulcwq3mZlLHwIta3+5ReBfw2Z0mU4stAswSEQ
	urB4mH+emqF6umRP/oao+hdZz2qCcB29q9zfGzGG8caw+M3tKvAl/rAoXul6O82s+Cs+XoCZFoi+m
	n5fuhWadIG2fUctooNUx0vsfyYWDOEOVBdilAOS4Cme1WCZQJ6NyInZQOySkeuyWb0HXw2rOUS93E
	yZnyUrsCUSPO9lXeotvYVqtdh3K5tsXyWUY+TkvkAZg5EdLhXbDkhYHiwxpIXdhaHmt+oixvpianQ
	CdURoEGGopZU/QOT1c4amPQ9aQQvcfGkSYsl/LHbLt8GI1TwfwslRiYSrbUfJRTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s1kJ0-0000000E5yC-0RB5;
	Tue, 30 Apr 2024 12:01:46 +0200
Message-ID: <e2f20484fb1f4607d099d2184c1d74c6a39febc1.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: Avoid address calculations via out of
 bounds array indexing
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
  linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Tue, 30 Apr 2024 12:01:44 +0200
In-Reply-To: <20240424220057.work.819-kees@kernel.org>
References: <20240424220057.work.819-kees@kernel.org>
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

On Wed, 2024-04-24 at 15:01 -0700, Kees Cook wrote:
> Before request->channels[] can be used, request->n_channels must be set.
> Additionally, address calculations for memory after the "channels" array
> need to be calculated from the allocation base ("request") rather than
> via the first "out of bounds" index of "channels", otherwise run-time
> bounds checking will throw a warning.
>=20
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_reque=
st with __counted_by")

While I was weighing whether or not to apply this for 6.9 still ...

> +	request->n_channels =3D n_channels;
> =20
>  	if (n_ssids)
> -		request->ssids =3D (void *)&request->channels[n_channels];
> +		request->ssids =3D (void *)request + ssids_offset;

This really doesn't even seem right, shouldn't do pointer arithmetic on
void pointers. Same applies below too.

And also if you set n_channels before, perhaps it's actually OK to get a
pointer to *after*? Not sure though.

johannes

