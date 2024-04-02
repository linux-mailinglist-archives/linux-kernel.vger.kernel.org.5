Return-Path: <linux-kernel+bounces-128825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C70896003
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D037B21CEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E91446B6;
	Tue,  2 Apr 2024 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSr+xnQt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A727224FA;
	Tue,  2 Apr 2024 23:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100068; cv=none; b=HOESzb0VQ+p74EZJIgxuVlZt1hRGGHwU8UI2IaG5i7hOHqnrJG9bSHrYQt71GObe2g50USbdAD7XwUFOhD0zVo01ejfXirbNgiG2j7HDrrdx3TWnAAYIzEnWcTWBy5JoAi02Q7zEjW1gpPksfSLW3WL9uYkU+mm6Ll/Pri+wTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100068; c=relaxed/simple;
	bh=cX+vqzisIaO+Ki2taFXWqjs59rFDcLk4j/9kjaZxcoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgMXQzD16Pb5lFump+19v7VH13cjC7+IjzFzCYmfjwEbgFJDNpcH+m31etulYItefXq3WlOOay5QVts+MrLB3dVFziRIW+NBnhmF5yUOhjAI9eScP29NjD2++vM51zniGtivpQg5HPx72iFgbcxGJprJZokYCzvQrFV8JUKdEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSr+xnQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D811C433C7;
	Tue,  2 Apr 2024 23:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712100067;
	bh=cX+vqzisIaO+Ki2taFXWqjs59rFDcLk4j/9kjaZxcoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mSr+xnQtCqlsnDXqJW+hxekB0mMivwMlYiG2WjLkXZM7jKOcWaxEO81IfBqBShDAD
	 BHi92j4RZeX+ZvmL0lFfK09+Lbo+zkaBvX9zcwmjXw+umzS8iQhZmuKCDXph/DOZV7
	 IWJm+OQbt/FQn2ulp0qZvMyQwxPmhkPXkfAUsCFKA6tB82Ch0VtjSGhR2IEDIrJijs
	 OsdZEHZISeI/v+r9tS/P0OHGWzBJeD7pp/+Eo01IFWEGCWsmrD6eUqV2WT6DIAs3Yx
	 EzsB/KqpfrKXcl4o8HgY8FfNlLbmVYEuVWm12FJ8/felKWiMKAyWRi3fliIO8+z2qe
	 edHU3fl4BlQzQ==
Date: Tue, 2 Apr 2024 16:21:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig
 <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>,
 linux-kernel@vger.kernel.org, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240402162106.11112e99@kernel.org>
In-Reply-To: <20240402224632.GT946323@nvidia.com>
References: <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<20240401123003.GC73174@unreal>
	<20240401075003.70f5cb4b@kernel.org>
	<20240402184554.GQ946323@nvidia.com>
	<20240402143607.0357d71a@kernel.org>
	<20240402224632.GT946323@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 19:46:32 -0300 Jason Gunthorpe wrote:
> On Tue, Apr 02, 2024 at 02:36:07PM -0700, Jakub Kicinski wrote:
> > > FWIW, I've been trying to push RDMA away from driver created sysfs for
> > > a while now. Aside from the API complexity, implementations have
> > > messed up using the sysfs APIs and resulted in some significant
> > > problems :(  
> >
> > Sure, agreed, but off-topic.  
> 
> It is not - I don't want a huge amount of sysfs in drivers to replace
> what fwctl will do for pretty solid technical reasons.
> 
> I do object, as snarky as I was, to you saying RDMA should take on a
> whole bunch of read/write sysfs in drivers that netdev would not
> accept as a "reasonable" direction.

Repeating myself a bit - I'm not saying you should take the sysfs
patches. Just that RDMA configuration belongs in the RDMA subsystem.
I don't want to suggest another solution, because frankly given
our "no direct FW interface exposure" I don't have much experience
maintaining such APIs upstream. It'd be vain of me to make suggestions.
Also I don't want to sound like I'm giving you my "blessing" to do
whatever, since my personal beliefs(?) remain unchanged. But they
carry little weight when netdevs or traffic which ends up in netdev
are not involved.

