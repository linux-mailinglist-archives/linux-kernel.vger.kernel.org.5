Return-Path: <linux-kernel+bounces-167792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC28B8BAF3A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629D9283842
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB842056;
	Fri,  3 May 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="yn2Kqd6b"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C934206A;
	Fri,  3 May 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747662; cv=none; b=FZgQYz0FmlTiaQXaCGXLQtVO6FRyo5H//HTcpIYR9idN226AoHxm0UJWYVCmihxot0NxVGchguJtbQ0FWfjXcK8TQf7Xv4AOqSaeDJljjRsGmnPQX8xlnPrWyuIOeHab1EPbG/OgDIEksSkxGHFIPpcqSrTq6WSGGv+EKHGISLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747662; c=relaxed/simple;
	bh=TZJCI1romHYB3K7M0RnD7je7ZU6T6c8LjcioM4SVmjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqtfUkR07oShb9RcUWQy+ueztgvIzs5tXRQUXf0jskHRmRrt8IOkcV/FkssOPDUXEDBCRXV7LukvIVaSvZmLv5fi6mKkcJVAME/m2jIQlqasumON4noaJ4Tw2HLZlk/yJqceincG50E632T9Tg9jlgOndrLCZfbRQWnfmmcFA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=yn2Kqd6b; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714747652; x=1715352452; i=parker@finest.io;
	bh=T+69W9y9gDlQCEnhSbezE3ef/Q0WYMrfqF0FGdvI5SA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=yn2Kqd6b3pRoSSrbwBF8FrgYEwKgNcWBS+J91CM2AQpwOrN0x9q1Z71m0wCAgX8D
	 mIh80H/I4xrGZNm3EgtAi/2t0nouoiD3eChAkU+ZC7u8Cugm7VlpL2cTLEk0/l1Yc
	 FRdBRLCwl+/hy/2B6jELkjaEqfCl5EW6x6+q19B+RdWi7YagT1X8Hvh5/j0z8VtgX
	 9KQSUMf44dr9NeaWfo6LhroJBoRRtNHXVTw/w6PFv91Q3b/eiKjvt6aTT01XsLFbb
	 miIWGpsju+b9RBLbkqv8QbJ90yPylnwGni5uAjUPSvC7Dy+7pT8bcXtfJ+SmkRw9t
	 fWoYtiE1ItKwkHx02Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M1DzC-1svgi348z2-00xAg6; Fri, 03 May 2024 16:47:32 +0200
Date: Fri, 3 May 2024 10:47:30 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240503104730.3e0f55d0@SWDEV2.connecttech.local>
In-Reply-To: <20240503083638.0f8d9afb@SWDEV2.connecttech.local>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
	<20240502114645.4445b3da@SWDEV2.connecttech.local>
	<ZjO4vYEBzxU3fpzC@smile.fi.intel.com>
	<20240502120840.02c65f30@SWDEV2.connecttech.local>
	<ZjPL5z7ah-Qkct6l@smile.fi.intel.com>
	<20240502134949.5e780635@SWDEV2.connecttech.local>
	<ZjPVEr7D0lEf86kQ@smile.fi.intel.com>
	<20240503083638.0f8d9afb@SWDEV2.connecttech.local>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H/QltAz0nGlYfQDl9r0XHlXOofS8l7UvFlDkn49Jwh3MvBzTn26
 OI6KbRdnUUp69MOTajTvFjM8WlY5pJf3Mz1siEKM/lJVi1rzsNd7tGm/h9MSdl9TteSLcbg
 /9/zNCWabhcDZBmg2F5aTEH5qeoZSZi+yne7V5jlrD/8zYFPFfI3aBa61fHLNWexlkSOUdm
 3LP1/V1XKDXS7HluBRWsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n8xASmWg36Y=;WXw9ghYm9n6Z43z2zipX7m+qDlx
 ntsqrm2aVP27mlEp2NXGVmTDQJhvw6DWl+aEZdrWMoFOcGcR/Xv9JNygmLDS3pvy1Ge+EADyF
 wPLn0nDsIoVjvQzx+jM20zl066uWiCO1m2p2kOmgTwcIFZ5hV3osadsDWA8YwLk06huvhWLFJ
 kqvOsTcJIsQdH/9D7LS2JGzytlaxnR8TkYckbDx4GvN/zqaQX3fHyiwEXPBF9M6P5Efg+SpsO
 jxJyzibDPM0WJE+vUfciXkf2ZuZzo2tU8e8NF3rMsZ4bqbgknBOaeMc+1efRZy0OEXA9B71ft
 ta39w+AI3Igcr3usJwPDw34Ga7nGOvodO9ahzF9V/Ynw6SjVVd/bz7Bzuh3LoU3nV4bwVOKuy
 f6ojCTwcGWQlIlCBnnvTKNw9JVTJGl0bbeGqLU3OaMyzBdUMXEJ6rC81UlgeILmCYqgsNuM6m
 gP7TcCcIIjuhQtsGCLDMHK/FLeSlYQsi55qadkYKAUlhODXBw6Z16tioQWE8tVW9bJElzQ0vy
 dGx2l5NViIzydug2oICZSDTz017/aoGYXiGM0iqpEcrHEdbv9TW6TBPpEv60KYPOjuZvItcGS
 IkdT+mrZ64leVFtQN6fG/BEOgvoEwh834zhIVSry/TQyrU5mG5f4B2P4jPgMdy8EYeHkVsmAt
 7pKY4XQebvfhN9OIRWUWXStondShibvfwVEijZG5I2NaEWW2dGO1fQtl64/mjdP+rFqyv6zDc
 nM8mXNNEAvzHcpqiSNSXvGcpAMAmFU5xk7FmrShld3037zwvpx76Dg=

