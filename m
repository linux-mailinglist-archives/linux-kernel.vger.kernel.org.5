Return-Path: <linux-kernel+bounces-164854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD6A8B8401
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE60A28419F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1FA748D;
	Wed,  1 May 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPdA2TD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F114400;
	Wed,  1 May 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527631; cv=none; b=VQLgxZLSAsqGgLBtisuu2ZD4Mor6H9Vx0DDNWsaGfGccRS0cEcE9QCfCdaEDcrm206vUgnJu+Or6g/9mvwUrUiEYbWTteWcoK+poz5U29/9ZWIDi1t7tLECOASsYWKWP+RVwpHOGy8IBLcXfCvSPY/tejWwi9GmrBEWMVGSeNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527631; c=relaxed/simple;
	bh=ptTyktK7GZ8036WknfUkFHQgCjEBOJqYQcJNwsQO2Qs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kZyuyeDRL8vN/WU6dX1J4UkBkg8MLTuFZm8iUEgin9M9xAEO45ig+MHjAvLNcxV2w9joOlr7g2/yqJtrLozAqt43dwe++a0eBf9rETqVCkiHw9NYWcga7XFXj91JutJzR9ffxJcI9p3wC3ugtzOJyMdlGlAKILwPVYLEstTgw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPdA2TD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87B03C32789;
	Wed,  1 May 2024 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714527631;
	bh=ptTyktK7GZ8036WknfUkFHQgCjEBOJqYQcJNwsQO2Qs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cPdA2TD5rEfPxQh/uqJAMywR0GOOeMohIEJDl2O+MSNJu8DW2WYcctByxya5HW4YD
	 R+fFCLq3qcMF1lTeTovMvb3mY2bqZ/T9S2nHf2KqRl5mZJArg5OwTjfAn1tcR/kHZ4
	 WVhXq51sqbO9v712rwaT/+NM2WLsXMF4w8ecyoA6PnczyzefX3hCS9hcr3nBAZLhD2
	 xwZ0wQ06lIBAuAIH+WUfl33y+0JrV0F6h7zpGrFbGHvgSuFbxaGcyuRUoQm6JOf5vY
	 7QpTQ4shWh/alyoZBSHlqaq1td2hoNJCJXOGYtZ7g1fioZaCPnmNTBHDAu0pGxrJ4q
	 bFzScjCDDgZlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72818C43616;
	Wed,  1 May 2024 01:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] rxrpc: Fix using alignmask being zero for
 __page_frag_alloc_align()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452763146.16260.12414739867671113540.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 01:40:31 +0000
References: <20240428111640.27306-1-linyunsheng@huawei.com>
In-Reply-To: <20240428111640.27306-1-linyunsheng@huawei.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alexander.duyck@gmail.com, linux-afs@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 28 Apr 2024 19:16:38 +0800 you wrote:
> rxrpc_alloc_data_txbuf() may be called with data_align being
> zero in none_alloc_txbuf() and rxkad_alloc_txbuf(), data_align
> is supposed to be an order-based alignment value, but zero is
> not a valid order-based alignment value, and '~(data_align - 1)'
> doesn't result in a valid mask-based alignment value for
> __page_frag_alloc_align().
> 
> [...]

Here is the summary with links:
  - [v2] rxrpc: Fix using alignmask being zero for __page_frag_alloc_align()
    https://git.kernel.org/netdev/net/c/9f8eeea1643c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



