Return-Path: <linux-kernel+bounces-107580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F092987FE85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0D92852C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C468E80036;
	Tue, 19 Mar 2024 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ebQjNwzQ"
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D973FBB9;
	Tue, 19 Mar 2024 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710854376; cv=none; b=E4ZyEl7pDrgfQp/JcQUFJBVejjc9mV5M0NEVUrgJpJ1sB7kvhGb5m5UBb5PdimUwyBO1r3hEzjLpm4KblkAfc7Vl87yJs7un9I3Y4MyVfinoqP/axud3eLj6N/YNDfxGyfCtxcYeGFNBCJaaOomV+uH3WkiNPIIMIYwq2SJdapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710854376; c=relaxed/simple;
	bh=y5PFZZrOqJ9NtxbU4B1OWP5hKkoz13ncb5FkS6JbXw0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cj6PxbU/7GN6KPgw5PCM4XkQ1/Eu0LiB5bDqX9XLceMxxyJDmg6iIWv0R6Y45WHzM+YgqvkPBvBvTiQLDr0qihcPyLJlTYIWlMyAaTYvrNI0KLXqpumYge9Sqj6XHS1avTrqhh95eUzJLQz/A35SE04vp4NU8TiZyizxEuVD4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ebQjNwzQ; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1710854364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlMWgzCdIDDA3TfwtyMcSQvofdYr4JxDgv8/lzTuVSY=;
	b=ebQjNwzQiC9YAQIOw5K3DJugtjjHnKCsOBqUZQHO8KmDFC6CaDWqsrzvDnWawN8KYIvZZJ
	XbyOlyAJJtqqZAaLqXXGmzYogRHlo7EELioeF50I9zQKOShoFQZ+uFkka5OuOdcK4CNuFI
	aDWZ+pU6Iwl84el0Fv8w7jzskZmX3xM=
From: Sven Eckelmann <sven@narfation.org>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, christian@brauner.io,
 daniel@iogearbox.net, dvyukov@google.com, edumazet@google.com,
 elver@google.com, glider@google.com, hdanton@sina.com, jakub@cloudflare.com,
 jannh@google.com, john.fastabend@gmail.com, kasan-dev@googlegroups.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mareklindner@neomailbox.ch, mark.rutland@arm.com, netdev@vger.kernel.org,
 pabeni@redhat.com, shakeelb@google.com, syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
Date: Tue, 19 Mar 2024 14:19:20 +0100
Message-ID: <2615678.iZASKD2KPV@ripper>
In-Reply-To: <000000000000901b1c0614010091@google.com>
References: <000000000000901b1c0614010091@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2316114.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2316114.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Mar 2024 14:19:20 +0100
Message-ID: <2615678.iZASKD2KPV@ripper>
In-Reply-To: <000000000000901b1c0614010091@google.com>
References: <000000000000901b1c0614010091@google.com>
MIME-Version: 1.0

On Tuesday, 19 March 2024 11:33:17 CET syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    35c3e2791756 Revert "net: Re-use and set mono_delivery_tim..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=10569181180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> dashboard link: https://syzkaller.appspot.com/bug?extid=8983d6d4f7df556be565
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d9fa4e180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137afac9180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/26b55a26fc12/disk-35c3e279.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6f39fa55c828/vmlinux-35c3e279.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e1e0501539e6/bzImage-35c3e279.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com

Sorry, this is a little bit off-topic. But how does sysbot figure out the 
subsystems (like "[batman?]"). Because neither the reproducer nor the 
backtrace nor the console output mention anything batman-adv related.

Kind regards,
	Sven
--nextPart2316114.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmX5kNgACgkQXYcKB8Em
e0aRihAA0kDB39knEezz051yKh214KQyzCHU9DDVkDQEJKEhl9AMpB/1R4O5poka
SiwAwoSoP5A5kkczS9gtZGmEcCTSCjPx+Zj5aGgGylhgnHsLoA67qxQhiXDu5EWx
QSXqPtTmfNboRsZ8433zCQcUjN4tHc+r/mxFRkaBcRMWQh5tVXpeYjAB5rkOshVP
/Gnp/V9b3rVqu7STsr2npZT3F0SDk6yj2Oi810d0pnNzR2y49DmabnqzWtPe7sX4
d0/zPlX80F7FYrxjbi7LmjNYUoRrudHTXrb8FZaptsa+mIwVQ01UnK7sm/wWW6xF
BVuEC4j3OyaL9HEHgp9o7lxMNMx7KqYwimrewgPqeMWNHOkYX9swwRGzHUkU5wuC
TbbtgbAJaTtBroNZ4AqxwWO8LviRFhwwABtA6zb1VD/WOu8chQ7dgxAEJs3QdEUK
zVXOaOZefHULjIoJzRoPqwcnE67cvYwlmfHZnEVEp9YPXvdcrjswghJ+TeNoBt3s
+rrgbAsvbTxl/N5EF6Ke4OoVg4qDIY2djOubxk+l5r/Od0thLbHWaFq5vYg2G5Zq
VCX52iuKimsHb9Uso3kCzkGjcE2a/UcZu+9pgD4njh1CS+5l7bO89eknX8+yY1Kw
mOLKMD6oyYfDVWWIj7HNhlQxFZdR+mZoiG1FItjoJ7Pof8CRuZk=
=B2hL
-----END PGP SIGNATURE-----

--nextPart2316114.PYKUYFuaPT--




