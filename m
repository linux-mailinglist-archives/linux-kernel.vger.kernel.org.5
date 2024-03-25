Return-Path: <linux-kernel+bounces-117536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819A388AC56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BE71C3FEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906145023;
	Mon, 25 Mar 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTmoAtCi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED83FEC;
	Mon, 25 Mar 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386371; cv=none; b=TYp+UaEc78dL2822fZXRQmcSDxzdxhntUTwfmobpWS0ARoZZPRRMJou0jo2HCtjg1PdFa3CpOb2cKnFunRSha1N37C8z3pqGTn8epGNjQW44XE2pFnrjDxNoRcWdAe9WuKXqIptcyqCcMdUh8XoXdZTgiv1CInoA6E7ypEmtc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386371; c=relaxed/simple;
	bh=tCRv3+lqIzzsRYi39BX2aoxsvxZmwjbLe16p7lNvRYU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=tZS1qAX/Hh1rDgebmih/RzlhqlccQ2kqsSN8LLTVfXNLEdDjEKfflheknTcqefofydpKRp2YwljpN+o/09153WmGGVJsbVDk7cHeIUEIB8mPVf14ItmyhJzPsnEwUvYI9rG8qK4Fm/3g6T5QyaturaSECHo9IpceDacBQ5nwsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTmoAtCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D325C433F1;
	Mon, 25 Mar 2024 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711386370;
	bh=tCRv3+lqIzzsRYi39BX2aoxsvxZmwjbLe16p7lNvRYU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RTmoAtCib6kvJhv7xadArxDddOFl9pOLgVWVZ0ChCtdrohAK2NWrcb8/mEe2loEp1
	 5cK1JZF3EJvXEV1i8kqbH5U34ACTQMFeT+kqTh2nOJ3iJuRYXvNPleyrjBZTz3UkbM
	 9h/E6o1Vl1PrHgOEWz2PvJp05z96rB29dy3WmM0IuYVXcRP/47Zci57lpBbW+piBG9
	 4dXNe3kz9vYn5dVBqkZdtewuDJsUR0CijgQQK9n9OtXvoAHj9zThhL59ejHnpOXxOJ
	 G/kxctXg+ZvGsqPxJpAVqrdicLL2FlLf46L9rGI5T3PdVFfRKyVzFpiNPAaXZ4RP/v
	 I/bQurroUwBzg==
Message-ID: <42ae624ca2289fb82e00f3ac8938d05e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=Ws-LYcpiitibPBPRhqrbS8rTo_7xtPPw2kA+qBzybOxQ@mail.gmail.com>
References: <20240325054403.592298-1-sboyd@kernel.org> <20240325054403.592298-5-sboyd@kernel.org> <CAD=FV=Ws-LYcpiitibPBPRhqrbS8rTo_7xtPPw2kA+qBzybOxQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: Get runtime PM before walking tree during disable_unused
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 10:06:08 -0700
User-Agent: alot/0.10

Quoting Doug Anderson (2024-03-25 09:19:37)
> Hi,
>=20
> On Sun, Mar 24, 2024 at 10:44=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> =
wrote:
> >
> > Introduce a list of clk_core structures that have been registered, or
> > are in the process of being registered, that require runtime PM to
> > operate. Iterate this list and call clk_pm_runtime_get() on each of them
> > without holding the prepare_lock during clk_disable_unused(). This way
> > we can be certain that the runtime PM state of the devices will be
> > active and resumed so we can't schedule away while walking the clk tree
> > with the prepare_lock held. Similarly, call clk_pm_runtime_put() without
> > the prepare_lock held to properly drop the runtime PM reference.
>=20
> There's a part of me that worries about the fact that we'll now be
> doing a pm_runtime get() on _all clocks_ (even those that are used) at
> bootup now. I worry that some device out there will be unhappy about
> it. ...but I guess the device passed in here is already documented to
> be one that the clock framework can get/put whenever it needs to
> prepare the clock, so that makes me feel like it should be fine.
>=20
> Anyway, no action item, just documenting my thoughts...
>=20
> Oh, funny. After reading the next patch, I guess I'm even less
> concerned. I guess we were already grabbing the pm_runtime state for
> all clocks while printing the clock summary. While that's a debugfs
> function, it's still something that many people have likely exercised
> and it's likely not going to introduce random/long tail problems.
>=20
>=20
> > +/*
> > + * Call clk_pm_runtime_get() on all runtime PM enabled clks in the clk=
 tree so
> > + * that disabling unused clks avoids a deadlock where a device is runt=
ime PM
> > + * resuming/suspending and the runtime PM callback is trying to grab t=
he
> > + * prepare_lock for something like clk_prepare_enable() while
> > + * clk_disable_unused_subtree() holds the prepare_lock and is trying t=
o runtime
> > + * PM resume/suspend the device as well.
> > + */
> > +static int clk_pm_runtime_get_all(void)
>=20
> nit: It'd be nice if this documented that it acquired / held the lock.
> Could be in comments, or, might as well use the syntax like this (I
> think):
>=20
> __acquires(&clk_rpm_list_lock);
>=20
> ...similar with the put function.

I had that but removed it because on the error path we drop the lock and
sparse complains. I don't know how to signal that the lock is held
unless an error happens, but I'm a little out of date on sparse now.

>=20
>=20
> > +       /*
> > +        * Runtime PM "get" all the devices that are needed for the clks
> > +        * currently registered. Do this without holding the prepare_lo=
ck, to
> > +        * avoid the deadlock.
> > +        */
> > +       hlist_for_each_entry(core, &clk_rpm_list, rpm_node) {
> > +               ret =3D clk_pm_runtime_get(core);
> > +               if (ret) {
> > +                       failed =3D core;
> > +                       pr_err("clk: Failed to runtime PM get '%s' for =
clk '%s'\n",
> > +                              failed->name, dev_name(failed->dev));
>=20
> If I'm reading this correctly, the strings are backward in your error
> print. Right now you're printing:
>=20
> clk: Failed to runtime PM get '<clk_name>' for clk '<dev_name>'

Good catch. Thanks!

>=20
> With the printout fixed and some type of documentation that
> clk_pm_runtime_get_all() and clk_pm_runtime_put_all() grab/release the
> mutex:
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

