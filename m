Return-Path: <linux-kernel+bounces-138888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D989FBAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB08E1C216F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D316EC18;
	Wed, 10 Apr 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVbAmK+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBA16E871
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763265; cv=none; b=e7iagwR7vJK3UVcIDTOmP6jDP6w1c2Hh/eLfefMYPNjdM7vcMaOIoRvLU5fA78hMmtqHZJZ12utVv3YImS08EJRCmkmfyHT7hCZ8/ZpflBjYPBF+U5APaU+Zn+Jqy3b/vqtJbRrogQFEqvUHu5b+4QAoct6Mo/lPNdsmbQwyzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763265; c=relaxed/simple;
	bh=HnzozCvOS1q27gnKJVvpU7CHZz9gMEPBCAW7+Cc7CVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAwdYxz78MkZxi2hFDM2AsACnc5T6VK8ZLF9FX3C8ued7A3e0pnKiryQKKodgY9DBdnx2HpujHVhWmh9Fd0aIPvYLzEjmWYeP9a5MIibut4ajaypYT084J4uRmuH01/UvfKQGlpo99bhutik/sCxni4dac4zd5zutPv6aTlJs3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVbAmK+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88590C433F1;
	Wed, 10 Apr 2024 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712763265;
	bh=HnzozCvOS1q27gnKJVvpU7CHZz9gMEPBCAW7+Cc7CVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVbAmK+8SUeJoukHHawbCIya8ngLTbHf6Eg59RFqOJ5x5ulWk3u8qtRwZwRJAd+nh
	 GpLmyqE2v9zegDypKQ1HJ83rAh/j+CAsf3CbVAiS2QtmmaFFBK/7CO1cGrgW9F6DrN
	 oPc9Yk/dWpQglCJT9OU9dfkTjIfrcGHwwjo/x1phTjufzt5dkl/zpZQ/Zzaqtcx7Di
	 7JHxqPh3rsy6LSxAjjHdJDjCJfmZwXuYvgwlWp8HUf54Y+TNs8/pnzvMkmcCZPiexG
	 4BE7eDFabQGKPAShg6pUZR23tNxa0Pfd3sNx5uOrmiyGfWjj8gMM/J4ThnUk+etzA5
	 9QY4KWuUWa0KQ==
Date: Wed, 10 Apr 2024 16:34:19 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com,
	yangyicong@hisilicon.com
Subject: Re: [PATCH 1/2] perf: arm_pmu: Only show online CPUs in device's
 "cpus" attribute
Message-ID: <20240410153419.GA25171@willie-the-truck>
References: <20240410095833.63934-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410095833.63934-1-yangyicong@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 10, 2024 at 05:58:32PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> When there're CPUs offline after system booting, perf will failed:
> [root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> This is due to PMU's "cpus" is not updated and still contains offline
> CPUs and perf will try to open perf event on the offlined CPUs.
> 
> Make "cpus" attribute only shows online CPUs and introduced a new
> "supported_cpus" where users can get the range of the CPUs this
> PMU supported monitoring.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/perf/arm_pmu.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Hmm. Is the complexity in the driver really worth it here? CPUs can be
onlined and offlined after the perf_event_open() syscall has been
executed, so this feels like something userspace should be aware of and
handle on a best-effort basis anyway.

Does x86 get away with this because CPU0 is never offlined?

Will

