Return-Path: <linux-kernel+bounces-120287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C688D55D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5BEB21F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7225624;
	Wed, 27 Mar 2024 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJKgC5Qm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37C22EEF;
	Wed, 27 Mar 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512575; cv=none; b=nIupz1P6zunTBMZnFJ/gFDCECkl7aSk3+T/Su/IEPJB7QaejJScvaZyQV2NnNj9OWGSQtx6drHYbBanwZjNVED7jTwr8kiLOw7A403G9aQxNZcUwPEEsl77o7YGrPJaQxWlRWd6OCeZlSHx2aNjCgDUN8XGw1wYEKUldxKEGNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512575; c=relaxed/simple;
	bh=3PikuLC/TJJ8xameNyGccXDcFBPoGzkIsB0EgyE8nf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eSZw6/Fb8W6AyRGGvu5K1A7xPgRVW948OxwzupBkVrljyi0Urfqx0DrvPrWaOTrNUfquYs2uNWvUQoDIi1l7crdsDHmarubNtfmpnkIrn/As9hYnPg89YKZc07LOT5Dq68VfrqtJJTrrm4i4i8tnBnxz3djD8bWXtiJIDyRHBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJKgC5Qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E23EDC43394;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711512575;
	bh=3PikuLC/TJJ8xameNyGccXDcFBPoGzkIsB0EgyE8nf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oJKgC5QmeGLWpUM8WVvvc99/wi1ZVQiQaB/ysaURAVil6PBwkIjiLg2uDztc3KmwC
	 gmSDjlwMCi3YfOPKE4BZExpHRp7wAW7C/1YfkeXLnhxltb2DoaZaCBM7aGn+7GtlFi
	 HZ+IHmEZkxNKYMs98Re6GHmAFBn2YwNzSIUx/m05BleR5cmw7IvFsFsTuX4Wm4I6+L
	 C7mZQhf++nfFfkS8egfWCVdB0zeEMrNIMDaUnPBcqVDVsX3kRMM1it+/uXq1qKEboa
	 ytglJKuOwwhTg0aP7V6uSoQ1XbqapPI+GFS1KL8iVnGaK53BMwTtS8VX9iyQWj8L6f
	 z7HoPmgJhFsEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D24C9D2D0EB;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pin system percpu page_pools to the
 corresponding NUMA nodes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171151257485.29046.3411978356061042710.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 04:09:34 +0000
References: <20240325160635.3215855-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240325160635.3215855-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lorenzo@kernel.org, toke@redhat.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 17:06:35 +0100 you wrote:
> System page_pools are percpu and one instance can be used only on
> one CPU.
> %NUMA_NO_NODE is fine for allocating pages, as the PP core always
> allocates local pages in this case. But for the struct &page_pool
> itself, this node ID means they are allocated on the boot CPU,
> which may belong to a different node than the target CPU.
> Pin system page_pools to the corresponding nodes when creating,
> so that all the allocated data will always be local. Use
> cpu_to_mem() to account memless nodes.
> Nodes != 0 win some Kpps when testing with xdp-trafficgen.
> 
> [...]

Here is the summary with links:
  - [net-next] net: pin system percpu page_pools to the corresponding NUMA nodes
    https://git.kernel.org/netdev/net-next/c/341ee1a584c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



