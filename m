Return-Path: <linux-kernel+bounces-104475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A849D87CE6F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D0B228FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97360376FD;
	Fri, 15 Mar 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSytP7bB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6E2CCD3;
	Fri, 15 Mar 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511228; cv=none; b=R/T+EYh2p3tZufFlgTSo07MM7LtSqG/QPCGXVEohsJIuuXWVPJuG2hIIkP0YCs0Ifogv85dRi3UjxXfzsBwbbCtBmfcglgnU346uLDEGFFYubEz2SbBiFadqdIKqlEQXZWQryARq2W6J9SO8ZVYnmTLzvhomDk9gARlNOzIvq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511228; c=relaxed/simple;
	bh=7DWJePM4r2xKv6SnP4rVkipsXTkNhZAmPSn/p3svg/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P4TcWwXancrz787/F9CUNu/COsM3v5KCRw2EpZAz7oQuPtKppAoeYIyiaZWKETznRtOU9z369o2m5AiZtmy76yT03lxvBqfOjl/lHjtQZyRi3tIq86j6mKbouDwdjbZva4q1o3/iwef1eWOFgAsxXvHZWibJlYQxyYdP8k0Fr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSytP7bB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC4FC43330;
	Fri, 15 Mar 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710511228;
	bh=7DWJePM4r2xKv6SnP4rVkipsXTkNhZAmPSn/p3svg/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YSytP7bBaa/dzBAN/IfjLNxTOUVcV70DDpHknUjUH3aZbBozMBhCxwf6s1M+UZtRl
	 P7YtIAcYCOP/6rb+TAIb4iQXa/jvSKII3DuevFwzIPBnfjp9a+Lic4uGK4oN/qtdiH
	 b9EIWAUStVzER+zkBv807VOBJ6mIB4iRauhxUZ184qJKmpQGIqhu9CMh1BEjcAY5uE
	 V8yibtfH+zMNTjZnnCK8SH4zOCr6rZBRgBShHPN7vreqeQl8ODCt4MFH09eglJQYzN
	 eIB9a23df7X81qr01Awbvns/JIDdsegjXFseAYnMsRP1COMoknuu1P7C+Z6y/yJGzR
	 OojsK1LOhD9fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4ED23D95053;
	Fri, 15 Mar 2024 14:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cxgb4: unnecessary check for 0 in the free_sge_txq_uld()
 function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171051122831.31092.16966126558261968540.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 14:00:28 +0000
References: <20240313153437.124749-1-m.lobanov@rosalinux.ru>
In-Reply-To: <20240313153437.124749-1-m.lobanov@rosalinux.ru>
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Mar 2024 11:34:36 -0400 you wrote:
> The free_sge_txq_old() function has an unnecessary txq check of 0.
> This check is not necessary, since the txq pointer is initialized by the
> uldtxq[i] address from the operation &txq_info->uldtxq[i], which ensures
> that txq is not equal to 0.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - cxgb4: unnecessary check for 0 in the free_sge_txq_uld() function
    https://git.kernel.org/netdev/net-next/c/237bb5f7f7f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



