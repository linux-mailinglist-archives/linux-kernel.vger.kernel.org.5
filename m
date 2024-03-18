Return-Path: <linux-kernel+bounces-106323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841687EC60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375711C21227
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA06524D1;
	Mon, 18 Mar 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lt1eQ3SK"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526252F6E;
	Mon, 18 Mar 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776595; cv=none; b=c0tVBXGkYxUhAXIC3FvbbltAR/bv0GZ+HZ7yVdV+n7WwScECT3vGnaCDA/RBg3s2G5w7nLpSWb/sq/s8xnQffSdrrLzOTOcqDCu5ezjCtpS6ktECkxb7x3rPuvtBBDHVqSinp9J8olgxlpG4zqkQQDZLvVwxBG0i1+qweb0v/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776595; c=relaxed/simple;
	bh=Qetuu7QvjFE3ZIUojcFrdrQ9Bdi9l5k1YSxbe3gJmp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvtdR/x293AMocO6VE1zvusDD/ZLyJrg16Hy3WKH9gfXyYsHUZHWF4LfDq2i2RJ1HVlS0+HmFFKAoX+Fmsdc2taI5iQNyRlfdZt+LIfZKCWJV0jDUEFEQCSY+arGLy+VKzJIV0Pc0oImdilqOMHLRmeZgjE3fbHpcJOtYvSgU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lt1eQ3SK; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56D952000C;
	Mon, 18 Mar 2024 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710776590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mxAe+yGWRvy3BCYdAAdo65TTkSj8GHWewIWNE5JYWE=;
	b=lt1eQ3SK5h5uJgjuD95f392E57bLU53C66j6tYQAK+sMUQCSCvnJFQqZ8LoL9HFNbW1c/+
	BzoHZixnKd0LpHw8hPQdqt9gAe9yVX5YcJAm/C/MuDQsDS7GaOLOo03A8WMvVjUf4fB27H
	dZirWuI6X1LNbK6SISCJ1UHapdTjtwWa4eScA+JyTUdUQpvyAIctuNUE/FB/TsKU0haFfG
	IX4Wxne0JTRebKS/grsltG54LKS/brLbRC+sUV+iDxCL/mDu/b+pJOs7xHl9aLbu9O03eK
	5ZTiAP/ya0zOAjORP0JSJw61yOiHkxlKo1jtPsiuXXK/irgVsPd8kYsZGvYnfA==
Date: Mon, 18 Mar 2024 16:43:07 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: TP_printk() bug with %c, and more?
Message-ID: <20240318164307.53c5595f@booty>
In-Reply-To: <20240315145852.46125ac5@gandalf.local.home>
References: <20240315174900.14418f22@booty>
	<20240315132146.29edf416@gandalf.local.home>
	<20240315190312.2bd6a198@booty>
	<20240315145852.46125ac5@gandalf.local.home>
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

