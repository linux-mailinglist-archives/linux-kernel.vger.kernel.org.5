Return-Path: <linux-kernel+bounces-40541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A57983E230
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47E61F26CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C6224CE;
	Fri, 26 Jan 2024 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwzLJvBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1F1CAA1;
	Fri, 26 Jan 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296078; cv=none; b=TVUNCIAOYVYm1WGHuzr2BA/2GHPTIC2SV/i+3DSU/8xm+8De8WoDRYf+Zm3jqrausxI6uoZ61/J0jNHaJcD7G0s6BT/x6BLZzUR2JTg/O9dI7GxJxJmNMkFIz1bPeULbYu0nhyawMBXFKL441ijXSSWRUpTWC4VHSv0qPqC85H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296078; c=relaxed/simple;
	bh=w76WQZwHmCAgG8Z0pclPra2iK4UcbBg/K6jGmHZCnEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUW4DyalskK+o6GpYMUWO5Veau7JdiEhkml0F6OZ1AsLb9TokP1EDzn/xqLFUdR+HiB6AFd55wMKgWPE4Ys9XWy+5HunR1p726enq28BPm5bXMGE6DhpL51DgZZrxhF0zyAXreuVwVHFfIs7Nr7brCI3m7U/u4qtDHfM3/KrwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwzLJvBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF60C433F1;
	Fri, 26 Jan 2024 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706296078;
	bh=w76WQZwHmCAgG8Z0pclPra2iK4UcbBg/K6jGmHZCnEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IwzLJvBczl3h23mDdcH/l2aRInlWzX22xOABe5YWbrm+TbCAV+t2dRCqhjNBo5pEO
	 mPmcBmFJwcZV6IjpyiIREajMgdq2+x2UETlGXIB2+ADvhNvIaURJLo+uNdrWhOFlaH
	 X/wE6UHGGZW0vCohl3uSnipjL/ikRQrzmYExy9hY=
Date: Fri, 26 Jan 2024 11:07:57 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PM: domains: Add helpers for multi PM domains to
 avoid open-coding
Message-ID: <2024012649-unblended-earthen-6e17@gregkh>
References: <20240105160103.183092-1-ulf.hansson@linaro.org>
 <CAPDyKFoGozKrNrAc0vpnNVuKvnorAuN_fg37DU4j0rq=egJ6Hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoGozKrNrAc0vpnNVuKvnorAuN_fg37DU4j0rq=egJ6Hg@mail.gmail.com>

On Fri, Jan 26, 2024 at 05:12:12PM +0100, Ulf Hansson wrote:
> On Fri, 5 Jan 2024 at 17:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Updates in v2:
> >         - Ccing Daniel Baluta and Iuliana Prodan the NXP remoteproc patches to
> >         requests help with testing.
> >         - Fixed NULL pointer bug in patch1, pointed out by Nikunj.
> >         - Added some tested/reviewed-by tags.
> >
> >
> > Attaching/detaching of a device to multiple PM domains has started to become a
> > common operation for many drivers, typically during ->probe() and ->remove().
> > In most cases, this has lead to lots of boilerplate code in the drivers.
> >
> > This series adds a pair of helper functions to manage the attach/detach of a
> > device to its multiple PM domains. Moreover, a couple of drivers have been
> > converted to use the new helpers as a proof of concept.
> >
> > Note 1)
> > The changes in the drivers have only been compile tested, while the helpers
> > have been tested along with a couple of local dummy drivers that I have hacked
> > up to model both genpd providers and genpd consumers.
> >
> > Note 2)
> > I was struggling to make up mind if we should have a separate helper to attach
> > all available power-domains described in DT, rather than providing "NULL" to the
> > dev_pm_domain_attach_list(). I decided not to, but please let me know if you
> > prefer the other option.
> >
> > Note 3)
> > For OPP integration, as a follow up I am striving to make the
> > dev_pm_opp_attach_genpd() redundant. Instead I think we should move towards
> > using dev_pm_opp_set_config()->_opp_set_required_devs(), which would allow us to
> > use the helpers that $subject series is adding.
> >
> > Kind regards
> > Ulf Hansson
> 
> Rafael, Greg, do have any objections to this series or would you be
> okay that I queue this up via my pmdomain tree?

I'll defer to Rafael here.

