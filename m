Return-Path: <linux-kernel+bounces-143508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30918A3A52
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB581C21415
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE54612B95;
	Sat, 13 Apr 2024 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzE/ui3r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C832BE5E;
	Sat, 13 Apr 2024 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973645; cv=none; b=UekZHmG9RC5dJqM3yTC1O0nNbRJKtOS9HBpzxQ6UPqg1to/pkO/2JqoZKaDSvIVO60pjM9vPP+WKHBR1md5RW9N9SifzCTWpaG5fUWrv+NMWQ+Z7Klm8OxM9dSOEC68F13EMinYIsEO1rhIz+dJNV1jRSt/Y4TcuzXloignbgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973645; c=relaxed/simple;
	bh=fEpfFAsM22uGefJGwAikp/WrS8DiFQaDIJcoWgMscpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNQrD7YmntOG/x1L3sfR4K9RQwcgZ+d9KdAyHLJfbXbLI4+Znz1JzhsVNabLMOBFTb8xKEaeieKxpQrcW7XcPZkoVBL5ifqHWAPhlKpk/Y3hCNottezMAAIvHnQrulQBG1pujWh90p5dJ0+MHm6Uz+081U3/oQV6KvhZAVzewT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzE/ui3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E0CC113CC;
	Sat, 13 Apr 2024 02:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712973644;
	bh=fEpfFAsM22uGefJGwAikp/WrS8DiFQaDIJcoWgMscpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NzE/ui3rXrPVKcoc/9f4KbQBr34NyqsCdJRABycaZAwsgE8JdtGNAr6Rp52XCq0B6
	 ABEZpFvRuw68Lc/bMR5/SErDM+11LekFJadCsB/2T5yKSg8aU9vMnTFGpZIuUEqj8W
	 irDC3qLpWH9B976XGtTEH+0deF3qqadKTfe+UxVrKaqmlYVijUUS7SKAuWP/SBt2Vh
	 x3+nL2tFZMw2s7eTYKyl2RwKGjl8mRa57hxQkupZeJIpKgMypLn2rzyjB9JunCIYgR
	 p6GtfBtB/gHoc17tgdBwPGXQ3y9s7SoLpsw15hwyDO7vaRoIkQ43tAijfU/ODUTQts
	 U215jQpKuxQaw==
Date: Fri, 12 Apr 2024 19:00:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Jiri Pirko <jiri@resnulli.us>, <yisen.zhuang@huawei.com>,
 <salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 net-next 4/4] net: hns3: add support to query scc
 version by devlink info
Message-ID: <20240412190043.69c306c5@kernel.org>
In-Reply-To: <5e9abc23-96c8-4a37-abae-f6c208aacda2@huawei.com>
References: <20240410125354.2177067-1-shaojijie@huawei.com>
	<20240410125354.2177067-5-shaojijie@huawei.com>
	<ZhapUja4xXiJe4Q2@nanopsycho>
	<16347737-f0ac-4710-85ee-189abed59d6b@huawei.com>
	<ZheB58bjmkFzIEbG@nanopsycho>
	<5e9abc23-96c8-4a37-abae-f6c208aacda2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 15:12:17 +0800 Jijie Shao wrote:
> >> +   * - ``fw.scc``
> >> +     - running
> >> +     - Used to represent the soft congestion control firmware version.
> >>
> >> scc means "soft congestion control"  
> > I guess this is something specific to your device, isn't it? Can't you
> > please extend the description a bit more?
> >
> SCC is a firmware which provides multiple congestion control algorithms, including dcqcn.
> Congestion control is a mechanism that controls the entry of rdma packets into the network,
> enabling a better use of a shared network infrastructure and avoiding congestive collapse.

Thanks, I'll amend the patch with a condensed version of this info.
Otherwise I feel like we'll need another 3 revisions to polish it..

