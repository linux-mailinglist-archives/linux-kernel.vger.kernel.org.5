Return-Path: <linux-kernel+bounces-127366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DD894A61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331951F22FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BDC17BDD;
	Tue,  2 Apr 2024 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtSye/VO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A7DF51;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031627; cv=none; b=bg7SY1IsvdCXrfb8ejVaIUpHQp1nm6bAoj5XzdanoCLg+HNGKcT18pTyrHkD7ucQYaAUqIMhAG8HOmX7be9t65x6U6DvMQo38vuI3MArIRFf6Mh63lWDkNBQLUpvXHTmUX7i3ktb1Q1zDKKmYaZuiFgBZNv4NvSndyttI4NTjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031627; c=relaxed/simple;
	bh=L7V4ZZEpyzT6YE2KiK9DMqMh2Tqt3QHOgWStTMlGgG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kpPvtKsYuAmM15kVzQqha2DpYZzZr0mEMJGwso+VGatB3VICSU+XmTbzRWNvvOSJeDdcmbxdrBlZVBaFXx3CAp8DUCS24Tl/54ID+GVX+5601Ynkd0U4PAJk093SrlirMsfLin6M4L5i4NURjstm5dZu6k2SvabZdjhnOs9cS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtSye/VO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 265D0C433C7;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712031627;
	bh=L7V4ZZEpyzT6YE2KiK9DMqMh2Tqt3QHOgWStTMlGgG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BtSye/VOVudDINXRAbV+Ee300j9JSIf3h0KKgdxXTHTsrdThugg9UqfGTR7k81z/3
	 jDxCnisObVwAPrznku5iCRxYpKkz0ET0M5QEqAN2/dem0vb7N24efyHxWvsfibWHHw
	 whMAGDRoMQHlMbjSJ1f5i4oQfbWaAW1+TvJxugMFeL0iN8jYYMc6igIT4JYXTZpRZ8
	 ozsUYo33ezlkpRn0AJAdLa1E/3Y285zemvZQd2TVonpQmuIT21aiQIEvlvqo70/fJ2
	 FaW/HMuQ46/LRZGCILbHQJ9EXWAT5dSUF/8VXpaUNmaqjqXNwlYtM6koPBy+p2LnFA
	 48AEESCCqMzQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16028D9A158;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: micrel: Fix potential null pointer dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203162708.30104.15586785610130138957.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 04:20:27 +0000
References: <20240329061631.33199-1-amishin@t-argos.ru>
In-Reply-To: <20240329061631.33199-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Divya.Koppera@microchip.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 09:16:31 +0300 you wrote:
> In lan8814_get_sig_rx() and lan8814_get_sig_tx() ptp_parse_header() may
> return NULL as ptp_header due to abnormal packet type or corrupted packet.
> Fix this bug by adding ptp_header check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: micrel: Fix potential null pointer dereference
    https://git.kernel.org/netdev/net/c/96c155943a70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



