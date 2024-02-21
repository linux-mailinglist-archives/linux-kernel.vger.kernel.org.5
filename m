Return-Path: <linux-kernel+bounces-74806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAF85DAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7098B2649B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E17E110;
	Wed, 21 Feb 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt2mz48L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15D7C0AB;
	Wed, 21 Feb 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522512; cv=none; b=Z8Ya05FGcG9HCWfxcKGQxzv3kZvzoAreC/OfaiwCk/669tbShWkpctxqsRe8I9+q5zD7OcqvA0ITZhfFn3A8mYRpb5MbHMjJ50eIyVF2/rVojmEFlK9o0p0JKYLKlpKrlBJrCYl1ttelq1X3IOZRHc2oDgBb7yvIhfTVIig5ZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522512; c=relaxed/simple;
	bh=/FBo0ozbi+S85/NktGeytrIewY4O5ONTH6BoqeYAxEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKctPFgS0R/GgEdQ8M07Z2O29mxE4CuN1thscENYOXAmt/bE+uDotW10NvV+RL5fBcOH+TObsX5L+d+cg4UyuIf+618Rbs4PDqpXdgzSKxfBJ28FkUXER8uarhVn5zGR36rCQLkz04pJ74MosT7FkRiksUs0zQURvqfG+HSoTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt2mz48L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E674DC43390;
	Wed, 21 Feb 2024 13:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522512;
	bh=/FBo0ozbi+S85/NktGeytrIewY4O5ONTH6BoqeYAxEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lt2mz48L0rt0L66CkuuxnJBgz3sOD7V0uVBw+UC/IPOvW+O+L1H7rHkugZ52MNFW/
	 jzoh1IDFm4T/xYbPbUVPpshfXC+UiSEjadWrgRt/3lW3LgtBo3hIoVDQKgseMRKVQp
	 wXuplVJfDMq1ZPob3vQih9HCEFFprNz2rwmdZN1kA+x4Fipb9h4iOQ6Kw89Inf/NLB
	 BgoR/s0LcScg8mZOij4LYDwU9X/3jR2RyAwf5R+sZbpWiGH11bMQCJyvSm0kf7ehRw
	 Wtmh+rLcEkWIftulgV6B86lfdKi6pSk+dOHfdoHEThXMOYu1l+Xdbcg1DfreiFGBNL
	 ScTpgVr8uA7Cg==
Date: Wed, 21 Feb 2024 14:35:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240221-hocken-jagdbeute-695072475027@brauner>
References: <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
 <20240220-einwurf-depesche-d8682be0370c@brauner>
 <20240220090255.GA7783@redhat.com>
 <20240220-pragmatisch-parzelle-8a1d10a94fae@brauner>
 <20240220110012.GB7783@redhat.com>
 <20240220-anlegen-feinmechaniker-3c2cfcc3ec01@brauner>
 <20240220162201.GD7783@redhat.com>
 <20240221-zapfhahn-pulsschlag-e8f9d919c350@brauner>
 <20240221125525.GA16773@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221125525.GA16773@redhat.com>

On Wed, Feb 21, 2024 at 01:55:26PM +0100, Oleg Nesterov wrote:
> On 02/21, Christian Brauner wrote:
> >
> > On Tue, Feb 20, 2024 at 05:22:02PM +0100, Oleg Nesterov wrote:
> > >
> > > > > > +       /* Currently unused. */
> > > > > > +       if (info)
> > > > > > +               return -EINVAL;
> > > > >
> > > > > Well, to me this looks like the unnecessary restriction... And why?
> > > >
> > > > Because right now we aren't sure that it's used
> > >
> > > Yes, but...
> > >
> > > > and we aren't sure what use-cases are there.
> > >
> > > the same use-cases as for rt_sigqueueinfo() ?
> >
> > Specifically for pidfd_send_signal() I mean. To me it seems very
> > unlikely that anyone would be opening a pidfd to itself
> 
> Ah, with this, I do agree. And that is why (I think) we can remove
> the "task_pid(current) != pid" check in the "info != NULL" branch.

Ok, so let's try that. :)

