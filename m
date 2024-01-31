Return-Path: <linux-kernel+bounces-45744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04FF8434D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4C61C23582
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEEB17729;
	Wed, 31 Jan 2024 04:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BtDk4lvO"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2916435;
	Wed, 31 Jan 2024 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706675334; cv=none; b=kYgF2gqikAL7ZsTLUlOTWnM3VJhpogSDs4RDl4OQqtU26lXSvTCIybGa05sQenAUan9WQVpuGRCu91Sa/UMpUtsDu2DvgOeRjkwWufs/C1RVIlhtf+0nJLxrOIpyZtN1bQg9Qz5GuQbVq12PKLCia0fd7PPYjgTEG8CbItYirwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706675334; c=relaxed/simple;
	bh=q/1BS2OX1oUUGnrX6cy1UM172bA0q2pXg6jeavFp5vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egakzBNAxVt9a5Ojjqri+p7VFHvmFeD8hz/pNfVXSmL0Mlh7dQUQ3ku0JyRwt4c9r1nAaUZxSAPGEuVVqia0MLbNuHtD13f5KSHDQV2WEoGCpXV9VhNISUSrdlqhpL6E9tj04rQrM8eIGw9wcxMA8mZtLrh/+BbAWgSFIa7hXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BtDk4lvO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FDd5RueNwxuOVcrivLNJd26KzEVzpCVpny7vKd/QBaU=; b=BtDk4lvOSpoeLOMPHd+C8AebNZ
	XXgdRSjjDba8hWd1zMjZr9ioiBzks2CMsKoZV1JMHKrcNhAP5u7+7OSWJSMSZ5UApID99gngXJvZv
	fOO+tJ6t5jTRIRHnNat/IaWAu496t+ZLUom0iMxhI9ilQCf+DgGoZWE+tjrlg0IAMw3vKl3dsm7WN
	cHqh25LjLSR/QyQGyMopwas+OEB4LqI0D94AcUMJYH6xIq6CPgzJpiLsOCKAdEq70VUdqw8qT2iN1
	15pWBarvYNtm6IGDD6dSoexPyL81qv7CfkI5hYSmPRc/AfazrDoocVpzUNcX7bjCQJPL+I2kiBuTP
	WGLfC72Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rV2DL-001sLR-1u;
	Wed, 31 Jan 2024 04:28:43 +0000
Date: Wed, 31 Jan 2024 04:28:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate
 function
Message-ID: <20240131042843.GR2087318@ZenIV>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-6-torvalds@linux-foundation.org>
 <20240131011246.GP2087318@ZenIV>
 <CAHk-=wie3VgLatmR4J_VpnyJR-qKppz=gnDfxEa9Gyy-7cH7HQ@mail.gmail.com>
 <20240131024626.GQ2087318@ZenIV>
 <CAHk-=wjyki7XCnUjaBZSobLaNqWSjg39JhaUjrMH67sYxZLmdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyki7XCnUjaBZSobLaNqWSjg39JhaUjrMH67sYxZLmdQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 30, 2024 at 07:39:55PM -0800, Linus Torvalds wrote:

> Why don't we, btw? It would be so much better if we did the
> d_release() from __d_free(). We have all that smarts in fs/dcache.c to
> decide if we need to RCU-delay it or not, and then we don't let
> filesystems use it.

Because we want to give filesystems a chance to do something useful
in it?  Something that might need access to the parent.  Or superblock,
for that matter...  By the time we are past the RCU delay there's
very little left; if you want to look at some per-superblock data,
you would have to do something like putting it into a refcounted
structure, with each dentry holding a counting reference, with obvious
effects...

We could add a separate method just for freeing stuff, but... we already
have 4 of them related to that path (->d_delete(), ->d_prune(), ->d_iput(),
->d_release()) and the things are pretty confusing as it is, without
throwing another one into the mix.

I'll look through the RCU pathwalk fixes (will repost the rebased set in
a couple of days, need to finish the re-audit of that stuff) and see how
much would such a method simplify, but I don't think it would buy us
a lot.

> So I guess the "make low-level filesystems do their own kfree_rcu() is
> what we're doing.
> 
> In this case it's as simple as doing that
> 
> -       kfree(ei);
> +       kfree_rcu(ei, rcu);
> 
> and we'd just make the rcu entry a union with something that isn't
> that 'is_freed' field so that it doesn't take more space.

