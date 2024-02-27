Return-Path: <linux-kernel+bounces-83631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF22869C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5671F275B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6D2511F;
	Tue, 27 Feb 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1hOr4QW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F42032D;
	Tue, 27 Feb 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052029; cv=none; b=tJo7DQJgx2xcnMa0GctEF2Su1Rhl18lCir/tTK+/bMLwcLM/iVmPUUDztSJ4/THDvHa4qIAup/En+NEzODboRul15MeQuy3skkO5HamXACh9huMFMZI0F598NgxUl9tmSbxZfizv6zKdbzKx7H3GKEtnk84ihSOpwut/kUri9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052029; c=relaxed/simple;
	bh=lyJEfgXF40+Zl2Lt0OH31UrkHavvA/lS30Emq/LKxrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OGCqw8esP5X/xlhF87PGk3nlxtzHrDHOqjenP0M5iA7Rt2oNdIBiVkbyCSxoeyxQ9kZTin6G+p5sp57QVG2lR2jjRxP2+1CB6eSoOrLm0brYAALe19spXjhTpVvVJMJQ034+v+pbeojhIg8uUbyYEtLmvQN7VLglZpngUhnChow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1hOr4QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4FB1C43394;
	Tue, 27 Feb 2024 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709052028;
	bh=lyJEfgXF40+Zl2Lt0OH31UrkHavvA/lS30Emq/LKxrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r1hOr4QWlD6HELxjz6BMcjfJ0DZv2eLIv9AxyL167YHDCm1ix1f6HF1tzUpsVG6pa
	 KclvtSy+35RrcGnopBuTZIjPdMh9VBi/bGAfxFvfqEx9782HRsAHdxW3qTrbuyrmWq
	 ByCWuXG9E2HK1M3Ux7zFRlXUZBUDjDS+PJclF3NewBwSblsUDrLd1b9zJWKrxdqGON
	 Tc1TlSQoVzP4bkY2MyKhJuicbqNMgNQgPtg3H0ySqG2MLtCYlXxX5/bvarShQlzaEy
	 eFLQVWzhOdIfTsKT6AOtzncQxwR3ZdCT6Z9/ESYYJQSH9upVo0WeqmNOuYBpyRzU4E
	 pMwRgO6OtAJpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9676ED84BC5;
	Tue, 27 Feb 2024 16:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: fix accessing vnic_info before allocating
 it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170905202861.21868.12725398276813095379.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 16:40:28 +0000
References: <20240226144911.1297336-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240226144911.1297336-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michael.chan@broadcom.com, somnath.kotur@broadcom.com,
 pavan.chebbi@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Feb 2024 15:49:11 +0100 you wrote:
> bnxt_alloc_mem() dereferences ::vnic_info in the variable declaration
> block, but allocates it much later. As a result, the following crash
> happens on my setup:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000090
>  fbcon: Taking over console
>  #PF: supervisor write access in kernel mode
>  #PF: error_code (0x0002) - not-present page
>  PGD 12f382067 P4D 0
>  Oops: 8002 [#1] PREEMPT SMP NOPTI
>  CPU: 47 PID: 2516 Comm: NetworkManager Not tainted 6.8.0-rc5-libeth+ #49
>  Hardware name: Intel Corporation M50CYP2SBSTD/M58CYP2SBSTD, BIOS SE5C620.86B.01.01.0088.2305172341 05/17/2023
>  RIP: 0010:bnxt_alloc_mem+0x1609/0x1910 [bnxt_en]
>  Code: 81 c8 48 83 c8 08 31 c9 e9 d7 fe ff ff c7 44 24 Oc 00 00 00 00 49 89 d5 e9 2d fe ff ff 41 89 c6 e9 88 00 00 00 48 8b 44 24 50 <80> 88 90 00 00 00 Od 8b 43 74 a8 02 75 1e f6 83 14 02 00 00 80 74
>  RSP: 0018:ff3f25580f3432c8 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ff15a5cfc45249e0 RCX: 0000002079777000
>  RDX: ff15a5dfb9767000 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>  R10: ff15a5dfb9777000 R11: ffffff8000000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000020 R15: ff15a5cfce34f540
>  FS:  000007fb9a160500(0000) GS:ff15a5dfbefc0000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CRO: 0000000080050033
>  CR2: 0000000000000090 CR3: 0000000109efc00Z CR4: 0000000000771ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DRZ: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt_en: fix accessing vnic_info before allocating it
    https://git.kernel.org/netdev/net-next/c/c4b04a802d8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



