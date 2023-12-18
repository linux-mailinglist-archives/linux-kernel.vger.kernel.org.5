Return-Path: <linux-kernel+bounces-3603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0136816E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B7F1F24774
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B688138D34;
	Mon, 18 Dec 2023 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij+JTDF2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83113877C;
	Mon, 18 Dec 2023 12:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAC0C433C8;
	Mon, 18 Dec 2023 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903462;
	bh=dDN46ecZEAy2OD4iXawXY7EQooHgbdoIMOokrSC7xxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ij+JTDF2dMEDldN9ayZn01MeHm1+1nmSibQz3/FcofQaH2lxvT9YLXPnqVdOQDcTw
	 gt/4QoMi0tv/ZyPcx1c6UFAEKzPep2kCCkzNs0kvEJBOCSMAsf6vIyK+Tb9cNDfq0Q
	 Mgut4LgLv8+h3rvEWO7GTO/42j2IIjB0ZVn4DudCkHiHZlok1nptxApdX/1wueJ7YG
	 OUPSdR7/DNklDiVyK3/1ejM92ORwF0Dc8gL2BUyVtg+B+LU1BeIkpbMsPF7qR+gNxa
	 o2ZQBDDGgWNISjRy37T+P/E2Lm5fDkCruzVGkoaUKzlJiGKk2SIq8/Lj5vGMAeERYU
	 2BBGIT9FH1buw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Song <chao.song@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.6 03/18] soundwire: intel_ace2x: fix AC timing setting for ACE2.x
Date: Mon, 18 Dec 2023 07:43:37 -0500
Message-ID: <20231218124415.1379060-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124415.1379060-1-sashal@kernel.org>
References: <20231218124415.1379060-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.7
Content-Transfer-Encoding: 8bit

From: Chao Song <chao.song@linux.intel.com>

[ Upstream commit 393cae5f32d640b9798903702018a48c7a45e59f ]

Start from ACE1.x, DOAISE is added to AC timing control
register bit 5, it combines with DOAIS to get effective
timing, and has the default value 1.

The current code fills DOAIS, DACTQE and DODS bits to a
variable initialized to zero, and updates the variable
to AC timing control register. With this operation, We
change DOAISE to 0, and force a much more aggressive
timing. The timing is even unable to form a working
waveform on SDA pin.

This patch uses read-modify-write operation for the AC
timing control register access, thus makes sure those
bits not supposed and intended to change are not touched.

Signed-off-by: Chao Song <chao.song@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20231127124735.2080562-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/intel_ace2x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index a9d25ae0b73fe..e320c91289135 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -23,8 +23,9 @@
 static void intel_shim_vs_init(struct sdw_intel *sdw)
 {
 	void __iomem *shim_vs = sdw->link_res->shim_vs;
-	u16 act = 0;
+	u16 act;
 
+	act = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL);
 	u16p_replace_bits(&act, 0x1, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
 	act |= SDW_SHIM2_INTEL_VS_ACTMCTL_DACTQE;
 	act |=  SDW_SHIM2_INTEL_VS_ACTMCTL_DODS;
-- 
2.43.0


