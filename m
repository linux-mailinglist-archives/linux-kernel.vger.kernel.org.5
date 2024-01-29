Return-Path: <linux-kernel+bounces-42026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19C83FB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA8C2821BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AE20F9;
	Mon, 29 Jan 2024 00:21:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43B2106;
	Mon, 29 Jan 2024 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706487674; cv=none; b=ltA17hoIsOcknDC39fRPFf4uo+T+JbiTt3ttblJe8vGdyg6WRgHZPIxfRrVYU3gyASomeZhl4kLG862J4sNLqUCI1vS/nriBfgazFshBKzA+yJ/9yuqJz2tO8pEKAEGJfhKnRr0L0DjFepGHdzJD+tugV98NvnPspCgzUt/5yqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706487674; c=relaxed/simple;
	bh=rgphQiz0R2K4/aXTeK5mCBYjAqv98lYNgmkV/UD7Lsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAeScGMvYCOpRTq2FFirAGqJIsJvS3gvkPkEE3Vntfia7H2HCoziaNuZt7sXFENc40xinbTk1pIJ37wYfBVMx5sptv3ctgFSVa1hlHdru1M1fuyz9IPDftT+DgSPY0Ajsf7gd0ePn3Tn3kGjl0rnuYbSmoDgdfwlqc/1uyYAmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E57C43390;
	Mon, 29 Jan 2024 00:21:11 +0000 (UTC)
Date: Sun, 28 Jan 2024 19:21:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128192108.6875ecf4@rorschach.local.home>
In-Reply-To: <20240128185943.6920388b@rorschach.local.home>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
	<20240128175111.69f8b973@rorschach.local.home>
	<CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
	<20240128185943.6920388b@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 18:59:43 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> >  - somebody is still using it (you can 'rmdir()' a directory that some
> > other process has as its cwd, for example), which keeps it alive and
> > active anyway  
> 
> Wouldn't it be bad if the dentry hung around after the rmdir. You don't
> want to be able to access files after rmdir has finished.

And thinking about this more, this is one thing that is different with
eventfs than a normal file system. The rmdir in most cases where
directories are deleted in eventfs will fail if there's any open files
within it.

eventfs doesn't itself enforce this, but the users of eventfs do.

-- Steve

