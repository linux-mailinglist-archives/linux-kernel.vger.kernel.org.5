Return-Path: <linux-kernel+bounces-116549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5688A09A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367541C371AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCE1411FA;
	Mon, 25 Mar 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXHKiDxC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532F1411FD;
	Mon, 25 Mar 2024 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345447; cv=none; b=NToKzENn9NKRoDyT3zw/za4w4LYDYDz0SPGcEf0lnyUXf25BdeUzNAC+mfSD9pw1IIKNMjYQa+lE/Xx0dg9VF6Td29FHzroruHWKJnKvi3FsB6dbiPUjE2OFTkkETyAAbWx3VjLl7waygnCX/ZccMh4gov1J5ZEQk/NqynGm+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345447; c=relaxed/simple;
	bh=k6gn1w20BsWibDDISoF2Gh0s7LZl2+QUPMkufpcBitU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyLwyfalodQHDJjUFb8CcnxbFAjC4NlH80cyvSgxYNtNwcHB9As8cPl+MV/7jFv2+lfK7e+ZK6gSEUn3BTHOIU79vlrYRFg0/qU6KkP0NDmt1Y4cZXhNwsmm/4M7BWWZ1aO7JQunclNw1lp813Udmpmh8JvATjc30MN+Oa7/7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXHKiDxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417ECC433C7;
	Mon, 25 Mar 2024 05:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711345447;
	bh=k6gn1w20BsWibDDISoF2Gh0s7LZl2+QUPMkufpcBitU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXHKiDxC8DDhqwCswLVuDncycxPjabiNLHeg8GxEDSaPzhJJ5R3h9tAVPQCgvOxp1
	 U9rSXCwSv1dWhejrwOOocsBDEhToxq6Bbt/qRpqat0esXLEIODadaAAyTx9xQYhfFR
	 MEdl8f0OjVpunqF6W6MjRRa74vmJO7A6w+QgNGNZ5M+Nj/HYfBAaIG/TWZVVjCQUA6
	 BhUbRRWdYVSS/UJR1uqVOJejF6FSiWXPNe9w9wIOpqgfToICk6sSDwAqGlo8ymrGO0
	 IJM6nejb+yrWIMww0vW/2WZ8yKicUwHyKeb1wxao0rmKES5r/FXImdw+l6qzMUS+Tg
	 hQFQIKZWQFyBw==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Taniya Das <quic_tdas@quicinc.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 5/5] clk: Get runtime PM before walking tree for clk_summary
Date: Sun, 24 Mar 2024 22:44:02 -0700
Message-ID: <20240325054403.592298-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240325054403.592298-1-sboyd@kernel.org>
References: <20240325054403.592298-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the previous commit, we should make sure that all devices are
runtime resumed before printing the clk_summary through debugfs. Failure
to do so would result in a deadlock if the thread is resuming a device
to print clk state and that device is also runtime resuming in another
thread, e.g the screen is turning on and the display driver is starting
up.

Fixes: 1bb294a7981c ("clk: Enable/Disable runtime PM for clk_summary")
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 31998ca67b1e..10792599bec1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3332,7 +3332,7 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id\n");
 	seq_puts(s, "---------------------------------------------------------------------------------------------------------------------------------------------\n");
 
-
+	clk_pm_runtime_get_all();
 	clk_prepare_lock();
 
 	for (; *lists; lists++)
@@ -3340,6 +3340,7 @@ static int clk_summary_show(struct seq_file *s, void *data)
 			clk_summary_show_subtree(s, c, 0);
 
 	clk_prepare_unlock();
+	clk_pm_runtime_put_all();
 
 	return 0;
 }
@@ -3389,6 +3390,8 @@ static int clk_dump_show(struct seq_file *s, void *data)
 	struct hlist_head **lists = s->private;
 
 	seq_putc(s, '{');
+
+	clk_pm_runtime_get_all();
 	clk_prepare_lock();
 
 	for (; *lists; lists++) {
@@ -3401,6 +3404,7 @@ static int clk_dump_show(struct seq_file *s, void *data)
 	}
 
 	clk_prepare_unlock();
+	clk_pm_runtime_put_all();
 
 	seq_puts(s, "}\n");
 	return 0;
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


