Return-Path: <linux-kernel+bounces-3639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C12816EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B46B20C12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BF74E1B;
	Mon, 18 Dec 2023 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyEnxV/b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD780E00;
	Mon, 18 Dec 2023 12:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7F2C433C9;
	Mon, 18 Dec 2023 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903568;
	bh=j34T0lfPhIM3gPdvaLQXV1yN93kRwsMlME4cTd4eg+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyEnxV/bLMcrmZzUq0/yw+u14zUxBQ4ZLb3jerPbfWFHY6Ne12qPzVF61+7Fwq1xm
	 2iUpJxUjUg2woZk8XRKagNFa+JLtbt3gSqBvcUGhUmH+cn2bQ/+NrFSmIJs0vXZODM
	 RZi+C0KhqfNa9wXba1t50fjhwzWkPFCicfr6aPAdgss6dGTi5ifdmdMnHQW1rXy22C
	 tuwJ9fnKMaVdYsgFeKmYbDdUZWKbg4HA0mOAsauHEk7TvzcReaxNRQ1aPQSKwC0A1t
	 gElRmp945GwWLFcYXSSID7hYsxh/V2MgQ5WAlOFBf0GOwalFSBmM8jDq8kAnaBvGa4
	 02a3OhL+3InxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Arnold Gozum <arngozum@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	acelan.kao@canonical.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/13] platform/x86: intel-vbtn: Fix missing tablet-mode-switch events
Date: Mon, 18 Dec 2023 07:45:38 -0500
Message-ID: <20231218124557.1380724-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124557.1380724-1-sashal@kernel.org>
References: <20231218124557.1380724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.143
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 14c200b7ca46b9a9f4af9e81d258a58274320b6f ]

2 issues have been reported on the Dell Inspiron 7352:

1. Sometimes the tablet-mode-switch stops reporting tablet-mode
   change events.

   Add a "VBDL" call to notify_handler() to work around this.

2. Sometimes the tablet-mode is incorrect after suspend/resume

   Add a detect_tablet_mode() to resume() to fix this.

Reported-by: Arnold Gozum <arngozum@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/87271a74-c831-4eec-b7a4-1371d0e42471@gmail.com/
Tested-by: Arnold Gozum <arngozum@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/r/20231204150601.46976-1-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/vbtn.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
index 15f013af9e623..f5e020840d947 100644
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -73,10 +73,10 @@ struct intel_vbtn_priv {
 	bool wakeup_mode;
 };
 
-static void detect_tablet_mode(struct platform_device *device)
+static void detect_tablet_mode(struct device *dev)
 {
-	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+	acpi_handle handle = ACPI_HANDLE(dev);
 	unsigned long long vgbs;
 	acpi_status status;
 	int m;
@@ -89,6 +89,8 @@ static void detect_tablet_mode(struct platform_device *device)
 	input_report_switch(priv->switches_dev, SW_TABLET_MODE, m);
 	m = (vgbs & VGBS_DOCK_MODE_FLAG) ? 1 : 0;
 	input_report_switch(priv->switches_dev, SW_DOCK, m);
+
+	input_sync(priv->switches_dev);
 }
 
 /*
@@ -134,7 +136,7 @@ static int intel_vbtn_input_setup(struct platform_device *device)
 	priv->switches_dev->id.bustype = BUS_HOST;
 
 	if (priv->has_switches) {
-		detect_tablet_mode(device);
+		detect_tablet_mode(&device->dev);
 
 		ret = input_register_device(priv->switches_dev);
 		if (ret)
@@ -198,6 +200,9 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	autorelease = val && (!ke_rel || ke_rel->type == KE_IGNORE);
 
 	sparse_keymap_report_event(input_dev, event, val, autorelease);
+
+	/* Some devices need this to report further events */
+	acpi_evaluate_object(handle, "VBDL", NULL, NULL);
 }
 
 /*
@@ -358,7 +363,13 @@ static void intel_vbtn_pm_complete(struct device *dev)
 
 static int intel_vbtn_pm_resume(struct device *dev)
 {
+	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+
 	intel_vbtn_pm_complete(dev);
+
+	if (priv->has_switches)
+		detect_tablet_mode(dev);
+
 	return 0;
 }
 
-- 
2.43.0


