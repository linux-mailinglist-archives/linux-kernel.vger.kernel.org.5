Return-Path: <linux-kernel+bounces-104762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A74687D332
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F6DB239D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092BA4CB55;
	Fri, 15 Mar 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IsdhNMIL"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210718E06;
	Fri, 15 Mar 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525801; cv=none; b=Wv8FyzSz40K+Gq4lyvSceSOLWjzBgRr3ibOLDNnCQUdPsck7AQR94C0e9RKxPWGO5JhWMT9p0BICjGZCkxnyaKIrQDNruLBiog8kNekWrcnQRxdiG829jbtvLEeGo7th4NdrET/THu8DfwdfrbhYaf1h6KGoRuoiw1KLkTlpL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525801; c=relaxed/simple;
	bh=96jjlzaKqPIoD+J27xsIk2R5l8th0S2N61/a556Lg3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akFNe1iaGhuRJRohgFqykjCPqHgHOZvXoUujQRJpB3wzElr7wM206vwhNp1Py8tf7kAyKTZOeySnkqXoaBcuBVrAKr1Qu1NeAU+0YWS7Jaw8FqKKZn2k5yvSt/FSnroli9lqsUx6eXdzSzCAAA1k2v7LzYHpZbbfBTbnwnlQTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IsdhNMIL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DD251BF203;
	Fri, 15 Mar 2024 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710525794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VO5WZoCCq5NoqpHuTQPS36Qy1y1GqkTO5VES9r52zkQ=;
	b=IsdhNMILYndk7lAja94Rbuj9zEqXwi+IGFwPR1D66L3EaLl5481AdeJlUEPtRyBS/U+dOI
	R0HwG/6/Uyo+Js0//vR2akLv7SXUmK/JUcidrxpzqH7WauX2z2B/LCE5hKxiIBhJVCQELu
	X3CMrvdE+qU0WXjQLfLEHMlXTs52x0wTJ26+MTQ8xNl2c/khWYoWw26g7zNPdwBd/meSKe
	u4aJViL8tzt/WMcARqF0C/vkaFQxnhAcs0NjmUVXiclJXap7VrINnQc+m7h90+PNTRMIWP
	zJDbKW7eff1L3JHZ44cU8DCndTJedLZRWub2NTeeSJm5Ikt/JqH0UvEqezxh+w==
Date: Fri, 15 Mar 2024 19:03:12 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: TP_printk() bug with %c, and more?
Message-ID: <20240315190312.2bd6a198@booty>
In-Reply-To: <20240315132146.29edf416@gandalf.local.home>
References: <20240315174900.14418f22@booty>
	<20240315132146.29edf416@gandalf.local.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Steven,

thanks for the quick feedback!

On Fri, 15 Mar 2024 13:21:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 15 Mar 2024 17:49:00 +0100
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> 
> > Hello Linux tracing maintainers,  
> 
> Hi Luca!
> 
> > 
> > I've come across an unexpected behaviour in the kernel tracing
> > infrastructure that looks like a bug, or maybe two.
> > 
> > Cc-ing ASoC maintainers for as it appeared using ASoC traces, but it
> > does not look ASoC-specific.
> > 
> > It all started when using this trace-cmd sequence on an ARM64 board
> > running a mainline 6.8.0-rc7 kernel:
> > 
> >   trace-cmd record -e snd_soc_dapm_path ./my-play
> >   trace-cmd report
> > 
> > While this produces perfectly valid traces for other asoc events,
> > the snd_soc_dapm_path produces:
> > 
> >   snd_soc_dapm_path:    >c<* MIC1_EN <- (direct) <-
> > 
> > instead of the expected:
> > 
> >   snd_soc_dapm_path:    *MIC1 <- (direct) <- MIC1_EN
> > 
> > The originating macro is:
> > 
> > 	TP_printk("%c%s %s %s %s %s",
> > 		(int) __entry->path_node &&
> > 		(int) __entry->path_connect ? '*' : ' ',
> > 		__get_str(wname), DAPM_ARROW(__entry->path_dir),
> > 		__get_str(pname), DAPM_ARROW(__entry->path_dir),
> > 		__get_str(pnname))
> > 
> > It appears as if the %c placeholder always produces the three ">c<"
> > characters, the '*' or ' ' char is printed as the first %s, all the
> > other strings are shifted right by one position and the last string is
> > never printed.
> > 
> > On my x86_64 laptop running the default Ubuntu kernel (6.5) I'm able to
> > trace a few events having a '%c' in their TP_printk() macros and the
> > result is:
> > 
> >   intel_pipe_update_start: dev 0000:00:02.0, pipe >c<, frame=1,
> >   scanline=107856, min=2208, max=2154
> >   
> 
> What does /sys/kernel/tracing/trace show?

It is correct:

   intel_pipe_update_start: dev 0000:00:02.0, pipe B, frame=377644, scanline=1466, min=2154, max=2159

> If that's fine, then the bug is in libtraceevent and not the kernel.
> 
> I'm testing it out now, and I see %c not being processed properly by
> libtraceevent. I'll take a deeper look.

Thanks.

> > originating from:
> > 
> >   TP_printk("dev %s, pipe %c, frame=%u, scanline=%u, min=%u, max=%u",
> > 
> > Here it looks like the %c produced ">c<" again, but apparently without
> > any shifting.
> > 
> > Back on the ARM64 board I found a couple interesting clues.
> > 
> > First, using the <debugfs>/tracing/ interface instead of trace-cmd, I'm
> > getting correctly formatted strings:
> > 
> > trace-cmd: snd_soc_dapm_path: >c<* HPOUT_L -> (direct) ->
> > debugfs:   snd_soc_dapm_path: *HPOUT_L <- (direct) <- HPOUT_POP_SOUND_L
> > 
> > Notice the arrows pointing to the opposite direction though. The correct
> > arrow is the one in the debugfs run.

This other issue appears a separate bug however.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

