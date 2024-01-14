Return-Path: <linux-kernel+bounces-25495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5082D120
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473351F20FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174D7257A;
	Sun, 14 Jan 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uchuujin.de header.i=@uchuujin.de header.b="wwAx7v5/"
Received: from mxout.uchuujin.de (82.245.131.213.static.inetbone.net [213.131.245.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09E7E;
	Sun, 14 Jan 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uchuujin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uchuujin.de
Received: by neutronstar.dyndns.org (Postfix, from userid 1000)
	id CB1231430A3FB; Sun, 14 Jan 2024 16:08:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uchuujin.de; s=h;
	t=1705244902; bh=VqBi8P/8QXs0eKF0LplhfgJL8qxug0zUG0douZc9RAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wwAx7v5/neFDUkBsQTcTZ78/yUjzEN0Z11qQHiEbyZi9Dl29wYtHyG1cM5UdAJVl0
	 raj+fsVZ8VPTbjamL6s4m4+yyTh0dnpVXdK5UYxV7b+SxegdLVlElFp2yTXpjjIlFW
	 ogsp4vi1UIGIby+feVdkSpWGpJXtQztc064UKmBL7dz5mLNmOeRxhX55v46L2aEbVa
	 3Hd+oz11FKYNj3Fe6sFzLaC0MHr78BBBDWdvf8mXIwPlGYz7MoY2oVLQpdRcY2qBbZ
	 rbh1lSNb7MZuMo1CDo1ESZ2fv5EJvEjV/O3g5LztMDnEywKonh6uJovX5FeqyH1v01
	 0uKE+YMwWFQnA==
Date: Sun, 14 Jan 2024 16:08:21 +0100
From: Martin Hostettler <textshell@uchuujin.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Adam Borowski <kilobyte@angband.pl>,
	Egmont Koblinger <egmont@gmail.com>
Subject: Re: [PATCH 3/4] vt: ignore csi sequences with intermediate
 characters.
Message-ID: <ZaP45QY2WEsDqoxg@neutronstar.dyndns.org>
References: <20181215143423.4556-1-textshell@uchuujin.de>
 <20181215143423.4556-4-textshell@uchuujin.de>
 <f6190d39-6afe-4106-911e-00e93a7e0640@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6190d39-6afe-4106-911e-00e93a7e0640@kernel.org>

On Thu, Dec 14, 2023 at 01:10:07PM +0100, Jiri Slaby wrote:
> On 15. 12. 18, 15:34, Martin Hostettler wrote:
> > Various csi sequences contain intermediate characters between the
> > parameters and the final character. Introduce a additional state that
> > cleanly ignores these sequences.
> > 
> > This allows the vt to ignore these sequences used by more capable
> > terminal implementations such as "request mode", etc.
> > 
> > Signed-off-by: Martin Hostettler <textshell@uchuujin.de>
> > ---
> >   drivers/tty/vt/vt.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 448b4f6be7d1..24cd0e9c037b 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -2023,7 +2023,7 @@ static void restore_cur(struct vc_data *vc)
> >   }
> >   enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
> > -	EShash, ESsetG0, ESsetG1, ESpercent, ESignore, ESnonstd,
> > +	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore, ESnonstd,
> >   	ESpalette, ESosc };
> >   /* console_lock is held (except via vc_init()) */
> > @@ -2259,6 +2259,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
> >   			vc->vc_par[vc->vc_npar] += c - '0';
> >   			return;
> >   		}
> > +		if (c >= 0x20 && c <= 0x2f) {
> > +			vc->vc_state = EScsiignore;
> > +			return;
> > +		}
> >   		vc->vc_state = ESnormal;
> >   		switch(c) {
> >   		case 'h':
> > @@ -2421,6 +2425,11 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
> >   			return;
> >   		}
> >   		return;
> > +	case EScsiignore:
> > +		if (c >= 20 && c <= 0x3f)
> 
> Staring at the current code, I am confused as I cannot find out why "20".
> Was this supposed to be 0x20 (the same as above -- 0x20 is SPACE and that
> _is_ sensible)? Or why was this arbitrary 20 chosen?

I'm not sure what happend here. But i agree this should be 0x20 or it
should be removed (see below) but not decimal 20.

This is supposed to match what ECMA-48, xterm and the usual terminal
parsers do.

The most important behavior here is that common usages work, which
fortunatly it seems this did not break.

CAN, SUB and ESC are in the range 20 to 0x20, but they are already handled
before the switch. And 0x20 to 0x3f are properly ignored.

I think that is all that really matters for terminal interoperablity.

When comparing with how xterm handles this state [1], xterm ignores more
characters. If we want to match that, i think we would want to remove the
whole `c >= 20 &&` part.

xterm ignores 0-4, 6, 16-23, 25, 28-0x3f and 127.
Or in other words, it does not ignore
5 (ENQ), 7 (BEL), 8 (BS), 9 (TAB), 10-13, 14 (Shift out), 15 (shift in),
24 (CAN), 26 (SUB), 27 (ESC) and 0x40-126

This code already handles 7, 8-15, 24, 26, 27, 127 before the switch.
The code also does not implement ENQ so effectivly ignoring it is the same
as handling it.

But if we match xterm here, we should also match it in other cases like
ESsquare and ESgetpars.

So in summary i think we should fix this, but the fix does not need any
backporting to stable kernels.

Do you want to send a patch to fix this, or should i send a fix.

Do you have thoughts in which of the two plausible directions we should
change the code?

[1] https://github.com/ThomasDickey/xterm-snapshots/blob/3a151f2f31358d135204c8f90759f3cfd0697b9e/VTPrsTbl.c#L5290

> 
> thanks,
> -- 
> js
> suse labs
> 

