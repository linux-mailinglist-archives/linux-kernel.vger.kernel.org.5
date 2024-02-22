Return-Path: <linux-kernel+bounces-76103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6F385F2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E80C1C22EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212B324B28;
	Thu, 22 Feb 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4I30x4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E6225AD;
	Thu, 22 Feb 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590628; cv=none; b=HYJ4YFnQ1d73bOyQ2tH64odRc6ptiNUzy/YpkCL28DFwYEpPyrxu4i3mn9wTX3Rkg+JVbQIrXggEvfs5Q8lW8JaPADVFjHomGT8IW4S9+sdh4N+SKrsGCtQmxXYdXKFxOBKsSg272it2x0n4ekCyCkNVf4UrJWAD4D4PHMvz/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590628; c=relaxed/simple;
	bh=nJh4fDgd8eOjnDa4i8G2RcE2n2BJ9Lac/yijA46fRo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eGUWYem6Wh2OK24azTxWDLv8VSPIDH6degvu1aO0xa0I44oyxjUgwqVvwgOiI3K4/jfymOUGz6knCnWhbY0ge84zZ6Rn3g1yRPl9AtV54+f3W42vxYtdkMBVh7AZ+Btn7ym+v1Osn5UlSocrIN4U7QXmyq4iC6hVg2VTwecOH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4I30x4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF35FC43390;
	Thu, 22 Feb 2024 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708590627;
	bh=nJh4fDgd8eOjnDa4i8G2RcE2n2BJ9Lac/yijA46fRo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j4I30x4yNy9cm90i2f807uP3vaF8cK5xAODr5BwKSURTR24UA75wa3xBqYPWQg6Xq
	 v+yTl9M7C5HE4ZGZI+dl/Ev1XtRNPv3wnk3bgaJMI67oJTHnGsO2aBZ9EFkig8mai9
	 2VChAStHmphTF6oOP+s4jqBnZRMShnOvLsn4544tmv7MGt9+NYsNOv1m1xd2Oyfev2
	 bySl1mUMxTNbn0cZYi7Ku+p3wN7GFu6e9ZlTmeAthhv62ktcOXyh2ZIPIXkRSL7ulN
	 BdVLtoJAkBZxWPfsgBGwyGxY47LOoEKH3a7NS1r7PhHfJ4hs6jCGBi2F8UKwdrIqxE
	 F1P6L9/4R2m3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EC70C00446;
	Thu, 22 Feb 2024 08:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 1/2] phonet: take correct lock to peek at the RX queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170859062764.3566.8197659339596370605.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 08:30:27 +0000
References: <20240218081214.4806-1-remi@remlab.net>
In-Reply-To: <20240218081214.4806-1-remi@remlab.net>
To: =?utf-8?q?R=C3=A9mi_Denis-Courmont_=3Cremi=40remlab=2Enet=3E?=@codeaurora.org
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 18 Feb 2024 10:12:13 +0200 you wrote:
> From: Rémi Denis-Courmont <courmisch@gmail.com>
> 
> The receive queue is protected by its embedded spin-lock, not the
> socket lock, so we need the former lock here (and only that one).
> 
> Fixes: 107d0d9b8d9a ("Phonet: Phonet datagram transport protocol")
> Reported-by: Luosili <rootlab@huawei.com>
> Signed-off-by: Rémi Denis-Courmont <courmisch@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,1/2] phonet: take correct lock to peek at the RX queue
    https://git.kernel.org/netdev/net/c/3b2d9bc4d4ac
  - [PATCHv2,2/2] phonet/pep: fix racy skb_queue_empty() use
    https://git.kernel.org/netdev/net/c/7d2a894d7f48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



