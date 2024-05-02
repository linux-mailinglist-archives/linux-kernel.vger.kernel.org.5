Return-Path: <linux-kernel+bounces-166908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3E38BA1C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12131F22BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC3181317;
	Thu,  2 May 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO7JyiAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3A1635DB;
	Thu,  2 May 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683632; cv=none; b=giJbQqSB09TTP3nQlXrasyO8JfCr8S0+ltwJHnk2nS7vIwN9SzssUylI/L+gl6QeXmNEiMeb0FfDbUhBSe8i1u8m32i/bm0Lq9b1wxe/JRG5vHLb6xbbGmfSDkjeIL4mxPH0PYr+rBw3+gqG0yQ+rotJ/vqri5hWevYXsjrWRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683632; c=relaxed/simple;
	bh=wavHkSLS/2ManlnQhU0jt9AtHervsYOZvmpdknNuNdw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sbHIyqNGVnFYQvKszolaQRJQZFqRxRTrHhNPL2iPViV+Rfi85PhP3SX9NofwzSVLKMW/bGYGOqU3dGriHJfYnvSfC5pm1fj8Q3jkCG4hk/L9TxQeu7MzIhYFDYtk4Kk/2rz6VgeXoJz+3tle53svbTXM0GzuFm8jQpYPFxHgDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO7JyiAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5D4DC4AF19;
	Thu,  2 May 2024 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714683631;
	bh=wavHkSLS/2ManlnQhU0jt9AtHervsYOZvmpdknNuNdw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pO7JyiAHh4iMmC2QtaOY1Uzytq58sEwncbYFpbwKU9xYbaRjEEVU6MuoiS7ngjF8P
	 SWnugdHbYorUGTcapXWq4pJalCrIU18kBWaUe4y84KTro2S9sjlKTixjkStou6WJPE
	 zxW1a16S7xnW9HsI0ns8c3Y5oEmda/5ByAlTA6SjLJlQs3V8PZ33vYAvm4WnfMqNs9
	 STXrxk2upKcYHJQNx/poURgEKQReCoKa/KCCPmYfV8rLW8MPNn7vZzFa0SpyIYg8lP
	 o6fSvW5KhppoyLzd9MFKViCF7Tl4UmYMrQuVQLJeVtU9uOMbbLTp2VO67uc/iiHwMT
	 n1CT8lIIHzDrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A672DC4333B;
	Thu,  2 May 2024 21:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: HCI: Fix potential null-ptr-deref
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171468363167.27708.3688765583769901173.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 21:00:31 +0000
References: <20240502171709.1280128-1-iam@sung-woo.kim>
In-Reply-To: <20240502171709.1280128-1-iam@sung-woo.kim>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: luiz.dentz@gmail.com, daveti@purdue.edu, benquike@gmail.com,
 marcel@holtmann.org, johan.hedberg@gmail.com, iulia.tanasescu@nxp.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 May 2024 13:17:10 -0400 you wrote:
> Fix potential null-ptr-deref in hci_le_big_sync_established_evt().
> 
> Fixes: f777d8827817 ("Bluetooth: ISO: Notify user space about failed bis connections")
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
> v1 -> v2:
> - add a Fixes tag
> - make the commit message concise
> v2 -> v3:
> - fix a wrong Fixes tag format
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: HCI: Fix potential null-ptr-deref
    https://git.kernel.org/bluetooth/bluetooth-next/c/5c7d0f260187

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



