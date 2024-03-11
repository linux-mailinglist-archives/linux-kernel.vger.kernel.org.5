Return-Path: <linux-kernel+bounces-99642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186F878B58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0B81C216AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37B05917C;
	Mon, 11 Mar 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWv9maGO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72258235;
	Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198033; cv=none; b=B56o+8bhJ7v47VNUkqBMuH0wDT+rAW1PnAzMTMpBMd6B5EI4opBbGh7btG4sN0tbtQ4lbs/z2UptLkjLW8T+CkABx3aN7cGJYgvZuA15CkkE5U2dJDnMLRduPuGwOmNZbp2HTdxbig46lQSpYjmmr+DTaCtDXeFa//tzMAVuBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198033; c=relaxed/simple;
	bh=wvuvXYzjxk58JdcgcdXsECnG0HdLz5CGghUzu7FS5OM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tGUG7ZAAPQRL2GkuFgCpmuUJx0iKr3OIbBKhNJ/ATi0JXjILKbhzHBB2IF65UgDxyubxsc8y7YvP8AVUwqBjUQm5erZvTeKeeF3kVxIYfOKQB0Gq8z9OE5C9HgYS5Eygwec0VYUEIh4/oI5mfc8OT5dk06rOsHNOdCQGSQzHaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWv9maGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A97CAC43399;
	Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710198032;
	bh=wvuvXYzjxk58JdcgcdXsECnG0HdLz5CGghUzu7FS5OM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gWv9maGOUempka0C+OWMdC8v81nFRo6xevJjuKgqR/n33Ah3U2cU3DNnX5CmFVKn1
	 ZaP6rvlLx8RkD9wVIwaTptBT6sWHwGvkOYe4wow44ee5HO4/mMl/edz6HVsquc0MTR
	 Leez5yDJiY1skE55d22a9Wq+ClHvUCj1A6B5sKRVNrqAQYM5Lv8D4hyMIhscJXfckK
	 K5CeRXB6W294qLMKrjkiz4CJP9Geiw0U4sH7NGBMXm4JsNq9NQg/k6WjdEtoxM7NaH
	 MQ4fk73QEQnjbKmHY86P1nZuKOeP5JgSEg6X6xgMuxoCO58glkoVjX7onY7RQ9/uRv
	 SQSqfGipvmoaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DDFCD95057;
	Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] nfp: flower: handle acti_netdevs allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019803257.14238.8405013451298243885.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:00:32 +0000
References: <20240308142540.9674-1-duoming@zju.edu.cn>
In-Reply-To: <20240308142540.9674-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org, yinjun.zhang@corigine.com,
 netdev@vger.kernel.org, oss-drivers@corigine.com,
 christophe.jaillet@wanadoo.fr, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 louis.peens@corigine.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 22:25:40 +0800 you wrote:
> The kmalloc_array() in nfp_fl_lag_do_work() will return null, if
> the physical memory has run out. As a result, if we dereference
> the acti_netdevs, the null pointer dereference bugs will happen.
> 
> This patch adds a check to judge whether allocation failure occurs.
> If it happens, the delayed work will be rescheduled and try again.
> 
> [...]

Here is the summary with links:
  - [v2] nfp: flower: handle acti_netdevs allocation failure
    https://git.kernel.org/netdev/net/c/84e95149bd34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



