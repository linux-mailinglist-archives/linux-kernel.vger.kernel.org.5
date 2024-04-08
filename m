Return-Path: <linux-kernel+bounces-135313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9D389BEE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7FC1C221D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DCC6F06F;
	Mon,  8 Apr 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTd9wbmP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28016A340;
	Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578902; cv=none; b=C/ap8xeIg+MRm8UrrCLh/4rlnYyg5Ct0m2fH/XK0xTN2oTDrJIjKOFsv5TBNT3uemyFZWR43yeAQDoHoN3775+lcetDxLDDwHvIK+c/xag2wC5bMXXIiyhPCnbZjurKqr+FmXCTV6UXBjBZYQQ4mqs4Jpi3SRZ0ZCuk8W7Dz48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578902; c=relaxed/simple;
	bh=+wmN/AnzNilENyp3GYrx7rTjEa+yyO+OkP6khikeb00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YjVpVfveYHgdDnAe2/FnKP7uxmNtOnKbTopwkghi78jHbultYuppwPs1pZfAP/8TmZQw0xv0F3Z/ys1H1g4mU6il6F21UKtLorhqPDe4pSyfwaQYWDQ0880pO6Rx0opszujixmlm+ixF5pEhL7ucH38XIWlb/2qBlprV8Q+fH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTd9wbmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55198C433C7;
	Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712578902;
	bh=+wmN/AnzNilENyp3GYrx7rTjEa+yyO+OkP6khikeb00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KTd9wbmPduTyZXyrIYvaQYFFRLAQNuqGHUL5ND6geRMNjr7MH951K+cQ8+iR8zFV3
	 23Z00JD8b2u0xWH0WtmVE+FJ9ttpIRN55YE/XBnmp5QnixSoKbyMv7B5GMMxG6von/
	 9sHrX3zKEyb817dO+Inn7hsFaQagkr25lYkK3wv54FYApLtrscxEKSnDS9b6zCcXxC
	 b0C+tUqdaY1cM7GVSirblamQaJSYZ2lpkrQrzBFKs2t1Ym3dgG0Ji4XWmixm+pxJJU
	 IDq5CHEqh8HsqTbA9XIUw/ZshTdMBTp00EuaDQ4lLfsonagTnp8bs23XlVhErnoWuF
	 IRyZWP80lpYig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44E9EC54BD3;
	Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ipvlan: handle NETDEV_DOWN event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257890227.8472.5712754967060706726.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 12:21:42 +0000
References: <1712340972-13643-1-git-send-email-venkat.x.venkatsubra@oracle.com>
In-Reply-To: <1712340972-13643-1-git-send-email-venkat.x.venkatsubra@oracle.com>
To: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 maheshb@google.com, edumazet@google.com, kuba@kernel.org,
 gia-khanh.nguyen@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Apr 2024 11:16:12 -0700 you wrote:
> In case of stacked devices, to help propagate the down
> link state from the parent/root device (to this leaf device),
> handle NETDEV_DOWN event like it is done now for NETDEV_UP.
> 
> In the below example, ens5 is the host interface which is the
> parent of the ipvlan interface eth0 in the container.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipvlan: handle NETDEV_DOWN event
    https://git.kernel.org/netdev/net-next/c/229783970838

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



