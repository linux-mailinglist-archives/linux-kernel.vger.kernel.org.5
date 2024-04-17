Return-Path: <linux-kernel+bounces-147793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C758A79C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FD2284659
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BA7FE;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TN/ATjDg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC3364;
	Wed, 17 Apr 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313232; cv=none; b=MlbBciCviKexe96AGP0cMLEzG0z0/cyV2Hv2ZAsNZMyQEm9isDuf5wOO0AdBabcJJ5BF3DCN4cvP5QR+La7WqoKIltV+B5tw4JnmguAvJvVtWZdo2zflLsuhOqIecZG776lNa/YIoubABOrHBRQuVBZ0a9KKVqVQlCohHZHmj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313232; c=relaxed/simple;
	bh=g/eyLAic0iUPbVzvYhhfhYWIuj+Sz702diFXnFEErGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s2oORUSAxZNspVw6DjKkRT0qxaDjnulmTF0OgXbNc69h+vwn4a9nicIaS608a8vSyxr/VcKIYfWuxEDZNAJI/ACGWZtVoZmOYJd48ZRe3S6kK90wySFZfuVi/W7JId7toUpZ/JTf+aA5maOWFHsq2BuGdBjp6AhpoNEU+3INycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TN/ATjDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5EDEC3277B;
	Wed, 17 Apr 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713313231;
	bh=g/eyLAic0iUPbVzvYhhfhYWIuj+Sz702diFXnFEErGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TN/ATjDghKDiKZ7d957Q2GCdv6JPMiMHU8V14fj8HwGSA6cLK+j5d5MNGf1teIEk3
	 x7KAEhshH0FR7Ku0OKKgjO+g/h9rlGfthjTG3KxoItgZ5mqHPRRJcseV7Xdzmrka6/
	 XmpbjVgRwWjdA93CEYR0+yVaxnsIj1AmmVLQmhR/B1kbJljDOjOOjSv3PF8M/1ytAe
	 VlnsluOLyqqHNn+sub+zDxiUy5gnNwhvE4wV8o0OCvWD7eprOpNQhrSHY1YDE03Wyh
	 EbvnAwXeJRVrVkGQkhSURUjLt/RKTz6u1jSm2XBCyaqin04ItHgQeJ52CWpdzGUF7J
	 jOEiF2SnEELbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97CCAC395F3;
	Wed, 17 Apr 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] tun: limit printing rate when illegal packet
 received by tun dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171331323161.29224.12069023011947304664.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 00:20:31 +0000
References: <20240415020247.2207781-1-lei.chen@smartx.com>
In-Reply-To: <20240415020247.2207781-1-lei.chen@smartx.com>
To: Lei Chen <lei.chen@smartx.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 herbert@gondor.apana.org.au, mst@redhat.com, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Apr 2024 22:02:46 -0400 you wrote:
> vhost_worker will call tun call backs to receive packets. If too many
> illegal packets arrives, tun_do_read will keep dumping packet contents.
> When console is enabled, it will costs much more cpu time to dump
> packet and soft lockup will be detected.
> 
> net_ratelimit mechanism can be used to limit the dumping rate.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] tun: limit printing rate when illegal packet received by tun dev
    https://git.kernel.org/netdev/net/c/f8bbc07ac535

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



