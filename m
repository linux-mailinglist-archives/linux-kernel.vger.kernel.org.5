Return-Path: <linux-kernel+bounces-57682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C384DC26
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3870FB24A93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076F6A325;
	Thu,  8 Feb 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKZlkwps"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9846A333;
	Thu,  8 Feb 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382712; cv=none; b=R7Meple7FG9NrWgLQCpaq6rSf/W27/zrciQq3FZkyuX05iCEIfonF6WdLP6a8DoRPh6rQnADHP6IDhg7e8oPS+ZyJUjm5S6Lv2KdwHJhjdkBspYtR9FA4ArAbqNRd4dLGkZNr8V36rIkmo5uJHQQz+zBn1iXHiQ082syhwNsd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382712; c=relaxed/simple;
	bh=o7Dd1XzX/PbrlCBpSnEi0XUsR+ddU0GYVJ90l4RyqbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUVkCwouJyRl9uK0PgXd5FqXkBvUZdAnk3l1QYBHXqZ55p/6Ch91JPSRjpWQBkVrw7lVG9oAs5O/O/K8VGYVeen0nD/bjLmYGXINjygMn3Wd4CPnFcL3dUZxMiKgBb9pNT0m5vZ3T7AlsJfaKY6PEjXZyfzaUQ6AuZw3Fto8yLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKZlkwps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20D5C433C7;
	Thu,  8 Feb 2024 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707382711;
	bh=o7Dd1XzX/PbrlCBpSnEi0XUsR+ddU0GYVJ90l4RyqbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKZlkwpsFO/KUXx5/6e/U/BohcQBijftivhtpzFLbV5RCQ4Ml2x0VsynunZ0gTCql
	 PGzTwvUckISrmSTDzqEpcyVTuvWwsywsTZ1WI3S3uz26LhQuzyucEVy25yM568xnPX
	 Z6Py6C54DILN+Ibb4QJIP4b6OSAqtP8yEBKvcO3XcXBC54upbmTLreWsY9rN6HW4bC
	 VuNVVZtk2TE+QkaL5XVmaTlnXVh7ZYFZ8o12LhBXv/9TiwFMxEP0nyO/odwFgifjIY
	 SXMl/FfaPFO/S/ULpbC+/SKSXOaCkxq65WJykj0QrVIxYi0y763jNwv9uhcEnH2vu/
	 9nLbxxq5JYjEQ==
Date: Thu, 8 Feb 2024 09:58:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Tycho Andersen <tycho@tycho.pizza>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240208-empfinden-annalen-da6c77b0fefb@brauner>
References: <20240131132602.GA23641@redhat.com>
 <202402081434.9e1ded3-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202402081434.9e1ded3-oliver.sang@intel.com>

On Thu, Feb 08, 2024 at 03:54:44PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "last_state.load_disk_fail" on:
> 
> commit: aa9c201b150f15cf12e8df8af531b2c74ae1a8fc ("[PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for pidfd_open()")
> url: https://github.com/intel-lab-lkp/linux/commits/Oleg-Nesterov/pidfd-implement-PIDFD_THREAD-flag-for-pidfd_open/20240131-213408
> base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
> patch link: https://lore.kernel.org/all/20240131132602.GA23641@redhat.com/
> patch subject: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for pidfd_open()
> 
> in testcase: boot
> 
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202402081434.9e1ded3-oliver.sang@intel.com
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240208/202402081434.9e1ded3-oliver.sang@intel.com
> 
> 
> as in dmesg in above link:
> 
> LKP: ttyS0: 1408: can't load the disk /dev/disk/by-id/ata-SanDisk_SDSSDH3250G_182971800454-part1, skip testing...
> 
> we know this should be related with some early issues but we failed to figure
> out. so here also attached parent dmesg as dmesg-e0ee7b583f.xz FYI.

I have a hard time seeing how this would be caused by any of Oleg's
changes. Plus, the merges from the vfs tree linked under "url:" above
are all pretty out of date?

