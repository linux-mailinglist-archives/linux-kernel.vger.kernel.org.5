Return-Path: <linux-kernel+bounces-103988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7156A87C781
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28A61C2125A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DBE8801;
	Fri, 15 Mar 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP6FE4eq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B78D2FA;
	Fri, 15 Mar 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469831; cv=none; b=Mh4MEwuPWtmPFLKjX+38ME0FzIf000fe3r8745CouHRPp3nWFa9YE9SIvoEsRT/JNw3uEDvvm/4O78VaANzmmisxQ1n2RzJatRBmjOGawYRs/9gpxBByluqFzpmGp10m9BwVJ+e45ouflO6/KwxSfRMJo2HrVz8TykKtV1ngcGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469831; c=relaxed/simple;
	bh=/DuxcoU5eU7Jg2W0UecnZo3j6aFQsVsJnqcpKoj3iDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mVDBStFU77eZ/LU1HaaOnd8nnpsBYTNRxmOTUPyheO72N4g9SOv8g2fG1ChRqxLKetY/647C3EcybO+MrHeiVehzInfSOEoUHekQX6N0r/V19qKPVJ9eKsqHWcu6DuMcxPkjNFvg9MXeoiSPzNHXR/v0POweoP8jdg9eXgVZOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP6FE4eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D109C433C7;
	Fri, 15 Mar 2024 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710469831;
	bh=/DuxcoU5eU7Jg2W0UecnZo3j6aFQsVsJnqcpKoj3iDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KP6FE4eq9/myZv8B6rO85RyDC/5fy8vNg16+Nz/OmRAVWA0o5ldthsyQHF9xdmSQD
	 3sGhNMgSv2xxV3C5rikVOXZzCyLxjUMljmmQHwVrrkUDmGrnQvOtpyCFOz0ZbHddh6
	 meiyRECn3tp+MCoUkGwPalXjGO8yEUDPyJLjYi1k2TMOWcwI9VkkDp1EKWuhu8Waxg
	 DHzRRIfjbJnniJwWQfZM9ckyC7Wq1VzEpcqorHyXiaMEQYz6Sk9RJECU67gJnNavX5
	 CsyUGj74Bq5C3LTBLwmtQwd0mJbg1t/FxU1HdjS2cYKVqMT74jNfrEZZRl/+PZ1piE
	 irzVcogN+JBCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFF08D84BAB;
	Fri, 15 Mar 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171046983097.25404.15651868965957197359.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 02:30:30 +0000
References: <286def78955e04382b227cb3e4b6ba272a7442e3.1709850515.git.christophe.leroy@csgroup.eu>
In-Reply-To: <286def78955e04382b227cb3e4b6ba272a7442e3.1709850515.git.christophe.leroy@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, keescook@chromium.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  8 Mar 2024 06:38:07 +0100 you wrote:
> set_memory_ro() can fail, leaving memory unprotected.
> 
> Check its return and take it into account as an error.
> 
> Link: https://github.com/KSPP/linux/issues/7
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linux-hardening@vger.kernel.org <linux-hardening@vger.kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()
    https://git.kernel.org/bpf/bpf-next/c/7d2cc63eca0c
  - [bpf-next,v3,2/2] bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()
    https://git.kernel.org/bpf/bpf-next/c/e60adf513275

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



