Return-Path: <linux-kernel+bounces-75603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963185EBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B377A1F23846
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE7B84FA5;
	Wed, 21 Feb 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaoCCqzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE269318;
	Wed, 21 Feb 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554630; cv=none; b=sAHvN4u4m9hniESHZs88LJuMHiE1athXGzxeSrcneJI1KsZ0q+bhkGi81ecuX8FdjIm0lmYT8eOiliPNFUKKsYuN0BjhPJlm+tQiTxJOlzjb3kNLtaLgd6PgDlvRFU0SU49p+imek8fq1mnkZ+gFgkfVLqV/GjKqZipiK4uagik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554630; c=relaxed/simple;
	bh=OT7EOi/ourfNVtCJMunc3Vcywb1aP07ZDVjFhX6VFOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mw+gRrh+mSV5D2Fjc5rorllKgyT9P+7xEsRXkE3dQpN8cbzCqO8qQ+WPLWs4d1OmBQaKff1d3bPt3mdViR76yBoZGm56Vt/BD/BbrmAez9+TBOyayY8rBxp9nogjK01X6JUWA7+es9q67McRJBfRvn0+aGR5QYoPC0YETkncAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaoCCqzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35E49C433A6;
	Wed, 21 Feb 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708554629;
	bh=OT7EOi/ourfNVtCJMunc3Vcywb1aP07ZDVjFhX6VFOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AaoCCqzNI/fZmqRVXFGH6nfYvlCKzDu/oi16Ru3I4J3K87KKsb/Gw7iRw3R0/nEd/
	 GnrE3Cv9EF7HjiOZvQOQr3cBCH/qMiJVNrjeeoXEiqX32VqtUDcHOK2Qdw76MAVLos
	 FBzGS0BFL7pviE2d2Nie27Gma/lSXFQs/F4BOhfgnYd2J2aZLMgzcbVTeNSdLECyuD
	 CiTFupC73iF00Hw7hMnj65TYZpvx6DQxIYQIFwB2qC8cHimWGpop1E1/OEMrUluw2M
	 fLtgQZK9pMhWqlPASUmEhO0vHIt06DXG/Lt4P09SnFjkHZYbQzyx3cy8L7PhwliR+Q
	 P4Hw1ek4HJPug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A50BC00446;
	Wed, 21 Feb 2024 22:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ver.2] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170855462910.28356.12191334633977961990.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 22:30:29 +0000
References: <20240214162733.34214-1-kovalev@altlinux.org>
In-Reply-To: <20240214162733.34214-1-kovalev@altlinux.org>
To: None <kovalev@altlinux.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, nickel@altlinux.org,
 oficerovas@altlinux.org, dutyrok@altlinux.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Feb 2024 19:27:33 +0300 you wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> The gtp_net_ops pernet operations structure for the subsystem must be
> registered before registering the generic netlink family.
> 
> Syzkaller hit 'general protection fault in gtp_genl_dump_pdp' bug:
> 
> [...]

Here is the summary with links:
  - [ver.2] gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
    https://git.kernel.org/netdev/net/c/136cfaca2256

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



