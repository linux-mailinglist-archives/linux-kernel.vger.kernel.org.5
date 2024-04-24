Return-Path: <linux-kernel+bounces-156577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9A8B04DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43101C2284C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D58D158A17;
	Wed, 24 Apr 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6SaCtae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF1157489;
	Wed, 24 Apr 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948710; cv=none; b=Z/u5kOqEPIpzb6ojr4kJMPsowbbsvE7l7S6xUsyI+XihyD4O5Z1/cZBex+ZcaS4ARmV3q3L5I4FkVqoRb62fVJkMDtSHAhIsGcdc4UcyM4O8zNq2XZeqFg2SyITPt8yOix+PqfDokNkyF4Ss2QxkpsmD0FNCSVn5NzuadUGWJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948710; c=relaxed/simple;
	bh=Rg4e9txP5oX9sV/aUZHZulZUF6DxQi+sn7vMiXtVOIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DwI9zrNDYyoZQ6GP3R17PaYOxutc8VJq2D27X6x1LHtNuSMg3frCTa2058f96c5tGd18hieUh7+olRFIdXzcxX6XbSOcCx5E8PTpCPs42tYQPtwHFHxudfehJk/dGnKDI9kGRej+6bygF6kxelH1sHJNUKhjKbD6HyA3qgefeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6SaCtae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EF8BC32781;
	Wed, 24 Apr 2024 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713948710;
	bh=Rg4e9txP5oX9sV/aUZHZulZUF6DxQi+sn7vMiXtVOIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b6SaCtaeUiH/y+HsEFw64JUzzAKOeS3mn22EIp2rvbeKz31/e3ZmhzLqHCVMicrFA
	 Yw9qzh9fD+S3fdYWiWHdBmSsJ/5ACVXrYQ6IN8ctCdmn5CuP5aB0X9TJplKi6lFG1J
	 CC3a2dozyo1x7GR7QZjhobhjfAkJDPCrJ3/v5aIuwwX6MGf+A3WEmPH7sBPckhjiZj
	 EreN0PL5vFdgQXAKkDOurK1UAPGWAWbWWhrLQMLKt/N8ZbQ6C9NPTletzHt2ELH76O
	 6654WmyRb0EPmnb70ejusDn1ai9k5dwMnaLiENPfLjHyIqZSc1XfsaKCnjtg7bmYZ5
	 NUiq/5hw0QfcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18605C433E9;
	Wed, 24 Apr 2024 08:51:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_uart: properly fix race condition
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171394871009.3441.4963068263841932091.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 08:51:50 +0000
References: <20240410182618.169042-2-noah@noahloomans.com>
In-Reply-To: <20240410182618.169042-2-noah@noahloomans.com>
To: Noah Loomans <noah@noahloomans.com>
Cc: bhanumaiya@chromium.org, bleung@chromium.org, tzungbi@kernel.org,
 groeck@chromium.org, robertzieba@google.com, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 10 Apr 2024 20:26:19 +0200 you wrote:
> The cros_ec_uart_probe() function calls devm_serdev_device_open() before
> it calls serdev_device_set_client_ops(). This can trigger a NULL pointer
> dereference:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     ...
>     CPU: 5 PID: 103 Comm: kworker/u16:3 Not tainted 6.8.4-zen1-1-zen #1 4a88f2661038c2a3bb69aa70fb41a5735338823c
>     Hardware name: Google Morphius/Morphius, BIOS MrChromebox-4.22.2-1-g2a93624aebf 01/22/2024
>     Workqueue: events_unbound flush_to_ldisc
>     RIP: 0010:ttyport_receive_buf+0x3f/0xf0
>     ...
>     Call Trace:
>      <TASK>
>      ? __die+0x10f/0x120
>      ? page_fault_oops+0x171/0x4e0
>      ? srso_return_thunk+0x5/0x5f
>      ? exc_page_fault+0x7f/0x180
>      ? asm_exc_page_fault+0x26/0x30
>      ? ttyport_receive_buf+0x3f/0xf0
>      flush_to_ldisc+0x9b/0x1c0
>      process_one_work+0x17b/0x340
>      worker_thread+0x301/0x490
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0xe8/0x120
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x34/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1b/0x30
>      </TASK>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_uart: properly fix race condition
    https://git.kernel.org/chrome-platform/c/5e700b384ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



