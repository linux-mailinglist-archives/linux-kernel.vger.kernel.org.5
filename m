Return-Path: <linux-kernel+bounces-31814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52726833506
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD531C20E53
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5FBFC02;
	Sat, 20 Jan 2024 14:34:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84B8BF6;
	Sat, 20 Jan 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705761245; cv=none; b=NiWZQnLNN7Tr825e2sVoFcb1TU9zez+7pBU/lAIOUXV63fHqqUZ4tGOi7LsPcGorjtphjTJ0HqJyoofxXmLepQ78QJe+HkNPoEfl3uVunFUnCjZ2hYl95Sp1QDG+EbAa2NTpNQnKKFGIZtrmuqtVgyVnMlVwb0aAOmOV81eEKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705761245; c=relaxed/simple;
	bh=gVBiF1l1RwHoJevzizAeKdLrJpQJxoi4BCbAk/Wubww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYE/8Uu8G5+LiKfxpozznN++yZAze8Mcf2GhbaiGN8WtkKdMEpK28xtgXBiB3lVZ2m7RM70sZvhjUvd3VZpGlwnpmryPeot0XaDpwpBZ1wP7imtbEnMQF01+BzBV7qzvpmDoUTrRKhAiCxEL+vOwyZNJcsJ5rC7gwHjweKISrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F657C433C7;
	Sat, 20 Jan 2024 14:34:03 +0000 (UTC)
Date: Sat, 20 Jan 2024 09:34:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Philippe Proulx
 <pproulx@efficios.com>
Subject: Re: [PATCH] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240120093401.0274a2e8@rorschach.local.home>
In-Reply-To: <20240120084713.6eb7aa52@rorschach.local.home>
References: <20240118181206.4977da2f@gandalf.local.home>
	<504085e9-bf91-4948-a158-abae5dcb276a@efficios.com>
	<20240119103754.154dc009@gandalf.local.home>
	<cd3f37cc-31ba-4eb4-8d67-852d05570e7b@efficios.com>
	<20240119164252.54ccb654@gandalf.local.home>
	<5d323a65-8a04-4c73-8702-58869982a269@efficios.com>
	<20240120084713.6eb7aa52@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jan 2024 08:47:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > I would also consider reducing code complexity as a worthwhile metric
> > in addition to speed. It makes it easier to extend in the future,
> > easier to understand for reviewers, and subtle bugs are less likely
> > to creep in.  
> 
> Really, it wouldn't make it that much simpler. The addition of the
> cmpxchg() of this patch removed the nasty part of the code.

Now let's look at the difference of the two. You still need to save the
current timestamp in one variable. I have to do it in two, so your
algorithm does have that advantage. I currently have (eliminating the
"always add absolute timestamp" switch):


  w = write;
  before = before_stamp;
again:
  after = write_stamp; (equivalent to your last_tsc)
  ts = rdtsc();
  if (!w)
	delta = 0; // event has same ts as subbuf
  else if (before == after)
	delta = ts - after;
  else {
	delta = 0;
	inject_absolute = true;
  }

  before_stamp = ts;

  if (!try_cmpxchg(&write, w, w + length))
	goto again;

  write_stamp = ts;


Now if I were to updated it to use a delta from the last injected
timestamp, where injecting a timestamp only happens on overflow.

#define TS_BITS 27
#define MAX_DELTA ((1 << TS_BITS) - 1)
#define BITMASK (~MAX_DELTA)

  w = write;
again:
  ts = rdtsc();

  delta = ts & MAX_DELTA;

  if (ts - (write_stamp & BITMASK) > MAX_DELTA)
	inject_absolute = true;

  if (!try_cmpxchg(&write, w, w + length))
	goto again;

  write_stamp = ts;

I admit that it does simplify the code a little, but does it do it
enough to be worth the process of deprecating an ABI with a new one?

-- Steve

