Return-Path: <linux-kernel+bounces-136513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1958989D504
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D28B28391B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB67E78F;
	Tue,  9 Apr 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vH8VJKBV"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21527E580;
	Tue,  9 Apr 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653189; cv=none; b=i+7zl/xnMZRrNzs6/gzQagqHBcqHrOXw4lo/vXyHObWOIw0L/YFHF+UiaZsC5ZD4Jf0T3GC2YeEk3y4hAa7r3b4+5U9h0HhfCCRsbdumjPwWRLGSDOeZZOIurOSwRNmiXMSKGkqlKef2z6TIaU491qVwGX6uFYyz3C1iwPmJosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653189; c=relaxed/simple;
	bh=Ji9qU29b0LOvBoHZAKGFxAoA21Xv44MATWXua9pnMVk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kxRVYJz1crO2Od3Tp/oeh2zQBSYG1kcIy5KiwYO/xxj4g44dgkV7vOgWon+Hcyups6dgeLxQgg5ONrIeZ7GU7BrQTBH4iMF0fOX+rssAoA+SO/jd122JT6cYeWg4LSlCmeGnVkCbItpm2ZoAUs51YCj9u9fzC7lCcAxdAk3xwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vH8VJKBV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=q64bAyl+Qg6fQaVjCQKqO/8qybmHcNNCXqZE2H37A1A=;
	t=1712653187; x=1713862787; b=vH8VJKBVhh9f70N0wksw9vwHlD+oMRxRxsA5JMV6duo/PY9
	mBQ9RnONVPltUJrzI8c/sj7fN3PlaUkwgTRAh+B6zTwEXeJoUSFSevPDYemtrVJ27WfgKJ/RFQxKp
	hqRmjUjlIVryoyF7fdRA5/hUuj79zSYvxZa6yvJNV0QK8tsyCHr8vQjZxC4u4D00L9XVf4FamO22S
	8vPqbnqCGGVsd23wKWx1MlGx8qULg1SJuXdKuw8EtmisqKTROZugy0fD1UpoFcvp2I90Vr4wJNCzu
	nRjBKmWWqd9Z96PWdrePBPJm7tGDGxZtQP9/0kXSMT0Uybl1sgzDKSIt7vcL4Luw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ru7KS-0000000HUKi-05fi;
	Tue, 09 Apr 2024 10:59:44 +0200
Message-ID: <157c703381624d331c7de4aeb2b2802789239456.camel@sipsolutions.net>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Ben Greear
	 <greearb@candelatech.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-leds@vger.kernel.org
Date: Tue, 09 Apr 2024 10:59:42 +0200
In-Reply-To: <93494f0b-ad05-4566-b454-fa36a7dac248@leemhuis.info>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
	 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
	 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
	 <05545ecdd2b05223b9204131b0ce9ba33460f44c.camel@sipsolutions.net>
	 <93494f0b-ad05-4566-b454-fa36a7dac248@leemhuis.info>
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

On Tue, 2024-04-09 at 10:47 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
> On 08.04.24 18:35, Johannes Berg wrote:
> > On Wed, 2024-04-03 at 12:35 -0700, Ben Greear wrote:
> > > >=20
> > > > So, deadlock I guess....
> > > >=20
> > > >  =C2=A0INFO: task kworker/5:13:648 blocked for more than 180 second=
s.
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.9.0-rc2+ #23
> > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this me=
ssage.
> > > > task:kworker/5:13=C2=A0=C2=A0=C2=A0 state:D stack:0=C2=A0=C2=A0=C2=
=A0=C2=A0 pid:648=C2=A0=C2=A0 tgid:648=C2=A0=C2=A0 ppid:2=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 flags:0x00004000
> > > > Workqueue: events deferred_probe_timeout_work_func
> > > > Call Trace:
> > > >  =C2=A0<TASK>
> > > >  =C2=A0__schedule+0x43d/0xe20
> > > >  =C2=A0schedule+0x31/0x130
> > > >  =C2=A0schedule_timeout+0x1b9/0x1d0
> > > >  =C2=A0? mark_held_locks+0x49/0x70
> > > >  =C2=A0? lockdep_hardirqs_on_prepare+0xd6/0x170
> > > >  =C2=A0__wait_for_common+0xb9/0x1d0
> > > >  =C2=A0? usleep_range_state+0xb0/0xb0
> > > >  =C2=A0? __flush_work+0x1ff/0x460
> > > >  =C2=A0__flush_work+0x287/0x460
> > > >  =C2=A0? flush_workqueue_prep_pwqs+0x120/0x120
> > > >  =C2=A0deferred_probe_timeout_work_func+0x2b/0xa0
> >=20
> > This seems ... complex.
> >=20
> > Does changing iwlwifi's request_module() to request_module_nowait() in
> > iwl_req_fw_callback() (only) fix it? I think we can do that, we don't
> > really care at that point, and the issue here seems to be waiting for i=
t
> > while also other modules are loading and due to the hashing in
> > idempotent() (kernel/module/main.c) it can't make progress.
>=20
> Not my area of expertise, so listening to me my send you off-track.
>=20
> Might this be related to the issue discussed here:
> https://lore.kernel.org/all/ZhRD3cOtz5i-61PB@mail-itl/
>=20
> See also:
> https://lore.kernel.org/all/2695e9db-a5a0-4564-9812-a50b91fb1b46@gmail.co=
m/

Don't think so, that was related to devm and module unload, neither
seems to be the case here.

johannes

