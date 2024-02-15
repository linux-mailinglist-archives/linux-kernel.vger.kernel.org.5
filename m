Return-Path: <linux-kernel+bounces-66906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977385636A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB16B288ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C723C12D755;
	Thu, 15 Feb 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcyDV74M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF312CD80;
	Thu, 15 Feb 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000827; cv=none; b=KLYvqU0kKJu6MY+PpVgu/q5ZawYEkerFT+ajq5uXsnuJnh1KbuEAyVEADbSQIoWDb+sX8ifL0gzNdA2CVYyVBSEdMLWAsk9DWWUzBZg+wbVdC7NqMv+tPx6+9oWA/59xf/N39bZhOR+gEsLrtIRZYowsABEe2d1B2ORs7vnpggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000827; c=relaxed/simple;
	bh=93NFgxagbaSIqUl1DCES332PMG6zuiVgh/ky5VxmbgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QTIfK+MMuCpOaI+jR2kQwNJLyueXUIh+U2ksu4aInKtf8+pdXFrP4J0fup6lSTkJCnsONuK9JZ0MVME/QOPSipxhcjDW0UyMB2Wh81+i0ZYuFHpUgDOTUZI6HgnupbcXCGXdzClWoR6X4BcgGqMY+AaMjCzoZV2JpoUhPxuh9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcyDV74M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89A11C43390;
	Thu, 15 Feb 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000826;
	bh=93NFgxagbaSIqUl1DCES332PMG6zuiVgh/ky5VxmbgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kcyDV74MQ8YqsBypex6/67QB+C2xlOn0JDdWPD+VovgOTUQnS8goFFCwazfWa/ot9
	 SAHYX7L9jUzzUDAxGpNOPzu6E61/8ujS/ohzjO6QrGLYv3p9PjAo1qh73QitCSb20A
	 R5RNJ7YjKRLwQL4G9e44YAJEvXd40bg8Sd0s8CfnmWL0QQrG2ucqmZTBsXh3mhfC7k
	 HiZgjYev3ZlLLeDw7PqXUUk3uA2a3LEwmK2+A6NlWdTqERd14Bsn5tE6h8jLriX9pr
	 +16MbFzE8TROMqcXksuQbXkRa9cXFSMuQhMtMKu3//s13cKa4B8nN0Eq8Fns21dgKZ
	 4Z8rOQs20UNsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70754D8C97D;
	Thu, 15 Feb 2024 12:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmasp: Handle RX buffer allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170800082645.17816.14918539012782696298.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 12:40:26 +0000
References: <20240213173339.3438713-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240213173339.3438713-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Feb 2024 09:33:39 -0800 you wrote:
> The buffer_pg variable needs to hold an order-5 allocation (32 x
> PAGE_SIZE) which, under memory pressure may fail to be allocated. Deal
> with that error condition properly to avoid doing a NULL pointer
> de-reference in the subsequent call to dma_map_page().
> 
> In addition, the err_reclaim_tx error label in bcmasp_netif_init() needs
> to ensure that the TX NAPI object is properly deleted, otherwise
> unregister_netdev() will spin forever attempting to test and clear
> the NAPI_STATE_HASHED bit.
> 
> [...]

Here is the summary with links:
  - [net] net: bcmasp: Handle RX buffer allocation failure
    https://git.kernel.org/netdev/net/c/e5b2e810daf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



