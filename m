Return-Path: <linux-kernel+bounces-135760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DA189CAE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0401C2211F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE994143C52;
	Mon,  8 Apr 2024 17:35:22 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD0143C59;
	Mon,  8 Apr 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597722; cv=none; b=HMaLIc6JNe+iU9F5aECVS16PltUPGmcGg5MRPG1vnozv4gC2oGAfpgWwAlWZdBbjSQpBSG/gw6XkEMm9XCxwyGuE4FFBTetkACHgbar+qkTSONKBiFRFYePlD/9dcZ4c9GkC6fiiS4SDeS1BOpz3dmernAGmqIoC7+V8lZ/l8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597722; c=relaxed/simple;
	bh=ReyZ/SK2T9RJMzqGhOr+f/IyAMkYqv/fQkx3qjS6WBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=euixD/KMELTsVEc+hTVrLp+36lqQev8ruitQ4ZUNcul9WMsiDkljspP1TT+ZPiLhOQ0rIJo06zXgatrHNtg6gloC+STd2KpvwuQIIrw//X8EBOfTZBSadUR/BheCG1hZSiZ2jkGJdzodjn32OgKCVo9gPIPeMpQw7UdMdvn2bNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000706EF.0000000066142AD6.00264616; Mon, 08 Apr 2024 19:35:17 +0200
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
  Daniel Lezcano <daniel.lezcano@linaro.org>,
  =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v6 3/3] platform/x86: thinkpad_acpi: use platform_profile_cycle()
Date: Mon,  8 Apr 2024 19:35:12 +0200
Message-ID: <eb2484f5356786578d820301b714335221524839.1712597199.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712597199.git.soyer@irl.hu>
References: <cover.1712597199.git.soyer@irl.hu>
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


