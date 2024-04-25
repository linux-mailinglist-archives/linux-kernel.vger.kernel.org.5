Return-Path: <linux-kernel+bounces-158901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC28B267F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A101A284A23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61414D457;
	Thu, 25 Apr 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQDmqIgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C21E877;
	Thu, 25 Apr 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062633; cv=none; b=fgx9kiQSXgXiHTVy6JadD5EBrMmdTW4ChCEctwYDClHObvtmb1H/8t9C2rTP0ir2xyiURCCti/iBrrCTJLkMq+FJSjav/NiUp0HSho8/8hgedd1GkRmYw68kpiSt9aST084WrDDHYjN5vOTCvAJxU28l4k0SY+zUmuzh0a9Ojec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062633; c=relaxed/simple;
	bh=BHCta2OxYcR8v7BuTv23WDtpEtEmrdZZfulRSy8cqDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hD6Nx4sX38eJcOtD1dHUC/u0gP5xbQAhpP5wXU18M2TW9F6z66dznyQEV4osS+jar3lCL7h0BIRaCj+dkssiAQ6CSPA0QgIXpT83tRvmOYZ1s5KBrUp9oCicJvfxLz6vVp7VCNulX8PVbp6AxarE2haWT3fSd44IcJZxR2jI+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQDmqIgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B61CC2BD11;
	Thu, 25 Apr 2024 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062633;
	bh=BHCta2OxYcR8v7BuTv23WDtpEtEmrdZZfulRSy8cqDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eQDmqIgIMgq3ofNEMQUolGl4aNgGsMCSYY77LXfM0Esf+oHkpYUFXPQJ0MQzaiWz4
	 tmSHtiOR0M1ixGr2vvEGGQJEw59VxB3NcZOV+Yu23gWAoltnonwpDp7wK+mbasaFuG
	 /eLMrUAwASwu+BUC4SkwFhlMGaIFxPpletAtbGlNXqHGczYkjgFhOxfSFWrE7DVTgQ
	 ywk5V5eSs7BgWGPAPp7+7PgeklYkf2051ZQHgpjcX28E4f+17MewZW6wmpjPnho/lt
	 FDbXQ2b1JwxMVvVMQ/5V6Zw4pyd/t10oE0KDLckHp2gmu+YwR8y9YFQzVhko9jZJEx
	 23onaOBuH68fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04A54CF21C2;
	Thu, 25 Apr 2024 16:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171406263301.12899.1823558479194537202.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 16:30:33 +0000
References: <20240425041128.3093970-1-iam@sung-woo.kim>
In-Reply-To: <20240425041128.3093970-1-iam@sung-woo.kim>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, marcel@holtmann.org, johan.hedberg@gmail.com,
 luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Apr 2024 00:11:28 -0400 you wrote:
> Hello, could you review the UAF bug and its fix?
> The stack trace is at the bottom.
> 
> mgmt sync cmd could be used after freed in this scenario:
> 
> set_local_name()       ... cmd is allocated, set_name_complete() is
>                            queued in cmd_sync_work.
> hci_error_reset()      ... hci device reset.
>   hci_dev_close_sync() ... close hdev, at this point, cmd is freed.
> set_name_complete()    ... callback from cmd_sync_work. cmd->param causes UAF.
> 
> [...]

Here is the summary with links:
  - Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work
    https://git.kernel.org/bluetooth/bluetooth-next/c/37dd04e4d594

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



