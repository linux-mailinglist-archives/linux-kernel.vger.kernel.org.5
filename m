Return-Path: <linux-kernel+bounces-56330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 145F984C8CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5ADB239B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87317BCF;
	Wed,  7 Feb 2024 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OWSjFK/X"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B34214281;
	Wed,  7 Feb 2024 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302369; cv=none; b=jk0gk3nqncFKb895/BKAKOhv5OWHADFWOBUCzUd1t6JjLZTN5g5+EUH2HnGSpsiPk/0dooYolxBjfMscwALjE7cNHjvWuq/DfdHPYpDqPbgAHobgmm3qLGoQNLYXAAh9R6kAbFTXcI9Cab1ylthX6u8gWM9RlfiJxoyXBkVMIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302369; c=relaxed/simple;
	bh=JoEyE+MfjTvyZcsiLGlm3U7JAnN2n6Yzc654NE4ZF38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7qcVVzouS7EjOx76ckjFCubWPvzRHUUkYhe3UaTzYx5h564kAFBDW0CqH6GjcOUEeX3iktUgQDwQT8iMT3QxYd6XS75VjFImNRu6qGZX9vnO4i6s6RV6Lkx69Vq6duYFzHySII6wJpyq64tksORr8qxivT1508m+n+ltzKeOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OWSjFK/X; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HWAwF2YdOQMEfTUHZf37BFCb5r8J7CTQWb/66Vahoho=; b=OWSjFK/XyCTaih7CRpbZkN5x8y
	TFUtUVOkD4C21QQK7uStobCqlkfBQqgxjZJpmnEu7qBXDYCgcHJQ1eSfBDSx9le4Vf/LAzz5B3OEy
	VUtfHraWAG+oTIL9XEil9VjXORDxUVwAZioUZXYutEeURetJk+FRY6lIJFqRvlAcqeo5Dug99e87H
	wA5Cx7ss3r1lG4MCGQqtDa4kBGW/cH3HFCWVtjqDKFHLlXeewCv6RZ1MPPVU2RZHwX9OyXAjgVtdF
	5CFxcz8++gxS/rS6K5xvRqeNCp8AJBBGnIcrMoctgyN7G7OrOX3+ou8TnCbYQtQUN/X6t/xHRS2of
	gjxowczw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1rXfKn-00D8bo-QO; Wed, 07 Feb 2024 10:39:18 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id E68E6BE2EE8; Wed,  7 Feb 2024 11:39:09 +0100 (CET)
Date: Wed, 7 Feb 2024 11:39:09 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Valentin Kleibel <valentin@vrvis.at>, Jordan Rife <jrife@google.com>,
	David Teigland <teigland@redhat.com>,
	Alexander Aring <aahringo@redhat.com>
Cc: 1063338@bugs.debian.org, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Subject: [regression 6.1.67] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
Message-ID: <ZcNdzZVPD76uSbps@eldamar.lan>
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
X-Debian-User: carnil

Hi Valentin, hi all

[This is about a regression reported in Debian for 6.1.67]

On Tue, Feb 06, 2024 at 01:00:11PM +0100, Valentin Kleibel wrote:
> Package: linux-image-amd64
> Version: 6.1.76+1
> Source: linux
> Source-Version: 6.1.76+1
> Severity: important
> Control: notfound -1 6.6.15-2
> 
> Dear Maintainers,
> 
> We discovered a bug affecting dlm that prevents any tcp communications by
> dlm when booted with debian kernel 6.1.76-1.
> 
> Dlm startup works (corosync-cpgtool shows the dlm:controld group with all
> expected nodes) but as soon as we try to add a lockspace dmesg shows:
> ```
> dlm: Using TCP for communications
> dlm: cannot start dlm midcomms -97
> ```
> 
> It seems that commit "dlm: use kernel_connect() and kernel_bind()"
> (e9cdebbe) was merged to 6.1.
> 
> Checking the code it seems that the changed function dlm_tcp_listen_bind()
> fails with exit code 97 (EAFNOSUPPORT)
> It is called from
> 
> dlm/lockspace.c: threads_start() -> dlm_midcomms_start()
> dlm/midcomms.c: dlm_midcomms_start() -> dlm_lowcomms_start()
> dlm/lowcomms.c: dlm_lowcomms_start() -> dlm_listen_for_all() ->
> dlm_proto_ops->listen_bind() = dlm_tcp_listen_bind()
> 
> The error code is returned all the way to threads_start() where the error
> message is emmitted.
> 
> Booting with the unsigned kernel from testing (6.6.15-2), which also
> contains this commit, works without issues.
> 
> I'm not sure what additional changes are required to get this working or if
> rolling back this change is an option.
> 
> We'd be happy to test patches that might fix this issue.

Thanks for your report. So we have a 6.1.76 specific regression for
the backport of e9cdebbe23f1 ("dlm: use kernel_connect() and
kernel_bind()") .

Let's loop in the upstream regression list for tracking and people
involved for the subsystem to see if the issue can be identified. As
it is working for 6.6.15 which includes the commit backport as well it
might be very well that a prerequisite is missing.

# annotate regression with 6.1.y specific commit
#regzbot ^introduced e11dea8f503341507018b60906c4a9e7332f3663
#regzbot link: https://bugs.debian.org/1063338

Any ideas?

Regards,
Salvatore

