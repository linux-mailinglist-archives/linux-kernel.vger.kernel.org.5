Return-Path: <linux-kernel+bounces-56734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D184CE51
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 150E4B22639
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3C80603;
	Wed,  7 Feb 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LFw9oKbh"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5680055
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320636; cv=none; b=LE09oi4wx0LMWuBJJ3Ny9Nf7Ce3U+Elw7AFvOM3bFkWvjO44PMR9j0bLlDayrkTFDUZP9NE0xzIwX4L8KU3HQdQlUiGXKbAfllUuCnZ5r1uWCRfOG34KpB4L4G7XuyfqJ4xpjzq7AmZFvsPRAsVd5+XDYyhwMcUxcS9ps1QRIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320636; c=relaxed/simple;
	bh=0vxjX47B6ZgpdmiW7EVKqCFH/j69PxaUc08wp4q8im8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMVMRunozFeT6yXW3JSvGGPkvgMTs+BEicRHuTcguu4qA82HC7zm62M/kRER2yJF3IgAhvhu/6MQJmLbqR4Fd1ehD6R26RP3jyuDhR+i7lUSudDokkecg3Da3f3lc1o0T0PXUJo8fp24zkNYjKwJjSy1gSh5ST9Z+RYeCQKwHo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LFw9oKbh; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bfd27f6dc0so492786b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707320634; x=1707925434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fT7OrhiRuIZhNQcmagLUCZ3268l7RImx+viDE+2dBHY=;
        b=LFw9oKbh2lMPICDhaQyxT7pKPlavYRiL/Arlh0g7UTbkmB49L4DnCwYdJbT5m+CHle
         19jOhg/eeC+/hlNcLEpMyGSL8CB1tYivigS0KVsO5Msllav3KxkA2b03joaxYwmto723
         oFigIKI5waEKkAGVZm8OJizZRptX8YVHaLEII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320634; x=1707925434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fT7OrhiRuIZhNQcmagLUCZ3268l7RImx+viDE+2dBHY=;
        b=PFuF4sCeWztpD5i7tw6VkMJIfQtInc29A1kfMznBAP3dN3LysmLVVnIsX5NimEbflo
         6yNvIpyYDe7myNx+ZJNHrEzkmEAU1sG19BS/pBagOt3K28lrLBhKa8CyTRmsrpOn1FNf
         RkLDl0RnCKmZ5dVfG48foIm1AWoZ4hpcanYStLAicYhpaFIXu46/RbuLe5QoGvTdc2+X
         lbvo4wiNLLUZgNYzx6ymcWvbDyHxaohXzNwCW5woqzc82HgpFGH6jokaCWe7Wj71mRJZ
         mzvr4uSv60oFxSJwfnCKMe4i0+E8Z8gedK1ulC4+DPI+A4jvoVPHPZU+sn8b5d0E5Ihd
         +BLw==
X-Gm-Message-State: AOJu0YxO4BS19waY+N44I2bxOLVvzOY1mmQBmTpJDrtbILqR/k+H+iE4
	k7kvn+e5z3rkZ4Ae9pwIzBBf5fVJclNO0D2CvT5tDFR9JGnOaPbB5YVnDSfQM1x1815qAPK30go
	=
X-Google-Smtp-Source: AGHT+IF396kKk0rdy004VVPYDuPYv9DwxzXoOR6Kvm9ziqiHthI/RUMfDBLMi4vfaoIZ2sbm9RevTQ==
X-Received: by 2002:a05:6808:f8b:b0:3bf:ede4:9a57 with SMTP id o11-20020a0568080f8b00b003bfede49a57mr1838228oiw.27.1707320633877;
        Wed, 07 Feb 2024 07:43:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3PuW6ws9JWC7eVxAlbqXnDHKSk0P2YmIzFI97ctOQmNTs+74DKsJKO4wYGBbGfO42/jRaojmBW5kV4n2FT4d0tr8kH7r4aQUxMEmIK9FSpzX0+pIMCA15w2h9wknJ03TotrXxVbFLDDJMb3tAR9UBjBQ1lm3zQBDxElQLAnLBo/q7iMfJqxCY2fmPncMLgWFvGjIAikLYHUGWVzwlMWYm3vHqlpF/gcN/FnIldLYt0SP7xo1Z2wH1mPSDaOXCGzltp29+grXhTvd+rvan/N/uNyiAlByd2IkHMNf8nbgttrAyvF0AHMlcB0xUerECuwe2T0UC7sguw0Id8vwFxFwXiSEbTTEOxQmlnfedeEq8E4MuJEWbwVUt6ROZfmwaV08Ju508ne3sow==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o26-20020a629a1a000000b006e0521c2156sm1834465pfe.173.2024.02.07.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:43:53 -0800 (PST)
