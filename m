Return-Path: <linux-kernel+bounces-72567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DA885B553
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1151C222B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8F25D46B;
	Tue, 20 Feb 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubspOjZb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD355CDE6;
	Tue, 20 Feb 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418093; cv=none; b=AQS3M2/XfQUyXKMQ4UUYhhQrSLaPCByQ6LkzzCkjFBaHMV0M/zWXpxC/W4EyT99He4uAPWs2dUw9r+nwWte4u8LMw458E3wYyNH2qSmyrz7R6cQBdKntrTrGxm5+6vE1rKO0tIQ7kgS/jxXwTi5ynUYwjgcMiqFSM5Twge4lQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418093; c=relaxed/simple;
	bh=ekyugrnvGjdr5kW4xHy9sxtpj+T8GN9Tmf1QbVkJvwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7d/OrWGoE5CVD8GgU7LLAAIjdXUf0FqkhltKDbwWoOeaSCmHWdjPGCzU1QRn0sUsomGgDzQiGyr0E+dwKU2OZxJId95RRoxtUKo4+c4vPHs2GQ2NW7X0dg7eY4k/7nhl7JsNFiWa0pxl4wiHQC5ZCHdqSTGerSATLtB8LaXjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubspOjZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59755C433F1;
	Tue, 20 Feb 2024 08:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708418093;
	bh=ekyugrnvGjdr5kW4xHy9sxtpj+T8GN9Tmf1QbVkJvwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubspOjZbQnGu1lgLvawYR/iL/NjCHWmfEW62LVEyZEScQwgnVdB3ujquhJpEnqmMF
	 96UBa3qT+dunw7GfoSnrQDjL7mmGVrX739w/XLJYy92L7ku3rrCzBlGDsiAJpa6bE0
	 v6O1akrG6y8phga0urA7FNb0Dm8yIdLONWl7kz9PlUd4uR4g3HhgxpmcADzRRlkEos
	 ub1sglxL6z/Ulns06k9GVezdcp7PUNTUdKRGatdf2l7jFYjGKcDwoTZ49KHBdlDkY9
	 91nxDCvzphzI70JOF0kgQMm1gm5ApdmbgzxgbZaiwz0c4aq9VIS9xeCjMVs1AbINqT
	 umyw+02eH/5tQ==
Date: Tue, 20 Feb 2024 09:34:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240220-einwurf-depesche-d8682be0370c@brauner>
References: <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
 <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216181214.GA10393@redhat.com>

On Fri, Feb 16, 2024 at 07:12:14PM +0100, Oleg Nesterov wrote:
> On 02/16, Christian Brauner wrote:
> >
> > > SI_USER means that the target can trust the values of si_pid/si_uid
> > > in siginfo.
> >
> > Bah, what an annoying nonsense. I see that this can be used to emulate
> > stuff like SI_TIMER and SI_ASYNCIO. But I very much doubt the value of
> > e.g., emulating SI_DETHREAD. Maybe I'm missing something very obvious.
> 
> I don't understand...

My question was what the purpose of being able to to set si_code to
e.g., SI_DETHREAD is and then to send a signal to yourself? Because it
looks like that's what rt_{tg}sigqueueinfo() and pidfd_send_signal()
allows the caller to do. I'm just trying to understand use-cases for
this.

