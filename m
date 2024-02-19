Return-Path: <linux-kernel+bounces-71669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689685A8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DA81C215B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ECC3CF67;
	Mon, 19 Feb 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3owxR2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CE3399C;
	Mon, 19 Feb 2024 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359720; cv=none; b=my+7OL6ZFZzL8y+wAPb/2qFCgX24+UpIO7dN9L4NmSRknxf0pVSzUkd3qxXzGcdjFboCeJtWdLkdDRDTfbisrwtLhl5U1BPhyqC4oOkMCLn+WaTa6cQ4yYbyR2oC1InPM2ECHl2W8+G+5Um2W1zGfMaz221ew9Ar0iyDcgj/jlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359720; c=relaxed/simple;
	bh=poqWJYLpGWi6VBFBO/1VRRUYnD195F2U9nLBnrdiLtM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=GSy4LT4sLEAmYKM7S2POin0cVcu5mIrX3FRUjeZ/A4zj1lrNnQNscdE6BugHkqpH71Nzfr6MZHfuu2Ichzf5ZgNxAIBGxvZlkV0Jm9fECBkiPcqPh4ImnUiBClf+LCQ4kFqh4l5YCb7NjDn5/kC4uWcM6X4+7BVxQzJkmo8BuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3owxR2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F58C433F1;
	Mon, 19 Feb 2024 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708359720;
	bh=poqWJYLpGWi6VBFBO/1VRRUYnD195F2U9nLBnrdiLtM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=K3owxR2puc00Fi/sNvX25bta2oCRh324+1yVJNmegAkHOyvefBAGrTpw67aLA3bSX
	 RMSHc70alN0Lr/O8hGRc7Oz7qEwcrQDetb+ARehMy8fIR46fEq9eBXPSBJjiDOezh0
	 sw/DMCXYP1LNll3BZQKR/OM/1jTbaex0zqyVUJX+86l7sYi/UWwcMFRJoBpUiZMJp/
	 riNebfzWR+J/RtSGvmR8SoqGViP7e1f8lNxe0+ui8XHcMWO1FMEJgEowkeUZl3UuF/
	 gJ++/Zp9vUcpilbYJSkscewO6mmT5YM9FKrwhz94bOH7zHf8bP2JNbi2qeEZurcjp/
	 dRNz+fSMps4Ig==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] wifi: wilc1000: split deeply nested RCU list
 traversal
 in dedicated helper
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240215-wilc_fix_rcu_usage-v1-1-f610e46c6f82@bootlin.com>
References: <20240215-wilc_fix_rcu_usage-v1-1-f610e46c6f82@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170835971632.848163.13838781391580317277.kvalo@kernel.org>
Date: Mon, 19 Feb 2024 16:21:58 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> Move netif_wake_queue and its surrounding RCU operations in a dedicated
> function to clarify wilc_txq_task and ease refactoring
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

4 patches applied to wireless-next.git, thanks.

5d2dbccc2b3c wifi: wilc1000: split deeply nested RCU list traversal in dedicated helper
059d0e3876ab wifi: wilc1000: use SRCU instead of RCU for vif list traversal
51e4aa8c449b wifi: wilc1000: fix declarations ordering
dd66185c23f7 wifi: wilc1000: add missing read critical sections around vif list traversal

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240215-wilc_fix_rcu_usage-v1-1-f610e46c6f82@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


