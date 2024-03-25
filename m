Return-Path: <linux-kernel+bounces-116544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D86088A086
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09811F39049
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FDF1411F5;
	Mon, 25 Mar 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwUwJwMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4931411F7;
	Mon, 25 Mar 2024 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345445; cv=none; b=bYtCv73T4wesbsmU/JbKHYBlxDGDjhbux/ziB2RX1il/72W70LUXi97Rq1H8H44vZ7Ce0YBrSnXshWjEATjTKu9fnBLBx0HD2w2MiNDRwZLj+KpCYNUoTXLvJVH6XQJxrCxkw52Mx2J8vT1Loevdq7zGXD+unaiEL8AVgsuZg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345445; c=relaxed/simple;
	bh=S6KN9NZ86rsgC3JbJzRsAdTxPonS8+fxlmqhl9tZ1yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lS8YKp20fDs6SLZAlVpja/YX5UZzMU3bKGv3wFXfigYIhLuC8hcvhGN/G/9prEfI2fM+zCK/yDFl7K/3CxKlfbBfU2+J2MD22MxL7/GXL6pCDasGAXzlG81/eE5MRqyDumNEHpGcL+4uXh/OGiMMbrYTVoH7UmEHRuvEFtmx7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwUwJwMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75841C433C7;
	Mon, 25 Mar 2024 05:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711345445;
	bh=S6KN9NZ86rsgC3JbJzRsAdTxPonS8+fxlmqhl9tZ1yg=;
	h=From:To:Cc:Subject:Date:From;
	b=rwUwJwMFeRA31ZENhBOdCiysC+P6+e/hadizGOz4gmwvM4riRhQSW8seRjHUBUoTC
	 CGUcZ7DGUVR1iLCIDuKnEBn6iReIvWPbD6XLAJuXrtUhv6Ow+a2l+9hvOZavJzoVR3
	 n7xd07fbPWA77PhEBtup8DXBOTbPqeov3fE4Bha8INIG4S3dehxvCLnC292LP8CgrS
	 h8Igu7BDaaPCt2CzvmPxvEvm5r/R8+CXBvZCcb7RVVJOKVWUtkDRWPqJbHLo8xgWMN
	 QfDYl4o5wHBXUX3WTdaGnJ9g7A3nBcgzg9v3AAFWi0AX/fna+fYzPnhlKjVYMgz3YT
	 tKzvSk6aHK1vA==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/5] Fix a deadlock with clk_pm_runtime_get()
Date: Sun, 24 Mar 2024 22:43:57 -0700
Message-ID: <20240325054403.592298-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes a deadlock reported[1] on ChromeOS devices
(Qualcomm sc7180 Trogdor). To get there, we allow __clk_release() to run
without the prepare_lock held. Then we add runtime PM enabled clk_core
structs to a list that we iterate and enable runtime PM for each entry
before grabbing the prepare_lock to walk the clk tree. The details are
in patch #4.

The patch after that is based on the analysis in the disable unused
patch. We similarly resume devices from runtime suspend when walking the
clk tree for the debugfs clk_summary.

Unfortunately this doesn't fix all problems with the usage of runtime PM
in the clk framework. We still have a problem if preparing a clk happens
in parallel to the device providing that clk runtime resuming or
suspending. In that case, the task will go to sleep waiting for the
runtime PM state to change, and we'll deadlock. This is primarily a
problem with the global prepare_lock. I suspect we'll be able to fix
this by implementing per-clk locking, because then we will be able to
split up the big prepare_lock into smaller locks that don't deadlock on
some device runtime PM transitions.

I'll start working on that problem in earnest now because I'm worried
we're going to run into that problem very soon.

Stephen Boyd (5):
  clk: Remove prepare_lock hold assertion in __clk_release()
  clk: Don't hold prepare_lock when calling kref_put()
  clk: Initialize struct clk_core kref earlier
  clk: Get runtime PM before walking tree during disable_unused
  clk: Get runtime PM before walking tree for clk_summary

 drivers/clk/clk.c | 142 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 115 insertions(+), 27 deletions(-)

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

[1] https://lore.kernel.org/all/20220922084322.RFC.2.I375b6b9e0a0a5348962f004beb3dafee6a12dfbb@changeid/

base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


