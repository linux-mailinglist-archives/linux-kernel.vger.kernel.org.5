Return-Path: <linux-kernel+bounces-91682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E768714F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB28A1F22AF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC48A43ACE;
	Tue,  5 Mar 2024 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcFWtqMs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA79611A;
	Tue,  5 Mar 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614226; cv=none; b=NKKDglIOlGFEmQpjJHbrVgSFs3BtqZ3xHG24tWpHzEKVLAkRrj4hWtikZv/R7FgOEzM/8d4k8InnyzhQCk8XJfudP1Xdhk3QHaIugwOUX1tbn/v1B/ev8X07lwTUT93VGzkB0hMHwpmMueoOC07cpcBAGq+WjT82SHxQmfAt3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614226; c=relaxed/simple;
	bh=cKLuwCiUhCsy1B8eb8rtuf8JGOKZ6cC7a04LUww1DPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VMuy3EBEahhqcRXveopBuLbZ2GHPb6jXbkwfJwPzuDLY5aXkIJr940jm69eXlm7S++NPjD0da+56+YLYCTXwhGlaPvdmpq9OIRXoJ5owIU883a86ZdwRzBxB4iOSiqdzGkrnbBcQTBIkdid96am7GVWrKHxRr1fYN7lftRJh7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcFWtqMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94DDDC43390;
	Tue,  5 Mar 2024 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709614225;
	bh=cKLuwCiUhCsy1B8eb8rtuf8JGOKZ6cC7a04LUww1DPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IcFWtqMsVsIPEmcVKowxDYMHjn9G7zlhZFBenGbvmtEGgKT6xQj27wT8WhHiywZ4v
	 Hk2rSZr/Y+DR046aIxYS0IWvOQLcFBu4NCyIPwflyrB6Mppy6+l83417/9IDut0DF9
	 BqjptL4RFuLJAqQkpGqwndOmP4P+xpZSFUzmPn/m5UXbYySnzK6AUDclB8q0WgpALe
	 QcSA8zWgWL3EauWwzUkcaAUs17F2MLkh1JT+XsDlKffgO+SNRuKjOy+HToze6ZiPrW
	 1CJ8NrYLItOEClRlKjEREpNX2648heAoPcab3E1ras0TojkFOqSGfLS4XP5eiOj0fQ
	 RJXZP4v+H7mng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A9F4C595C4;
	Tue,  5 Mar 2024 04:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5: Fix use after free inside
 sparx5_del_mact_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170961422549.11055.14570418226395792148.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 04:50:25 +0000
References: <20240301080608.3053468-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240301080608.3053468-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 bjarni.jonasson@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 1 Mar 2024 09:06:08 +0100 you wrote:
> Based on the static analyzis of the code it looks like when an entry
> from the MAC table was removed, the entry was still used after being
> freed. More precise the vid of the mac_entry was used after calling
> devm_kfree on the mac_entry.
> The fix consists in first using the vid of the mac_entry to delete the
> entry from the HW and after that to free it.
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5: Fix use after free inside sparx5_del_mact_entry
    https://git.kernel.org/netdev/net/c/89d72d4125e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



