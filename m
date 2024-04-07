Return-Path: <linux-kernel+bounces-134530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ADA89B295
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FBC1F2218D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B403A1BC;
	Sun,  7 Apr 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQxdpSnq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E631EF15;
	Sun,  7 Apr 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712501429; cv=none; b=l8okYMRdT3vHyrbGGluFr5cjh9Vid0Z21urjkPz4SNCmWpc314SEyd+8poLyeVxH+yttiG85Csocm1l35McKkrHLP+ebSw6LrxTe+XGweEk/iiEwL/oCVf1zVbfsOgHwWgwzPqPv4eM+wXUy7jU8wwdfTauuu78y+38K52L5Tcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712501429; c=relaxed/simple;
	bh=3NpH5R0cVdwG55tWo4S05Y/2aK0dgTnsL65UnhXoKmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BJ3ukgLx25v0ofwQPANwLQqNraCEQGVPerU38ri/PB/Hc5+o9sQY0wRQzfLwytteNQlEOSmOby3mo4qIDyS40KDlqjUEDMMKWGxFjozTQNB+31t+mbqYA/Q6Jd3w9pGjFsMaAHA/i50kNU+8laeLXWtcFnzdFZv9MddM/uMXIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQxdpSnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2986C433C7;
	Sun,  7 Apr 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712501428;
	bh=3NpH5R0cVdwG55tWo4S05Y/2aK0dgTnsL65UnhXoKmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HQxdpSnqvJ5ndkGtMSQhnuZ0GuF8iQMAe2Y/rdW8GsvVZCKrQ/O5oyW3IhtlkmN1/
	 YWoPUnC2ADXX1/B1QTc0AsoIxZl/nidfGjBZqv+ZtZRfEVZ+mh567Da3zrqj53a5x+
	 8sFakqJYd3nCa6+Dje+ae0H4ZVIfKe9JcqEG/XwxXq4/x7EOQNJ/dTpXGnOCC1HNjX
	 hWjZ8e88JdjI1RuoIJkgK4MuzXX1bY3tFrSXk+cFDk8DIh43Q4ZgDsn94ROvUPuU6t
	 0sOgvi/AUvkVgQuMIYRXHa8eJeuFLnkn0tKYJsS/Va94iQB7Qiis0J2ryb1D/cuVqr
	 oqAvxBi3UDXVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92384D7E2B1;
	Sun,  7 Apr 2024 14:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] virtio_net: Do not send RSS key if it is not supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171250142859.30136.10958803623122674552.git-patchwork-notify@kernel.org>
Date: Sun, 07 Apr 2024 14:50:28 +0000
References: <20240403154313.1331319-1-leitao@debian.org>
In-Reply-To: <20240403154313.1331319-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com, rbc@meta.com,
 riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Apr 2024 08:43:12 -0700 you wrote:
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
> 
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
> 
>     # ethtool -X eth0  hfunc toeplitz
> 
> [...]

Here is the summary with links:
  - [net,v4] virtio_net: Do not send RSS key if it is not supported
    https://git.kernel.org/netdev/net/c/059a49aa2e25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



