Return-Path: <linux-kernel+bounces-33993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52FD837190
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5474C1F31A12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F03D38E;
	Mon, 22 Jan 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+Ihr1J/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE11EEE6;
	Mon, 22 Jan 2024 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948620; cv=none; b=Myu6C00g8lMaVT31ernlNe2Ww4jvngvqmsBgGbwmJzS+glH2V6YA4Taoy3xoMLWTtnHaRSlpSXSvHd0At/OzeRhtUwoBvCqBGhlw37ZZDtu4a3d1RnbDqnNyqaRWYKH5FZWWTylcbBlru2L+KxKcqzVd0Xi6F+k70OUuyWM+TnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948620; c=relaxed/simple;
	bh=hrwjbRp1ado/yW8ClBvMvhONAHhRUekw/nstehGSnZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzKE46IbBt7UQ8iC9L8oOtjAkNiKScKZh2/H1KweBlkreom4G0KRod9FEYTR9Tkw7U8iHUureUkqzhEaVR4ub7u77iK0HF7eWU2dky/y1TF1M+TrI/8zfFQGKWsNX6zuxBw0zqe90GHe6fBe+oQWnB42tgBqVzatHKU6vtSKxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+Ihr1J/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7198C433C7;
	Mon, 22 Jan 2024 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705948620;
	bh=hrwjbRp1ado/yW8ClBvMvhONAHhRUekw/nstehGSnZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+Ihr1J/rinwBofu3hFnmERu66u6Qwd2ohTRAek0EaKIh8OOXpybSPROymf+a2WYD
	 kTNKzxkLmXUsQvYgnvAZRD00i7/LvXcpfwOHAlJ/qwp49Mns8P0AbVLSpwepqAC4Og
	 1nGQYA5lDvN/Kn3i7jvxw6T8xhW6QEkMDeguab5SXgxxr06M0qbLNibIDV2PCEOljV
	 JBUNxKlFRw1xs4kzZeAB72eSKKEfaTA9X//NR7/plFd6tNryUjO51hN1wWimXStzq7
	 lbyDMdQNh3OT4SWjJXlzGb5JVyxp9ZBA9YpvZrRPcal/fecMkOJWTxPXpGD8bXeoOp
	 PJOrbj8Ih7pDA==
Date: Mon, 22 Jan 2024 10:36:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Netdev <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic in netif_rx_internal after v6 pings between netns
Message-ID: <20240122103658.592962d1@kernel.org>
In-Reply-To: <f96b33ab-56d5-4a43-a1ff-2e68e2c55ac2@kernel.org>
References: <98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org>
	<CANn89iLAYXpRiGaGi+rvOZyxMfpUmW2cOg6hLhqE=+2JJS8rkw@mail.gmail.com>
	<65c4f6a2-207f-45e0-9ec3-bad81a05b196@kernel.org>
	<5340b60d-a09a-4865-a648-d1a45e9e6d5f@kernel.org>
	<20240122092804.3535b652@kernel.org>
	<f96b33ab-56d5-4a43-a1ff-2e68e2c55ac2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 19:22:42 +0100 Matthieu Baerts wrote:
> > Somewhat related. What do you do currently to ignore crashes? =20
>=20
> I was wondering why you wanted to ignore crashes :) ... but then I saw
> the new "Test ignored" and "Crashes ignored" sections on the status
> page. Just to be sure: you don't want to report issues that have not
> been introduced by the new patches, right?

Initially, yes, but going forward I bet we'll always see crashes and
breakage introduced downstream. So we need some knobs to selectively
silence failing things.

In an ideal world we'd also have some form of "last seen" stat
displayed to know when to retire these entries..

> We don't need to do that on MPTCP side:
> - either it is a new crash with patches that are in reviewed and that's
> not impacting others =E2=86=92 we test each series individually, not a ba=
tch of
> series.
> - or there are issues with recent patches, not in netdev yet =E2=86=92 we=
 fix,
> or revert.
> - or there is an issue elsewhere, like the kernel panic we reported
> here: usually I try to quickly apply a workaround, e.g. applying a fix,
> or a revert. I don't think we ever had an issue really impacting us
> where we couldn't find a quick solution in one or two days. With the
> panic we reported here, ~15% of the tests had an issue, that's "OK" to
> have that for a few days/weeks
>=20
> With fewer tests and a smaller community, it is easier for us to just
> say on the ML and weekly meetings: "this is a known issue, please ignore
> for the moment". But if possible, I try to add a workaround/fix in our
> repo used by the CI and devs (not upstreamed).
>=20
> For NIPA CI, do you want to do like with the build and compare with a
> reference? Or multiple ones to take into account unstable tests? Or
> maintain a list of known issues (I think you started to do that,
> probably safer/easier for the moment)?

Exactly - where we can a before/after diff is the best. We do that for
all static checker / building kind of tests. But for selftests I'm not
sure how effective and applicable that is. Even the stack trace I
posted here happens somewhat unreliably :( We can try to develop more
intelligent ways going forward, obviously :)

> > I was seeing a lot of:
> > https://netdev-2.bots.linux.dev/vmksft-net-mp/results/431181/vm-crash-t=
hr0-2
> >=20
> > So I hacked up this function to filter the crash from NIPA CI:
> > https://github.com/kuba-moo/nipa/blob/master/contest/remote/lib/vm.py#L=
50
> > It tries to get first 5 function names from the stack, to form=20
> > a "fingerprint". But I seem to recall a discussion at LPC's testing
> > track that there are existing solutions for generating fingerprints.
> > Are you aware of any? =20
>=20
> No, sorry. But I guess they are using that with syzkaller, no?
>=20
> I have to admit that crashes (or warnings) are quite rare, so there was
> no need to have an automation there. But if it is easy to have a
> fingerprint, I will be interested as well, it can help for the tracking:
> to find occurrences of crashes/warnings that are very hard to reproduce.

Indeed, I'll keep my ear to the ground. I believe it was discussed in
relation to KCIDB.

