Return-Path: <linux-kernel+bounces-104706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5195B87D297
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836C01C21C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0F4F20E;
	Fri, 15 Mar 2024 17:19:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094A4C637;
	Fri, 15 Mar 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523174; cv=none; b=iWI3qU+9/JZJUgaTiZVbPAaoicYHgi0Ktjh6JVrcG1mxCnw8m6hGnvporuFs1AXIthCSMwhsSNOUMlyEuaKgRYFW5ZhJEeOucTTFmpPBLmHIOFjJnhrec9+oE/P0FQONu5PtLZlRCUeJNGFFFtOhbr/J9bQXY3yQkKto6ib1v4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523174; c=relaxed/simple;
	bh=CRVeu9fBjqD2aRKqUgc0w7WBeeU30YVOG7/MSWK4HlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQgVlTAfLSEbwdjj7p+qIVe1KpD25FThRPseuUU1VKRqLfeiUN4tc9XCKiNLLm7T/Be3DdkDmXawE1e9p/hLCTHFyYG2FK7mGbQDFvVKZVUy7C7ZuSq7sg1qNMUNuesWGMwbhQVMTh4XEaMucvPZ3MttU3bKTdeijo0teAMRiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93924C43390;
	Fri, 15 Mar 2024 17:19:33 +0000 (UTC)
Date: Fri, 15 Mar 2024 13:21:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: TP_printk() bug with %c, and more?
Message-ID: <20240315132146.29edf416@gandalf.local.home>
In-Reply-To: <20240315174900.14418f22@booty>
References: <20240315174900.14418f22@booty>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Mar 2024 17:49:00 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Hello Linux tracing maintainers,

Hi Luca!

> 
> I've come across an unexpected behaviour in the kernel tracing
> infrastructure that looks like a bug, or maybe two.
> 
> Cc-ing ASoC maintainers for as it appeared using ASoC traces, but it
> does not look ASoC-specific.
> 
> It all started when using this trace-cmd sequence on an ARM64 board
> running a mainline 6.8.0-rc7 kernel:
> 
>   trace-cmd record -e snd_soc_dapm_path ./my-play
>   trace-cmd report
> 
> While this produces perfectly valid traces for other asoc events,
> the snd_soc_dapm_path produces:
> 
>   snd_soc_dapm_path:    >c<* MIC1_EN <- (direct) <-
> 
> instead of the expected:
> 
>   snd_soc_dapm_path:    *MIC1 <- (direct) <- MIC1_EN
> 
> The originating macro is:
> 
> 	TP_printk("%c%s %s %s %s %s",
> 		(int) __entry->path_node &&
> 		(int) __entry->path_connect ? '*' : ' ',
> 		__get_str(wname), DAPM_ARROW(__entry->path_dir),
> 		__get_str(pname), DAPM_ARROW(__entry->path_dir),
> 		__get_str(pnname))
> 
> It appears as if the %c placeholder always produces the three ">c<"
> characters, the '*' or ' ' char is printed as the first %s, all the
> other strings are shifted right by one position and the last string is
> never printed.
> 
> On my x86_64 laptop running the default Ubuntu kernel (6.5) I'm able to
> trace a few events having a '%c' in their TP_printk() macros and the
> result is:
> 
>   intel_pipe_update_start: dev 0000:00:02.0, pipe >c<, frame=1,
>   scanline=107856, min=2208, max=2154
> 

What does /sys/kernel/tracing/trace show?

If that's fine, then the bug is in libtraceevent and not the kernel.

I'm testing it out now, and I see %c not being processed properly by
libtraceevent. I'll take a deeper look.

Thanks for the report.

-- Steve


> originating from:
> 
>   TP_printk("dev %s, pipe %c, frame=%u, scanline=%u, min=%u, max=%u",
> 
> Here it looks like the %c produced ">c<" again, but apparently without
> any shifting.
> 
> Back on the ARM64 board I found a couple interesting clues.
> 
> First, using the <debugfs>/tracing/ interface instead of trace-cmd, I'm
> getting correctly formatted strings:
> 
> trace-cmd: snd_soc_dapm_path: >c<* HPOUT_L -> (direct) ->
> debugfs:   snd_soc_dapm_path: *HPOUT_L <- (direct) <- HPOUT_POP_SOUND_L
> 
> Notice the arrows pointing to the opposite direction though. The correct
> arrow is the one in the debugfs run.
> 
> Second, I tried a simple test:
> 
>   TP_printk("(%c,%c,%c,%c) [%s,%s,%s,%s]",                                                                                                                                             

