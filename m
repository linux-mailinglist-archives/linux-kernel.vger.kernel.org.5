Return-Path: <linux-kernel+bounces-146239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6D8A6291
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E724A285025
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CD83770B;
	Tue, 16 Apr 2024 04:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcXIAjWD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702372E622
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242939; cv=none; b=UwFy9QNSyNA7L3i8YEd8T1Y1d38LV4GAdOczwfqqNCPFTWpCZaqm1NfzrBkr0lO13dEcI+EymxCFgQdaqpBnBejOzS2I24lP4xBk5y5nnPufz+wzL8KFdksVhMCwPU+OIPuQY0bva+btnhx7fqmxzcuPAlfUbASSqhK1Pr134Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242939; c=relaxed/simple;
	bh=zFIazubz9lAZhK0n9voQjFdUXkFSTdqVGc2opJfNIlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W78u5Rg8qvawbTnCAZznedlvUM9Np2l7sUekxKmeXnFFN0dKTjDsa3I1ZxV/MfsRtoEcp2gLa0/XanYqbnZIkpUD5E3nI66Ygu2Qh5pyRKCjNlLwBZdc9LX/0s7mpVn8ib0fDplajWB92xoEIHUERsm/5oJvRom6LV11fk+CsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YcXIAjWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12580C113CE;
	Tue, 16 Apr 2024 04:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713242939;
	bh=zFIazubz9lAZhK0n9voQjFdUXkFSTdqVGc2opJfNIlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcXIAjWD2zpfdoqqsN2r8BNAEA1fCmQpcrJOgojFttpa7Go/szfmanB00V6Yo+8UK
	 PxHshPolYQSGuSecdepA9aDANpskzfe9tIRpUKDK2fIGsSR9wO+MnNJcp+qrwKQ/FR
	 OHPwzQ5c/7WHpPx6AEaIP0iAqHlDICAtAu0OjDk4=
Date: Tue, 16 Apr 2024 06:48:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhu Wang <wangzhu9@huawei.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
	christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
	sanglipeng1@jd.com, sashal@kernel.org, wayne.lin@amd.com,
	joshua@froggi.es, hongao@uniontech.com, cssk@net-c.es,
	nicholas.kazlauskas@amd.com, chiahsuan.chung@amd.com,
	mwen@igalia.com, roman.li@amd.com, aurabindo.pillai@amd.com,
	hansen.dsouza@amd.com, Rodrigo.Siqueira@amd.com,
	konstantin.meskhidze@huawei.com, aric.cyr@amd.com,
	zhangjialin11@huawei.com, jaehyun.chung@amd.com,
	mario.limonciello@amd.com, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5.10] drm/amd/display: Wake DMCUB before executing GPINT
 commands
Message-ID: <2024041633-breath-unfiled-86c1@gregkh>
References: <20240416024347.2446403-1-wangzhu9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416024347.2446403-1-wangzhu9@huawei.com>

On Tue, Apr 16, 2024 at 02:43:47AM +0000, Zhu Wang wrote:
> From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> stable inclusion
> from stable-v6.7.3
> commit 	2ef98c6d753a7 ("drm/amd/display: Wake DMCUB before executing GPINT commands")
> category: bugfix
> bugzilla: https://gitee.com/src-openeuler/kernel/issues/I9BV4C
> CVE: CVE-2023-52624
> 
> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2ef98c6d753a744e333b7e34b9cf687040fba57d
> 
> --------------------------------
> 
> [ Upstream commit e5ffd1263dd5b ("drm/amd/display: Wake DMCUB before executing GPINT commands") ]
> 
> [Why]
> DMCUB can be in idle when we attempt to interface with the HW through
> the GPINT mailbox resulting in a system hang.
> 
> [How]
> Add dc_wake_and_execute_gpint() to wrap the wake, execute, sleep
> sequence.
> 
> If the GPINT executes successfully then DMCUB will be put back into
> sleep after the optional response is returned.
> 
> It functions similar to the inbox command interface.
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
> Acked-by: Wayne Lin <wayne.lin@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> This patch comes from following commits:
> 
>  115c7e7f0501 ("drm/amd/display: Add psr get_state call")
>  1d496907f1c5 ("drm/amd/display: Engage PSR synchronously")
>  34ba432c946d ("drm/amd/display: [FW Promotion] Release 0.0.44")
>  672251b223c1 ("drm/amd/display: [FW Promotion] Release 0.0.40")
>  04f3c88f0955 ("drm/amd/display: Retry getting PSR state if command times out")
>  b30eda8d416c ("drm/amd/display: Add ETW log to dmub_psr_get_state")
>  f59a66c1915e ("drm/amd/display: use do-while-0 for DC_TRACE_LEVEL_MESSAGE()")
>  e97cc04fe0fb ("drm/amd/display: refactor dmub commands into single function")
>  522b9a5d5852 ("drm/amd/display: drain dmub inbox if queue is full")
>  9dce8c2a5f1b ("drm/amd/display: [FW Promotion] Release 0.0.161.0")
>  276641775848 ("drm/amd/display: [FW Promotion] Release 0.0.162.0")
>  8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")
>  65138eb72e1f ("drm/amd/display: Add DCN35 DMUB")
>  dc01c4b79bfe ("drm/amd/display: Update driver and IPS interop")
>  5b7954272ae9 ("drm/amd/display: [FW Promotion] Release 0.0.183.0")
>  da2d16fcdda3 ("drm/amd/display: Fix IPS handshake for idle optimizations")
>  5e8a0d3598b4 ("drm/amd/display: Negate IPS allow and commit bits")
>  820c3870c491 ("drm/amd/display: Refactor DMCUB enter/exit idle interface")
>  2ef98c6d753a ("drm/amd/display: Wake DMCUB before executing GPINT commands")
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

I'm confused, what are we supposed to do with this?

greg k-h

