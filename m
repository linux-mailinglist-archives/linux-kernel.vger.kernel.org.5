Return-Path: <linux-kernel+bounces-66346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DBC855AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8641728E6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8FD53B;
	Thu, 15 Feb 2024 07:02:12 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C09BA3F;
	Thu, 15 Feb 2024 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980531; cv=none; b=CEYDMdzaNlMJ7KUQr2aThN9ub8ci5R+UTR3kJLLXsAF+MkdqbmNpoXCdF2YC9p0o5HP2ze21DjFPNsoPRuFTKzg8TYUhnBU4q/Y9v+5zOMBQ/4oFF4tLQ0hQ5nJSKmx7LSPTrLF4jJnpMrxnNl5EfnK4k9DjuihOC1mlLHaUz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980531; c=relaxed/simple;
	bh=c1eutWs/h7+zqMutLtkSQP4xND8+gBTwO84eSFmq2Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHl0HQsP1DT/Ga0MSYK2y3gFx+JOd/w5rSP8tb57MbPBot34K8BNP3kTnY4FyyDTA765FQraYn/uKQSuKC59X6NdckyjYZDCf9kL7FogTatGwPK8TCDE9bFw4zRs7ASGNEd8ZQ7cjTPNzmefjKanKfRz/YbKalauxTrZi2tJ/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeca7.dynamic.kabel-deutschland.de [95.90.236.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A176561E5FE01;
	Thu, 15 Feb 2024 08:00:55 +0100 (CET)
Message-ID: <fc1be95d-b34b-4153-ba0b-f124180a33ec@molgen.mpg.de>
Date: Thu, 15 Feb 2024 08:00:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 0/8] drivers: net: Convert
 EEE handling to use linkmode bitmaps
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>,
 Manish Chopra <manishc@marvell.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20240214-keee-u32-cleanup-v2-0-4ac534b83d66@lunn.ch>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240214-keee-u32-cleanup-v2-0-4ac534b83d66@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Andrew,


Thank you very much for this patch-set.


Am 15.02.24 um 12:13 AM schrieb Andrew Lunn:
> EEE has until recently been limited to lower speeds due to the use of
> the legacy u32 for link speeds. This restriction has been lifted, with
> the use of linkmode bitmaps. This patchset convert some MAC drivers

Maybe reference the commit introducing them?

One small nit: convert*s*

> still using the old _u32 to link modes, with the aim of soon being
> able to remove the legacy _u32 members in the keee structure.
> 
> A couple of Intel drivers do odd things with EEE, setting the autoneg
> bit. It is unclear why, no other driver does, ethtool does not display
> it, and EEE is always negotiated. One patch in this series deletes
> this code. Comments on why its actually useful and should be kept are
> gratefully received.

Nice find.


Kind regards,

Paul


> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Changes in v2:
> - igb: Fix type 100BaseT to 1000BaseT.
> - Link to v1: https://lore.kernel.org/r/20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch
> 
> ---
> Andrew Lunn (8):
>        net: usb: r8152: Use linkmode helpers for EEE
>        net: usb: ax88179_178a: Use linkmode helpers for EEE
>        net: qlogic: qede: Use linkmode helpers for EEE
>        net: ethernet: ixgbe: Convert EEE to use linkmodes
>        net: intel: i40e/igc: Remove setting Autoneg in EEE capabilities
>        net: intel: e1000e: Use linkmode helpers for EEE
>        net: intel: igb: Use linkmode helpers for EEE
>        net: intel: igc: Use linkmode helpers for EEE
> 
>   drivers/net/ethernet/intel/e1000e/ethtool.c      | 17 +++++--
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  7 +--
>   drivers/net/ethernet/intel/igb/igb_ethtool.c     | 33 ++++++++-----
>   drivers/net/ethernet/intel/igc/igc_ethtool.c     | 13 ++---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 48 ++++++++++---------
>   drivers/net/ethernet/qlogic/qede/qede_ethtool.c  | 60 +++++++++++++++---------
>   drivers/net/usb/Kconfig                          |  1 +
>   drivers/net/usb/ax88179_178a.c                   |  9 ++--
>   drivers/net/usb/r8152.c                          | 31 ++++++------
>   9 files changed, 123 insertions(+), 96 deletions(-)
> ---
> base-commit: d1d77120bc2867b3e449e07ee656a26b2fb03d1e
> change-id: 20240204-keee-u32-cleanup-b86d68458d80
> 
> Best regards,

