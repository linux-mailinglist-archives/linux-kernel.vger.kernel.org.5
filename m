Return-Path: <linux-kernel+bounces-160155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5A8B39EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57F01F214BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9B1149018;
	Fri, 26 Apr 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhN29pCU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F971487F3;
	Fri, 26 Apr 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141573; cv=none; b=HdactwFNjMLY897FsVjwIUktdLNbnAq4gqYPWhqjHeKmDeGoX+T1MsFao8Goudu9nm4uvRrGSvNK/mxhvBuKln8LKuEj7Ziax7nAARh8fCNq6oWumyT7wlZ0bs2rwl8fsgWYKEzQQ+bpRCdqCke19Pizobmq5lp2ga/MwXjqluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141573; c=relaxed/simple;
	bh=BW3IrUhr8k8nMyZu+RxeprUpIoYaLID1II23sjD5TCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIim0+/EpM+RrbGvfDYHpeqDF7zDwxGSeT23MF34wKzJWtswRYbCkm+bsDTCi4lIfVfNljLDqizKWysh8SEaaKSj1ut1WtHRmtqPeKPmUPwHe8OOgoqN3SCpimEmXn9cZ5CO1Q/nGNmy7XFaZQDkNrofFTlN9Nk/i8R6mYYRLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhN29pCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A4FC116B1;
	Fri, 26 Apr 2024 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141572;
	bh=BW3IrUhr8k8nMyZu+RxeprUpIoYaLID1II23sjD5TCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EhN29pCUQqWR3zFZjBMaoWf+GI/B7afbHmyLM95tvtiUDQD6ucj7wHGNJJ/NEvvCG
	 cr1BWnJmUKzmQ5GEqX6O3+n4wAMHfCRZWphUeZgBWwM3P/hwOd3z6te/mselaKonaR
	 AQ0ThL74e4AtKbZFWCQaEbgFj9DLyt1ZeXPGOQbqiThpxdgv+whhGwN+a7rwzH4nvU
	 j0S27sFNqMxx0TDAhhlwxFSn5zYL5e1HYUyzqOyvr+6M+Y5cf1A+x2hUN818HF5ZwR
	 h0H5SmPtOYIpxk1QTSciP6G6uesQYN0VpBM6fEaD2EUnTnCxV35WHEQOZ7qhtvsAIh
	 Y+OO6kNuwNCEA==
Date: Fri, 26 Apr 2024 15:26:07 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 1/7] net: hns3: direct return when receive a
 unknown mailbox message
Message-ID: <20240426142607.GC513047@kernel.org>
References: <20240426100045.1631295-1-shaojijie@huawei.com>
 <20240426100045.1631295-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426100045.1631295-2-shaojijie@huawei.com>

On Fri, Apr 26, 2024 at 06:00:39PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Currently, the driver didn't return when receive a unknown
> mailbox message, and continue checking whether need to
> generate a response. It's unnecessary and may be incorrect.
> 
> Fixes: bb5790b71bad ("net: hns3: refactor mailbox response scheme between PF and VF")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


