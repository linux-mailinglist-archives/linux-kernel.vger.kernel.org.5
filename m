Return-Path: <linux-kernel+bounces-133726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727389A7CC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650D82848DD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996DA93D;
	Sat,  6 Apr 2024 00:01:53 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D081E533;
	Sat,  6 Apr 2024 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361712; cv=none; b=BcbkEXDYb7kEOinlg10PBjQjLTWmLH4rB4hv2Sdr5cpvyDpSq2bQANtSW9Z9S0n8BIUBvMQKy+RwYk3T++Y0+JUG4t0cntTOz+wfAliCEtSF//IvyZF1xgdvhbR1kGDkaF1vNp01OBdrOf4FSwe+IwSjuy4cG/q8KV1TBrbaT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361712; c=relaxed/simple;
	bh=ReyZ/SK2T9RJMzqGhOr+f/IyAMkYqv/fQkx3qjS6WBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TwmICj7IsWCuQ8DFOLtzJlSkA2xXlxyZcD3Veyze+hbxlFKVRSAKvR6RWSSEq9CKGHNop0kn9y9ZWPCN5WI8Adf3irpi8ceMTYAjDopNR9ySFI+KKbUF+kjz+8XjWsxEZnVipg76+bCTOmkisTBhvk8Wcpu1QdY7aJoLrd8lQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F9A2.00000000661090ED.0025D582; Sat, 06 Apr 2024 02:01:48 +0200
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
Subject: [PATCH v5 3/3] platform/x86: thinkpad_acpi: use platform_profile_cycle()
Date: Sat,  6 Apr 2024 02:01:33 +0200
Message-ID: <b70f4f1639451965ed76db7c023476ddd80e6241.1712360639.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712360639.git.soyer@irl.hu>
References: <cover.1712360639.git.soyer@irl.hu>
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


