Return-Path: <linux-kernel+bounces-66032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5E85559E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A7FB24365
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBE614199C;
	Wed, 14 Feb 2024 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzoSx0WX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6E141991;
	Wed, 14 Feb 2024 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949036; cv=none; b=g9x4txaDjsKXlV9kje+M5wXjEGw+TVALlA9DPFCpHV5e4HtgRw5AzFCVtba2feyzVuam4JFfzubeQ5ZqkNxy4FV8tsbSQhXx4el1H0Crv1YkkV2Q0KCFS/5SDV84tJKM6tIkw542O2a3cVYqDvHNRtft76rPwmEwIKUW1mIfZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949036; c=relaxed/simple;
	bh=onHM2PvWbGKcmgXmhJrMe6QUt13ZR4KnsTU99UtaYr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRBPuScwdjaA0OnPV6cyGDHk+tkR9tMsfeBaDKddGJoAlj8wljGK4FVjE6gVGz7pYHGzJlUobraMuqamLkS7BR8C7d3NHphGsuo3l/jhyZT/5SyTnBxzmMjXcSinMLA4ZsXw2CNG4p0u32rLJGAZ8gmXDgwG4u7AD3PDc3hicX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzoSx0WX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E209C433C7;
	Wed, 14 Feb 2024 22:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707949035;
	bh=onHM2PvWbGKcmgXmhJrMe6QUt13ZR4KnsTU99UtaYr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzoSx0WXTwADo516VwBnLm+6dL0TkG5FZbVOoRBoN6aFO2v6Nt3lIu3HlgM4erQVm
	 i6B8tmWls+vOlZmqjgsx2FZo/IaUd3jlNr/3Dq9grGFirZd+WSd+HebK/LWDSeqxRh
	 7F5FQ59yhfEFL0LjkLD8jK3f8l3Qa86LWj5VJK427zEznrvKnJnMLgpmsiK8uUNKk3
	 IkdpAkSycL/byITmC9nrSim+2kKPMnY83ig6C42NQO9ffgvpckfXFTj6P/2hNoTJ4W
	 MAsBsOewDfJ9uruoF7YONu6PSCEI7j8cuD8EwPoPZL0xEDp/LyuY/dI55kQvC4gzb5
	 Td3DI/aygMSjg==
Date: Wed, 14 Feb 2024 14:17:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 0/3] Remove the XFS mrlock
Message-ID: <20240214221714.GB616564@frogsfrogsfrogs>
References: <20240111212424.3572189-1-willy@infradead.org>
 <Zc05FiqYKgtNHUL7@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc05FiqYKgtNHUL7@casper.infradead.org>

On Wed, Feb 14, 2024 at 10:05:10PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 11, 2024 at 09:24:21PM +0000, Matthew Wilcox (Oracle) wrote:
> > XFS has an mrlock wrapper around the rwsem which adds only the
> > functionality of knowing whether the rwsem is currently held in read
> > or write mode.  Both regular rwsems and rt-rwsems know this, they just
> > don't expose it as an API.  By adding that, we can remove the XFS mrlock
> > as well as improving the debug assertions for the mmap_lock when lockdep
> > is disabled.
> > 
> > I have an ack on the first patch from Peter, so I would like to see this
> > merged through the XFS tree since most of what it touches is XFS.
> 
> What needs to happen to get these picked up to not miss the next merge
> window?

Rebase against xfs-linux for-next, then send Chandan a pull request.

That would have gotten done this morning, only now everything's on hold
again while we wait for the mm maintainers to get around to reviewing
the patches in the xfile diet v3 series:
https://lore.kernel.org/linux-xfs/87frxva65g.fsf@debian-BULLSEYE-live-builder-AMD64/T/#m99f2f7e1fb221c4d7f5a00f249119d570ab70fce

Yes I know you already reviewed all of them (again, thank you!) but
apparently your RVB tag is not good enough for the very high standards
of the kernel community.  In the mean time, the only thing we can do is
wait patiently and hope that one of the maintainers can free up enough
time to take a look.

</sarcasm>

--D

