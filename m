Return-Path: <linux-kernel+bounces-59295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21384F4A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609FD1C23853
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C052D602;
	Fri,  9 Feb 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZrXbYaz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5A28DD7;
	Fri,  9 Feb 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478198; cv=none; b=OS7zgS9cqbdj0Mq4wqXIFrNDvewA8lz+thxidiYZfae/Yo16G9TTo1f9qiPvX8iUN1tNRXFUyS1hYxBLgN6WnpOUQmq4v5S3/norxs6JGDGv+Ar3ZVEmb2sYgOwlAJM8pX49aKXjsY2VUAneamoZsxDvf4I7e6iBvY5Qk8EzN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478198; c=relaxed/simple;
	bh=4kesE2UZVWgqQnVNur9ckzyrrvDHgb90Gl447oWUgAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8ga4UreSAH6oduQHnJLBW4yHob32mzqIlUXyIlywu9MyHQQ/h/lpyeoO/ocDNYwH88KYKPoF5GvnCay3b32HZsMh41oGCaLMUMaSg1LKBIHcwkOp+3eIrVxzl3xzTnaxhTgsaohajHVFBepQHUkpDeO+m/WeQa76/jpahO3IKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZrXbYaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C845C433C7;
	Fri,  9 Feb 2024 11:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707478198;
	bh=4kesE2UZVWgqQnVNur9ckzyrrvDHgb90Gl447oWUgAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZrXbYaz1EW1deF2dUsdAdyKsNqy+25LMpVMb34NuAIQGXuCHBTw24vEnMoDcq+m8
	 jwIHZYRMkLTKNeLB73KKeNlVyDsp+4gZFUSg5tWChQbF+zhS6tv/FOne57e2t8cJ4d
	 7ALBf4W7nC9fIb0WjO0Bw4N4PHSISQj8IuNnuX76xT2MR55yqkp//oruZJ+ppmuc5m
	 viGrzPEmjUL5Fd/uPkDaa1aHnH0fGggzV4apjLAUVugsFW4ECzMRVX3n0YWwBzFYEl
	 DcRtjCJ+jFhSPDvyKQAoPpdXKYniATgI8ftrT6NgAsKsDf5/77wHrJxbE/ecD66BxR
	 nBL73CxgHXX4w==
Date: Fri, 9 Feb 2024 12:29:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240209-festmachen-gekreische-7616d41f6e43@brauner>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
 <20240208135344.GD19801@redhat.com>
 <20240208143407.GF19801@redhat.com>
 <20240209102816.GA3282@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209102816.GA3282@redhat.com>

On Fri, Feb 09, 2024 at 11:28:17AM +0100, Oleg Nesterov wrote:
> On 02/08, Oleg Nesterov wrote:
> >
> > Is prepare_kill_siginfo() correct when we send a signal to the child
> > pid namespace? si_pid = task_tgid_vnr(current) doesn't look right
> 
> Yes, but iiuc send_signal_locked() should fixup si_pid/si_uid, so it
> is not buggy.

It must've been. Yesterday I realized that otherwise kill(2) would have
been broken for a long time. I think this was originally fixed in commit
6588c1e3ff01 ("signals: SI_USER: Masquerade si_pid when crossing pid ns
boundary").

