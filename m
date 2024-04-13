Return-Path: <linux-kernel+bounces-143573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127518A3AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B965285C01
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D11C69D;
	Sat, 13 Apr 2024 04:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FzCAOtmk"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5A1B964
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 04:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712981739; cv=none; b=KVWW0Qs4xaN38hbQzFrPV4oC9u5RDJ9+1tX1E4Q3Erq+5zXTbzxbeEjamdIS5QHtLe4MR1emU4DnBiDI+1Zzaw4manBfwIGlcXUQZWpbvVcF0GrBMwX5Zftlb2wIZ07H6GHtsftRegnYjyjBjyXAFkHv6cT1p3kB3+7RiSP3pKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712981739; c=relaxed/simple;
	bh=2j9ShjLfSgpt1dRoNoPWk+SPK9pwF6GyYMHgJkLP354=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv82hNGHZc8sPbnzCKGr9eg1HyKCxqFGEzJAwaSlj/USAtsD3WV35swAbHyGjx+uvJ/cOa3j6fCt8zols1enzbmXeM7zELJBs6tPXOokrdPNT3UxHYOJjgXY7FJQjHW4n7CLuRB168kilfftov12iw1PUaizafv2th3OUztwqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FzCAOtmk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L8fKgzAxuXRxYh8g7LfILxb7Rk2jCjze6hOtopuCmrs=; b=FzCAOtmkGaE1V42QVhtfTNNNlv
	XWhLtGKHlChkI+X7K2IBnUBZRCj1QQo1+hD1ZzsXANwAA3HX9LXXTo3m6w/V+/WsupB4a11tsAvOJ
	/dG/QKK6qoE/qjKWXTTQ7QhXgI9MdiZVkadG3gi+cY/suKTWVbDHTtifOfpw4BvrnXfcpKux0lmwo
	MOkYdPbtOJH6ZFuO0Ds4xYmOnsxsL27rgk5d9VIxDPOHYviHEvkNNe2STWTYlVyYJbot4ji8eWQxo
	zy+HUoWKPIYL7VjJdZKWvOn7vGZnKorfWdL3qFP9IeGRZgxpw86YLLUVMN/emUTMAhSZAH+84Mu5L
	yLMROmBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rvUne-00BYVm-0r;
	Sat, 13 Apr 2024 04:15:34 +0000
Date: Sat, 13 Apr 2024 05:15:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET RFC 0/437] Kill off old fops ->read() and ->write()
Message-ID: <20240413041534.GO2118490@ZenIV>
References: <20240411153126.16201-1-axboe@kernel.dk>
 <20240412042910.GK2118490@ZenIV>
 <b6725c23-ad82-4082-9e72-b219fc2b453e@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6725c23-ad82-4082-9e72-b219fc2b453e@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 12, 2024 at 07:58:13AM -0600, Jens Axboe wrote:

> I'm aware of some drivers that do different things from write vs writev,
> or read vs readv for instance. But those I did cater to, by having a
> flag they can now check.
> 
> Can you be a bit more specific on an example of a driver that does the
> above?

Consider e.g. your #39.  Current mainline: 1 call of ->set() for each
segment passed to writev() on any of those.  With your patch: call
segments concatenated and if the concatenation looks like a number,
a single call of ->set().

If nothing else, it's a user-visible ABI change.  And in cases when ->set()
has non-trivial side effects, it just might break a real-world code that
is currently correct.

I picked that one because I didn't want to dig through the drivers -
I'm pretty sure that there's more to be found there.

It's not just "write() and writev() parse the data in different way" - we do
have a couple of those, but that's a minor problem.

"write(fd, buf, len1); write(fd, buf + len1, len1 + len2); is not the same
thing as write(fd, buf, len1 + len2)" is not rare for character devices and
for regular files on procfs/debugfs/etc.

For any of those you need to use you vfs_write_iter() helper or you'll
be breaking userland ABI.  The cost of audit of several thousands of ->write()
(and ->read() - similar problem applies there) instances, checking that property
is the main reason this conversion hadn't been already done.

