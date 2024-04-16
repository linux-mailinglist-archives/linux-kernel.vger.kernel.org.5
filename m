Return-Path: <linux-kernel+bounces-147049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770888A6EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344BA284BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D712DD95;
	Tue, 16 Apr 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsMLJDN7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF612DDAE;
	Tue, 16 Apr 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278699; cv=none; b=VICOpnNeJGMctGrfrAfUAw7zn1Zhr+ws5Csd4kdb3HsE9jI8gkMra8q/MlPqAtAfQAKfq4RF0Dy6vmAEdgSVKfzbNBbvaaYsltwe9h/Q01BDDN5F5gLCr4jRSk9Ug6ZZVzfjyOrxF88oeyMGluBGnXiZvY+/Yz7LAuxyV+BNgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278699; c=relaxed/simple;
	bh=RsDtzCi/AC/WSg7s2RwFMDLB7cfQ+Jn7MP8sUhas0/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4L+A9MScEqRSIQKlKDv3TZjk3v4vWi7+flrfNIXn5vt+w68qMbx/3QXRzvCahGapf7ErhkC8UGuA0/NjcW1wtSjaNDrTdu+4eKSyjbv5fNm8JXbSQ9bphCpaN2y6UH9YodB4cD0gjS0RrtEj7TsmIvOD8GT07uECzHannFDsnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsMLJDN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515E5C113CE;
	Tue, 16 Apr 2024 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278698;
	bh=RsDtzCi/AC/WSg7s2RwFMDLB7cfQ+Jn7MP8sUhas0/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsMLJDN7maRAxcb09mjajne7GLFzZEMR7vrx8x6Ba3SC23G8CuNg3qVDsmGfAcJdq
	 Ou/Tf+uCqkBveUDsaf+0s81sEJNMZKvLVqzAn4UiVI2b+Iy53V4uHOq+1lpSBciuhd
	 R6IFI98ogEHxf8bYS6xrdQR+CWah8hja17628/4rZT9tDmEujDm/w1XjTliqeyYmzn
	 yIaTl5QHtKOIULhyFgETY/9tHp9WzR/Qew6aUGQgCJiOD5r3yU0legUw8TCrzkas70
	 J8jlJLkSUVNVGiKbzHs/pomYtn98llYwdOO5D/m9QQUp5bfZJUzRPTRx+rE/whm/SQ
	 iPK6AD3TLzTQg==
Date: Tue, 16 Apr 2024 08:44:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <Zh6O5zTBs5JtV4D2@kbusch-mbp>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login>
 <20240409141531.GB21514@lst.de>
 <Zh6J75OrcMY3dAjY@gardel-login>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6J75OrcMY3dAjY@gardel-login>

On Tue, Apr 16, 2024 at 04:23:43PM +0200, Lennart Poettering wrote:
> On Di, 09.04.24 16:15, Christoph Hellwig (hch@lst.de) wrote:
> 11;rgb:1717/1414/2121
> > On Tue, Apr 09, 2024 at 10:19:09AM +0200, Lennart Poettering wrote:
> > > All I am looking for is a very simple test that returns me a boolean:
> > > is there kernel-level partition scanning enabled on this device or
> > > not.
> >
> > And we can add a trivial sysfs attribute for that.
> >
> > > At this point it's not clear to me if I can write this at all in
> > > a way that works reasonably correctly on any kernel since let's say
> > > 4.15 (which is systemd's "recommended baseline" right now).
> > >
> > > I am really not sure how to salvage this mess at all. AFAICS there's
> > > currently no way to write such a test correctly.
> >
> > You can't.  Maybe that's a lesson to not depend on undocumented internal
> > flags exposed by accident by a weirdo interface.  Just talk to
> > people.
> 
> Undocumented? Internal?
> 
> It's was actually one of the *best* documented kernel *public* APIs I
> ever came across:
> 
>    https://www.kernel.org/doc/html/v5.16/block/capability.html
> 
> So much detail, I love it!
>
> I mean, you did good work here, documented it, with all flags in all
> details. I think that's great work! You should take pride in this, not
> try to deny its existance!

The patch that introduced this was submitted not because the API was
stable; it was committed to encourage developers to update it as it
changed because it is *not* stable. That's not the kind of interface you
want exported for users to rely on, but no one should have to search
commit logs to understand why the doc exists, so I think exporting it
was just a mistake on the kernel side. To say this doc is "good"
misunderstands what it was trying to accomplish, and what it ultimately
created instead: technical debt.

The block interfaces documented in Documetation/ABI/stable/ are reliably
stable, though.

