Return-Path: <linux-kernel+bounces-103718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E794F87C35C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F6AB22AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEC775807;
	Thu, 14 Mar 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHR9glI1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53B2BB13;
	Thu, 14 Mar 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710443431; cv=none; b=h/D89KrM9L0ySwnI8ODIS0Ms2dENkJjuthqWNSyTbP7/KuD5+3c1UM1aEbzff1RabWL4ehY0XMTIxpkRNy7QAJ+KssMfOqJDK7gfc4wY1DrSJ0NlgyeWC7LeBI6vmZvm9/3BCmNGGofOS9YE8M9sja7l0viVabjASyaFPvkloeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710443431; c=relaxed/simple;
	bh=A/L/Xxt7fXbGgWNyQy6zNLHcJ/h/grArt2RG6AtChhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a5hhLtoykslpdgntv0oHiGOxgz3+mKGD4/JY82VF9DtQ3T43XZYJfeRrvfe7jrVrkkhYZD90qwOVCkOFvCG2R0HpJz3XZtLgPLrWoCCB3EnsJjdcQ3l0tBoIkP7c2r+w9UBDiD0WuACVjODKpBReQ+0fn+k7E2/XvyCRdAgHV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHR9glI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EDB3C43390;
	Thu, 14 Mar 2024 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710443431;
	bh=A/L/Xxt7fXbGgWNyQy6zNLHcJ/h/grArt2RG6AtChhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHR9glI1tLyEueqMssJ6DbyET0pQVuIhLr129d91iPJEEtF7fFXERkSKTqsX9Yh3D
	 jgbTefc6mN4tyU0YLhe/TxvymQmQ7BjfDEKJlTGnCcaSFZ+iB9UDui456G0FrsuYrY
	 VGVrXw8rBGvSYU+Jqu/yJH2+IzeVv1MIl38kGmF7t5pAcqp87QodBJQS5G56nsnYD8
	 0G/qJgu1nK2s1bWdaPh7BZWWn4kNCfAOcwq7Koie1nYxpnccSnoMBdB/NEYIXvKkjO
	 nffZuBZAj+wdlxwih+0KmAtxuzNhi0np+GvYJTvc3WJSXFkdTDjXdWhtHuQ2+Ctshw
	 agvNM0F9MLSoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F01C6D95055;
	Thu, 14 Mar 2024 19:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Temporarily disable atomic operations in BPF arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171044343097.30186.7484635385194590602.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 19:10:30 +0000
References: <20240314174931.98702-1-puranjay12@gmail.com>
In-Reply-To: <20240314174931.98702-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Mar 2024 17:49:31 +0000 you wrote:
> Currently, the x86 JIT handling PROBE_MEM32 tagged accesses is not
> equipped to handle atomic accesses into PTR_TO_ARENA, as no PROBE_MEM32
> tagging is performed and no handling is enabled for them.
> 
> This will lead to unsafety as the offset into arena will dereferenced
> directly without turning it into a base + offset access into the arena
> region.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Temporarily disable atomic operations in BPF arena
    https://git.kernel.org/bpf/bpf/c/44d79142ede8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



