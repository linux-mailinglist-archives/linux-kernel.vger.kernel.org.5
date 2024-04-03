Return-Path: <linux-kernel+bounces-128909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A908961C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE6E28753B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF1D175AB;
	Wed,  3 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q70d+SGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF10DDC9;
	Wed,  3 Apr 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106627; cv=none; b=NyF9otRDjzWo56e5ws9YhP8bh7XHCc1iIyVeFuZHENcaH2vWKxevqXNcn6dK5ZMk2+nUc5oEWIXG/uryOn7tZtuRdkSl5q4DrmzgRQ9W6hgd2qVHyErr9/LYykB7f1C/Haw1p4GeIFWXahz0RrvWsKO8EiOLbQoPcV0D6vpT+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106627; c=relaxed/simple;
	bh=KCnOBi74BlzNl2+FFa0fS0VuyU/hlw2By7Q//n5ToVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E0xNa5xkbqjf3Std/3YrEdjsekvFi21kVuRKSb8xJqTndffCWjfkBOQlb9VT51xRJCR41XU17+1LK/B8jeT3Ehy1gkUlZTmH0VdP9Wrry94VDKcnFIthN7Ox5IRzymmp2W5t9Dke7ictOx6YaVnjaaUu6+jjLoQFx2RaDfNLWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q70d+SGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 404C6C43394;
	Wed,  3 Apr 2024 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712106627;
	bh=KCnOBi74BlzNl2+FFa0fS0VuyU/hlw2By7Q//n5ToVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q70d+SGwrgF7L4DIKYOBolGftr93n7uidNS8QWaYW/OF/ySgsqXAvSK0i7fukXw+u
	 C/W6veJu3bxvkSBCocluJS+Y2u3CxWuAiW9va9Z6AFucsV2N6kcTYNxUyKaGdNmKP8
	 8QUbgTbSsW6GjfeoxyfRu1+Jb32+RU7Pe+rv/LqCmMwUyD/FR7Rh1F7oCuNKlGwr3i
	 Ctpp/n+AcBnowxw29Ul2GcDjD5kPQTf7yZxGpbtAQgsRX6cDbfBY9pCOlGcROUED8j
	 bls7G4KYWqLYFpMrgAiZ4ATxxwNC65DQX8kr7cDWtgSQo//n160NmKRIZsyZKXxFmv
	 mCbleRxyc/AYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DF37D8BD1B;
	Wed,  3 Apr 2024 01:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ax25: fix use-after-free bugs caused by
 ax25_ds_del_timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210662718.30217.1033477175371401576.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:10:27 +0000
References: <20240329015023.9223-1-duoming@zju.edu.cn>
In-Reply-To: <20240329015023.9223-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, jreuter@yaina.de, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 09:50:23 +0800 you wrote:
> When the ax25 device is detaching, the ax25_dev_device_down()
> calls ax25_ds_del_timer() to cleanup the slave_timer. When
> the timer handler is running, the ax25_ds_del_timer() that
> calls del_timer() in it will return directly. As a result,
> the use-after-free bugs could happen, one of the scenarios
> is shown below:
> 
> [...]

Here is the summary with links:
  - [net,v2] ax25: fix use-after-free bugs caused by ax25_ds_del_timer
    https://git.kernel.org/netdev/net/c/fd819ad3ecf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



