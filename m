Return-Path: <linux-kernel+bounces-115464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98CC889BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B531C20D25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D921EB88;
	Mon, 25 Mar 2024 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz0s3qIN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C8129A61;
	Sun, 24 Mar 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320863; cv=none; b=sVX4J7iWt/umuMaEIbEkkeWHB1BSQRkOdspH9mAlQqvmQPWKwFt1do2V9vGoA1HF9Dah2lJcpFPh8T8kzti091QxqhLqcGSJkD8bDFzyC23x7VNv/GihRy2qRF+gUskgXzpTpQC3UJ/nmYaB4q5N4cf31ckpvJX4w/NZlmQOGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320863; c=relaxed/simple;
	bh=8aj/goXBmUnz9yrgHDqGWbx3hqheBb4xsQdBsUfe4oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7PfVnxd2f+Wyb0ll2Sj/Z5Uzi+GUJ2clqV8f6QTMH4JYIQANdd29QZ4Fj4NGTI6IcRu2HiKS4GxuZzSc51lE5cuzqDfIF80Hj7F6y2DQ2PhWV0kLwr+PCtu11z1CuAjKUAw3JrEJNm5k9bEEnBw6haCPZ/xus2Arh2Yfu7X06c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz0s3qIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC348C43390;
	Sun, 24 Mar 2024 22:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320863;
	bh=8aj/goXBmUnz9yrgHDqGWbx3hqheBb4xsQdBsUfe4oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kz0s3qINGJu2nIcl31E30O/s6H/yi7xqiL0d2Oq4cZROg3iQkXSwIzydmWPG5wFDb
	 rCcCH2A1SrUeTRkpQAuaMUcDLKJh0TioR/b2u66ock+gvR+ZYsf9WjSlJUPNQ0ZgeT
	 vNHhRExOpMY+NQSbmxdsLK4vqo08d/FpSoyUNezwry/U7Ie18NGa8ULN7pDbW6oHRV
	 3kcYHNvBONJxuYLqKXV+5n6apB5DGsorS5xVXEF+E+RtvyjkmD8wGKCyj0UjLYL/Ao
	 wprvJuvZEYPU9reknoqU2DQoSd3NcqQGuD0WiLF1DYYsoEBO5MW/fqG5mivi/NAdiR
	 Qe/WzR+OVkn2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Prusov <ivprusov@salutedevices.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 427/713] clk: meson: Add missing clocks to axg_clk_regmaps
Date: Sun, 24 Mar 2024 18:42:33 -0400
Message-ID: <20240324224720.1345309-428-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index c12f81dfa6745..5f60f2bcca592 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -2142,7 +2142,9 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
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


