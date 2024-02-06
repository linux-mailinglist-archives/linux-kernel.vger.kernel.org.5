Return-Path: <linux-kernel+bounces-55737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D74F84C0FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E129E1F23EDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B81CD1F;
	Tue,  6 Feb 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dJveVRbb"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C761C691;
	Tue,  6 Feb 2024 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262807; cv=none; b=p3d/lDqiutR+ByWBY1En/CHm9d+TxyrO3CsLQdAcJmB5BwoBqt3+zyd8nbNDpZt0slUyLl0Zk6EqdsXQIOyjQTOQGr3GDhIX/XxrQnL/zdbGzEe9yYsiNEH1x1gWOW5SkglKy48wC8Sm1yx0IXTun95a/UEIRcVzPjVIZstdvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262807; c=relaxed/simple;
	bh=kC4HEKcherQTH9APDWQEGrUJPkCM85Qz70jzRLglUIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lf2TA64+s4JqXXLw/c8Q5PjxAZ6F+CGwjPRAiwZqqT6BBQOaLUEPGoUvCrGk/q1MbQbI5a+NlCJI1EsbTrPpPXPQvY8Ah1GtRbncXqWJ1QG0qO5weeG56YBQdw15XJ9GJrMP6WEpXdRnDMqjFGAg1iH1K4RaNIq+9UpOZ+3Wp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dJveVRbb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707262801;
	bh=xb7CcD9AjvI8TrkcjBFIrC+paFho9/OcaytUo9CJn+4=;
	h=Date:From:To:Cc:Subject:From;
	b=dJveVRbbIA4+/4zV2Uq65d4e4cPnb2LPSXzAymKcd9qFOsO3di/gViG9riVcv4iLf
	 DSKtK2i42m5RGtvmHQK31ARwW+cWzG/rcCPrDSna11vGzy2oRC+frY1Mc+hBRMDTZv
	 pghCugFQbF2R2yFbxoLnr7f1c80fAZiYrMX1Ho/LpLN1VFDQgqYYmvnqyt3iBM2wBe
	 4fBjB7Rn90jRyfbYjsIfa+vbZQXjgX80Rztlc8NSjiT23wSuLNGOutLi+fG4eQxyUi
	 alo9jdvcnRBrcLIbdgc75sqVP7LPsn1w1qQWIZa2bq79JVlS6h0pxFskMC4eI2iPhq
	 l7op0sYRh1L5Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TV08x4SSwz4wcB;
	Wed,  7 Feb 2024 10:40:01 +1100 (AEDT)
Date: Wed, 7 Feb 2024 10:40:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20240207104000.40367799@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yP6/0_5_zjAgwZFMEA/.5GW";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/yP6/0_5_zjAgwZFMEA/.5GW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (native perf)
failed like this:

arch/powerpc/util/kvm-stat.c: In function 'is_tracepoint_available':
arch/powerpc/util/kvm-stat.c:117:16: error: 'struct parse_events_error' has=
 no member named 'str'
  117 |         if (err.str)
      |                ^

Caused by commit

  fd7b8e8fb20f ("perf parse-events: Print all errors")

I have used the perf tree from next-20240206 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/yP6/0_5_zjAgwZFMEA/.5GW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXCw1AACgkQAVBC80lX
0GwV2gf/YNnxmeS1myqb5LqhOP9D2XJdXL9bslIcm2zWm226/bZDGwaIQe9wABAX
VyyyQWICPWuaIAGG3UK/pJWb9a1Nu5dFZBV6fMQ6Bzx+ntHvewVTSdyqczRwP4/F
8HLCe2H8rT6xDjDjTsShg3sHFerX2S/vFpaZImAgkgzm7BJH/8/9qPUo73EdTvuy
rFvh8+3jmavJB71dL6FW4DSR12ZEIv09kk3+sQdFoZgGMU1R89eRUkhNy6HNJ1oR
JmvYGqLNmFegpU6NAYNUhlq3OXnfWt4aYluONuEDDVt9cLEiD4+TvIsjRyt6HZIG
SheyD8bl0/qSsC5O0OqDejDgJcmnCw==
=sXbi
-----END PGP SIGNATURE-----

--Sig_/yP6/0_5_zjAgwZFMEA/.5GW--

