Return-Path: <linux-kernel+bounces-84468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E50886A724
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0907628408F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF8720329;
	Wed, 28 Feb 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLEvg6Dq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78E1DDF6;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090432; cv=none; b=HO8z9ItWvmonooJWbONsqZ9EiU1rtnK7fK18h46Skjt31+swYKbShkqhfIlPnTifaL4ZmYEyHfbFRqA8ep/QLOmomi9/gH1wDclA5qF2N0o0UE1ST95SiNQ2xrZ9FN9VXSm+MDnLiQMZBRKAqmHN2qQwdx/jf99JzxAaP/uZFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090432; c=relaxed/simple;
	bh=32Xrl8Cj1A/94tqRjyWRZ2bTOcduHcS83VXeg3Snfas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UHinRFjr6bFDFxwIva3sTspIk0vc9Z69pQv+V7NkUMQFpL7db1eL+fbv/i8ss8WEZo8oyZ95cfoFWjkpCl8259Flr9xMcC7AL8aPFrGED0BalYywDrIA85CxssyqvR/4FQrfPhSAmVpNS9CdMaZ1YUzFYUcZCUtjtx22tYHef20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLEvg6Dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B71CCC43394;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709090431;
	bh=32Xrl8Cj1A/94tqRjyWRZ2bTOcduHcS83VXeg3Snfas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qLEvg6Dq+AAwsEe/RKGr66ICa0LcMW30SiXMYNs//FQ0Tay96yGq7nCEG/jomR1AO
	 CKdnuEOqzq/ur8QVpO1HBErXmqzp9MtMdN3D4Aq84tu6IDlhh9NOel6zwIm2OcVM/l
	 +e1wFJUocVDyEIOZtuK528FR+7++RMfWoEOKobSRqgzcWJVuIwtmeBW2MrUNYgYJhV
	 IGkKxj6D1BcOq3t+U8vPr17QnJ8G5WmiomSlettBCLjdUMYaQxESOuckazhbhu22CA
	 euQiTeqHv5WmTdZhiU24GQrBXZ/60NtCluwKkrjfzakh10ZI898JG5eNF7NOFIP7DR
	 Z/izOEabF2d9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 945C8D88FB4;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: lan78xx: fix "softirq work is pending" error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170909043160.27277.10700634687974290743.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 03:20:31 +0000
References: <20240226110820.2113584-1-o.rempel@pengutronix.de>
In-Reply-To: <20240226110820.2113584-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Feb 2024 12:08:20 +0100 you wrote:
> Disable BH around the call to napi_schedule() to avoid following
> error:
> NOHZ tick-stop error: local softirq work is pending, handler #08!!!
> 
> Fixes: ec4c7e12396b ("lan78xx: Introduce NAPI polling support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: lan78xx: fix "softirq work is pending" error
    https://git.kernel.org/netdev/net/c/e3d5d70cb483

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



