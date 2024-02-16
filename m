Return-Path: <linux-kernel+bounces-68567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E3F857C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BD1286E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA078B74;
	Fri, 16 Feb 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u29Siem9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C91278B5F;
	Fri, 16 Feb 2024 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086510; cv=none; b=EnImLlfytqRbc5Z+bLi1DQ/Is8YqtlASwxaY+uc3eYKf83n/F37LFs0PMqoDkd5Uf5jmuoS9qiY1WD0K0A1o3nbNu9imFP+7EglMILuqQ4mT4szLQHn3NOrmFeAzuf+Jrc006baDZ3i4Ilw/L6goGY02v1/RFvejFtA7ysKc6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086510; c=relaxed/simple;
	bh=/SEClanMb1zOTsu/SpJJ69zMCA76oCxBh7VA840dNk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYb/kpYxxWA4H9/VUuJskiyPSCWVc8DRirPJ6ohlZe/egOF2PWi/6gl+u/s5pxS40txsFOn0PcwlyhY0eFSBHk+/AfuT5ak05gLgMdoxVGAe7RSYa6LGhP+CkwmCGexnPmBr8atcuNOpFmsd4hTdoig0YSadiBitb7tX1pG2JXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u29Siem9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA9CC433F1;
	Fri, 16 Feb 2024 12:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086509;
	bh=/SEClanMb1zOTsu/SpJJ69zMCA76oCxBh7VA840dNk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u29Siem9VAyc1Dqteg+8FLJoJJeIbdmOtuMnJWghjzE0QtDgNuuiZzZTs3JRv4PCG
	 aB5/TKtX4EBTYHQN+AIBXHFVYrASm863is1GLMFSK2VCda/jrn6ejJQxMPR/JAN9sO
	 zWKGWbxjaR2usvgSQNL3S86IaNNP5x79384QxFhYKnX19XOJ31bkWt1uuRCXrQoLiX
	 ApGiW8uh2zXiGYm2ALdbuO1ymWmmCaeudnd69J3o1Bh7/tSjfiaTk3sxuICYmY+4OG
	 XIP1TisohKO6RGlr0D/Pni1Oki9JT0mIoPardZ/Vm/ofIEnBB+SehIFeamf5oqcZiu
	 kcnnfrNNNWqug==
Date: Fri, 16 Feb 2024 13:28:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240216-albern-aufwiegen-1de327c7dafd@brauner>
References: <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xjc36g5iq2xly2w4"
Content-Disposition: inline
In-Reply-To: <20240214123655.GB16265@redhat.com>


--xjc36g5iq2xly2w4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Feb 14, 2024 at 01:36:56PM +0100, Oleg Nesterov wrote:
> On 02/10, Oleg Nesterov wrote:
> >
> > On 02/10, Christian Brauner wrote:
> > >
> > > +	if (type == PIDFD_SIGNAL_PROCESS_GROUP)
> > > +		ret = kill_pgrp_info(sig, &kinfo, pid);
> >
> > I guess you meant
> >
> > 	if (type == PIDTYPE_PGID)
> >
> > other than that,
> >
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> Yes, but there is another thing I hadn't thought of...
> 
> sys_pidfd_send_signal() does
> 
> 	/* Only allow sending arbitrary signals to yourself. */
> 	ret = -EPERM;
> 	if ((task_pid(current) != pid) &&
> 	    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> 		goto err;
> 
> and I am not sure that task_pid(current) == pid should allow
> the "arbitrary signals" if PIDFD_SIGNAL_PROCESS_GROUP.
> 
> Perhaps
> 
> 	/* Only allow sending arbitrary signals to yourself. */
> 	ret = -EPERM;
> 	if ((task_pid(current) != pid || type == PIDTYPE_PGID) &&
> 	    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)
> 		goto err;

Honestly, we should probably just do:

if (kinfo->si_code != SI_USER)
        goto err

and be done with it. If we get regressions reports about this then it's
easy to fix that up. But I find that unlikely. So why not try to get
away with something much simpler. What do you think?

--xjc36g5iq2xly2w4
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-signal-disallow-non-SI_USER-signals-in-pidfd_send_si.patch"

From 82a0d641e6f0bcf1a81731e06462df6911ecdd4e Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 Feb 2024 13:21:11 +0100
Subject: [PATCH] signal: disallow non-SI_USER signals in pidfd_send_signal()

Oleg pointed out that the following condition:

/* Only allow sending arbitrary signals to yourself. */
ret = -EPERM;
if ((task_pid(current) != pid) &&
    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
        goto err;

doesn't account for PIDFD_SIGNAL_PROCESS_GROUP. He suggested:

/* Only allow sending arbitrary signals to yourself. */
ret = -EPERM;
if ((task_pid(current) != pid || type == PIDTYPE_PGID) &&
    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)
        goto err;

but I think we should just go all the way and error out if userspace
specifies anything else than SI_USER as si_code. It's probably an unused
feature right now anyway and if someone needs it than it's easy to add
back.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240214123655.GB16265@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/signal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index cf6539a6b1cb..92a80e8d6b22 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3954,10 +3954,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		if (unlikely(sig != kinfo.si_signo))
 			goto err;
 
-		/* Only allow sending arbitrary signals to yourself. */
-		ret = -EPERM;
-		if ((task_pid(current) != pid) &&
-		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
+		if (kinfo.si_code != SI_USER)
 			goto err;
 	} else {
 		prepare_kill_siginfo(sig, &kinfo, type);
-- 
2.43.0


--xjc36g5iq2xly2w4--

