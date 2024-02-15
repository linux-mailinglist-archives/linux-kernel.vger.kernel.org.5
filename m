Return-Path: <linux-kernel+bounces-67249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F48568A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFB6290485
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D391339B2;
	Thu, 15 Feb 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIivHZOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A8133993;
	Thu, 15 Feb 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012831; cv=none; b=CwF9s6hpq5AtyXnEPkGwCm4dEUacgWz3MX3WxDsR8qha1W2eF2V861TLhur9fcMbSK+JKYLRr+7Fw0olBHIEwterqq3ZeDNqz2FQK5KaJ/c8MTP+mzXlMFv/9JPzqZ8zZVlkP+3OSo47pFFbYTeNOQzUXeU7fZT1zPFQ7GhU4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012831; c=relaxed/simple;
	bh=BXkarRnrP9ql3/F0jVVEdEj9rG4J9sjU6VHcSMrN6BE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J/xcx0WbpHsSzJVWzds6Tar4pKAVoVOqSy7KVEWHJjQwgyY/1uG+7wDf35vkZJL1SUo/a4NGPbKnGsOl7itf1/Id4KDPpevtQPh81IgagWtkC1OEnDwEEvBUIB9uJPCZ1Dk+buCZ6IWhFhhUAMSBt6weGAEawUH74l43Tzkq+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIivHZOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0880FC43390;
	Thu, 15 Feb 2024 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708012831;
	bh=BXkarRnrP9ql3/F0jVVEdEj9rG4J9sjU6VHcSMrN6BE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VIivHZOk6jxdd577mnEbjH+58sxhG9ymrK6rOXBZW7kMRtFsHr0HGn/MJSwbhY8VD
	 E7AGjJJYShMFTUg13RLTln51ujBsl65c0aBFV2CbM+DydYXevhMaH+xnUwhT1NnekG
	 rrFb8fEmd2EtM1XGhC1ncxwzY6NjxFyyrpxBYoggCIyvKFLUxvpAeNbGh5Gh0oeSH6
	 cnKhHlyts4JZMJfbXXZjz/Eip2+jp7lCgohtWNC9uQkbZOoisTNoE/+A/LiMtLX0X8
	 HQGF1yjK2m+0MP7+UYzr0UoW9KXDV0U2zyyXxNCS4K7vy1SoP1qhlPc9kGRwnB1Rz7
	 5JHW71X5h7/SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E50ACD8C978;
	Thu, 15 Feb 2024 16:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pppoe: Fix memory leak in pppoe_sendmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170801283093.9967.12597229007790214662.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 16:00:30 +0000
References: <20240214085814.3894917-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240214085814.3894917-1-Ilia.Gavrilov@infotecs.ru>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: mostrows@earthlink.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Feb 2024 09:01:50 +0000 you wrote:
> syzbot reports a memory leak in pppoe_sendmsg [1].
> 
> The problem is in the pppoe_recvmsg() function that handles errors
> in the wrong order. For the skb_recv_datagram() function, check
> the pointer to skb for NULL first, and then check the 'error' variable,
> because the skb_recv_datagram() function can set 'error'
> to -EAGAIN in a loop but return a correct pointer to socket buffer
> after a number of attempts, though 'error' remains set to -EAGAIN.
> 
> [...]

Here is the summary with links:
  - [net] pppoe: Fix memory leak in pppoe_sendmsg()
    https://git.kernel.org/netdev/net/c/dc34ebd5c018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



