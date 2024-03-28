Return-Path: <linux-kernel+bounces-122808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4988FDA1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E618294F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB97E0FF;
	Thu, 28 Mar 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghf717IU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604642B9C6;
	Thu, 28 Mar 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623629; cv=none; b=fzjOEZzrFE/5fXnC1DTu1iRisnYwhkPtfj+XPOl2C2DHTYdWaS9MRK/sNwKX2pFKk/z3eKrmDFazTlyh5CTLUIhXmoCjEBJ87K3c0Q/WslGgxjxaUiIX8FSAQqKbYGuzfuAVSTQCIlgJx/UMRHE07Kq26u0VNzfEoBSA8wf/gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623629; c=relaxed/simple;
	bh=lEXLLTsqGqD8e7Ce9Kt326FYVHgiMnceN6e9O+Q4idY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kKW5yKNIRUahBADQ3KEdQInM7/Aoq4WkchnTA0MOGn3kluw+BHlzL7fn2F/7hEscOVTlv9ALNGQvzEPQiieKaliECEbz18l2aA6wnDZoerjxD3kKeztOgmOfJVbeBEX0Vk+33fbr0ViCsAs7aMM7LMqPJ9eXFlO/F5e8VhderQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghf717IU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 011F0C43399;
	Thu, 28 Mar 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711623629;
	bh=lEXLLTsqGqD8e7Ce9Kt326FYVHgiMnceN6e9O+Q4idY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ghf717IUJwOL3NbHAa2XMwE/JHa1f6rxQUTzfIis2EH/s0n2OQswpqx5BQpYnXfYD
	 RxsSuDhetTKmSTDySwzKEyzFGTdFg89D/+sc/VLWnlA/W+P1wFW332e49Ec+Ije6UR
	 TrWREccQss0Vax+n8OLz8v9cIVWDfLI67pfbU2FuMr4s/1ejaxcqk95rygynXdrdgv
	 TmLT3b/9KpBCWsBKnccIBj8FGu9bhXggioIegklt/0W2qOIjEevGP0faGTMx1HS3UN
	 8cGEZu3rywZude8oNyLdU+TLPA6M8gCcyePJE3ITrDtvz6fQ+v8miXW9FaCN0pwJXz
	 cfxD80KhzH/Ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB52BD2D0EB;
	Thu, 28 Mar 2024 11:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] Octeontx2-af: fix pause frame configuration in GMP mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171162362889.25241.17618110136874294396.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 11:00:28 +0000
References: <20240326052720.4441-1-hkelam@marvell.com>
In-Reply-To: <20240326052720.4441-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 Mar 2024 10:57:20 +0530 you wrote:
> The Octeontx2 MAC block (CGX) has separate data paths (SMU and GMP) for
> different speeds, allowing for efficient data transfer.
> 
> The previous patch which added pause frame configuration has a bug due
> to which pause frame feature is not working in GMP mode.
> 
> This patch fixes the issue by configurating appropriate registers.
> 
> [...]

Here is the summary with links:
  - [net] Octeontx2-af: fix pause frame configuration in GMP mode
    https://git.kernel.org/netdev/net/c/40d4b4807cad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