On Fri, 15 Mar 2024 14:58:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 15 Mar 2024 19:03:12 +0100
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> 
> > > > 
> > > > I've come across an unexpected behaviour in the kernel tracing
> > > > infrastructure that looks like a bug, or maybe two.
> > > > 
> > > > Cc-ing ASoC maintainers for as it appeared using ASoC traces, but it
> > > > does not look ASoC-specific.
> > > > 
> > > > It all started when using this trace-cmd sequence on an ARM64 board
> > > > running a mainline 6.8.0-rc7 kernel:
> > > > 
> > > >   trace-cmd record -e snd_soc_dapm_path ./my-play
> > > >   trace-cmd report
> > > > 
> > > > While this produces perfectly valid traces for other asoc events,
> > > > the snd_soc_dapm_path produces:
> > > > 
> > > >   snd_soc_dapm_path:    >c<* MIC1_EN <- (direct) <-
> > > > 
> > > > instead of the expected:
> > > > 
> > > >   snd_soc_dapm_path:    *MIC1 <- (direct) <- MIC1_EN
> > > > 
> > > > The originating macro is:
> > > > 
> > > > 	TP_printk("%c%s %s %s %s %s",
> > > > 		(int) __entry->path_node &&
> > > > 		(int) __entry->path_connect ? '*' : ' ',
> > > > 		__get_str(wname), DAPM_ARROW(__entry->path_dir),
> > > > 		__get_str(pname), DAPM_ARROW(__entry->path_dir),
> > > > 		__get_str(pnname))
> > > > 
> > > > It appears as if the %c placeholder always produces the three ">c<"
> > > > characters, the '*' or ' ' char is printed as the first %s, all the
> > > > other strings are shifted right by one position and the last string is
> > > > never printed.
> > > > 
> > > > On my x86_64 laptop running the default Ubuntu kernel (6.5) I'm able to
> > > > trace a few events having a '%c' in their TP_printk() macros and the
> > > > result is:
> > > > 
> > > >   intel_pipe_update_start: dev 0000:00:02.0, pipe >c<, frame=1,
> > > >   scanline=107856, min=2208, max=2154
> > > >       
> > > 
> > > What does /sys/kernel/tracing/trace show?    
> > 
> > It is correct:
> > 
> >    intel_pipe_update_start: dev 0000:00:02.0, pipe B, frame=377644, scanline=1466, min=2154, max=2159
> >   
> > > If that's fine, then the bug is in libtraceevent and not the kernel.
> > > 
> > > I'm testing it out now, and I see %c not being processed properly by
> > > libtraceevent. I'll take a deeper look.    
> > 
> > Thanks.
> >   
> > > > originating from:
> > > > 
> > > >   TP_printk("dev %s, pipe %c, frame=%u, scanline=%u, min=%u, max=%u",
> > > > 
> > > > Here it looks like the %c produced ">c<" again, but apparently without
> > > > any shifting.
> > > > 
> > > > Back on the ARM64 board I found a couple interesting clues.
> > > > 
> > > > First, using the <debugfs>/tracing/ interface instead of trace-cmd, I'm
> > > > getting correctly formatted strings:
> > > > 
> > > > trace-cmd: snd_soc_dapm_path: >c<* HPOUT_L -> (direct) ->
> > > > debugfs:   snd_soc_dapm_path: *HPOUT_L <- (direct) <- HPOUT_POP_SOUND_L
> > > > 
> > > > Notice the arrows pointing to the opposite direction though. The correct
> > > > arrow is the one in the debugfs run.    
> > 
> > This other issue appears a separate bug however.  
> 
> Can you make user you have the latest libtraceevent from:
> 
>    git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
> 
> And apply this patch.
> 
> Thanks,
> 
> -- Steve
> 
> diff --git a/src/event-parse.c b/src/event-parse.c
> index d607556..61b0966 100644
> --- a/src/event-parse.c
> +++ b/src/event-parse.c
> @@ -3732,8 +3732,19 @@ process_arg_token(struct tep_event *event, struct tep_print_arg *arg,
>  		arg->atom.atom = atom;
>  		break;
>  
> -	case TEP_EVENT_DQUOTE:
>  	case TEP_EVENT_SQUOTE:
> +		arg->type = TEP_PRINT_ATOM;
> +		/* Make characters into numbers */
> +		if (asprintf(&arg->atom.atom, "%d", token[0]) < 0) {
> +			free_token(token);
> +			*tok = NULL;
> +			arg->atom.atom = NULL;
> +			return TEP_EVENT_ERROR;
> +		}
> +		free_token(token);
> +		type = read_token_item(event->tep, &token);
> +		break;
> +	case TEP_EVENT_DQUOTE:
>  		arg->type = TEP_PRINT_ATOM;
>  		arg->atom.atom = token;
>  		type = read_token_item(event->tep, &token);

Indeed I was on an older version, apologies.

I upgraded both libtraceevent and trace-cmd to master and applied your
patch, now the %c is formatted correctly.

However the arrows are still reversed.

Is this what you were expecting?

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

