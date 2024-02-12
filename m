Return-Path: <linux-kernel+bounces-61435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596EB85124E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9355B23F66
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42ED39FE2;
	Mon, 12 Feb 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ehnTOX7x"
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B939FD3;
	Mon, 12 Feb 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737527; cv=none; b=plIccjlN5GiGqO+H3DGU7Mab3h2wqIs8lCRT64M+c7EAJ0rfVOuHBqFE8dIt02dtSUG6jISSiHgkFU+Fv+ulEZ3I6YTGSI86im/iV5y3lvW/AzTYSlgmmhb0pBLeHWIp2tmy63+kHHefvkWxGsVHWBHmSNL14dRE/rl4Wak5CpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737527; c=relaxed/simple;
	bh=JARpw4xEB9nEe17RqvsCk6HBS6XHVwck7TOuKJZAreY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQlOswiPflRA8qugnREQttYiFknlLY/0cARLcJuv2xLNtH7wxTo0Nh1mA2BFM87KlNC3czhRgKxEWKz4JLFaCKVYr04S4RjOnDmM9NgduW0+YC421RYwqy7iFVDAdqXR7p3fzLhmVaeCTYf0sF5qgj++sU0RaLA3xyDR7/OPh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ehnTOX7x; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1707737034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdW3ANPsOumnUTm35YIcSXXwWb81rhjV/4NqYwmk2Pw=;
	b=ehnTOX7xVqtW5lTFDHFyLRRbQ0lNc35QSCDG8pDLUj2YvuFR1E/SQbn56rHpD4o7qAQz4i
	qQLzA+okoJLz/xU88ulBpdVRl038dVl4X7/GdX2+71m9DWj3weIZW1UdAZOJLZKrTihze9
	+obYQ5F+CyocSijNqt9gjiWNU+YscMI=
From: Sven Eckelmann <sven@narfation.org>
To: syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
 kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
 netdev@vger.kernel.org, pabeni@redhat.com, sw@simonwunderlich.de,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
Date: Mon, 12 Feb 2024 12:23:51 +0100
Message-ID: <2173575.irdbgypaU6@ripper>
In-Reply-To:
 <CANn89iKPYAY226+kV9D0jUn6Kfjq1gQJBAjSRxxFgQJK-QbLwA@mail.gmail.com>
References:
 <000000000000ae28ce06112cb52e@google.com>
 <CANn89iKPYAY226+kV9D0jUn6Kfjq1gQJBAjSRxxFgQJK-QbLwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13450391.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart13450391.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
Date: Mon, 12 Feb 2024 12:23:51 +0100
Message-ID: <2173575.irdbgypaU6@ripper>
MIME-Version: 1.0

On Monday, 12 February 2024 11:41:38 CET Eric Dumazet wrote:
> This patch [1] looks suspicious

Shouldn't be caused by this - but this might be another way to trigger the 
problem. The problem would be visible even without it when a mtu is explicitly 
set. But the reproducer is not available so I can't actually check what is 
going on.

> I think batman-adv should reject too small MTU values.

You are refering to the size calculated by 
batadv_tt_local_table_transmit_size(), right? And yes, I would agree that it 
looks suspicious and might not have been correctly integrated in 
batadv_max_header_len() when commit a19d3d85e1b8 ("batman-adv: limit local 
translation table max size") introduced the code. But I think we also need to 
remove interfaces again when receiving NETDEV_CHANGEMTU and an interface is 
not having the correctly sized anymore. So have to check how to do this the 
best way.

Kind regards,
	Sven
--nextPart13450391.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmXJ/8cACgkQXYcKB8Em
e0ZZFw/+N3em2ptTXcnr3+ApNV8/D8QriRS0O6mBuF8Hijfj6xnYM1hPFaRImy21
WtJjnb2ti7uavNtiBKGR71EUpLW8nNsdI/tB/Pc3ndzy/AOMN9/+JqQE6ekD9K0I
n7rKn5MqBoYjIPMB06lm26Cgx5WyDr3Lkuu3S2OCP3mZZ9+g/p3T0ALJR1c1dkSd
iTM9Yl5zapFzbtebJEa3ywLfeWVApBh0sTpWgfkevsS1OnkRnep59h/KnOa4oBt/
V/BuknZ+m8McCLySH8DuuY0XBvah+mWHMGoGY3qpoeqCo447axPSweIAAXs143t3
ujigchJGL1eaKtOvc/ZeOr2jSwPqmiqIeMN+g7S/mHe7GIW+l6fzH0ZfYm+EADCa
8yJmtZhhwRtSB5j0QsDDEquWlykluoN+jkB2ysTkb3ATY1S+K1ICVZpVMtZ6jCZr
PK68KmxnUFaGXdwKAMpDtDi50roDis7kafjRuIT+rSiTsTkR/uEJ7G4AZs7ca0xz
PfGS7dnXprXm+y/2pQuVXNUzcsuaZxCXzHtjEuzaCEec4qMq4a9QYRrHCLH5xQHE
LxkEvQ2TElGKTzFiOi2daRAreLUv5iQ6U9Y9taiL8AMsKaIjmDUdOmBAUFPhFHDX
ixcgudSFeAbYp0bGwjpqdvXkftitKiGESCAvgEDl+MIhIIK/4jI=
=4r6M
-----END PGP SIGNATURE-----

--nextPart13450391.uLZWGnKmhe--




