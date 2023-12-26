Return-Path: <linux-kernel+bounces-11215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85BE81E34C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE16C1C2142B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D06481D7;
	Tue, 26 Dec 2023 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpWR2Y8N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A9481C1;
	Tue, 26 Dec 2023 00:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F49C433C9;
	Tue, 26 Dec 2023 00:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550076;
	bh=yrXkD5m0pLzTWG7oxe7e/ZbYPIpqKMhygZxYBHKQPvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpWR2Y8Na36w21UytxmEKf+JT0LmvH37wf6wUGaEfUI/2EAAIeFqxoleLUQE5AIVz
	 WbNhRAeuzy2kTVfjfbhQ7QaJXnnHTW0mZVePUrKlH7RxHh5vxUeRHsQwUtkszOX/8i
	 WR3UBrgSf84eZyIe6JTRwWkw69xvnGT16LtxDDWb7Ci54pXQ9qmjRBxOo6oLr/boIq
	 e08fDMYrWsrPr3WWaypgQHd0EqkIFlTZJ4N8h8mwEOS6EIHK4KXr8VEV2euo2tkB7Z
	 0aoTanIh9Iv4kWz0HNKQnY/oG3+Fs9ICWlodxWT+EVMUb8Otp3SA/6jMHhxkyBdUNz
	 aBQlMjWRs4lug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/39] platform/x86/amd/pmc: Move keyboard wakeup disablement detection to pmc-quirks
Date: Mon, 25 Dec 2023 19:19:12 -0500
Message-ID: <20231226002021.4776-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit b614a4bd73efeddc2b20d9e6deb6c2710373802b ]

Other platforms may need to disable keyboard wakeup besides Cezanne,
so move the detection into amd_pmc_quirks_init() where it may be applied
to multiple platforms.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20231212045006.97581-4-mario.limonciello@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 3 +++
 drivers/platform/x86/amd/pmc/pmc.c        | 2 +-
 drivers/platform/x86/amd/pmc/pmc.h        | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 6bbffb081053e..c32046dfa960e 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -235,6 +235,9 @@ void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
 {
 	const struct dmi_system_id *dmi_id;
 
+	if (dev->cpu_id == AMD_CPU_ID_CZN)
+		dev->disable_8042_wakeup = true;
+
 	dmi_id = dmi_first_match(fwbug_list);
 	if (!dmi_id)
 		return;
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index f28bee6854f4c..96caf2221d877 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -878,7 +878,7 @@ static int amd_pmc_suspend_handler(struct device *dev)
 {
 	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
 
-	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
+	if (pdev->disable_8042_wakeup && !disable_workarounds) {
 		int rc = amd_pmc_wa_irq1(pdev);
 
 		if (rc) {
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index a85c235247d38..b4794f118739f 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -36,6 +36,7 @@ struct amd_pmc_dev {
 	struct mutex lock; /* generic mutex lock */
 	struct dentry *dbgfs_dir;
 	struct quirk_entry *quirks;
+	bool disable_8042_wakeup;
 };
 
 void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev);
-- 
2.43.0


