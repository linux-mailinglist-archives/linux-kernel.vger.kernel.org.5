Return-Path: <linux-kernel+bounces-58234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543DB84E33F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C23B24021
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACEA7992A;
	Thu,  8 Feb 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKUld+AN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7647AE69;
	Thu,  8 Feb 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402712; cv=none; b=sOhrySPxFZU/rlgtTgMpWxuE+QI3WW1kqS00k2S2Whm5K2LWdMt0kFHuzcpBbbLSqamM1KJLyGWFDaU7jpTCyefoQgYmHyZmi15E/aP7KznA/QUxj5+hKwdImSLDjsDQ9707uqfO0k0iwkP8bPqFTSMyV2/puAKJGPTkhbD7U0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402712; c=relaxed/simple;
	bh=WbU/6xaHRAqlvGDQf/ggBZjd6ChC9s/yYgY8Biwc1p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRd3zn4pNtsePWErRow5pwrgjNH1sV6/RLC/iidT+32YJRDlDmXXJ3Ub8mh7ZkayAnPtmFxOoNhsE6J8uyDVnazOpBCW9LqqgpfpzhlqxgVGy+wMXDlK/HEiLqNx8X1blF2JjkYqhK1KUpRYKLyQlgq2RbaWYsP1RSK5O/ZVmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKUld+AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8CFC43142;
	Thu,  8 Feb 2024 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707402711;
	bh=WbU/6xaHRAqlvGDQf/ggBZjd6ChC9s/yYgY8Biwc1p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKUld+ANKt07Kq6ZF9bQhr8j7CfkA/9T4V3E1TZtf6Hkzzxi+iQOc/TTA9LDisKLH
	 Vu8+kgax90JyO7GES3+jax9GNLqteOMpJCYgSeMsWyMNo6v2RuwuldjXf76eMfz8VF
	 nSsZjUrtxd5x/uvGSLm5fHAJLHyenAWqJkVoRUTQnk2u9kBSsypo1KaDU7NLeTExvI
	 /blMxnzlowhbAHzUZwDAhTd5+a2CDQNF1rFqhB6W+jrI2iZEpg6Ea5srFkFtdgzACy
	 MBi6V+AFbR0IGZ7W4TVISyj/99pLm3d6v0TpDkS2IKuWJqs0m+GftA9Vg6tRwVDIv9
	 8ZS2sIxSLpVOQ==
Date: Thu, 8 Feb 2024 15:31:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208-erwehren-zeitnah-6701d03a905f@brauner>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
 <20240208135344.GD19801@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208135344.GD19801@redhat.com>

On Thu, Feb 08, 2024 at 02:53:45PM +0100, Oleg Nesterov wrote:
> On 02/08, Christian Brauner wrote:
> >
> > On Wed, Feb 07, 2024 at 12:45:49PM +0100, Oleg Nesterov wrote:
> > > +	type = (f.file->f_flags & PIDFD_THREAD) ? PIDTYPE_PID : PIDTYPE_TGID;
> > > +	ret = kill_pid_info_type(sig, &kinfo, pid, type);
> >
> > If the user doesn't provide siginfo then the kernel fills in the info in
> > prepare_kill_siginfo() a few lines above. That sets info->si_code to
> > SI_USER even for the PIDFD_THREAD case. Whenever the info is filled in
> > by the kernel it's not exactly userspace impersonating anything plus we
> > know that what we're sending to is a pidfd by the type of the pidfd. So
> > it feels like we should fill in SI_TKILL here as well?
> 
> Hmm. Agreed, will do, thanks.
> 
> But then I think this needs another preparational 1/2 patch.
> prepare_kill_siginfo() should have a new arg so that do_tkill() could
> use it too.

Agreed.

> 
> (offtopic, but may be the "Only allow sending arbitrary signals to yourself"
>  check in pidfd_send_signal() needs another helper, do_rt_sigqueueinfo()
>  does the same check).

Agreed.

