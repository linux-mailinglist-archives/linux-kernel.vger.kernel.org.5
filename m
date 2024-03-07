Return-Path: <linux-kernel+bounces-95383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46C874D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A071F24212
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CC3128386;
	Thu,  7 Mar 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWzhpeWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79BE86AC5;
	Thu,  7 Mar 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809829; cv=none; b=knDj8PJpBACrAXbmZ2h/K/23DBCWa2p2yCWAVMuN9vMtQ9MGIU5jtnSUfGUdFh+VxYVetf8NSmmurTq/iFXkGtJ2TY1ySqCCVHZFUHB9f1bQkyIUjazcs7ECXerGSeHdnCDcFqqge0OxApnhPgUWMOW3PXMwM/+Qh10DmLAL1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809829; c=relaxed/simple;
	bh=3C9xoeam283PUe/HcVMxnUvsIgDvsXGE4yT2Hi7mErE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bqe2CyawOHNRGE6Af0N+7O6lLjMRTp+od+QzyrVFYVkCBvciDHN7Otjj9Ory3PvpLnYcg8Xto9ShO/H41snxGj1+IRS+LjJA++bm3SwrzQO0ChkFFi63CRtOtpUzr2JpgikUYxFO2CGtpOrHdbyU73rbIUm2QtUw1TCxo+GsL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWzhpeWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D457C43390;
	Thu,  7 Mar 2024 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709809829;
	bh=3C9xoeam283PUe/HcVMxnUvsIgDvsXGE4yT2Hi7mErE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JWzhpeWrJ3Oq7K/XOVqrBYc74eaIDnWL9kVQtW2a/R+oT6TGsKCmPTGswCjXwG/Lm
	 XobEZSKyHjy7iYSDgx25TrgSsw6S7tzLuA9YyhU929n/B7zstXqPYYif9o8hGB5wZO
	 F08A+sHK586TETtOwgHfCl2Fpu4+l7FwTgxcuq7JscReDd93DuSyg0L9WsqFVlMEBD
	 xiMHqBuTFOcfn2nU/rHPyn4d8LaupQRwxC1kWMsPlzzIbvXKR2+eX+wDHYcyY0gMyP
	 j4y/LsuZzCCjtxkfAEA7IuJR9FL05v9mn10I8Yl4ba7mKJHXfwqfIGBpCFvAU8Ax2T
	 JiQUgf/pFWziw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 447DBD84BD7;
	Thu,  7 Mar 2024 11:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V3] net: pds_core: Fix possible double free in error
 handling path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170980982927.5477.544521045314815654.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 11:10:29 +0000
References: <20240306105714.20597-1-hyperlyzcs@gmail.com>
In-Reply-To: <20240306105714.20597-1-hyperlyzcs@gmail.com>
To: Yongzhi Liu <hyperlyzcs@gmail.com>
Cc: pabeni@redhat.com, shannon.nelson@amd.com, brett.creeley@amd.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jitxie@tencent.com,
 huntazhang@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  6 Mar 2024 18:57:14 +0800 you wrote:
> When auxiliary_device_add() returns error and then calls
> auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
> calls kfree(padev) to free memory. We shouldn't call kfree(padev)
> again in the error handling path.
> 
> Fix this by cleaning up the redundant kfree() and putting
> the error handling back to where the errors happened.
> 
> [...]

Here is the summary with links:
  - [net,V3] net: pds_core: Fix possible double free in error handling path
    https://git.kernel.org/netdev/net/c/ba18deddd6d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



