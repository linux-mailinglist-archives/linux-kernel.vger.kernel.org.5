Return-Path: <linux-kernel+bounces-136204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D95289D10F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D4C1C24284
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189A564CD0;
	Tue,  9 Apr 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLv8Fdlo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7454F92;
	Tue,  9 Apr 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633428; cv=none; b=F17KLNHv/jxkkoOcS48fcnUWn8Kv5DJuOSreNlepQyDbHjMAws/ebiOUm6Afh1i3EYDXJnoeE2tSfdI3w3m33VLN3ioOViHDEhS0AdUnIdL/mt8dsiHZgwRP8meJ6YU5bNDAlXv5e0Xvl0JWGhzmKIdVu5h6RjfYF2Oi3EO/SCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633428; c=relaxed/simple;
	bh=L5tzIGoQ7gaUtFhp7qnGTgQYqqM68d1PFfllBbHYRdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P7ebuu+t02/WjDk0N/5YfiYY9xeUe2iqs7w7DqrXeb4s8qje+peF7bYmLC4FzwL0VLAjCCFZjXtfZ51/CnUtssUcAJKQQFZ5vFhtBQA/446rjk6/EG8fAGBGkOf0TJnQ0DZYhsKmy6Y8AywxJezNV9qqYiacUPFRPv0begy+CTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLv8Fdlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3A71C43609;
	Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633427;
	bh=L5tzIGoQ7gaUtFhp7qnGTgQYqqM68d1PFfllBbHYRdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JLv8Fdlollq/RHlcJyd0knOy0EcqEPQ7LF520NCpR6f+BPvc1ZaMBrMT5K17mwnch
	 ypmkDfOqzUmtshkurj9QBfKTs/ujE+0HCnobvbLLkTNJp0yZ6Ro18B8ZuzZLpwVEwI
	 eauWkPjvSfeGCcqv16XeTHtICVJWr5QPPzJSKy6MVIo41pnJVFjwKDjKXIFDUYRLAS
	 1DR0YyBaQsh/0UsdKr8OPtZdHS+5pItGZfw1tW0pyCDnJJ+BQBSyg3pS9Ln5Xlz2xY
	 h4qCBjL9EomkCBJe4nEFU2uU4NY889woQAQBVz5dZI9+kY/HEuMvo+pyPEpcE5jTLU
	 mXZB7PxpraeAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA3BCC54BD5;
	Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] archnet: Convert from tasklet to BH workqueue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171263342782.31710.5359069621172585635.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 03:30:27 +0000
References: <20240403162306.20258-1-apais@linux.microsoft.com>
In-Reply-To: <20240403162306.20258-1-apais@linux.microsoft.com>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org,
 m.grzeschik@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Apr 2024 16:23:06 +0000 you wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/net/archnet/* from tasklet to BH workqueue.
> 
> [...]

Here is the summary with links:
  - archnet: Convert from tasklet to BH workqueue
    https://git.kernel.org/netdev/net-next/c/775d2e2b3028

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



