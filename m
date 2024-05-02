Return-Path: <linux-kernel+bounces-165905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3E18B9335
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6AC1C219D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04AC17583;
	Thu,  2 May 2024 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIVINzy3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2F134D1;
	Thu,  2 May 2024 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714614634; cv=none; b=DaTN0/ctwD5N+UGyikiDxUXZ7cNj2vfl+vKPi3UWmIu/0NzIfNK9deeRvDLTH7aaZc3kbPhykunBzf0VMlcZi2J+8crO2lekx+72RL4LjiK4u/PlMwUm/9/753OR3w6klLGg06tXyC3XiqFHtCDQkzpAjgCIP0cuReJTBg6dI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714614634; c=relaxed/simple;
	bh=UqJyOCfUOQaamn1XOe5aPpuJ96nuGK2MkwC3U20TSVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V7P60zTQj5sFZjp4ApFl4i4xONyBnk/PSieqR4LdKD/kNcfS91Ciz5CFw6pIhqdO97qfUOLXbF5dSQ3WdGTP0ulzkR1CRLBU2LMo1LT1eFqHW64idqLY8OU0hL+isHCgwOF1lVtXf4VnkgXOiDelUD6QTGtIWBwMrC+hmy67yTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIVINzy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67CB6C4AF18;
	Thu,  2 May 2024 01:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714614633;
	bh=UqJyOCfUOQaamn1XOe5aPpuJ96nuGK2MkwC3U20TSVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NIVINzy3hG9s+sSJaz05jpkC3br03/TPTbIKfPIu6Ch8TPj31vQ2wPOXOj5G8wlQ3
	 tY20uEZoGIWPZxFmPjPmdTphE9xuP16i+LszcWE51h0t/aVOvWhatv1scvTd8pCWLJ
	 uz8dHMYDEYvAs050sd97pYvuqg3fura7XEe9v3adLtIBAvOgA9QN8/Tf56GhzI6Qk7
	 +pLkp6R+A5ACpGZ9zhez5v+5ZEHSgNOhnKsc/XII+Oigs8z++KAzQuzZ0MSOI28JOp
	 BcqNUWORNlkssqX9xs9gbE4rO6yoGzW7nV6XdE+SaYSUtGDIGdal/vn/lo36e2of/W
	 p1q6wK9gVcEgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FBA5C43440;
	Thu,  2 May 2024 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ti: icssg_prueth: Add SW TX / RX Coalescing
 based on hrtimers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171461463332.22196.9443088195151767378.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 01:50:33 +0000
References: <20240430120634.1558998-1-danishanwar@ti.com>
In-Reply-To: <20240430120634.1558998-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: dan.carpenter@linaro.org, hkallweit1@gmail.com, andrew@lunn.ch,
 jan.kiszka@siemens.com, diogo.ivo@siemens.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 r-gunasekaran@ti.com, rogerq@kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 17:36:34 +0530 you wrote:
> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
> driver, which can be enabled by ethtool commands:
> 
> - RX coalescing
>   ethtool -C eth1 rx-usecs 50
> 
> - TX coalescing can be enabled per TX queue
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ti: icssg_prueth: Add SW TX / RX Coalescing based on hrtimers
    https://git.kernel.org/netdev/net-next/c/dcb3fba6fa34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



