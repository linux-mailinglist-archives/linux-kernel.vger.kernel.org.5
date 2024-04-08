Return-Path: <linux-kernel+bounces-135690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E521789C9C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4681C24880
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703D31A83;
	Mon,  8 Apr 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Y8Eqia0E"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2855142640;
	Mon,  8 Apr 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594118; cv=none; b=MHN78tdbr1nV/pBZ6FpNmAfKM6Lotd5N4yyizeaUe7nl3hgwGybszfwtZ5YQcno4uWfbctw2XwaUej/DpVTVEWNUlZ+Zn7AQdYmCFOXj6TYLpzpK5FXqtbfkumNwrsfdi7RQLf+VYH+VWoxAEhlyMV3zU7lUEfSmg2qocxduQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594118; c=relaxed/simple;
	bh=Ol3OuCOs0qz0p2kk34C2mb8GJuxPZ0RRneOwfjXA/qw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGKEwYMe1uvd8Dian+qHc6CkQI6s8vrgrtEN8FBEr6fb2KzkDloUwJ6bjWyMH2BQlpqpAARWv1x0t9qUhahXhGk+h9XDaw6I8+rAYn9OZPS7Ad0OAsqOk2TBFwmApfoQlcyF91eS8ZNcVwvzZKEwMNFcOfvmNiS3Lb04Uzu9v1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Y8Eqia0E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LgugAqDes5DUfL9jH3DtDqEBiyAQfB08J/y6lFBdf+c=;
	t=1712594115; x=1713803715; b=Y8Eqia0E3zDCF8ygCKiMooMyyfIAh1c3nJ/Acw6/xx2Sp8k
	kr+Puz/mBf5gKqNCpWsz2200QiQEHycvjFis/0e7MBSqGTTLAs2p9y5evuDnDo8sYHUOtEYIRH//V
	YJ+YUZk8TUsx9tc6XQcrOe1VP4N+DJ6K5oOtiIAZtVM+cZujvxx9XjoU4hVPeUCsI7zVfoHJHrB2J
	muImTrP7AYhxAb42QpQqPl8IXz2HlbFwWWbhlY2ZdJYzcwdGJaj5FuXHcymB1E5Av8jfP3XW5VQWA
	iH49+KWTAp1AyDM1GZEXVJTv83CCHM8yF2+Zqq2QRSQXbVPStwX+3penVJPqrNog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rtrxg-0000000GMsP-2sSt;
	Mon, 08 Apr 2024 18:35:12 +0200
Message-ID: <05545ecdd2b05223b9204131b0ce9ba33460f44c.camel@sipsolutions.net>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, LKML
 <linux-kernel@vger.kernel.org>,  linux-leds@vger.kernel.org
Date: Mon, 08 Apr 2024 18:35:11 +0200
In-Reply-To: <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
	 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
	 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
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

On Wed, 2024-04-03 at 12:35 -0700, Ben Greear wrote:
> >=20
> > So, deadlock I guess....
> >=20
> >  =C2=A0INFO: task kworker/5:13:648 blocked for more than 180 seconds.
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.9.0-rc2+ #23
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > task:kworker/5:13=C2=A0=C2=A0=C2=A0 state:D stack:0=C2=A0=C2=A0=C2=A0=
=C2=A0 pid:648=C2=A0=C2=A0 tgid:648=C2=A0=C2=A0 ppid:2=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 flags:0x00004000
> > Workqueue: events deferred_probe_timeout_work_func
> > Call Trace:
> >  =C2=A0<TASK>
> >  =C2=A0__schedule+0x43d/0xe20
> >  =C2=A0schedule+0x31/0x130
> >  =C2=A0schedule_timeout+0x1b9/0x1d0
> >  =C2=A0? mark_held_locks+0x49/0x70
> >  =C2=A0? lockdep_hardirqs_on_prepare+0xd6/0x170
> >  =C2=A0__wait_for_common+0xb9/0x1d0
> >  =C2=A0? usleep_range_state+0xb0/0xb0
> >  =C2=A0? __flush_work+0x1ff/0x460
> >  =C2=A0__flush_work+0x287/0x460
> >  =C2=A0? flush_workqueue_prep_pwqs+0x120/0x120
> >  =C2=A0deferred_probe_timeout_work_func+0x2b/0xa0


This seems ... complex.

Does changing iwlwifi's request_module() to request_module_nowait() in
iwl_req_fw_callback() (only) fix it? I think we can do that, we don't
really care at that point, and the issue here seems to be waiting for it
while also other modules are loading and due to the hashing in
idempotent() (kernel/module/main.c) it can't make progress.

johannes


