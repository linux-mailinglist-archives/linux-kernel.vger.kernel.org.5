Return-Path: <linux-kernel+bounces-120288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C988D55E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387CF1C2553F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36CE28DCA;
	Wed, 27 Mar 2024 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJDkhcmu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD724211;
	Wed, 27 Mar 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512575; cv=none; b=KqpykhrJ1izuSvPbnTfgrvx5QXHyVIez83886LkRyCzZoiFG9DPXJAlp2tYmfuAnbhPjBTRHiOxjDLP7x5PrtDYp/GtUP1IsgRAHVGZPpidlyNVkUtfbgIJoBAHTOaTquKmRAZgIEOv4mg80wpaB9O4ncRFZd95TWItExjcQ9vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512575; c=relaxed/simple;
	bh=DfKRggbLQPnah/j7AqhtFsxmQZMJ2jTVZKuWmOnkN3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pc60s+jhesLV6v5szYbKh8Az9CqlulbmYjJOn8ucMO3yy+nBRW9suVad0cwuaDe8KRKZhILZlEJcRMf50pzNUSsFdMC1sr0Lu49oXSRyZW5fk/aenfGdBDfi9NJ7/CnBDYlcDa92hSMEPJbdPozs1FVjI5VXM5djiH5PSxDcvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJDkhcmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6290BC433B1;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711512575;
	bh=DfKRggbLQPnah/j7AqhtFsxmQZMJ2jTVZKuWmOnkN3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vJDkhcmubCZ/BDnwKhaUiy7ic+S9BztYxgVxJPssCq3Ahne/OKOy07j8sTZ/yOYGb
	 rbFw0S7XLAeRdz0atOnV+YyWPMyroagfQPZiKfnPdR2G3ebQBFM05vJFpXGvAJLB01
	 uavf0eBsqNVsQ9PfX1HnpTvosVH/sMB08TUB+lAYKER/Cd5aArNxddYHeMkGJoj6kT
	 TSW50rZ8YcFXhdLMnMO1Xk0sISY/iGVOMFPyophwtt5nuhHm3CsnRwa719ussXzfeF
	 PEfKotYQlOXWgu5eoJUOMZv3xcCDPg2FzZpzr8op6UBA1yyTOvZ4phuNz5GJt/SIZK
	 sqTvpblX6NTjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 574E5D9505F;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] mlxbf_gige: call request_irq() after NAPI initialized
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171151257435.29046.15255647159792456.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 04:09:34 +0000
References: <20240325183627.7641-1-davthompson@nvidia.com>
In-Reply-To: <20240325183627.7641-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, u.kleine-koenig@pengutronix.de, leon@kernel.org,
 asmaa@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 14:36:27 -0400 you wrote:
> The mlxbf_gige driver encounters a NULL pointer exception in
> mlxbf_gige_open() when kdump is enabled.  The sequence to reproduce
> the exception is as follows:
> a) enable kdump
> b) trigger kdump via "echo c > /proc/sysrq-trigger"
> c) kdump kernel executes
> d) kdump kernel loads mlxbf_gige module
> e) the mlxbf_gige module runs its open() as the
>    the "oob_net0" interface is brought up
> f) mlxbf_gige module will experience an exception
>    during its open(), something like:
> 
> [...]

Here is the summary with links:
  - [net,v3] mlxbf_gige: call request_irq() after NAPI initialized
    https://git.kernel.org/netdev/net/c/f7442a634ac0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



