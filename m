Return-Path: <linux-kernel+bounces-164497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C238B7E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36791C23003
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C07D17F37A;
	Tue, 30 Apr 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PairxiMw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3717BB0F;
	Tue, 30 Apr 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497033; cv=none; b=WkFtPy8vTIaxTUE/iey0omS/iaVRaIQvvq4faQkBAQxC+ZUPE3hpLFzTuLgsvMCD2thW+zOlNjYkU2fN/AIfISx34kjBjffW6ZiTGE8K3I9f7IqYoKj/TvxIEZHWQfkZTdzc7NQLLvASN36gWcNQe4jHgOfaCifAv4dUyFzG7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497033; c=relaxed/simple;
	bh=ckFa3745nOlVI+kSJBt0f5SNB7YdeZaGKsf397a2N68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KEhIRNLMLBFBXkRU5TtYs8ebccYLMyZ2QePzb/j5s9b1KeyW77uhsTTOfIAWGpoppSJwgLc+X+0eTAIO0h3i7PNTDK8LsGO807JAAGMxSfr6XlKJrF1LfU1ONEvcLgdVBBcJQroCxWJIs7IzAKqDyAJvSGNRXNKoq8T5ys+/lWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PairxiMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF8C9C4AF19;
	Tue, 30 Apr 2024 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714497032;
	bh=ckFa3745nOlVI+kSJBt0f5SNB7YdeZaGKsf397a2N68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PairxiMw37PbLj9NZl2NhLSpKvW9Rx7wYvrcXAu0wTA2bum7IcqwvvaE7UN4MJtQX
	 x37JBBM1iAEh6iEKd3UAWD0m9trG+J8QUX1c8Fk8bryk2hgwjXluDplfkyEaGv/PMT
	 THAIDaKMYAT997w1AvqIwQ8rMPE3NRWxs4Vtc49zvfnTuzdLuyLU/U00VwCImQG4Lh
	 Lc/GdQoQcoXmrjUoIKUtd8I43Ifseknc/Tn8SutQmpY6EgE6JwLzn0vcZJTghMOA3f
	 ujFm3utSeov4Nmzv0/b5pclDGDXuHg+vXwdLX1YVVEMyifL8KVLPZqslZXmWpRYtOu
	 9fgCIHJvupZyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAAA2C43617;
	Tue, 30 Apr 2024 17:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: msft: fix slab-use-after-free in
 msft_do_close()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171449703269.32532.7945042735824867820.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 17:10:32 +0000
References: <20240430162049.1516720-1-iam@sung-woo.kim>
In-Reply-To: <20240430162049.1516720-1-iam@sung-woo.kim>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: luiz.dentz@gmail.com, daveti@purdue.edu, marcel@holtmann.org,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Apr 2024 12:20:51 -0400 you wrote:
> Hello Luiz,
> 
> Tying the msft->data lifectime to hdev by freeing it in
> hci_release_dev().
> Also, change msft_unregister() name to msft_release().
> 
> How msft is used after freed:
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: msft: fix slab-use-after-free in msft_do_close()
    https://git.kernel.org/bluetooth/bluetooth-next/c/91708e8a4376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



