Return-Path: <linux-kernel+bounces-96833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78B8761FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBCD1C20B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF555C27;
	Fri,  8 Mar 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6NG8FI0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7954775;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893834; cv=none; b=m2F0sJPJoylIJQo0j0Dc0zU1kqt/LgS1uc7oKzRch9zs4HvQiUOBpocLwmQb3Eq56KF4Jv4tMNtrNY+F+N98HZhQthOOzLPTEBn3Pg8HMVRe9DVR7MT4pCd+hciPxNvOns4uZeZvSfNynJpdiNAKZskt+nqnp5Xm/6zS1yh1Uu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893834; c=relaxed/simple;
	bh=jXZRPKHn0JFP8FteGX2Hur/wWRGFd7wXTpyzyCjO2qw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hm2iuOsCEV6Bzoha7d0fH+GE+GWieg7z1ujEjw8S6eE/Uyq0E6aRtLmgT4z7qvliDicoNC3v31uMkJgbRNf98tznN7NiGk7G/i050qc4fJBduCgiLdhMrIjKvhDzMZrzCPd0ZbSkBVIxFaWMcrR9FZXDaZAoUXO1cWlTt7ob50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6NG8FI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ACC0C433B1;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893834;
	bh=jXZRPKHn0JFP8FteGX2Hur/wWRGFd7wXTpyzyCjO2qw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n6NG8FI0yUlWyavOwVgKXevPY+TLRUmH5R/FGfe7KkjAxAUC87jSXqkaYAioUxnXN
	 Gg+RKGTgYQkJDCZDpzI0I45t9FdAYgvwrKvaO91z0Lf2594RXsCvyn/4dkIzpTO3Rt
	 8NnqgfEzKYe3ki4d8Rf8BK9nge0zzwJgPZHpCNDBAFDYdXa6RWNOZQSNEOX8OpOtML
	 8w5vPPC8SpJTMh5cgSNlFx/9qSu732hCHK3ZDVoeOYCNp2iyoD6JDTBPsECdVtaPZ+
	 bpeeXRzJSFwQkLnYjhJmQYMH75psRLc8K62VdaR4C/J4bTgMWQMMdrJs3+tMqDi2FB
	 R30nrYQQ9H/tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FF1AD84BDB;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: dqs: add NIC stall detector based on BQL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989383412.12583.2389930654847220179.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 10:30:34 +0000
References: <20240304140901.121533-1-leitao@debian.org>
In-Reply-To: <20240304140901.121533-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, bhelgaas@google.com, rdunlap@infradead.org,
 corbet@lwn.net, johannes.berg@intel.com, linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  4 Mar 2024 06:08:47 -0800 you wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> softnet_data->time_squeeze is sometimes used as a proxy for
> host overload or indication of scheduling problems. In practice
> this statistic is very noisy and has hard to grasp units -
> e.g. is 10 squeezes a second to be expected, or high?
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: dqs: add NIC stall detector based on BQL
    https://git.kernel.org/netdev/net-next/c/6025b9135f7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



