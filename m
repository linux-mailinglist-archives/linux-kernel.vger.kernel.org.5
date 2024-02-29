Return-Path: <linux-kernel+bounces-87194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93586D0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3518B2652B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191C70AF4;
	Thu, 29 Feb 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APjUPxwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F770ACC;
	Thu, 29 Feb 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228431; cv=none; b=B0eWozCyFCEuKnzmTOYoiK3Io/lvZUGHye8BjTu4w6vwnJWu0YZVBQi9fbyLOofqhUUta3VBdYiR2aEaqo1kQ9MZUXa1F6RwVO9Am+Nvb8tE2SDUw9E95qAyeO/K1J/6dPk0oJQgSQ6n61V/vd6P7J3X4WavbrKG2diNkXcHkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228431; c=relaxed/simple;
	bh=V1XSw9+t7HO2TZf9lH7scaOjMKfXZJG1RorWB6ygbc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M8h5Wnow/6+nukiqQEGh6CXkULEwWRFkkOW0TdsBGK65eYjxivHkGsm8kPq9Ec5ZR3DpoXFWwVztvnoOYq5nqCnzuI9NM2ZOjaHp8UJ8mi0Y+ti4pR5TAhzGyUwNuihvay0XCohhjc6GQhpp5vtzvbfvFBTiKFef26s36x3K9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APjUPxwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DF3FC43390;
	Thu, 29 Feb 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709228431;
	bh=V1XSw9+t7HO2TZf9lH7scaOjMKfXZJG1RorWB6ygbc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=APjUPxwV+bEjVQt/AGr6yHMZMVX3VM2G4F5HWrZc2yO+e9dstp6qmhrHpU3QVpOOe
	 uxoJgi87LxwAAgYj4F7HpqpKKGGVP61fNRv+V8eHImHjGJ58o2apG1firWTWqHwa6g
	 KofG61yVuRFCNds99VPMcyE4xgetRASdYriOSc6kBDYBQtmnISUh9mTq5l29VA6pE9
	 tOZbAQIfMxkgPGn85DYKZs9jWdoe0FTtWxGER4FkvH+QJWgIjgfPqnGsYQa6bBrD84
	 LRVrRYE4tHkgSs3jGbVLtT3u/4j6OTNeWMt1Wol+sj1kWEak9NTsgXTZXSS3gQCnRq
	 HiSDUAXZmS2rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 405B7C3274B;
	Thu, 29 Feb 2024 17:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170922843125.9358.2716683497348325384.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 17:40:31 +0000
References: <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
In-Reply-To: <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: davem@davemloft.net, kuba@kernel.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, charlie@rivosinc.com,
 palmer@dabbelt.com, erhard_f@mailbox.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Feb 2024 11:41:52 +0100 you wrote:
> Commit b38460bc463c ("kunit: Fix checksum tests on big endian CPUs")
> fixed endianness issues with kunit checksum tests, but then
> commit 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and
> ip_fast_csum") introduced new issues on big endian CPUs. Those issues
> are once again reflected by the warnings reported by sparse.
> 
> So, fix them with the same approach, perform proper conversion in
> order to support both little and big endian CPUs. Once the conversions
> are properly done and the right types used, the sparse warnings are
> cleared as well.
> 
> [...]

Here is the summary with links:
  - [net] kunit: Fix again checksum tests on big endian CPUs
    https://git.kernel.org/netdev/net/c/3d6423ef8d51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



