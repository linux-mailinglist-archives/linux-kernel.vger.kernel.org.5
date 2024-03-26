Return-Path: <linux-kernel+bounces-118874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D6D88C087
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7730D1C265C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8DDDBC;
	Tue, 26 Mar 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw4J7Cry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C652F67;
	Tue, 26 Mar 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452164; cv=none; b=NdSnnWKK1V5S+ij5R/GopJrEO/aC6V6sPlkKCB1CqBNf4ZR8FC/iieB66YpZ0DuPOKZP15twrOhZTGgl5Jq2vJA8baQ7IbVKq6fu2PKQ/hKCeAdE7XlwOoY5fDrzI3B7buqmyPbvS9kUrGi5pzYXL0CMs0BLEmhvDJBDSsrOVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452164; c=relaxed/simple;
	bh=zqluNaI5eTMbfBTncHbPKfxvIRYojlIJJXj8sffFUiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG8tLLJ5jF62NHOajokLoixX12upaBJdB0kQlFuTae802CjbdZmZvKfODLrUKHV7XWwjCdBJp6JIW/hXqzUXCNoOkaWiaUDnSXyttDh4d0t1JHQvC2g2tMBE5Jby5syH6dazOSY7yPynDTvbYvjKQSdL/N19x9Tgs+5VB+kEI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw4J7Cry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F26C433F1;
	Tue, 26 Mar 2024 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452163;
	bh=zqluNaI5eTMbfBTncHbPKfxvIRYojlIJJXj8sffFUiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yw4J7CrybtAxnxTEfT8uv9KRTXKDVMtNt1HwX6TSWyDJs/6PAcrrHs0boufJfA1Ob
	 Fr6GUZAdT0zl/YaNwjqvbesuwp3VG9koHhmSsWRHkgOX6MM0aD3xKmtda5knLZFINL
	 kPRgtXEmEgWZnDS0YjURXaSRlKZtlBI2l7bDmbGKB7BQj/w6KhV49aNvA1mTNtn82m
	 hmoJDXkpruFt/tawwI4ZIRfIu6o71qqkG2EOSmRgHhxvW2oNucgNLuo8YKbkmuSohy
	 oqk3oBcjZVsEhIyiWSEyhDEP03DTI6CN+V2zOs5T3xrnBKgkSMdpzF34e571Mujosa
	 KIqPWnh0NaNUQ==
Date: Tue, 26 Mar 2024 11:22:38 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, rkannoth@marvell.com, jiri@resnulli.us,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net 2/3] net: hns3: fix kernel crash when devlink
 reload during pf initialization
Message-ID: <20240326112238.GM403975@kernel.org>
References: <20240325124311.1866197-1-shaojijie@huawei.com>
 <20240325124311.1866197-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325124311.1866197-3-shaojijie@huawei.com>

On Mon, Mar 25, 2024 at 08:43:10PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> The devlink reload process will access the hardware resources,
> but the register operation is done before the hardware is initialized.
> So, processing the devlink reload during initialization may lead to kernel
> crash. This patch fixes this by taking devl_lock during initialization.
> 
> Fixes: b741269b2759 ("net: hns3: add support for registering devlink for PF")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


