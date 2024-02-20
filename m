Return-Path: <linux-kernel+bounces-73052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F785BCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADEAB23C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183C6A00E;
	Tue, 20 Feb 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcmqVI2Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD76A033;
	Tue, 20 Feb 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434000; cv=none; b=keCct85V0eCf6jyy8Vb5zsOgF1q8/1ehUpO/w4bOOywhtcjqWtDrwUjQ4MVgO9/zYiwP73lkb4WN/OdCZwohQF34kCa7GWGru4SgIslxBKw9CxTX2b0bvrS+bl0qnSvpAOANkCTPRbHlPD6in3JzqHPZjHVrM5m2WbPIuPPu39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434000; c=relaxed/simple;
	bh=IBk5o7xJyW8kaLTZ375CIHQnrsmKTYRABjkagag9ESM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uR4zT3duGdRVFCqXEVUsK0i+oKNylecYAkb3VzBRYKaTXKypouR4ipUqJpDSZb2+9IM333C6IW2aYqr7KL6BrHc9PaYfSIhkpGiNp6BJJAHgbk3qwDAi3driuG/KEoJ9lElL3v4vnF0HskWSr5Rsq5bQ2qPbazlsl+Qai6I3CZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcmqVI2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AF2C43390;
	Tue, 20 Feb 2024 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708434000;
	bh=IBk5o7xJyW8kaLTZ375CIHQnrsmKTYRABjkagag9ESM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcmqVI2QdmCcWzf7U1Wpkxh8GwuTaDamN/1Zglxq5/rAWaJqYsPu+cigBpP4OumCD
	 XPI1QBf2nRTocQPptphAPtwlr/6egqLnY6zKuS/VML+jyWyGjb2DEUXy0byJh+HnCE
	 mROE4MVEdBSp17VT7Ond28HpDQb+XtNSeEw940abgCRH8OyKmCQgc5M9kNfBoVQDPj
	 uC7yiyyjpBCdbJMwTF4LwjYDnleo7GzebWInp2QZkO5YreHSYPIGe6g1IdH0UHXUhg
	 W+kSBOshBnQpDLRHtKbN4in3agI73jo9MmmogPNty9lO4HUE/ez+sM3XnkbrW8nq+T
	 TXKBFZRXA6v0w==
Date: Tue, 20 Feb 2024 13:59:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240220-anlegen-feinmechaniker-3c2cfcc3ec01@brauner>
References: <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
 <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
 <20240220-einwurf-depesche-d8682be0370c@brauner>
 <20240220090255.GA7783@redhat.com>
 <20240220-pragmatisch-parzelle-8a1d10a94fae@brauner>
 <20240220110012.GB7783@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ovt7oib6ffqntnud"
Content-Disposition: inline
In-Reply-To: <20240220110012.GB7783@redhat.com>


--ovt7oib6ffqntnud
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Feb 20, 2024 at 12:00:12PM +0100, Oleg Nesterov wrote:
> On 02/20, Christian Brauner wrote:
> >
> > On Tue, Feb 20, 2024 at 10:02:56AM +0100, Oleg Nesterov wrote:
> > >
> > > Ah. IIRC criu uses this hack to restore the pending (arbitrary) signals
> > > collected at dump time.
> > >
> > > I was a bit surprise sys_pidfd_send_signal() allows this hack too, I don't
> >
> > I think that we simply mirrored the restrictions in the other system
> > calls.
> >
> > > think that criu uses pidfd at restore time, but I do not know.
> >
> > Hm, I just checked and it doesn't use pidfd_send_signal(). It uses
> > pidfds but only for pid reuse detection for RPC clients.
> 
> But perhaps something else already uses pidfd_send_signal() with info != NULL
> or with info->si_code == SI_USER, we can't know. Please see below.
> 
> > So right now si_code is blocked for >= 0 and for SI_TKILL. If we were to
> > simply ensure that si_code can't be < 0 then this amounts to effectively
> > blocking @info from being filled in by userspace at all. Because 0 is a
> > valid value.
> 
> I'am afraid I misunderstand you again... 0 == SI_USER is not a valid value
> when siginfo != NULL.

Yes, I know. We're on the same page. I would just have preferred to
restrict remulating si_code completely because we don't know whether
that's actually used for pidfd_send_signal(). The point I was trying to
make is that si_code has no value that means "unset" so restricting
si_code further means always rejecting @info when it's passed.

> 
> Perhaps we can kill the "task_pid(current) != pid" check and just return
> EPERM if "kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL", I don't think
> anobody needs pidfd_send_send_signal() to signal yourself. See below.

Yeah.

> 
> > +       /* Currently unused. */
> > +       if (info)
> > +               return -EINVAL;
> 
> Well, to me this looks like the unnecessary restriction... And why?

Because right now we aren't sure that it's used and we aren't sure what
use-cases are there.

> 
> But whatever we do,
> 
> > -               /* Only allow sending arbitrary signals to yourself. */
> > -               ret = -EPERM;
> > -               if ((task_pid(current) != pid) &&
> > -                   (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> > -                       goto err;
> 
> Can I suggest to fix this check in your tree (add type > PIDTYPE_TGID as
> we discussed) first, then do other changes on top?

Yes, absolutely. That was always the plan. See appended patch I put on top.
I put you as author since you did spot this. Let me know if you don't
want that.

--ovt7oib6ffqntnud
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-signal-adjust-si_code-restriction-in-pidfd_send_sign.patch"

From 67a1a77630c00f457a46e1164caf0d32c0edc127 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 20 Feb 2024 13:53:00 +0100
Subject: [PATCH] signal: adjust si_code restriction in pidfd_send_signal()

Since we now allow specifying PIDFD_SEND_PROCESS_GROUP for
pidfd_send_signal() to send signals to process groups we need to adjust
the check restricting si_code emulation by userspace to account for
PIDTYPE_PGID.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240214123655.GB16265@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index cf6539a6b1cb..5f5620c81d3a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3956,7 +3956,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 
 		/* Only allow sending arbitrary signals to yourself. */
 		ret = -EPERM;
-		if ((task_pid(current) != pid) &&
+		if (((task_pid(current) != pid) || type > PIDTYPE_TGID) &&
 		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
 			goto err;
 	} else {
-- 
2.43.0


--ovt7oib6ffqntnud--

