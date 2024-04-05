Return-Path: <linux-kernel+bounces-133291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE1189A1D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5D21F220F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A116017106F;
	Fri,  5 Apr 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVBeBj8u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45616FF5C;
	Fri,  5 Apr 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332230; cv=none; b=mgmTYrGIuI2OetkxekR7aerltCjUcK3ut1BsjU0RZ9GV2ayLSVeHwtkd2aGBeSD7mydaH6g4xgBU4CAXP4MxAj8WYtLWVj2jsYUdoxjnm+FFvnRK3XYRMKkJnji3TZ7cX6VdnFffrA1SAcx95pISORegH4u8Yi/RAwcJg0+kBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332230; c=relaxed/simple;
	bh=dYWFC4dTPThsm4mKcrWmIM9MEbrMaA57mtINggeOeiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SB8okl4rYNA6k0H7gnAL9fGoXELVdYGGEUw+1Cvcycc+Ytfe54e/QJ0Hr6qjapZT4uuHaChuA2PINZ0o68Dt+r8WhyhxZj9xbwWyKTBKKtw4AAFXOmmXDGTBoR1aMRuG4CtFcSosZ1UHIhvsTcOUjWQEGKl054DTVK+Fmm4YTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVBeBj8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68EE2C43399;
	Fri,  5 Apr 2024 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712332229;
	bh=dYWFC4dTPThsm4mKcrWmIM9MEbrMaA57mtINggeOeiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QVBeBj8ublFEaE3qaj8F6ucZRkTiQp0RBlw07zx0XTUFAPJ7R8PfM64Rq3OnUb7s0
	 MjR6eykjh2cyBd6zK6pEjYjEAErAsjhO72oUi6YPpUD7K2Jhvzp/Kb37pNEnLhgOAp
	 90SeP2Joiyz9Sy99O/5Q/NycqMSD2XgmRsl+4AQv6XEgZ30D7tI7GOsV8h992fhyRk
	 G5dYzB5nrmKUMsT81l+2I6ZtQa1Yitrmd3JRip3HEcNZyaEC3vHt+inFD9yie2BZe4
	 th+JVYVBK1ED0/Wfx4rYBT12c/7y5OVhIOElzJN2TVV6YqlyWfpiPB162i8q6lRQdG
	 eBMIco4aTwnIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54C3CD2D0F1;
	Fri,  5 Apr 2024 15:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix perf_snapshot_branch_stack link failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171233222934.27726.10866961945362995147.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 15:50:29 +0000
References: <20240405142637.577046-1-arnd@kernel.org>
In-Reply-To: <20240405142637.577046-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, arnd@arndb.de,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org,
 shung-hsi.yu@suse.com, memxor@gmail.com, davemarchevsky@fb.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Apr 2024 16:26:25 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added code to handle bpf_get_branch_snapshot fails to link when
> CONFIG_PERF_EVENTS is disabled:
> 
> aarch64-linux-ld: kernel/bpf/verifier.o: in function `do_misc_fixups':
> verifier.c:(.text+0x1090c): undefined reference to `__SCK__perf_snapshot_branch_stack'
> 
> [...]

Here is the summary with links:
  - bpf: fix perf_snapshot_branch_stack link failure
    https://git.kernel.org/bpf/bpf-next/c/58babe27180c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



