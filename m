Return-Path: <linux-kernel+bounces-86153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B086C085
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7450E1C22121
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2343BBFA;
	Thu, 29 Feb 2024 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NxHYq+NN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2390C3E46B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709186706; cv=none; b=SPdEp4eOFX6BSOowlSG7uHZilEp3SC1ou35U67nSzQNTw7FY5biBderkhg+HNitjDhkAIPwe20N4R4Qxy3RyD/mM/N8pKzPIur1X28AHhLp284gLBxpBaxrqNb87gBYPyq9Z/COUIAnzepQdhonVtaFpNpme3/samvSfG85XVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709186706; c=relaxed/simple;
	bh=EjH2NC3zEjhzbW1ez6ZFtRVVeQ4Ai1TXy79No3Io1G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ/luwzTOpXyofnVUSDJUc72sEwtgD2HOuRd1p0TJ81LSWrH3saumLF6z9FiTGEaqeeoDzPL2ZtgkGGYo9VnWhR8qqRypxzvJIlvXNnoa1Xf6fFHUFjdS4Nt8jankuIutGG8IXcvnDzLfLQo9pwTzlHtGK5UpRMjDkIYolAVoiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NxHYq+NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28846C433F1;
	Thu, 29 Feb 2024 06:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709186705;
	bh=EjH2NC3zEjhzbW1ez6ZFtRVVeQ4Ai1TXy79No3Io1G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxHYq+NNgqwqinADtTPn3iT6Tsc0FY6SaKTBjMRUYHSNP6eyhcoLoDPoEV1HWfrrF
	 bIib9KfISfDK8b0jp0aZF+VDWuUMMivcHd9ZBv1leBir75FtmLyv+xOQ7FgtZkipyJ
	 vBFhFN/2ry790lEo0a960hrUag9ogVuAx0BJ5SUY=
Date: Thu, 29 Feb 2024 07:05:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	cve@kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Message-ID: <2024022918-deepen-composed-c680@gregkh>
References: <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap>
 <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap>
 <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
 <2024022129-expiring-resurface-146c@gregkh>
 <288132ea-87cf-4b56-908e-2263b6c6b67f@redhat.com>
 <2024022236-stock-wielder-fcbc@gregkh>
 <7be9ad00-1432-4a19-a954-32fa0f24fecd@redhat.com>
 <2024022949-uncapped-crushing-e5f9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022949-uncapped-crushing-e5f9@gregkh>

On Thu, Feb 29, 2024 at 06:32:03AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 22, 2024 at 02:31:06PM +0100, Paolo Bonzini wrote:
> > So if the reply-to points to LKML + the subsystem mailing
> > list for the maintainers + a new ML for the security folks (and these three
> > are also CC'd on the announcements, at least the last two), that would be
> > nice to have.  I can work on patches to vulns.git, for example to integrate
> > with get_maintainer.pl, if you ack the idea.
> 
> That might be a bit noisy, for some commits, but sure, I can see the
> value in being notified about a CVE for my subsystem.  If you have a
> specific 'get_maintainer.pl' command line invocation you think would be
> good, I can easily add it to the scripts.

Would:
	--no-keywords --no-git --no-git-fallback --norolestats --nol

be a good pattern to follow?

thanks,

greg k-h

