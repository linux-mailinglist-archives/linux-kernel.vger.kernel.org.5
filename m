Return-Path: <linux-kernel+bounces-132361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8623899392
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D92D1F239A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06546219FC;
	Fri,  5 Apr 2024 03:06:00 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9F17BAA;
	Fri,  5 Apr 2024 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286359; cv=none; b=bOIgrFsybGTCZIIdH+O9nFTfJuvF/PVqbj3ZzSKhBBKjzCCU9d7a/biTtXbllWICx5PJkvjjo0eLa20xbSLM6nkyCnY7/8jp6bBSGNP7Qm+JvJddgpX849v1EwGjFMrLasNSb7Urb1W5mcARojyWetN9UtyPdTdF5OgGmtky8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286359; c=relaxed/simple;
	bh=ReyZ/SK2T9RJMzqGhOr+f/IyAMkYqv/fQkx3qjS6WBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e0q1Ia9Si3x+ERpnAOh2PhvgyabqfGJdCp85PtIzknlkOV+V89iqy6su6v8xwxlJUd/jC6V3opMLsOVrySSrqFeYlpHplmjo71b+qdWfANowpLFXqrHLmZ1MSGsZEe/1lnJbMMCISFqWh5cVxdclLKD7YAND3DcU6bzoY6QNedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F242.00000000660F6A94.0025A8B9; Fri, 05 Apr 2024 05:05:56 +0200
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v4 3/3] platform/x86: thinkpad_acpi: use platform_profile_cycle()
Date: Fri,  5 Apr 2024 05:05:30 +0200
Message-ID: <25733f2e4b87705a27ee23540b69459cf8931255.1712282976.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712282976.git.soyer@irl.hu>
References: <cover.1712282976.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Some Thinkpads have a 'mode' button that switches between platform
profiles.

Use the new platform_module_cycle function instead of the existing
switch-based one.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/thinkpad_acpi.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 82429e59999d..771aaa7ae4cf 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -11190,23 +11190,8 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 		else
 			dytc_control_amt(!dytc_amt_active);
 	}
-	if (hkey_event == TP_HKEY_EV_PROFILE_TOGGLE) {
-		switch (dytc_current_profile) {
-		case PLATFORM_PROFILE_LOW_POWER:
-			dytc_profile_set(NULL, PLATFORM_PROFILE_BALANCED);
-			break;
-		case PLATFORM_PROFILE_BALANCED:
-			dytc_profile_set(NULL, PLATFORM_PROFILE_PERFORMANCE);
-			break;
-		case PLATFORM_PROFILE_PERFORMANCE:
-			dytc_profile_set(NULL, PLATFORM_PROFILE_LOW_POWER);
-			break;
-		default:
-			pr_warn("Profile HKEY unexpected profile %d", dytc_current_profile);
-		}
-		/* Notify user space the profile changed */
-		platform_profile_notify();
-	}
+	if (hkey_event == TP_HKEY_EV_PROFILE_TOGGLE)
+		platform_profile_cycle();
 }
 
 static void hotkey_driver_event(const unsigned int scancode)
-- 
2.44.0


