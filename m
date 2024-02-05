Return-Path: <linux-kernel+bounces-53961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2515684A879
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9873288357
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8704E151446;
	Mon,  5 Feb 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCbl2FgW"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCFC149006;
	Mon,  5 Feb 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167345; cv=none; b=mg0/uwtj5To2bp2avZSfZlZOJYnWR+mSXiZPYt5iaZxHTYKJxyVn+nXmKi0yFGcNb/xLFij7T7nnuowXq0q4qtbAmYODQ8dVH4JhiFpmDFdrPf5WlXcqCqUNTkKlm1RWoG4xCmD5maesfGFUV7PNUC2aKwqai02vLHuD66KTfMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167345; c=relaxed/simple;
	bh=LXICrHdI8+SoqujeoVEgEy5+dC5zdaTlkmnQy8HtSeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gILtzpQc3qQkzU7p6Qin9cu0jnl9Kv1jUPkuCNgYkU0z5s69W+ogOri15t+OCN+zNs7etL/7TkWBfaFrOpZQzYmjta4aHw6bOLA8pf6EQaClNUtz9xoeBOjR5TJ09S1fyqw5lEsjvBmCrBGLcrmgZWqOcPXty8aecHOD0oHIFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCbl2FgW; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6818aa07d81so30095806d6.0;
        Mon, 05 Feb 2024 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707167343; x=1707772143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D4YotZgs5kEqRhdKzsQq2/ydXplQT/QOmw6gv422KoE=;
        b=LCbl2FgWYLpaax0isYX8c67cnoaoHm178Vf18e70LtYNVVsKyfTagsCAKaKY+ewEWN
         H5h/PGNzzlBscmKv0p7lKGWiM/49olMf/DtxeanFkwCyj8utGGrPURmiHJUF66kgSS+c
         pVSdeI6hyLU5JVTCEGq5zgYMlg+SYyauAFPBlayPu+3uriJ7JqK+nspxVUsizzyPOaEJ
         GmK64pN/I+0Zmybk+zikGeZmYTxZIfDSW4XCbnaP0cP5D6TcX3vK8W1bk8ZUhDGEqqL9
         SJszEyw4DSzboklPBcaQlsS+Xk8zuHzcJc6pWgXlVMldlh+7vePRRE2xKgS/+QMk3P6s
         sa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167343; x=1707772143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4YotZgs5kEqRhdKzsQq2/ydXplQT/QOmw6gv422KoE=;
        b=Urz29mQEq8EhzJkkF4c57CaEhy571kIeTxMWasGYWmhFumhCPgBMSdjmxwi+gSXyPc
         TN7Jv5Bgwjg+APHmHSBC7TF+8GrElP8a/n6y1CZitq1IpaDbZWn3gfiE9yVXAyYsnngP
         549W6uevOKppWXD0qmuOTdKpteAdMm60lJ1KRjJjeQZYlbkZz/fDuYy2KL5Y5g9Pc1YD
         6CtsTQbllYTxHd9ofkT1duf9+WmcyYKpg8W8OEGN6Clh8yRr9s6Ohj4f85Ht1cDeHCAc
         h2M/ZpWLDomnzAGY443YKxBnLwBHWIuUJWy/RzWIrl54AHkEo/pSaBKhQWgOEBMloXDl
         qFxw==
X-Gm-Message-State: AOJu0YwRwPntGGyqO2r4htIp3sbZtWRaWKODR8kvAReNswrfK6zP03j+
	fBL0j55qmq2B6Elie07CLVCyPRFUW5D9PcQGDPLsC3c4P7DrVUYAXhkAP6JE
X-Google-Smtp-Source: AGHT+IF0WTs1xnpL3mPy4qmO/mjfl5QxVwpk7rzwVkvJICBa2AgNfTT3rNEukGlBd25Yi3V3VknTLw==
X-Received: by 2002:a0c:dd87:0:b0:68c:5583:a86f with SMTP id v7-20020a0cdd87000000b0068c5583a86fmr194489qvk.6.1707167342816;
        Mon, 05 Feb 2024 13:09:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWgnXHWUu+nBQEGTX4ms/+NO1866vcJle38UryRtyJqXCXz+P2rwyWxWcDERZyvMaWVZZCpPWVGe/IRdVGQ7H4zKl0MEIo3SiWdvu7eV0Y35avZqRk/hZ1vr6qW1bVIbTAuPddd5JJHLGVbQGEA20F+GWB6uj/lgr0/ShqXGb8NEML1+8BCuFACmyhknHxCBD15G53GBHYu+bpeQc7wvdKIJZx3RALJ/jUywMSMSquVld+GgemZDemTgtaYxH2k7XJy2z3ZIG69MdTpqxXciiD2W3PqwcYeHTJhFpnq+BIUma3II15G6c9aW6CC2AfrS7YIIjITeBhxbSo1VVu0RUw9Fsu1wIzegxKcVVvhUY8Sg1krsY3TgEYJ7EEH66cehhFgfI/n2uSHoqNHt9Rbu2mAlcGUNCmQBny7kS8fa0GRp5+F
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ks13-20020a056214310d00b0068c87d51529sm345579qvb.94.2024.02.05.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:09:02 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id BDF3027C005B;
	Mon,  5 Feb 2024 16:09:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Feb 2024 16:09:01 -0500
