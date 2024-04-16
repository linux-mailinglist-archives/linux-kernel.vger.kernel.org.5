Return-Path: <linux-kernel+bounces-147092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63A8A6F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EE928282C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C4130A6F;
	Tue, 16 Apr 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMSL+G/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279E12F5BE;
	Tue, 16 Apr 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280234; cv=none; b=o1YwDYojJVZHR9uky4//IxM/Z+v/PHzFUkPi39MrqfgaW+9hWp3vN+ngMDytfzsyosuecb7lsd6JXb+8icg1sB2o+XMZWrfKLVyMmArVTjHOlWkY4lN3ZxnZwm1vda7N4F/NmpawiWN3b7/5NkpRTy9yO2Ti4jt/mrq3aEgrUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280234; c=relaxed/simple;
	bh=EynJteTSYwVUCDspfJuwfZvpXYtJWb3TyxjoSWqOUY8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OLkg4tQQKKwgRjYXlHZcOK5YeC5iuPtqvwMMXlqaMd+OtCcH8aXJ4di6J/41+kA0zoHChUiA/kjNuYXxO+pBpn+le4NSoSimK1Iws0zOJ4hAyIid4rN30lLqtS95uwFoCrDwlWQ/J45kCqMaNN3bw+WpdYPZP8xLqpIOMQOGNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMSL+G/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E22CC2BD11;
	Tue, 16 Apr 2024 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713280234;
	bh=EynJteTSYwVUCDspfJuwfZvpXYtJWb3TyxjoSWqOUY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KMSL+G/pmCDi++6Er37OvlFbftDX3KboFoHhgQV3hLtIgNTlfuvNyNP9H0Ua9YJ26
	 DXKIiaci1fe+1OnWyQojrCpAn7PTUmYdHHsHWlb+KUvE3W+HB3SD/sR0AtGTzqdkCx
	 XSnTtoVwLfT09B+WFDeeiTfXgSSEaU3Iplgkav10hHxbgAfaFbu1sghripiS7A+J5Z
	 9/G34PEjdqYHy/0OwgULhQi2B+sU/pKutGEb5ZwohhZpKYKRAnzFxHzlE5B7E5uezi
	 3r8PWFL27OWFvh3w5CDeyWMFE03p4K1oZws9n4yRSCmeA3Rs4gTBkUPk0shvkBFYk0
	 Deyhdstu2piNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A23EC395C5;
	Tue, 16 Apr 2024 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171328023410.16225.6796027488142953241.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 15:10:34 +0000
References: <20240416091509.19995-1-johan+linaro@kernel.org>
In-Reply-To: <20240416091509.19995-1-johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, mka@chromium.org,
 dianders@chromium.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_janathot@quicinc.com,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Apr 2024 11:15:09 +0200 you wrote:
> Qualcomm Bluetooth controllers may not have been provisioned with a
> valid device address and instead end up using the default address
> 00:00:00:00:5a:ad.
> 
> This was previously believed to be due to lack of persistent storage for
> the address but it may also be due to integrators opting to not use the
> on-chip OTP memory and instead store the address elsewhere (e.g. in
> storage managed by secure world firmware).
> 
> [...]

Here is the summary with links:
  - Bluetooth: qca: fix invalid device address check
    https://git.kernel.org/bluetooth/bluetooth-next/c/00567f70051a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



