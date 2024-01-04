Return-Path: <linux-kernel+bounces-17281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3265F824ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C546C1F22808
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFE42CCCF;
	Thu,  4 Jan 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBk9numn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65902C857;
	Thu,  4 Jan 2024 22:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67BD3C433C9;
	Thu,  4 Jan 2024 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704406826;
	bh=Jn4T0B5wwaKEY8ncGAfsMVFvyghd4aVAmoAoz7sR8iI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VBk9numn2jGap9l0Um73an2WgbasH1U8Pkx/mij2HeQKbAjZBwoNEw7Vwq+LFaygv
	 UauwQrEw2juDjMq+fzL4f6NaMOhZeegoibjd3pCVAUM60LV4iaMQ+Bqh0knMV9YXwC
	 rACnVzQXLWJhcj3kQ3qSnO+3K0U/7UgqRAcEaJVAHihmQ7sltvyzq5Dn29Ov9U6VIf
	 rNUoT6wPYlKyycWI9VJxzpv8xHFtjqiH+cOQuhrRk1R/bulo3a8ra1ry96X2aS0YlB
	 6Dj+WWbw5dKDVIZ+pEagREj1xbFaoElS6W5GZJDA+XEG3mvUu5/zpidX0eOihPUxFS
	 Hax6yFvd2k0+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FBB9C3959F;
	Thu,  4 Jan 2024 22:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Avoid potential use-after-free in hci_error_reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170440682632.8457.15681827016026801324.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 22:20:26 +0000
References: <20240104115453.1.Iaa08c695d3dcf819910ea723c3eb502935638172@changeid>
In-Reply-To: <20240104115453.1.Iaa08c695d3dcf819910ea723c3eb502935638172@changeid>
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 linux-kernel@vger.kernel.org, chromeos-bluetooth-upstreaming@chromium.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jan 2024 11:56:32 +0000 you wrote:
> While handling the HCI_EV_HARDWARE_ERROR event, if the underlying
> BT controller is not responding, the GPIO reset mechanism would
> free the hci_dev and lead to a use-after-free in hci_error_reset.
> 
> Here's the call trace observed on a ChromeOS device with Intel AX201:
>    queue_work_on+0x3e/0x6c
>    __hci_cmd_sync_sk+0x2ee/0x4c0 [bluetooth <HASH:3b4a6>]
>    ? init_wait_entry+0x31/0x31
>    __hci_cmd_sync+0x16/0x20 [bluetooth <HASH:3b4a 6>]
>    hci_error_reset+0x4f/0xa4 [bluetooth <HASH:3b4a 6>]
>    process_one_work+0x1d8/0x33f
>    worker_thread+0x21b/0x373
>    kthread+0x13a/0x152
>    ? pr_cont_work+0x54/0x54
>    ? kthread_blkcg+0x31/0x31
>     ret_from_fork+0x1f/0x30
> 
> [...]

Here is the summary with links:
  - Bluetooth: Avoid potential use-after-free in hci_error_reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/c6d011a4e7d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



