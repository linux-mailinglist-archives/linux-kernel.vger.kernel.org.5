Return-Path: <linux-kernel+bounces-151918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439928AB5BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BB81F22A44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5713C9BE;
	Fri, 19 Apr 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUvR2KTl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11297139CE8;
	Fri, 19 Apr 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713556229; cv=none; b=LyiiLQKqaagKRDEBSzwS8eMUIrxru4ynTmYiDldhkUmrJcAMhNNoysROLIJDwDJHK41WCYsW9BizTWDNwJVUtEg+N4xphEQp/R3s2PZguhz4f+M4IX6IRe/zlrZXDzY0yrt9U3c2X7cKJirnscr1oMx84CCDowTQUOT5vqKhJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713556229; c=relaxed/simple;
	bh=x65GC0z98wTskh1l/wQIaNPdpvTmTWBoTgqMEUh8VgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ElsiDA5urlSyg9f+5/b9leJTNZL9WniMzh89huY/YomrOHaI85Kif6b4RxZJl8aglebdu9rkw3l9Q2O+dGb3A3n+ekzWrY7ZvdPJUAaXbnktEZ/kGKcSDz0ZsrrwJtELieQ3XGtRjgPFVAWsF6a7eMpjG//XL+sjunbOwg0qQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUvR2KTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BA63C2BD11;
	Fri, 19 Apr 2024 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713556228;
	bh=x65GC0z98wTskh1l/wQIaNPdpvTmTWBoTgqMEUh8VgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bUvR2KTlwI0I5MlLSJBpJhei/zHRCUBNLss9x0eWamMcK2+V+jhLoKwvL5Mzq6yNB
	 7dO/TBaVHUDla3aregIl0rtjUoY71QPxKGHNbqQIxI5VAmfayqp6oopTVv76rzrKpc
	 UfAHNkxu8PrRcaZQxXlr4veHAZtdL1Dle150bQhA2+0R/XOoOZC1hxpPW0sZ8klc70
	 V6MsTq/CHF9NYEJj+s0aJhScInyFiWdaO5T0NroIFYuHyynKF8/KFyfx9xItV0z4NJ
	 cfTcrysGnH4az2uejPqUtjwITLPA1RgO3x73g1Q6oKEjpbTF6ZBIrzakNIe1SMoqlI
	 utxJnHgx7sYqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B967C43618;
	Fri, 19 Apr 2024 19:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] Bluetooth: btusb: medaitek: fix double free of skb in
 coredump
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171355622856.26355.12127979464027120079.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 19:50:28 +0000
References: <da0859c4b24d314d9ff38179c26a58ee7e3f16d6.1713395895.git.sean.wang@kernel.org>
In-Reply-To: <da0859c4b24d314d9ff38179c26a58ee7e3f16d6.1713395895.git.sean.wang@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, Deren.Wu@mediatek.com,
 jsiuda@google.com, frankgor@google.com, abhishekpandit@google.com,
 michaelfsun@google.com, mmandlik@google.com, abhishekpandit@chromium.org,
 mcchou@chromium.org, shawnku@google.com, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Apr 2024 16:27:38 -0700 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> hci_devcd_append() would free the skb on error so the caller don't
> have to free it again otherwise it would cause the double free of skb.
> 
> Fixes: 0b7015132878 ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
> Reported-by : Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: btusb: medaitek: fix double free of skb in coredump
    https://git.kernel.org/bluetooth/bluetooth-next/c/6764ab72237d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



