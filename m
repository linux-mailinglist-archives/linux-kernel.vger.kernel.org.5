Return-Path: <linux-kernel+bounces-114842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F1D8891AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411461F2DC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E5F2C50EA;
	Mon, 25 Mar 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM6EO2ui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019513C670;
	Sun, 24 Mar 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323479; cv=none; b=aaVP/TdZQEbMiTnJ9pt29H/910MvQXM6hK3KBPbp6IDFoeL6aFw3Pcf+K3KFJOEQMRJOwfb1IfGtYJTtCCyxIcLNQYVXMlnOvt2swJ8y6zljJpiSPgbfB8aUz89nSV8Pqpoq11NBgxJAqKg8iUul7OS+dggl3zCAdaRJCKH6cOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323479; c=relaxed/simple;
	bh=1DhKusQ9HhD6fC5v6ak+Lgulwfz5amcq1rUMjvB5gtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fy4MS46S2mgQlxox7tHPynKK33C9UrLNbawtA9SPnwdKkqZkHNRIFyQfrJbV07L+iG5zSBKtiT1dRDzQCI0Fxx2BXrBukx0re7/LVAekFk3hxUcaNSwZ2VoyybhOZtsPr1oq846QVdcpaZZOQkT3zzOBSgWctJCc5EdhMMtZEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM6EO2ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC3FC433A6;
	Sun, 24 Mar 2024 23:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323477;
	bh=1DhKusQ9HhD6fC5v6ak+Lgulwfz5amcq1rUMjvB5gtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aM6EO2uiu90nYLEt2WV4Vu1eBmSvJELUdBvtJ9SUyRAxc1kARPq2G5JHm94OMaPfQ
	 e+i9TXE7f2wvPXbRa1yS/Oqy4D97R0af5g5XAQDK5x7JhRZz1cW3EDkLX7gjfQ6uCM
	 q77F7+9r0qtrzFJOK0y/jfmBikG2oO2wjXqwLH9lDNxprHG8h+fOwUzTwzq4mLtq5+
	 k6vUY2AW6s409noeVzwsrsde9ZWufIXM4R0w8GPSYrnPYdH7GQ9fNYjurfHXEFswRC
	 ChUOKLBm8RzQL1z95h6kmMUtVoFmUe/l9trLnfF91TzQco75G53vcX4jbqwvMEkxqW
	 Stpm9Hq2NqoLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Prusov <ivprusov@salutedevices.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 182/317] clk: meson: Add missing clocks to axg_clk_regmaps
Date: Sun, 24 Mar 2024 19:32:42 -0400
Message-ID: <20240324233458.1352854-183-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Igor Prusov <ivprusov@salutedevices.com>

[ Upstream commit ba535bce57e71463a86f8b33a0ea88c26e3a6418 ]

Some clocks were missing from axg_clk_regmaps, which caused kernel panic
during cat /sys/kernel/debug/clk/clk_summary

[   57.349402] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001fc
..
[   57.430002] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   57.436900] pc : regmap_read+0x1c/0x88
[   57.440608] lr : clk_regmap_gate_is_enabled+0x3c/0xb0
[   57.445611] sp : ffff800082f1b690
[   57.448888] x29: ffff800082f1b690 x28: 0000000000000000 x27: ffff800080eb9a70
[   57.455961] x26: 0000000000000007 x25: 0000000000000016 x24: 0000000000000000
[   57.463033] x23: ffff800080e8b488 x22: 0000000000000015 x21: ffff00000e7e7000
[   57.470106] x20: ffff00000400ec00 x19: 0000000000000000 x18: ffffffffffffffff
[   57.477178] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0000042a3000
[   57.484251] x14: 0000000000000000 x13: ffff0000042a2fec x12: 0000000005f5e100
[   57.491323] x11: abcc77118461cefd x10: 0000000000000020 x9 : ffff8000805e4b24
[   57.498396] x8 : ffff0000028063c0 x7 : ffff800082f1b710 x6 : ffff800082f1b710
[   57.505468] x5 : 00000000ffffffd0 x4 : ffff800082f1b6e0 x3 : 0000000000001000
[   57.512541] x2 : ffff800082f1b6e4 x1 : 000000000000012c x0 : 0000000000000000
[   57.519615] Call trace:
[   57.522030]  regmap_read+0x1c/0x88
[   57.525393]  clk_regmap_gate_is_enabled+0x3c/0xb0
[   57.530050]  clk_core_is_enabled+0x44/0x120
[   57.534190]  clk_summary_show_subtree+0x154/0x2f0
[   57.538847]  clk_summary_show_subtree+0x220/0x2f0
[   57.543505]  clk_summary_show_subtree+0x220/0x2f0
[   57.548162]  clk_summary_show_subtree+0x220/0x2f0
[   57.552820]  clk_summary_show_subtree+0x220/0x2f0
[   57.557477]  clk_summary_show_subtree+0x220/0x2f0
[   57.562135]  clk_summary_show_subtree+0x220/0x2f0
[   57.566792]  clk_summary_show_subtree+0x220/0x2f0
[   57.571450]  clk_summary_show+0x84/0xb8
[   57.575245]  seq_read_iter+0x1bc/0x4b8
[   57.578954]  seq_read+0x8c/0xd0
[   57.582059]  full_proxy_read+0x68/0xc8
[   57.585767]  vfs_read+0xb0/0x268
[   57.588959]  ksys_read+0x70/0x108
[   57.592236]  __arm64_sys_read+0x24/0x38
[   57.596031]  invoke_syscall+0x50/0x128
[   57.599740]  el0_svc_common.constprop.0+0x48/0xf8
[   57.604397]  do_el0_svc+0x28/0x40
[   57.607675]  el0_svc+0x34/0xb8
[   57.610694]  el0t_64_sync_handler+0x13c/0x158
[   57.615006]  el0t_64_sync+0x190/0x198
[   57.618635] Code: a9bd7bfd 910003fd a90153f3 aa0003f3 (b941fc00)
[   57.624668] ---[ end trace 0000000000000000 ]---

[jbrunet: add missing Fixes tag]
Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
Link: https://lore.kernel.org/r/20240202172537.1.I64656c75d84284bc91e6126b50b33c502be7c42a@changeid
Fixes: 14ebb3154b8f ("clk: meson: axg: add Video Clocks")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/axg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 2ad3801398dc1..7802dabb26f6d 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -2144,7 +2144,9 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_vclk_input,
 	&axg_vclk2_input,
 	&axg_vclk_div,
+	&axg_vclk_div1,
 	&axg_vclk2_div,
+	&axg_vclk2_div1,
 	&axg_vclk_div2_en,
 	&axg_vclk_div4_en,
 	&axg_vclk_div6_en,
-- 
2.43.0


