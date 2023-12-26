Return-Path: <linux-kernel+bounces-11282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F18281E404
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019031C21AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB6D5D8F4;
	Tue, 26 Dec 2023 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loff4CfJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2435DF30;
	Tue, 26 Dec 2023 00:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF58BC433C7;
	Tue, 26 Dec 2023 00:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550385;
	bh=6HQPl8Tszuk3pmHygsPnwru0P0b6n3bpfAaVxj/2Mss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=loff4CfJeG+5tuN3d/G3d7OOc+cigEHD3YAt3R5y08f3yfNxLCCr8egjcO7DCdU4I
	 hoB1NfVr6g5zaY7dw6v/nKB+A9Up0ALKRk7JVXpdgT4Ih4bX2aTe0tBEozIUKvURLm
	 jUwH9uRD2vxnPfQadl5GedFdzrsQ5mlt3iSoT/6+bZEmQXUHoqtT5r1I72eJ6vm5ug
	 fpAoe/sUGntOb3x/6QCCEY+AshGyYaR61UY3MbJvXfO0BY1PjX2uqyMUkSkZL7lErf
	 pF/t8i6C+ccpzJ3+mRBuieXolaA9oRM4FVKQ+4Iq6UNSUhc4+hdu7IF5VK4c4C3uWO
	 ikoIq3KeatXlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vineet Gupta <vgupta@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	arnd@arndb.de,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 6/8] ARC: fix spare error
Date: Mon, 25 Dec 2023 19:25:49 -0500
Message-ID: <20231226002608.7089-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002608.7089-1-sashal@kernel.org>
References: <20231226002608.7089-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.265
Content-Transfer-Encoding: 8bit

From: Vineet Gupta <vgupta@kernel.org>

[ Upstream commit aca02d933f63ba8bc84258bf35f9ffaf6b664336 ]

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312082320.VDN5A9hb-lkp@intel.com/
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 8877de0dfe6cf..2759d49a2f3a9 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -61,7 +61,7 @@ struct rt_sigframe {
 	unsigned int sigret_magic;
 };
 
-static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
+static int save_arcv2_regs(struct sigcontext __user *mctx, struct pt_regs *regs)
 {
 	int err = 0;
 #ifndef CONFIG_ISA_ARCOMPACT
@@ -74,12 +74,12 @@ static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
 #else
 	v2abi.r58 = v2abi.r59 = 0;
 #endif
-	err = __copy_to_user(&mctx->v2abi, &v2abi, sizeof(v2abi));
+	err = __copy_to_user(&mctx->v2abi, (void const *)&v2abi, sizeof(v2abi));
 #endif
 	return err;
 }
 
-static int restore_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
+static int restore_arcv2_regs(struct sigcontext __user *mctx, struct pt_regs *regs)
 {
 	int err = 0;
 #ifndef CONFIG_ISA_ARCOMPACT
-- 
2.43.0


