Return-Path: <linux-kernel+bounces-59158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0284F248
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D494CB29248
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE467752;
	Fri,  9 Feb 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRMPTmg8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773F66B52;
	Fri,  9 Feb 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470772; cv=none; b=dfYTQDy43a15VyXB7zRoOD/olD06WKUJJlREwIk0FhOBvb/U0mxx2ruICbKYeHLvwVh3Th7crbd4q4km7ysnvqAM1tgbNcTUYwAZwGQaD4//h2eak0KWyA3opALJeQ5eHmKwlF6f5Gbl/9Vpbl9ndPFAlRYVER7bPEMnfpIvJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470772; c=relaxed/simple;
	bh=wow+/fFaWTAWDZg9Wj6XbxsJzA3lOJSTAmd/BzzflAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWwTCJ2T6wLWo1zVseDJZrgwKjWBANX6QNyL93ehsvY/bEDYNfEcWRNHJlQWYHjEhRXXVO6T+QSUlK4KbWGdkh8GFQu3aOINIqlqEjCb6izSSlx8TuFXGyYj+7e1WiPcye98P/BNc4Lb/l9+Tdxu09zZ04ojyscR42s/UMAtD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRMPTmg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC15C433C7;
	Fri,  9 Feb 2024 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707470772;
	bh=wow+/fFaWTAWDZg9Wj6XbxsJzA3lOJSTAmd/BzzflAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRMPTmg8hbcMk95Fl/m868g1OIexPw7cT71ZY0hBQz1QU3UoSViUxSbiyyhVmWA/+
	 Jm34qqmt48wNPRMgiPMEG2zgI27QJNksRkbI83L2ZIQ/9jCj3MkL8du4mKrcVOkWN3
	 0Zzh670LXF1FlnqS474qvRTAVZWdrj+A9Ez0VMWXWL3vP1ORwWVZiPYJp8xsty7ema
	 7aVkEiOULvAQmKz1HVFNrTNabo/X4YoYHqckOFygSOh1CVmHIgMFvKFXwjdC77CPPo
	 ZYB1a8dV3VE/xAZKMYA6WE5EAqxZd9wshAEjL5I4q3pk5gJL4rLlplmt7VztTv+7Fc
	 a+/sFDnqQJ1yg==
Date: Fri, 9 Feb 2024 10:26:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Andy Lutomirski <luto@amacapital.net>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240209-postfach-notorisch-f8443677b490@brauner>
References: <20240207114549.GA12697@redhat.com>
 <8734u32co5.fsf@email.froward.int.ebiederm.org>
 <20240208155731.GH19801@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208155731.GH19801@redhat.com>

On Thu, Feb 08, 2024 at 04:57:31PM +0100, Oleg Nesterov wrote:
> On 02/08, Eric W. Biederman wrote:
> >
> > Oleg Nesterov <oleg@redhat.com> writes:
> >
> > > Turn kill_pid_info() into kill_pid_info_type(), this allows to pass any
> > > pid_type to group_send_sig_info(), despite its name it should work fine
> > > even if type = PIDTYPE_PID.
> > >
> > > Change pidfd_send_signal() to use PIDTYPE_PID or PIDTYPE_TGID depending
> > > on PIDFD_THREAD.
> > >
> > > While at it kill another TODO comment in pidfd_show_fdinfo(). As Christian
> > > expains fdinfo reports f_flags, userspace can already detect PIDFD_THREAD.
> > >
> >
> > I have a question here.
> >
> > Why is this based on group_send_sig_info instead of send_sig_info?
> 
> Well. send_sig_info() accepts "struct task_struct *", not "struct pid *",
> it doesn't do check_kill_permission(), and it doesn't handle the possible
> race with mt-exec.
> 
> > In particular I am asking are the intended semantics that the signal is
> > sent to a single thread in a thread group and placed in the per thread
> > queue, or is the signal sent to the entire thread group and placed
> > in the thread group signal queue?
> 
> This depends on PIDFD_THREAD. If it is set then the signal goes to
> the per thread queue.
> 
> > Because honestly right now using group_send_sig_info when
> > the intended target of the signal is not the entire thread
> > group is very confusing when reading your change.
> 
> Agreed, so perhaps it makes sense to rename it later. See

Agreed. The function seems misnamed and incorrectly documented. It just
seems that it's never been used with PIDTYPE_PID but it's perfectly
capable of doing that. So maybe just put a patch on top renaming it to
send_sig_info_type() and remove the old comment. But I can live without
renaming it for now as well.

