Return-Path: <linux-kernel+bounces-158903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531298B267E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F86E284849
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79314D449;
	Thu, 25 Apr 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDkHDscP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FC1EB5B;
	Thu, 25 Apr 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062633; cv=none; b=mIab+4AK7G9bXLibEw32xjFOAsxDgmTw5w/pu7o2WJy+At+9MuppC2Cy1lz09TO5kVMYC5fMCoUSZEKrzn1ve8dIsZGo47pmFJPAUM4yT4I2Gt9fMaxrsvlz8v2WQ5/5jKV87cjSzSHXwqD7zkAIjwJ3W5g05qzQGPJ4yuyIIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062633; c=relaxed/simple;
	bh=jsV+g6dcp/pIHqii76sajx5QrBvzDbI+qZjPqKdiJd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q9u6byww6sERN9y84Prv+ob1mkGn0RM9p5z0vdOERgwtS6qbkyto8xIs+LziMxf070y6MANrJMiSDE1igLQrOcAljVpodVmvAHQKFZy7l1atoS/3ZQDDmC69VKX09fqKOARWgc7+iksO8ukxNvSA6RSJscsmYY7GR8e1sufl8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDkHDscP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16B92C2BD10;
	Thu, 25 Apr 2024 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062633;
	bh=jsV+g6dcp/pIHqii76sajx5QrBvzDbI+qZjPqKdiJd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uDkHDscPm4NVqXcNvLEVDtE0NMKO4lqqPrv2MlzVRfTZEE/mhaePesGRuT4JpQCSy
	 /zk1xVQ8s8NrcPpkR3UQXZH9/GSuAl6SetXcBI4Qd/V3erkQYhn/lbSpx1ng5EOF/7
	 wherGFQ2HpYMICMQBy9g3XYBmiS2MwDDfW+PHsJdunXOE4M93cFP/UEpXAnyzix0W2
	 o5TwpGQDaeXZXoHQAi7bF9R4kyh88Xcm9sxFz9N5+6ytoTKIb+xEXWCjs7xLet/yok
	 zKqwAL4fvEwZ/cbG4GLK9UtghvPIO0qeRvFlSKL4uCTlG9HAPAvDsOMkdchbrp1RMG
	 6iINxv+Hg4ZMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0F7DC43140;
	Thu, 25 Apr 2024 16:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: qca: fix wcn3991 device address check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171406263298.12899.12245456534188638302.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 16:30:32 +0000
References: <20240425075503.24357-1-johan+linaro@kernel.org>
In-Reply-To: <20240425075503.24357-1-johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, dianders@chromium.org, quic_janathot@quicinc.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Apr 2024 09:55:03 +0200 you wrote:
> Qualcomm Bluetooth controllers may not have been provisioned with a
> valid device address and instead end up using the default address
> 00:00:00:00:5a:ad.
> 
> This address is now used to determine if a controller has a valid
> address or if one needs to be provided through devicetree or by user
> space before the controller can be used.
> 
> [...]

Here is the summary with links:
  - Bluetooth: qca: fix wcn3991 device address check
    https://git.kernel.org/bluetooth/bluetooth-next/c/0a0f9014b784

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



