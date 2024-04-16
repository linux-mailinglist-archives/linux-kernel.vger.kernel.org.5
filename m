Return-Path: <linux-kernel+bounces-146243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E78A62A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27DAB20B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB8D381C4;
	Tue, 16 Apr 2024 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2q4r1pm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57E12E4A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243269; cv=none; b=ZFBS7PX7OiRx9HJQkMDdif34/zIMx0R4vw6dES/VaoYoUa681tjp/saJShncykmA5q0jPkRiBOyBAw3kFwu2hfJgM+9/ZuWmj6nnwNG8hKtzrJ6Zffx5zQkR+iFYVuoRv1fVHJZOnPp5YuG8n6nyfkhzStIqdrun71sst9Dr7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243269; c=relaxed/simple;
	bh=4mVUVKHx9nj8ZHZlaWZQT0qownR6pzR8jt+FmiNQdqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD3KJ50Cn1BIDfw2NUi7ac0HkSH4i3Td3sCy4na2RSEGC9uD0tor/cHy2mBniaunBgCipDwZoopc4+7u31SjYJwDewHcPJ7trLSt6D89s2hZ2ujhUr2UrWg6IzoAoulwz9om2VvWhBMIZlUP0de+88KZKCcpE1tXjnjvc/4vb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2q4r1pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F3FC113CE;
	Tue, 16 Apr 2024 04:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713243268;
	bh=4mVUVKHx9nj8ZHZlaWZQT0qownR6pzR8jt+FmiNQdqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2q4r1pmu9VPBzRvK/6mDyTN5QQimtClS+cP4iELVIe6Y4myQPCgMFjgVMiZld322
	 2Tow4i5UBsZlahkQCJW33cFjHq9zK4S2v9ag+per8mcSrlM3evXSofCP+ROR8gXR4R
	 c6PbZwKUZgDQlkW4+YsnfDlrCFK95OV835/UR1XA=
Date: Tue, 16 Apr 2024 06:54:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhu Wang <wangzhu9@huawei.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	airlied@linux.ie, daniel@ffwll.ch, qingqing.zhuo@amd.com,
	stylon.wang@amd.com, Josip.Pavic@amd.com, trix@redhat.com,
	cruise.hung@amd.com, Eric.Yang2@amd.com, mario.limonciello@amd.com,
	alvin.lee2@amd.com, jun.lei@amd.com, austin.zheng@amd.com,
	sunglee@amd.com, paul.hsieh@amd.com, hanghong.ma@amd.com,
	JinZe.Xu@amd.com, lewis.huang@amd.com, zhengzengkai@huawei.com,
	alex.hung@amd.com, syed.hassan@amd.com, wayne.lin@amd.com,
	nicholas.kazlauskas@amd.com, chiahsuan.chung@amd.com,
	aurabindo.pillai@amd.com, aric.cyr@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6.6] drm/amd/display: Wake DMCUB before executing GPINT
 commands
Message-ID: <2024041658-imagines-unlatch-a9b6@gregkh>
References: <20240416035240.2450127-1-wangzhu9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416035240.2450127-1-wangzhu9@huawei.com>

On Tue, Apr 16, 2024 at 03:52:40AM +0000, Zhu Wang wrote:
> From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> stable inclusion
> from stable-v6.7.3
> commit 2ef98c6d753a744e333b7e34b9cf687040fba57d
> category: bugfix
> bugzilla: https://gitee.com/src-openeuler/kernel/issues/I9BV4C
> CVE: CVE-2023-52624
> 
> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2ef98c6d753a744e333b7e34b9cf687040fba57d
> 
> --------------------------------
> 
> [ Upstream commit e5ffd1263dd5b44929c676171802e7b6af483f21 ]
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
> This commit comes from following commits:
> 
>  8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")
>  65138eb72e1f ("drm/amd/display: Add DCN35 DMUB")
>  dc01c4b79bfe ("drm/amd/display: Update driver and IPS interop")
>  820c3870c491 ("drm/amd/display: Refactor DMCUB enter/exit idle interface")
>  2ef98c6d753a ("drm/amd/display: Wake DMCUB before executing GPINT commands")

Why are you putting multiple commits together and not just submitting
the individual ones?  And what is this for?

confused,

greg k-h

