Return-Path: <linux-kernel+bounces-55434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1853B84BCAD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978C71F26C59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1520B134C1;
	Tue,  6 Feb 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7tui5s3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FC134A5;
	Tue,  6 Feb 2024 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242820; cv=none; b=scG+KNJ9TPl3cvG8/XR0wl918ZHfxJXrkA08YaGrc8KQTpf236MXhgXPkPGBNUKGIeMq3+BrFowwgZDzX7AHmVo5MSCcxkp69PorbtHP9ruhhASak4eOSbUJ3NABWJ1T86Aa+uqEnhvWxH+JXoABNCep8MGCxxqa23Tw0siEV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242820; c=relaxed/simple;
	bh=HvEv2Kfd6eukGI9whK4yWFO/flKDzwX8BfuUE6HpwbE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=WPWPI2y8A8tiEaPWJgU3Ygaul0xNElpei8zVfbtdZiLTagf7P+b83cs0xniPU2Q4PmZol2onJadr+ysGXdM9wKkEJ8vA8k0yGGipCKLX9VK324PlhpASMyJXnSVZSGps+1MyvPxYz1LsBoq3rEF9+obuX1CQ80/LthwuOxgne2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7tui5s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8885DC433F1;
	Tue,  6 Feb 2024 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707242819;
	bh=HvEv2Kfd6eukGI9whK4yWFO/flKDzwX8BfuUE6HpwbE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=r7tui5s3ZqCJds0HWpLtSd+v77o7tJ1ss/1E0cmi0CeCo/8VTZi5bnc6ekDXZvktQ
	 +vDF9ds0Q7Uh2J3QKeHWRKtNhfzcyvzUnl5S56hv4OMVYpjN9JBOMnCiUcM66wgvRR
	 b5CQH73p8n+4Sv3d/HCAd80099qglu+QeZT82carplk8f/daglOXS2ERCNkC89E9iA
	 yZhnKjj61ukvhHI2xGYCZAn8qBQCL+UbRtSuVM5DEgklsblV3ABl7vfS5Rzxlid33j
	 NMpia9BqIAYwpYv/8ygVZR8Bs8dofdG0D3np5qOza3KCQk/fbVPEom/qwWNUEibNKF
	 r6dMZNbKrf8ag==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: wfx: fix memory leak when starting AP
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240202164213.1606145-1-jerome.pouiller@silabs.com>
References: <20240202164213.1606145-1-jerome.pouiller@silabs.com>
To: =?utf-8?b?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-devel@silabs.com,
 =?utf-8?b?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
 Ulrich Mohr <u.mohr@semex-engcon.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170724281653.1979906.14756847148616354771.kvalo@kernel.org>
Date: Tue,  6 Feb 2024 18:06:58 +0000 (UTC)

Jérôme Pouiller <jerome.pouiller@silabs.com> wrote:

> Kmemleak reported this error:
> 
>     unreferenced object 0xd73d1180 (size 184):
>       comm "wpa_supplicant", pid 1559, jiffies 13006305 (age 964.245s)
>       hex dump (first 32 bytes):
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>         00 00 00 00 00 00 00 00 1e 00 01 00 00 00 00 00  ................
>       backtrace:
>         [<5ca11420>] kmem_cache_alloc+0x20c/0x5ac
>         [<127bdd74>] __alloc_skb+0x144/0x170
>         [<fb8a5e38>] __netdev_alloc_skb+0x50/0x180
>         [<0f9fa1d5>] __ieee80211_beacon_get+0x290/0x4d4 [mac80211]
>         [<7accd02d>] ieee80211_beacon_get_tim+0x54/0x18c [mac80211]
>         [<41e25cc3>] wfx_start_ap+0xc8/0x234 [wfx]
>         [<93a70356>] ieee80211_start_ap+0x404/0x6b4 [mac80211]
>         [<a4a661cd>] nl80211_start_ap+0x76c/0x9e0 [cfg80211]
>         [<47bd8b68>] genl_rcv_msg+0x198/0x378
>         [<453ef796>] netlink_rcv_skb+0xd0/0x130
>         [<6b7c977a>] genl_rcv+0x34/0x44
>         [<66b2d04d>] netlink_unicast+0x1b4/0x258
>         [<f965b9b6>] netlink_sendmsg+0x1e8/0x428
>         [<aadb8231>] ____sys_sendmsg+0x1e0/0x274
>         [<d2b5212d>] ___sys_sendmsg+0x80/0xb4
>         [<69954f45>] __sys_sendmsg+0x64/0xa8
>     unreferenced object 0xce087000 (size 1024):
>       comm "wpa_supplicant", pid 1559, jiffies 13006305 (age 964.246s)
>       hex dump (first 32 bytes):
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>         10 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>       backtrace:
>         [<9a993714>] __kmalloc_track_caller+0x230/0x600
>         [<f83ea192>] kmalloc_reserve.constprop.0+0x30/0x74
>         [<a2c61343>] __alloc_skb+0xa0/0x170
>         [<fb8a5e38>] __netdev_alloc_skb+0x50/0x180
>         [<0f9fa1d5>] __ieee80211_beacon_get+0x290/0x4d4 [mac80211]
>         [<7accd02d>] ieee80211_beacon_get_tim+0x54/0x18c [mac80211]
>         [<41e25cc3>] wfx_start_ap+0xc8/0x234 [wfx]
>         [<93a70356>] ieee80211_start_ap+0x404/0x6b4 [mac80211]
>         [<a4a661cd>] nl80211_start_ap+0x76c/0x9e0 [cfg80211]
>         [<47bd8b68>] genl_rcv_msg+0x198/0x378
>         [<453ef796>] netlink_rcv_skb+0xd0/0x130
>         [<6b7c977a>] genl_rcv+0x34/0x44
>         [<66b2d04d>] netlink_unicast+0x1b4/0x258
>         [<f965b9b6>] netlink_sendmsg+0x1e8/0x428
>         [<aadb8231>] ____sys_sendmsg+0x1e0/0x274
>         [<d2b5212d>] ___sys_sendmsg+0x80/0xb4
> 
> However, since the kernel is build optimized, it seems the stack is not
> accurate. It appears the issue is related to wfx_set_mfp_ap(). The issue
> is obvious in this function: memory allocated by ieee80211_beacon_get()
> is never released. Fixing this leak makes kmemleak happy.
> 
> Reported-by: Ulrich Mohr <u.mohr@semex-engcon.com>
> Co-developed-by: Ulrich Mohr <u.mohr@semex-engcon.com>
> Signed-off-by: Ulrich Mohr <u.mohr@semex-engcon.com>
> Fixes: 268bceec1684 ("staging: wfx: fix BA when device is AP and MFP is enabled")
> Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>

Patch applied to wireless-next.git, thanks.

b8cfb7c819dd wifi: wfx: fix memory leak when starting AP

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240202164213.1606145-1-jerome.pouiller@silabs.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


