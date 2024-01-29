Return-Path: <linux-kernel+bounces-42668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D68404A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12460282326
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3F6604A2;
	Mon, 29 Jan 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOZt2HEz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12425FEED;
	Mon, 29 Jan 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530226; cv=none; b=qBh8EgurjmU8NGiao0FLmtlV7xJKQvPBlv89sGphzftfnkpnNcpabSoV8PMWW0yEuzQVCBd089VlZ3nHBs0tpxb918jT5ceUrxorKTqKEFBK6ot2iJvbl5aWo7v3FCAatUkMR90o9Sjn49Qtfab94KYW1+2P+E9FMrv1djGeY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530226; c=relaxed/simple;
	bh=VMNNZAKKjNfjAMNm8kPJWl4AR3VxVa0/bOc+xLjjHEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kWPptxNre7d9wSTdt9pEon+m7i0uQZgKyfDkayt7jT5+v4bQQ9RXOldbEbacXPnqX9PkRgDq/cctUnx+LDoRlc2hZBgz+8n5xauOiPCBrHP2UgKUIC5ncYrG5K/RsTce8l2OwPqm3Tcgp4pQJQEEqVkCpeMKTXo5DwoedrTCsXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOZt2HEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 692D0C433F1;
	Mon, 29 Jan 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706530226;
	bh=VMNNZAKKjNfjAMNm8kPJWl4AR3VxVa0/bOc+xLjjHEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KOZt2HEzcnvRs3ueWVxY9C2ZaMfVonH8797M/Fpio9r/dqtoPe+4iNnVDz06ReLn7
	 E9xWhvjGUgT9VDU10wZ5YQzg+HZwZtnoeGGDKWkRw9vvMGmUaRBYfTsjMvP2IRyT++
	 m7dDQzwN6O/jW0Db4o2I+JWQW7/LWCnJj4Rmt2t1YuVAeFKl97nmLCI9EWzDt3q+ph
	 fyvjH0KPjslF7LEN00Rj+fNR7ttNNhpmKedKnUmYwDhdDAeerUWNA7SRgXzjOMwyBO
	 QFfCq6CS5jnfe6H+gl1bMOpIBeZk1Q+CVy3N8kh5qzrZPMMgwjdf5YfMl0n3M+ViCo
	 A5eiLjk+koNnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 509BAC595C3;
	Mon, 29 Jan 2024 12:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfc: nci: free rx_data_reassembly skb on NCI device
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170653022632.12593.11211557853168091033.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 12:10:26 +0000
References: <20240125095310.15738-1-pchelkin@ispras.ru>
In-Reply-To: <20240125095310.15738-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jeremy@jcline.org, horms@kernel.org,
 leitao@debian.org, ilane@ti.com, linville@tuxdriver.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, khoroshilov@ispras.ru,
 lvc-project@linuxtesting.org, stable@vger.kernel.org,
 syzbot+6b7c68d9c21e4ee4251b@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jan 2024 12:53:09 +0300 you wrote:
> rx_data_reassembly skb is stored during NCI data exchange for processing
> fragmented packets. It is dropped only when the last fragment is processed
> or when an NTF packet with NCI_OP_RF_DEACTIVATE_NTF opcode is received.
> However, the NCI device may be deallocated before that which leads to skb
> leak.
> 
> As by design the rx_data_reassembly skb is bound to the NCI device and
> nothing prevents the device to be freed before the skb is processed in
> some way and cleaned, free it on the NCI device cleanup.
> 
> [...]

Here is the summary with links:
  - [net] nfc: nci: free rx_data_reassembly skb on NCI device cleanup
    https://git.kernel.org/netdev/net/c/bfb007aebe6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



