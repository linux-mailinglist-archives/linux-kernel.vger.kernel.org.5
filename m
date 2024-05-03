Return-Path: <linux-kernel+bounces-167937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E98BB15B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8521F231A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE71581F8;
	Fri,  3 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx9+OEdI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59654157A74;
	Fri,  3 May 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755630; cv=none; b=D0sPgNK26ESk+aXdIePdvLup7zwSv1ql3pTGet1WR7aq/NIJnCY4gaSgh0A6Ys71GfrbH+sZszQIPaA7Kec0s69cj6L2r5D+hpjC3TJeK38E6xT0TrOyhphyWzCa22Hm8yGXPG3HMAj4PxzXjMRgLK5yKEihUXCF67Tst8OcBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755630; c=relaxed/simple;
	bh=RNnAfOTCI9RTLbUU5DufVxa8z9JIVX9Jsb1vnHq1YU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GUDveoscMuTFNrfyeF+RhmWchTMWYhWFcfkNmA+fKxJEPK4qydN5gpJBmqSjVMV5hKqXGqX7KRuU93JSdIIjM6D0J8A06LXswutNi0/wiTHN4ZFNTSVvOGipIL7l4HyUG7YCvKtZLzJweeP4FQQQtjvj9CMpQEZVh9Vq5lIqCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx9+OEdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC9F9C4AF19;
	Fri,  3 May 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714755629;
	bh=RNnAfOTCI9RTLbUU5DufVxa8z9JIVX9Jsb1vnHq1YU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bx9+OEdIvCUa4TAFnL/VSL5rEvxu9/yIPUa/AHgYQVNFN8DPe94Y68Om/eTP0bXTo
	 4HItGzod4lhFF8IGRChp1IO8SeEbHpQFuvpkaKTdQJyG6r9GeiiKcNYvn6MhAVYXHC
	 4PU57eBj24iotUOUiZwIBzUxUjor9X3rfTVwaXLijKtWXgFPro8Hq+rGrI2BAFD5qh
	 ppSUmPgUMUtvaqDYCUQ+N1ajKKJ47Y1KRP4ZI66yaSIQefCl7l4tfz6PfVhZiW6L+F
	 RF+bLANwbNzzO9H37D3py5QkbjzLd5FiNRYYtkf2pvNTzXm+jA/YpuxK7UfL9vJWSX
	 VRGi5WwsO+/8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBA03C43444;
	Fri,  3 May 2024 17:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: qca: fix firmware check error path
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171475562982.29614.15220291572742565997.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 17:00:29 +0000
References: <20240501063740.32066-1-johan+linaro@kernel.org>
In-Reply-To: <20240501063740.32066-1-johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 May 2024 08:37:40 +0200 you wrote:
> A recent commit fixed the code that parses the firmware files before
> downloading them to the controller but introduced a memory leak in case
> the sanity checks ever fail.
> 
> Make sure to free the firmware buffer before returning on errors.
> 
> Fixes: 6fb81c405bfa ("Bluetooth: qca: add missing firmware sanity checks")
> Cc: stable@vger.kernel.org      # 4.19
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> [...]

Here is the summary with links:
  - Bluetooth: qca: fix firmware check error path
    https://git.kernel.org/bluetooth/bluetooth-next/c/8da121d4396b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



