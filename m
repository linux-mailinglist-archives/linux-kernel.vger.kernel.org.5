Return-Path: <linux-kernel+bounces-77683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25608608ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF4F283450
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A8BE68;
	Fri, 23 Feb 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8/txhwq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B45BA30;
	Fri, 23 Feb 2024 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656026; cv=none; b=HLfVWQcyt5YXtIPNQvNQvtiORzqG9dpr+3fEp9E/UBiYXpxv0kLnBxrVADbfmDCfLy2fXXZwRe+wQ9yiid7iTK+xOw4DMYYITrlKSd9M3tV8o9aMPc2OXmZFbczuEeWKNXKcTTqoo0uL5eVc5LN/cJqTBogUH583TrXbfK+4cwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656026; c=relaxed/simple;
	bh=yBCUh43+4cUIlNACBTAQRoEEO/fc10XQnrI/DKRmRfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GHC+jpSLPFceNo1rm5RCf98nEbzeUwqpVwhXB1fnPUzNFg2avkEqJyxpB6YvHBlEAZ9Sxf9jMcCGhahevwtVnqxI8tw09C+gamLXDAg9sYPZqwYFTUg1e+PXORGrfgvve/CxBSp7qRQESgIdaAYDUlCJ5EBgjql7kW5ONg8alsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8/txhwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BBA5C43390;
	Fri, 23 Feb 2024 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708656025;
	bh=yBCUh43+4cUIlNACBTAQRoEEO/fc10XQnrI/DKRmRfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a8/txhwq6pH/TtAUgqDGD56dFdC4AFVcOuZDr15uz9Yfk8WY0nx/b+HZMlgoKC92u
	 9/4PHqzbPpuwEdgMExSZfR+xb8zplHPJTLQUmbvYwYIHDYqQv9yzGuE/Hz/Dhi7ymz
	 nl46PqUtgEJcSaQ9xO9RiuY4Qc9594mOERm+BeMKc785bW8ujDvZQ1Vvf1TMAB3WHM
	 NSUcwNX+g1zTrDz2O5tlNDH8sg380yff18lgnZwGdB7NDCqtY00UVZFepj2H/2G6QE
	 4TZLMj7ZoECCTCVHw8q/OXO57U0xtbRVDEAAYYy7P/HzCNNal5bweY+VZIs8uv6KrL
	 ZDzH9kQZgCBMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33557D84BB8;
	Fri, 23 Feb 2024 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/af_iucv: fix virtual vs physical address confusion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865602520.1785.3573891648084258038.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 02:40:25 +0000
References: <20240215080500.2616848-1-agordeev@linux.ibm.com>
In-Reply-To: <20240215080500.2616848-1-agordeev@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Feb 2024 09:05:00 +0100 you wrote:
> Fix virtual vs physical address confusion. This does not fix a bug
> since virtual and physical address spaces are currently the same.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  net/iucv/af_iucv.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Here is the summary with links:
  - net/af_iucv: fix virtual vs physical address confusion
    https://git.kernel.org/netdev/net-next/c/9eda38dc9150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



