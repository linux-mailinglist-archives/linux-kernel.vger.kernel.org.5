Return-Path: <linux-kernel+bounces-117736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5188AEED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F7229BBFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23936757F4;
	Mon, 25 Mar 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2Xzm23o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8C73167;
	Mon, 25 Mar 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392126; cv=none; b=oeC/wjmAEnSZkNBqspm++ZRQEjq2dblNzLTwixy9o0lZNFRoIAea9XvREAxaxarAcax1YTSEq5XsAhXBKZD1HL9FTT/cpllKYw+hfe1PI2kEwAOjxMV4FI7gFcXitBLuu9XEoiNTAs4gc/gu6SLkex4ivh9L4GclX6ESMKnhvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392126; c=relaxed/simple;
	bh=KK1BOwhrvf6vsv6qu1VwuPcqqUAsXuisaEG+Fzrn2qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1gvHRSLg+GXMSeRlkr1lSFOZXlaUmIW8s8ZtuKGBaKO+pME8DWQEB3/n1Y70EtChijaUjONUJhKXecjobhCrtjKnuhRxAsrFcI1nViv6sOo7fxXY1VFLFPbaXQiwMnlHOMcuUi+DEAmORH1N1iaVhoeOJORj2aCq0PlaJiFcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2Xzm23o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3D3C433C7;
	Mon, 25 Mar 2024 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711392125;
	bh=KK1BOwhrvf6vsv6qu1VwuPcqqUAsXuisaEG+Fzrn2qg=;
	h=From:To:Cc:Subject:Date:From;
	b=a2Xzm23ob7lHh90BbhizLk/ttOU1oAOWRh0I68/hD7CQ1oPY5heoy1nItym7sOgyl
	 85Zar8EjOVxAIHUMYWyElYQ5N4kEFszvvPZE/wKfx6JnE+6+Y4twbX3L/LGzlItdwH
	 6AdKjbxbYr3wneDpKKru5bxw2xjbSjhh4AuyvXXF/4iNmYqaIuAddKLM+qOoopnd1P
	 c9zcnMhnGC1PKS7saGqHrQnMKbG7+YMp3cojjOADDHCb0U7/eLsvCqHaT3npE8KIq9
	 eQKN1GLPSBPLIDnxRcUqpdmObW0Kk9DEQQ4mLdlE5y+i8dVw+Gz80bsS3jLWSuumJ7
	 YUk+g7QCkUI3g==
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
Subject: [PATCH v2 0/5] Fix a deadlock with clk_pm_runtime_get()
Date: Mon, 25 Mar 2024 11:41:54 -0700
Message-ID: <20240325184204.745706-1-sboyd@kernel.org>
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

Changes from v1 (https://lore.kernel.org/r/):
 * Check return value of clk_pm_runtime_get_all() in last patch
 * Fix order of args for error print in clk_pm_runtime_get_all()
 * Pick up review tags
 * Move clk_pm_runtime_{get,put}_all() to the pm runtime section
 * Use kernel-doc for function comments
 * Drop clk_pm_runtime_{get,put}() calls when they're not doing anything

Stephen Boyd (5):
  clk: Remove prepare_lock hold assertion in __clk_release()
  clk: Don't hold prepare_lock when calling kref_put()
  clk: Initialize struct clk_core kref earlier
  clk: Get runtime PM before walking tree during disable_unused
  clk: Get runtime PM before walking tree for clk_summary

 drivers/clk/clk.c | 173 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 135 insertions(+), 38 deletions(-)

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


