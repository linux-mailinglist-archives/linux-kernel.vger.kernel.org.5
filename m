Return-Path: <linux-kernel+bounces-99641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6125C878B57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A511F22434
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC459167;
	Mon, 11 Mar 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV0Tr8ay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7F58226;
	Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198033; cv=none; b=o3aTOssFRlFaOFk7YR9vukp0MxMYkg0FGvNO6zsaZaySrJnsy3IDNCbSaa0HvUrS3qSWbMTUGsF8RNITBHTAaTdC2icIbOyGEMUVWT31H5zuf3/ceTDmEq3x/55dVFI9MrdS8rfWb2yilOPti8WYQ1TJaM4AHTp6xxUn4LW0PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198033; c=relaxed/simple;
	bh=Ipf7CbYaQiMxNoHsRlekGLw4cARTTEmiRA/MDvT1UIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZmP9PFi7DmbmGRQqNL80mFY7eVZQxUzuxdOmPQK060wVcx5OmanPTRO/T1V1QjDEUK++EUbkK5a67FeIwItePMuRX3XkVY+r5l/DCPDmN1ReFnte0kfELVnV9HN/4BPX9GLT6d++b8NCkCKYu72xeKkOCgrTKJVCSJKBOhKbVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV0Tr8ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DD3BC433F1;
	Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710198032;
	bh=Ipf7CbYaQiMxNoHsRlekGLw4cARTTEmiRA/MDvT1UIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SV0Tr8ay8/3albZ95AjN4B9fV2t/mfDf09uUYIHT7ihYYVUsz9tjSVViNK0DwjEcn
	 3byrq226UVfpRP11dDfgierOapJxYUUwMtMDzHEPSUniVrJF70oNIJFtaLDZGv/DAe
	 t9BLBwgRwpglsLqR6Ae0HUX2Qd9NjYosIV2V80nop5aap8+rJPrZt2eAGgXMbhfUJV
	 GFksMH+hQ+Avw1yf8Lx/DH03F/3bYCAVFjCWhmMpil0caUfx6QSeQzcuVqVL7vK9aB
	 yx5MZj1hJ7xJizI5SlaEup0vX8oT8dPAVA0hJEospNxVXBZCfpYVkWJMvW9bE59mUY
	 BHh4ccxQ69KJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8609FC395F1;
	Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8152: fix unknown device for choose_configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019803254.14238.341720765177339423.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:00:32 +0000
References: <20240308075206.33553-436-nic_swsd@realtek.com>
In-Reply-To: <20240308075206.33553-436-nic_swsd@realtek.com>
To: Hayes Wang <hayeswang@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 8 Mar 2024 15:52:06 +0800 you wrote:
> For the unknown device, rtl8152_cfgselector_choose_configuration()
> should return a negative value. Then, usb_choose_configuration() would
> set a configuration for CDC ECM or NCM mode. Otherwise, there is no
> usb interface driver for the device.
> 
> Fixes: aa4f2b3e418e ("r8152: Choose our USB config with choose_configuration() rather than probe()")
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>
> 
> [...]

Here is the summary with links:
  - [net] r8152: fix unknown device for choose_configuration
    https://git.kernel.org/netdev/net/c/46590b545df6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