Date: Wed, 7 Feb 2024 07:43:52 -0800
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
Message-ID: <202402070740.CFE981A4@keescook>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook>
 <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>

On Wed, Feb 07, 2024 at 10:21:07AM -0500, Paul Moore wrote:
> On Wed, Feb 7, 2024 at 9:24 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sat, Feb 03, 2024 at 07:52:54PM +0900, Tetsuo Handa wrote:
> > > A regression caused by commit 978ffcbf00d8 ("execve: open the executable
> > > file before doing anything else") has been fixed by commit 4759ff71f23e
> > > ("exec: Check __FMODE_EXEC instead of in_execve for LSMs") and commit
> > > 3eab830189d9 ("uselib: remove use of __FMODE_EXEC"). While fixing this
> > > regression, Linus commented that we want to remove current->in_execve flag.
> > >
> > > The current->in_execve flag was introduced by commit f9ce1f1cda8b ("Add
> > > in_execve flag into task_struct.") when TOMOYO LSM was merged, and the
> > > reason was explained in commit f7433243770c ("LSM adapter functions.").
> > >
> > > In short, TOMOYO's design is not compatible with COW credential model
> > > introduced in Linux 2.6.29, and the current->in_execve flag was added for
> > > emulating security_bprm_free() hook which has been removed by introduction
> > > of COW credential model.
> > >
> > > security_task_alloc()/security_task_free() hooks have been removed by
> > > commit f1752eec6145 ("CRED: Detach the credentials from task_struct"),
> > > and these hooks have been revived by commit 1a2a4d06e1e9 ("security:
> > > create task_free security callback") and commit e4e55b47ed9a ("LSM: Revive
> > > security_task_alloc() hook and per "struct task_struct" security blob.").
> > >
> > > But security_bprm_free() hook did not revive until now. Now that Linus
> > > wants TOMOYO to stop carrying state across two independent execve() calls,
> > > and TOMOYO can stop carrying state if a hook for restoring previous state
> > > upon failed execve() call were provided, this patch revives the hook.
> > >
> > > Since security_bprm_committing_creds() and security_bprm_committed_creds()
> > > hooks are called when an execve() request succeeded, we don't need to call
> > > security_bprm_free() hook when an execve() request succeeded. Therefore,
> > > this patch adds security_execve_abort() hook which is called only when an
> > > execve() request failed after successful prepare_bprm_creds() call.
> > >
> > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >
> > This looks good to me.
> >
> > Given this touches execve and is related to the recent execve changes,
> > shall I carry this in the execve tree for testing and send a PR to Linus
> > for it before v6.8 releases?
> >
> > There's already an Ack from Serge, so this seems a reasonable way to go
> > unless Paul would like it done some other way?
> 
> Please hold off on this Kees (see my email from yesterday), I'd prefer
> to take this via the LSM tree and with the immediate regression
> resolved I'd prefer this go in during the upcoming merge window and
> not during the -rcX cycle.  Or am I misunderstanding things about the
> state of Linus' tree currently?

My understanding was that TOMOYO is currently broken in Linus's tree. If
that's true, I'd like to make sure it gets fixed before v6.8 is
released.

If it's working okay, then sure, that's fine to wait. :)

-Kees

-- 
Kees Cook

