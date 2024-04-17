Return-Path: <linux-kernel+bounces-148910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D178A88D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E35B22286
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81734148FE8;
	Wed, 17 Apr 2024 16:27:02 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29C1411E5;
	Wed, 17 Apr 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371222; cv=none; b=aFDKshMZouvXJa7aMbdG1y8dwyyYu7IVEpJYcbz8zFIEflWkaOZxCYs0HZjpFeRk7Bjy/pp9EfGWXqh0bU9iElUxkiJ97YckAINjGcQmcz7XJuOu2hTB/tMxpJXzIC7MsYOixQ0Hyg0Lc1yMbresGiqHQdnw9KkA0m1IyyJkq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371222; c=relaxed/simple;
	bh=Kfk/+PMXTSlj8X88Ks9ci1e34mQJ52fS/4pU0B16Qjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN0r4foFkYFD44lTu0vhWyA4brhMUXjjXABxJTPQDGCYIbefSPcOkNsTMvqYvoXhetoV0nSpWWT6x8Z1KqqL1eSH1qtSUi9/9uYzKka5iLXLb25uBtvjvpKCLY7MDwgdmKRslfKp9k68e6dn00RmRfBII3hxYmWLOY9215TkYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id CB2E6E803A9;
	Wed, 17 Apr 2024 18:26:57 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 51EDF1602F7; Wed, 17 Apr 2024 18:26:57 +0200 (CEST)
Date: Wed, 17 Apr 2024 18:26:57 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <Zh_4UbT0m12EAFc3@gardel-login>
References: <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login>
 <20240409141531.GB21514@lst.de>
 <Zh6J75OrcMY3dAjY@gardel-login>
 <Zh6O5zTBs5JtV4D2@kbusch-mbp>
 <20240417151350.GB2167@lst.de>
 <Zh_vQG9EyVt34p16@gardel-login>
 <20240417155913.GA6447@lst.de>
 <Zh_0bfqBsJFyJKgT@gardel-login>
 <20240417162257.GA8098@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417162257.GA8098@lst.de>

eOn Mi, 17.04.24 18:22, Christoph Hellwig (hch@lst.de) wrote:

> On Wed, Apr 17, 2024 at 06:10:21PM +0200, Lennart Poettering wrote:
> > Well, there are plenty of other block devices with part scanning off,
> > such as DM, including dm-crypt, dm-integrity and so on. And that's
> > certainly stuff we want to cover for this.
>
> But there is no good reason to prohibit scanning for them.  We can't
> scan by default as that would probably break a few expectations in
> userspace, but we can trivially allow manual scanning.

Hmm, so you want to generically allow toggling the flag from
userspace? I mean that'd be fine with me, but it would feel a bit
weird if you let's say have a partition block device, where you'd
toggle this, and then you have two levels of part scanning, and then
you toggle it on one of the part block devices there and so on, and so
on. Could that work at all with the major/minor allocation stuff?

But let's say you add such a user-controlled thing, if you'd add that
I figure you really also need a way to query the current state, right?
which is basically what I originally was looking for...

i.e. it would be really weird if we could set the flag, but not query
it in the first place.

Lennart

--
Lennart Poettering, Berlin

