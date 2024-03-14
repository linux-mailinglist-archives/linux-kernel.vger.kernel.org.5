Return-Path: <linux-kernel+bounces-103263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9C87BD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBA81F24DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669E5A11A;
	Thu, 14 Mar 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MieWM5Ec"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250C58AD2;
	Thu, 14 Mar 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421230; cv=none; b=VsrtM+hHvvTteg7F1A4kJt5m/Y6pvfVdvGs5KgbfYBXiXI18ym4egf2XT0/c6Av4tjrDmhPeFMt7lwW/DloHga36FPXO+dvItpdTmYAWXvg4M5PSFxbAk5vggNAotLEJMQSKV4brqdOygxoSxB5wVlmndkmBqlwQuSaRwW5HnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421230; c=relaxed/simple;
	bh=DbVQHqNUOiF9cwvoomdtpUhXConL8TwOuW+UIdY8hTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qwk7j8TS+fHuBmLR0z7j8sVoxq9PQ4lVzPTrkh2+bBCF1t4A6uFuvHTyqawKeVD7EYzUsMnlh5xRQq++reUw/kSbWiOp0D3EoqdiFKTQlKtqqOspH75viz1i2vx8jim5peWoKjyLr1I+5lNqAnvPkz4zeOzXWNWlRQbKwKrryqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MieWM5Ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CF19C433F1;
	Thu, 14 Mar 2024 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710421229;
	bh=DbVQHqNUOiF9cwvoomdtpUhXConL8TwOuW+UIdY8hTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MieWM5EcNt82jf2c5sgvDJUcwqQ/UILDsGjkIzOYzoKJoJcHe0NT9JrBhX+NSPgHC
	 nBf5QoHetRvMLFBvsk7qNTjmJDHy1c3z4vztKLjXG1kHMaxrfJnk/VdFBKyuR/wmmo
	 GQYKQHOzxuf/FrKqe470PAbRtCkaSq0SW7Tt5n7XVPRylmw/EiiBGdZiik7ZD9xASB
	 UxVPPLdmKV7MoUz2VDoEqlxHJTTK6QYbUO5qCFwo9YzfD1w6KwiSOpCzttHDT/Ogz9
	 rNWIvJRLxESbpptN1GvaDZeiDaxfq92QZ1m2Z252fjR1PyMwwyY96w2AHkcVgrznTV
	 rj64y9vLwfNwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AC14C595C3;
	Thu, 14 Mar 2024 13:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: txgbe: fix clk_name exceed MAX_DEV_ID limits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171042122943.11983.9169028322185914388.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 13:00:29 +0000
References: <20240313080634.459523-1-duanqiangwen@net-swift.com>
In-Reply-To: <20240313080634.459523-1-duanqiangwen@net-swift.com>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maciej.fijalkowski@intel.com, andrew@lunn.ch, wangxiongfeng2@huawei.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 13 Mar 2024 16:06:34 +0800 you wrote:
> txgbe register clk which name is i2c_designware.pci_dev_id(),
> clk_name will be stored in clk_lookup_alloc. If PCIe bus number
> is larger than 0x39, clk_name size will be larger than 20 bytes.
> It exceeds clk_lookup_alloc MAX_DEV_ID limits. So the driver
> shortened clk_name.
> 
> Fixes: b63f20485e43 ("net: txgbe: Register fixed rate clock")
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> 
> [...]

Here is the summary with links:
  - net: txgbe: fix clk_name exceed MAX_DEV_ID limits
    https://git.kernel.org/netdev/net/c/e30cef001da2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