X-ME-Sender: <xms:bE7BZVZoBAx-ztrg5qZD_emyQRpwIR2wPxQE3qdxLae89PUogKInDQ>
    <xme:bE7BZcbM2x4vvxxbI8CeXxoejb-Cn4XlIQ67EgdP-jmL5kjxZgJjpgSJ5k6KaU5NM
    W_8jrS_RddUlJBvAw>
X-ME-Received: <xmr:bE7BZX9seA8V3qRtd5uX5WIA1VGXzTQSNP9J1lkZBWyG8B211YTRFaNvDpfz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvuddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgffhudetvdejueetieeijeejtdduhfdvffdvjeehffdtheevtdeuhfeu
    heehiefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:bE7BZTq4tzM0G_cVvREXiqLwdRowCoDS9zC8X_PULZ3hWOa7DL5WYw>
    <xmx:bE7BZQpReXLI1hpUGL767Gf7StHNl5Doeyd-BJvrzjd8fGvoxi6SbQ>
    <xmx:bE7BZZQZlZ5kBpIjPKYf35Kn5PXk8QRfAWc6quPCRKT_P3LfjcS1Mg>
    <xmx:bU7BZcZuMTop3oiqvLjaxCuQvxoM4nykEVcvWeuNCdBa7RugcZAzig>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 16:09:00 -0500 (EST)
Date: Mon, 5 Feb 2024 13:09:00 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Zhengxu Chen <zhxchen17@meta.com>,
	Danielle Costantino <dcostantino@meta.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Tang <feng.tang@intel.com>, Waiman Long <longman@redhat.com>,
	John Stultz <jstultz@google.com>, x86@kernel.org
Subject: Re: [PATCH 5/8] tsc: Check for sockets instead of CPUs to make code
 match comment
Message-ID: <ZcFObO-fcvq1_xj7@tardis>
References: <20240129235646.3171983-1-boqun.feng@gmail.com>
 <20240129235646.3171983-6-boqun.feng@gmail.com>
 <1781cc76-aeee-427b-bc9e-b3d2b8f184f3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1781cc76-aeee-427b-bc9e-b3d2b8f184f3@paulmck-laptop>

On Mon, Feb 05, 2024 at 12:03:33PM -0800, Paul E. McKenney wrote:
> On Mon, Jan 29, 2024 at 03:56:38PM -0800, Boqun Feng wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >=20
> > The unsynchronized_tsc() eventually checks num_possible_cpus(), and
> > if the system is non-Intel and the number of possible CPUs is greater
> > than one, assumes that TSCs are unsynchronized.  This despite the
> > comment saying "assume multi socket systems are not synchronized",
> > that is, socket rather than CPU.  This behavior was preserved by
> > commit 8fbbc4b45ce3 ("x86: merge tsc_init and clocksource code") and
> > by the previous relevant commit 7e69f2b1ead2 ("clocksource: Remove the
> > update callback").
> >=20
> > The clocksource drivers were added by commit 5d0cf410e94b ("Time: i386
> > Clocksource Drivers") back in 2006, and the comment still said "socket"
> > rather than "CPU".
> >=20
> > Therefore, bravely (and perhaps foolishly) make the code match the
> > comment.
> >=20
> > Note that it is possible to bypass both code and comment by booting
> > with tsc=3Dreliable, but this also disables the clocksource watchdog,
> > which is undesirable when trust in the TSC is strictly limited.
> >=20
> > Reported-by: Zhengxu Chen <zhxchen17@meta.com>
> > Reported-by: Danielle Costantino <dcostantino@meta.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Feng Tang <feng.tang@intel.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: <x86@kernel.org>
>=20
> Hello, Boqun,
>=20
> Please drop this one, as I never got an ack from the maintainers, and
> quite possibly for good reason.  ;-)
>=20

Got it I will drop it in the PR, the topic branch has been updated:

	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rcu-misc.202=
4.02.05a

Regards,
Boqun

> 							Thanx, Paul
>=20
> > ---
> >  arch/x86/kernel/tsc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 15f97c0abc9d..d45084c6a15e 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1287,7 +1287,7 @@ int unsynchronized_tsc(void)
> >  	 */
> >  	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL) {
> >  		/* assume multi socket systems are not synchronized: */
> > -		if (num_possible_cpus() > 1)
> > +		if (nr_online_nodes > 1)
> >  			return 1;
> >  	}
> > =20
> > --=20
> > 2.43.0
> >=20

