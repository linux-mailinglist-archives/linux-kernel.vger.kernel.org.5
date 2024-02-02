Return-Path: <linux-kernel+bounces-49830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37AC847024
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8B6292F13
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C821420A3;
	Fri,  2 Feb 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBI1ElvJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667FF14079C;
	Fri,  2 Feb 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876430; cv=none; b=i2HanE1zm1YPZ0VCQ9UJAiZwP3wgszqVr5pEgBtn14OON8LvrVxrvr3OLR9PR2gAN79A3HNGmmgwvrVPJ9Cn5H/7GVFotewX8QYBmRauyJrqiYbblRUMoiuiNrg0lpwkF8ySe1VFwYwKpubkHUHFeEDYZEazEa9/QOZGOBFBK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876430; c=relaxed/simple;
	bh=FV0ha3qJz0mYOJpLNPsy90g8FeOobYwSB7UjsP+sQ20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hJnd5riFZug5OZg+isXV7fvm1PnhOIO/2ANL3CZhNmJszQZtymeksTHxph8gF4452o4rKXKF5x5gpF/ik0lsSXHNFqO34I/hzyhGvJTrVyzMLMz2kYPSJpsH2xGH5sdctcGmXbfyEoKNimCNJBTTxrYUozD6xT9KGczMDtL462Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBI1ElvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0869CC43399;
	Fri,  2 Feb 2024 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876430;
	bh=FV0ha3qJz0mYOJpLNPsy90g8FeOobYwSB7UjsP+sQ20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LBI1ElvJpI6BA+juTCP3EffNxoLiuAdevcyYndlcAIQw0cKOIh9FCZ2xH/4HE9ry7
	 Cv20J+U57gF/kRbGmV9uSXzZi2enp2h22B5S0Bggfj0U9ULFSF9qhKZllfIJ4Wacar
	 bAPZXsMZU4gf3RADXVUTLnvIJVqgAgpNtc5X8opTQZoL3bsVNpcQqIZkuUOmeljFUy
	 I5MLxd1K43D5xZ24wJaEjASyU04HHr+FsLXtmlI+v1dQzv+pvzH8wcKFRte4CjSKFd
	 CHyNM2rFuOB++WKUh3v7edmuK8c7gPWFrJHSrRqpsH9RGH+mhx45Oby236kY5bTZfA
	 CdonEVvb+HCJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFB3DDC99E7;
	Fri,  2 Feb 2024 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dccp: Simplify the allocation of slab caches in
 dccp_ackvec_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170687642991.27809.3782875181223836265.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 12:20:29 +0000
References: <20240131090851.144229-1-chentao@kylinos.cn>
In-Reply-To: <20240131090851.144229-1-chentao@kylinos.cn>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 17:08:51 +0800 you wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  net/dccp/ackvec.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] net: dccp: Simplify the allocation of slab caches in dccp_ackvec_init
    https://git.kernel.org/netdev/net-next/c/20ea9327c2fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



