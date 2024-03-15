Return-Path: <linux-kernel+bounces-104649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393F687D170
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A37B2358D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB444C77;
	Fri, 15 Mar 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IPjBce2j"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E732BD19;
	Fri, 15 Mar 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521349; cv=none; b=FkV9EJTRXLI5DsXPSLPBfaSqyyfjvh7ergHDpsGtQ+pOINQ3V7VHKdqjyiH1SSPPhK3irliwEK18sGpBZntWXP4OEC5Ro6CCjRvkjScA6kRWm0p97SECvjMd9nd7h+IcVfSPT0XWgyM2XJvuQSOk6/2cgVw0BVJwNbDqEQOpv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521349; c=relaxed/simple;
	bh=JVu7cAl5b1rC/i/YgVwh6jYnMUpMTHputymmAufHTpc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Oxos2QoEqPCXqBfxXheLcPKPSDv/bA38i+32nTFUbzvOz4jlwXjLeUWVhvGR2KMIi0po7RQKGQgHdDcG/iyo6kgYTqfagWziUEz2wj1neRGpDgYMwNTFfNyuHaYvtBZoT+KOdEJGXR5IaRXxCujOi8iI2OkuEvcwopcGRGkYB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IPjBce2j; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18A9A40004;
	Fri, 15 Mar 2024 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710521343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/cMG+oSZ/w8c/DhsYM6dqVrXQGCtz99/u731U0CysXE=;
	b=IPjBce2j7yd+BCxagRlgaiuNADB5TXImYfUpzg7xRdFq0U8io49R1p8QADIEBf1S0LODt2
	/mW3uQQw9mQy0J6jsf2IiTeu0TnZEaquoxsUJcJtSapTHBtM37x6KYU9PfAL7kqsaflS90
	zg4Eb9T1owUMitoNeF6/+0Q8ZVr5l2YB3BwTxh19fgye5DMnW+QOXgqrEMfSNAC1mU7tJY
	tIywh+rOr3bUyfE7O3NdqPIMDLM/7YC1zHSFooGpsAPaxnZTvCsZN7f9NSc73ZP6fC3huP
	iVXxlyzx/BNrq5CLLbgy3pxGr6GEGCEuhdA4cL/g3K0s2ia7MjF7zDKlbcn4VA==
Date: Fri, 15 Mar 2024 17:49:00 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: TP_printk() bug with %c, and more?
Message-ID: <20240315174900.14418f22@booty>
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

Hello Linux tracing maintainers,

I've come across an unexpected behaviour in the kernel tracing
infrastructure that looks like a bug, or maybe two.

Cc-ing ASoC maintainers for as it appeared using ASoC traces, but it
does not look ASoC-specific.

It all started when using this trace-cmd sequence on an ARM64 board
running a mainline 6.8.0-rc7 kernel:

  trace-cmd record -e snd_soc_dapm_path ./my-play
  trace-cmd report

While this produces perfectly valid traces for other asoc events,
the snd_soc_dapm_path produces:

  snd_soc_dapm_path:    >c<* MIC1_EN <- (direct) <-

instead of the expected:

  snd_soc_dapm_path:    *MIC1 <- (direct) <- MIC1_EN

The originating macro is:

	TP_printk("%c%s %s %s %s %s",
		(int) __entry->path_node &&
		(int) __entry->path_connect ? '*' : ' ',
		__get_str(wname), DAPM_ARROW(__entry->path_dir),
		__get_str(pname), DAPM_ARROW(__entry->path_dir),
		__get_str(pnname))

It appears as if the %c placeholder always produces the three ">c<"
characters, the '*' or ' ' char is printed as the first %s, all the
other strings are shifted right by one position and the last string is
never printed.

On my x86_64 laptop running the default Ubuntu kernel (6.5) I'm able to
trace a few events having a '%c' in their TP_printk() macros and the
result is:

  intel_pipe_update_start: dev 0000:00:02.0, pipe >c<, frame=1,
  scanline=107856, min=2208, max=2154

originating from:

  TP_printk("dev %s, pipe %c, frame=%u, scanline=%u, min=%u, max=%u",

Here it looks like the %c produced ">c<" again, but apparently without
any shifting.

Back on the ARM64 board I found a couple interesting clues.

First, using the <debugfs>/tracing/ interface instead of trace-cmd, I'm
getting correctly formatted strings:

trace-cmd: snd_soc_dapm_path: >c<* HPOUT_L -> (direct) ->
debugfs:   snd_soc_dapm_path: *HPOUT_L <- (direct) <- HPOUT_POP_SOUND_L

Notice the arrows pointing to the opposite direction though. The correct
arrow is the one in the debugfs run.

Second, I tried a simple test:

  TP_printk("(%c,%c,%c,%c) [%s,%s,%s,%s]",                                                                                                                                             
            'A',                                                                                                                                                                       
            'B',                                                                                                                                                                       
            'C',                                                                                                                                                                       
            'D',                                                                                                                                                                       
            "Just",                                                                                                                                                                     
            "a",                                                                                                                                                                   
            "stupid",                                                                                                                                                                
            "test")                                                                                                                                                                 

and this logs:

  snd_soc_dapm_path:    (>c<,>c<,>c<,>c<) [A,B,C,D]

so it looks like there really is something wrong with %c in
TP_printk(), and the %c in the format string do not consume any
parameters, de facto shifting them to the right.

As one may expect, avoiding the %c fixes formatting:

-       TP_printk("%c%s %s %s %s %s",
+       TP_printk("%s%s %s %s %s %s",
                (int) __entry->path_node &&
-               (int) __entry->path_connect ? '*' : ' ',
+               (int) __entry->path_connect ? "*" : " ",
                __get_str(wname), DAPM_ARROW(__entry->path_dir),
                __get_str(pname), DAPM_ARROW(__entry->path_dir),
                __get_str(pnname))

With this change, the string formatting is correct both with debugfs and
trace-cmd, but the arrows are still wrong with trace-cmd.

I have no idea how to further debug this and after a quick look at the
macros I can honestly say I'm not feeling brave enough to dig into them
in a late Friday afternoon.

Any hints?
Am I doing anything wrong?
Is %c supposed to work in tracing macros?

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

