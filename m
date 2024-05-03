Return-Path: <linux-kernel+bounces-167935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8638BB157
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAD01C21784
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62D1581E9;
	Fri,  3 May 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMZOIjET"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C68156241;
	Fri,  3 May 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755630; cv=none; b=EiLGsPfyn6WxPrp57kMw6WDX+qnw+gYb4lyVwaHLhPxXDKfTdlZfw5a3opyhN5Iroo9EXICgIda0BSxf3yM97VB5DBLpEaQ2agALcc96KtE/ULRAT0F9XDQ3fYvZ4qe71UORisgU0+Qfv7sjz5PbBd39L4nTppsC45a6IWj8Ct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755630; c=relaxed/simple;
	bh=xychJx0gxN4Wh8S2y7zpJJcG4VRsDR4oFVHA09yKLJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I0ncFv7wWA2Mbk6Wip+ZNtRF0wjr+6wzQnv2/MHnnUsWcEggv7naSr5Ccui/wxKWGuHjw0H65EHQ37EPzFQSEFuWWIsJ7GhGkg/pQToI99FDNo7J6pQLKJElBvpqpW/Nq/ydEsUYExRTwVCoEp++jBrTr1EvbkRC3hmXkffs+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMZOIjET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D63E4C32789;
	Fri,  3 May 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714755629;
	bh=xychJx0gxN4Wh8S2y7zpJJcG4VRsDR4oFVHA09yKLJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nMZOIjETU2vsOVyocz0PBQzv5HUA2YyaxmmD2ZZB4A7xdwARk2yAvL7gDzvxOVFeC
	 GUsVgAJVrHQ4x4kYBE2BRZRsZpItpxSKJEJXoQVwlNzMREgpNyX38bIHpHbg93dm2F
	 eNAH8D07GetOl1JmbtWJ/MujvN5WBH8vdZI7iz2mqExZut1AeYVqfSmw7A89v1IUJe
	 HCCaiChMg/MlU/ZQfysqAtavr0PeAEZ47XNIXqkxtk4rRXwJ0ummesJeRF4j3fEm/D
	 YDv8cquoTYP22MHzhs/+cn6KJLbRJIUEGwrTHC7KtdD+plqfaoXfyFMeFTnw9qIju1
	 hx5KWYbwKqklQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0259C43336;
	Fri,  3 May 2024 17:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] Bluetooth: hci_conn: Use __counted_by() and avoid
 -Wfamnae warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171475562977.29614.6298254643721435482.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 17:00:29 +0000
References: <ZjO9qCx10KUJbK6w@neat>
In-Reply-To: <ZjO9qCx10KUJbK6w@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 2 May 2024 10:22:00 -0600 you wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> [...]

Here is the summary with links:
  - [next] Bluetooth: hci_conn: Use __counted_by() and avoid -Wfamnae warning
    https://git.kernel.org/bluetooth/bluetooth-next/c/6d18d5b03ee1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



