Return-Path: <linux-kernel+bounces-86101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8F186BF97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8FB1C21C19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B71376EC;
	Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/GF5TEP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D6E2E622;
	Thu, 29 Feb 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178628; cv=none; b=OTKaUqeOwCLt2+0yKCPi93g4VHs1p00M3JlNqYo25mUv/qFrGFrkWsJN8s1CBiZqoI3snA7/dB9b+EX1rbJ63LpgPZfLarxXvgyVItEFFfeLAdagcLhLa+8L1SHC+Zu7zwRMQTvQozgWCNNESD1U+rzxpHaYPJLwTAno3eC16AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178628; c=relaxed/simple;
	bh=x7HCXFc/QCt6bW6Q25nzlitIcya5GwMSMH8LmoGpH2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X2Fj1YHmumYM3GxMgv7HusYD85iotpD4Y3PzS6Q9Z8DF0iTL0zcF5GyK1OEOrRtiR/Jp+30LTG1SpBFLcCuOvCes8pa4xb+AwvA8gpebCpWCp2VrB/4a/G7rLkVVLu6zs5UVLkbKPt7JzdwinvXpRTUIbVT6sHPtj8QTUMX6Tbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/GF5TEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 249F2C43390;
	Thu, 29 Feb 2024 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709178628;
	bh=x7HCXFc/QCt6bW6Q25nzlitIcya5GwMSMH8LmoGpH2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u/GF5TEPUkbHil9/c11Tsw3LhTzIBMeTubvG9Kqy7Jy8qdLlH7nLk7wnrkisQP0Be
	 InNd14zsgbmoTzFi0l4z38sf1lMd/Ln0WE1qvzsUfUKTk6VHILb4dsRnM9meEdHPkc
	 GAVoJ4x9S5t7eGEpZtBKzINeH0r25Jq3Rs85ina6Pr0OJ9Sq8UaB0pUlCBmS+ZhCGp
	 BxQi+VNCNgJd8a1/7sjMlwZyebqZmwaKd0RZclUcncH5wuw5R/+/B6qoABla/voocW
	 5wczIQXe2i+3s4y3M4ElwZPGYz+rcuTcuSdkpUZaI06BBDJcfvmL1AbsN245WEdIHN
	 5xfR3qX8qyIfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B4C5D88FAF;
	Thu, 29 Feb 2024 03:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS
 writing back
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170917862804.28712.16209474962340682302.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 03:50:28 +0000
References: <20240227121128.608110-1-linma@zju.edu.cn>
In-Reply-To: <20240227121128.608110-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org, jiri@resnulli.us,
 lucien.xin@gmail.com, edwin.peer@broadcom.com, amcohen@nvidia.com,
 pctammela@mojatatu.com, liuhangbin@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 20:11:28 +0800 you wrote:
> In the commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
> IFLA_BRIDGE_MODE length"), an adjustment was made to the old loop logic
> in the function `rtnl_bridge_setlink` to enable the loop to also check
> the length of the IFLA_BRIDGE_MODE attribute. However, this adjustment
> removed the `break` statement and led to an error logic of the flags
> writing back at the end of this function.
> 
> [...]

Here is the summary with links:
  - [net,v2] rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back
    https://git.kernel.org/netdev/net/c/743ad091fb46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



