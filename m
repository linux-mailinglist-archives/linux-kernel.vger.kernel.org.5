Return-Path: <linux-kernel+bounces-143511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF98A3A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD6B219FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6C17C7C;
	Sat, 13 Apr 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opCfn/CR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC114290;
	Sat, 13 Apr 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974230; cv=none; b=JED/uMXbOqAZMsXpMLiMki9v1US0Fth44dprxUIYwjTzPKNfBf8++1P1ay5Ttl/DGb3VbsTbkgrt2e4geYWrUG6+ctEOERl6vmTRsL9621D06XObdyGOi8qSYgbdvXs3usmNWEiGZXn5K0r51XinqHVI/LoMVOpKIDxDYCTRmz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974230; c=relaxed/simple;
	bh=y7/r4Hl/aIaayI7vJmPKYoYuThmfjVt/AepmqMB1Axs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=alglGZsnA4ULIUm6NGhJEPjZS2N+48PeWedpIlMWymo0jpXXTzgLXO+r5nzAOV5+NIsZEmGUQC2AJ0vTkVLLC8CcVJ5ywjdusFGxNyy48QKVMeqDCaMialTPvXGviaZ+tW9OLgsjxFOgRDDKHOd/EPiJ9vSPb55TBe/BsEVFAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opCfn/CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0126DC4AF07;
	Sat, 13 Apr 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712974230;
	bh=y7/r4Hl/aIaayI7vJmPKYoYuThmfjVt/AepmqMB1Axs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=opCfn/CRLiVUBRq+HKV/NW+4ZLhD/V58ifk6Jg6Td2qF2I1VdpvDceVmeZBf0RAEz
	 IdpHOcpONgE/FLUns6IzskTIt+4PRGyU18y5gJB1mbq1KQsShwVYa1jFIIjGUVGOC0
	 YbLaGsqdXFyY1bfrOqRLhGlzBZFn1zDLn9FqPTqES67hhFDd2ZLxzULZCivBxqa8+Z
	 FxbAmqLVAAWHd6l3lMXHEYahtv98RJtsJXsDFfmUKcNHzcy1dzsExenniJppIDO2Iq
	 LG3RaENF6IV1X6IReWnzaoIzEViCIaIyeDv1krfHAESzLxHwPbb/qjbB50t7w1Pg13
	 jXcFV5R174ahQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D26C2DF7859;
	Sat, 13 Apr 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: sparx5: flower: fix fragment flags handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171297422985.31124.14511949916816022464.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 02:10:29 +0000
References: <20240411111321.114095-1-ast@fiberby.net>
In-Reply-To: <20240411111321.114095-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, Steen.Hegelund@microchip.com,
 lars.povlsen@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Apr 2024 11:13:18 +0000 you wrote:
> I noticed that only 3 out of the 4 input bits were used,
> mt.key->flags & FLOW_DIS_IS_FRAGMENT was never checked.
> 
> In order to avoid a complicated maze, I converted it to
> use a 16 byte mapping table.
> 
> As shown in the table below the old heuristics doesn't
> always do the right thing, ie. when FLOW_DIS_IS_FRAGMENT=1/1
> then it used to only match follow-up fragment packets.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: sparx5: flower: fix fragment flags handling
    https://git.kernel.org/netdev/net/c/68aba00483c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



