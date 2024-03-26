Return-Path: <linux-kernel+bounces-118875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A1A88C089
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5749BB2304A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E735754910;
	Tue, 26 Mar 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQV9VlHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537753E2E;
	Tue, 26 Mar 2024 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452178; cv=none; b=GUki9Id+MsnrIzmGIZOTsITPEQkFdoavHJO/lW+z82VKRlPSqJUFhqtV97QHuaT/uhCHS9zSGAFqhu7JJxl19txteui/yIMLTMfvu8mlFLznHv+ht7g/cBBtH4nxcBtbsATsBK3/vaNgMThyXWQndWXa3LdXgBBIyP0u4u77Oac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452178; c=relaxed/simple;
	bh=WawzTENwsYUOrDp5S0K26oozIGFl1jrEA05wmb5QyPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ5Gu+HPDBGAYh9mugiuVQhDJE4PNHL2qJNMhfv7dOEFSS+lQ39PMFT3AeOEJ0DvKoOYGe8w8BgOXY2fkEWQZBRBGE5D7N8dRwjNcxcDWDe9ASRJE2AIuW6bcjzg7QPTb4S4cC237Np5Aks9tKJbDQ4I9r5B4vQTIQsIPr6n+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQV9VlHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0813C433C7;
	Tue, 26 Mar 2024 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452177;
	bh=WawzTENwsYUOrDp5S0K26oozIGFl1jrEA05wmb5QyPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQV9VlHAeTw/8dqGLG3t5wlWDT7oCEKR6rQHIChe3CQ6LIRUNSfi/kYjKD57e9Svf
	 hPhyEFNjnxAgYimBoIU7AA0ikXajsUVs94wa7lMdxMmmwRYUuOlZMbJhh3urVf0JOE
	 NeP1DhKJ1e6FyHjeqG3JaLYzTwast0tJZB5L8gVP9LEcUBbic5Eg391Eklx3G7ZDyo
	 NtopiBh6iLhvqp+0Xr9NC5ya1bI+V2iwe04vDDAUoyPQiTP67ZWKjWhJv48xob34vS
	 4N0mXgJrDn8FTOP77zSmkB1koQ9lqsynAwYoT3owghDZSeMKP//1lZyaw0klQoUJ2a
	 iD+hT0uIHOhbw==
Date: Tue, 26 Mar 2024 11:22:52 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, rkannoth@marvell.com, jiri@resnulli.us,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net 1/3] net: hns3: fix index limit to support all
 queue stats
Message-ID: <20240326112252.GN403975@kernel.org>
References: <20240325124311.1866197-1-shaojijie@huawei.com>
 <20240325124311.1866197-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325124311.1866197-2-shaojijie@huawei.com>

On Mon, Mar 25, 2024 at 08:43:09PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Currently, hns hardware supports more than 512 queues and the index limit
> in hclge_comm_tqps_update_stats is wrong. So this patch removes it.
> 
> Fixes: 287db5c40d15 ("net: hns3: create new set of common tqp stats APIs for PF and VF reuse")
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


