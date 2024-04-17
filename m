Return-Path: <linux-kernel+bounces-148684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFA8A8628
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2E4282171
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BFE13D2AB;
	Wed, 17 Apr 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9T5SOC+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6222334
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364790; cv=none; b=KJ58oF5tweIitaMBAPDfYAb7sM+F0zJz0Y9UR/M6Ei3+zmERejEVJ/bWfNsoN/bK3GqpoloBT2wCYQfSFYop1zQKf8t2rGG+txfQWwoSRfqpuHeVlVrMfeYxa7oYn1/MGvLYJVYU/8F0xV6vcKriL95PQ/S0tPAiyCNDqvB7n9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364790; c=relaxed/simple;
	bh=oaCCmN1lVY7S22xF8rXCzmvkdga+euN0QD+4m2z6Dyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZCcHmBra7qG4xH51IXWPNap/fn/MTUW3cZxmcHd5mJrlOk+vCuqwH6x4zUPbDE0HizoYq5xxgq8V1GGY0HQ+6+dYMx3252IhHXv2FcaI1xcmtKSyBdoOngZrKdDDAsH0+MFmZTKXgUlDIdjPggV9KimIsAR5ifQgqea1zHL5RTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9T5SOC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC817C3277B;
	Wed, 17 Apr 2024 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713364790;
	bh=oaCCmN1lVY7S22xF8rXCzmvkdga+euN0QD+4m2z6Dyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N9T5SOC+NMSEd5N/rF7+d0rirtIHxnH0pfW/aWxODxkFbFoLmGJMeNvlvRaa4HIep
	 IkAXvRoCEIok1DNwroeIhBg1HcneeYdbzqfFqTPm+Xu3U8ZZBV4nedLHanOaG4YG+k
	 VYdBQac5Ej11UCqlhgW89uqGXhk0gnE0e5GLRmb1AFS4p9thvidA0ideyU/xBNJTzx
	 ZPONBtJT72/hLBe6Z/ZZ/9fGB+6LAFISnu6DGxDSJRxGGIfwd1P2LBNERtrDPKE2El
	 igCKkt6UT7+BAeLj1aiAUiZxXfTG3s9/vDNNv9wKY9TKHkIS6n8/OPn+amBm3PHSvg
	 TZ7klaPze8uzA==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Zhang Yubing <yubing.zhang@rock-chips.com>, 
 Frank Wang <frank.wang@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240415174241.77982-1-arnd@kernel.org>
References: <20240415174241.77982-1-arnd@kernel.org>
Subject: Re: [PATCH] phy: rockchip: fix CONFIG_TYPEC dependency
Message-Id: <171336478653.736784.62229019778133904.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 20:09:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 15 Apr 2024 19:42:25 +0200, Arnd Bergmann wrote:
> The newly added driver causes a warning about missing dependencies
> by selecting CONFIG_TYPEC unconditionally:
> 
> WARNING: unmet direct dependencies detected for TYPEC
>   Depends on [n]: USB_SUPPORT [=n]
>   Selected by [y]:
>   - PHY_ROCKCHIP_USBDP [=y] && ARCH_ROCKCHIP [=y] && OF [=y]
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip: fix CONFIG_TYPEC dependency
      commit: 9c79b779643e56d4253bd3ba6998c58c819943af

Best regards,
-- 
~Vinod