On Fri, 3 May 2024 08:36:38 -0400
Parker Newman <parker@finest.io> wrote:

> On Thu, 2 May 2024 21:01:54 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > On Thu, May 02, 2024 at 01:49:49PM -0400, Parker Newman wrote:
> > > On Thu, 2 May 2024 20:22:47 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, May 02, 2024 at 12:08:40PM -0400, Parker Newman wrote:
> > > > > On Thu, 2 May 2024 19:01:01 +0300
> > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Thu, May 02, 2024 at 11:46:45AM -0400, Parker Newman wrote:
> > > > > > > On Thu,  2 May 2024 17:43:54 +0300
> > > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > >
> > > > > > > > After a rework for CONNTECH was done, the driver may need =
a bit of
> > > > > > > > love in order to become less verbose (in terms of indentat=
ion and
> > > > > > > > code duplication) and hence easier to read.
> > > > > > > >
> > > > > > > > This clean up series fixes a couple of (not so critical) i=
ssues and
> > > > > > > > cleans up the recently added code. No functional change in=
dented by
> > > > > > > > the cleaning up part.
> > > > > > >
> > > > > > > Just an FYI I submitted a patch series that fixed several of=
 these issues but I
> > > > > > > think it fell through the cracks (I know everyone is very bu=
sy!).
> > > > > > >
> > > > > > > Link: https://lore.kernel.org/linux-serial/cover.1713533298.=
git.pnewman@connecttech.com/
> > > > > > >
> > > > > > > I believe my previous patch series is no longer required. Th=
is one fixes
> > > > > > > everything.
> > > > > >
> > > > > > I haven't noticed that, if it contains duplicated patches, I m=
ay replace mine
> > > > > > with yours if you insist.
> > > > > >
> > > > > > In any case it's better to reply there that you prefer this se=
ries to be
> > > > > > applied, so Greg will not pick it up.
> > > > > >
> > > > >
> > > > > I do not have a preference. I am fine with using yours if it is =
easier on
> > > > > the maintainers.
> > > >
> > > > Up to you, there is no issue to take your patches in case they are=
 the same
> > > > (or quite similar) as mine. I can pick them up, just tell me if yo=
u want this
> > > > to happen with a list of the patches (as mail Message-Id).
> > >
> > > Just use yours.
> >
> > Okay, thanks!
> >
> > If you are going to test, better to pay attention to the BIT() convers=
ion patch
> > as Ilpo noted an issue. I believe it's easy to drop (via local git-reb=
ase run)
> > or move and test separately.
> >
>
> I am working on testing now but patches 7 and 12 did not apply with git =
am.
> Both failed around lines 1095/1096.
> I can apply them manually but I may be using the wrong branch (tty-next)=
.
> Which branch/commit did you create your patches from? I don't see it in =
the
> patch submission.

I figured it out. git am was applying the typo fix patch out of order.
Sorry, I didn't notice that. Patches should be fine.

I can do a final test once you decide what to do with the BIT() conversion=
 patch.

Parker

