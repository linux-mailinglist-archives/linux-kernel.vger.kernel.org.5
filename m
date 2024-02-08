Return-Path: <linux-kernel+bounces-58236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD384E346
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D761D282037
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387379948;
	Thu,  8 Feb 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cehdgtf1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CF76025;
	Thu,  8 Feb 2024 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402831; cv=none; b=fOxGZFrQDHjOnbWt92Uw1XNAmtXnd5wpjLnLH9AWw1NrRKK/zxg/Fx4UUJihkJhKyZzPusufGLmcb5UOPoiBVSW9as1B4nJ0glxjwMUvA+MZICybuiSV2aCOE3NUzpILiXDhknyzxUdLYY3mMEsv75jbHXSyTj9ZBGLeFymGk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402831; c=relaxed/simple;
	bh=imQeAlzmuuCpUlPeugyY3TXa127oRZG/o03+jkL+eI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm4pl8TfFP1r+zCkJNbyE3jNBX9T7ozMLgiPp1q6i/84RcWkOj8097DAwqbX7osYud4iRf0H/xrNfNl5rE+GmCAG2fC3DWcIvhel1BKh9rtJ65vXdp6ScgY/ewJYteaj3k6q47jmZPZiTCxHUoRWMuHkQ9SyMfo72DRWxf/P6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cehdgtf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313C8C433F1;
	Thu,  8 Feb 2024 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707402830;
	bh=imQeAlzmuuCpUlPeugyY3TXa127oRZG/o03+jkL+eI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cehdgtf1f6DVbbYyI8KzEC12Wh0tYzj43aKJ2e4GndjsvgjQWBnWpoOWbbqazA2q3
	 8Yd8DehhPnjtfQY954h12WuZzCclgcOWgjoNALNrqZ9DzVd406ZLGSzEweM+dMSUnd
	 n8RpdMa90YaH4C5Q5QauL8Kev+rJPvTnlj4xsyJ09Ckl3SlyP3sRPHUMnNr7N5czyK
	 GryUeW7xIfyQcDd/o9SczRHxKM1pRiaw5wXTZmxPDmueSGhZfxIYUPtXjoByKUEwhR
	 mljSLFeR9t9GW2fdgq0dBBi8WJ0r4VHXe8b8x1qqdkIbUMbYQgTAYw5fpCXfX94319
	 c90mH8RTOuRRg==
Date: Thu, 8 Feb 2024 15:33:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208-babybett-nachjagen-ed354d2192f8@brauner>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
 <20240208140610.GE19801@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208140610.GE19801@redhat.com>

On Thu, Feb 08, 2024 at 03:06:10PM +0100, Oleg Nesterov wrote:
> On 02/08, Christian Brauner wrote:
> >
> > I would also suggest we update the obsolete comment on top of
> > pidfd_send_signal() along the lines of:
> 
> Yes, but...
> 
> > + * If the @pidfd refers to a thread-group leader the signal is thread-group
> > + * directed. If @pidfd referes to a thread then the signal is thread directed.
> 
> No, this depends on PIDFD_THREAD only.

Sorry, yes, that is what I meant to say but obviously wrote unclearly. I
mean that if pidfd->f_flags & PIDFD_THREAD then it's thread-directed.
That's what I meant by type of pidfd. Not type as in PIDTYPE_PID in
struct pid.

> 
> If it is set then the signal is always "thread directed" even if @pidfd refers
> to a thread-group leader.
> 
> Otherwise the target task must be a group leader and the signal will be
> "thread-group directed".
> 
> Right?

Yes, please feel free to update the comment!

