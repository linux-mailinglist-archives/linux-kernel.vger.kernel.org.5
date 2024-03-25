Return-Path: <linux-kernel+bounces-117742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CD88AEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B765D1F672C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095841BC35;
	Mon, 25 Mar 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oe+TD6tI"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC11DDBC;
	Mon, 25 Mar 2024 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392204; cv=none; b=Gow2/ENZ3lg67UwEPq+UejJMmL43FFpWkCVRqa+gfNUsNKXipVeUENmVsA209wZmrBCbDQlRbpKSqHRWS9rvo3O2bgSaHYD2J7UUzQTMd1aJKtnP99893LcbNlvoqXlueMq72haaokSR4LrGj2OS7HZHDZ2En4rueRNf4JLU1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392204; c=relaxed/simple;
	bh=qdFHRwDn5Dpo4RgBgnFNgRw+jK2dyYCqGr/cxlrDXo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VmFQZHS+dussgZvcHJnKjYTrIplIpBgCzm9kXoUW8QrW/AYUyihIKpgJmQmcO5w9z/vkWJLgjOlGgVKKJFSTExa6ijlUghbB+26dgNlZ7TBDYeQwHJ/SGuDdirSz8E7495/AyIX8TatbyOvj0M0o/rxrt1LsuCYpq1OGnVPA1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oe+TD6tI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=93+FVeoSlMuZbiAXFBL3M9hpRZZSS6lI5Qvwa5nPKIQ=;
	t=1711392202; x=1712601802; b=oe+TD6tIU9nP97EsS2YFuILRQtCwUnjTR3f+cm78QYmkkcA
	yMIYCnI65Szr/WICDCagpBFhlG2bJJyIJtH1p4T1qLz5AMao+5RGuHEN3FeQPQg3w/m4b0sb/klhn
	pltwbkEjgMvB+cIfCY4U2Z3ZdkzQTXW82SdgVZrt2FaUAIuQh8fPZMWZTy9e2qiOwKQ2rpcFKBHrP
	BasyQGH7acE1quLLK8mfPplPuSQ77VmJS6B8bwsEbaJR30XcCNDyxTG3OZQ37A6c2iKy2ADdrfFsO
	yiEh1zycWxE8/uHN92JoHoAt433DXFMtOEnShGRRaWo8iq52N0+HrHqvXz9fX4WQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ropHz-0000000E2FA-2Tho;
	Mon, 25 Mar 2024 19:43:19 +0100
Message-ID: <48034addaeb6c33ca8b3e636262b6c043ddc5359.camel@sipsolutions.net>
Subject: Re: [PATCH] rcu: mollify sparse with RCU guard
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, Josh Triplett
 <josh@joshtriplett.org>, Peter Zijlstra <peterz@infradead.org>
Date: Mon, 25 Mar 2024 19:43:18 +0100
In-Reply-To: <35355d02-3eef-4860-847b-b7bbf05f4a31@moroto.mountain>
References: <20240325101626.41584-2-johannes@sipsolutions.net>
	 <ZgGnuFJiTX5laS7c@boqun-archlinux>
	 <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>
	 <35355d02-3eef-4860-847b-b7bbf05f4a31@moroto.mountain>
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

On Mon, 2024-03-25 at 21:28 +0300, Dan Carpenter wrote:
> On Mon, Mar 25, 2024 at 05:41:22PM +0100, Johannes Berg wrote:
> > Also __acquire()/__release() are just empty macros without __CHECKER__.
> > So not sure the indirection really is warranted for this special case.
> >=20
> > I can add a comment in there, I guess, something like
> >=20
> >  /* sparse doesn't actually "call" cleanup functions */
> >=20
> > perhaps. That reminds me I forgot to CC Dan ...
> >=20
>=20
> These are Sparse warnings, not Smatch warning... Smatch doesn't use any
> of the Sparse locking annotations.

Sure, of course. I just saw that you added cleanup stuff to sparse to
allow using it in smatch.

> Smatch handles cleanup basically correctly at this point.

Do you "run" / "emit" the cleanup function calls there? I briefly look
at doing that in sparse but it felt ... complicated, and then I saw the
condition in the cleanup function which I thought sparse could probably
not see through anyway.

johannes

