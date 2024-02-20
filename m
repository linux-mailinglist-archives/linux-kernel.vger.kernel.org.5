Return-Path: <linux-kernel+bounces-73560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEADF85C42E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F01F23A44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE612EBEC;
	Tue, 20 Feb 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mmx9hrN1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474612F5BF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455646; cv=none; b=HJLsR3/p9R8H2iFCqnSV3Ul3mah4GwsXQ+V4PShvBeSfmAncR9VsGqs5SFiTpT5SO0RWTacvPqk9GJLUHSTPYZVQ1Gt60AvX0S1KIgJsNBZkhlmkVYhgE/xIpy/+BDhqu2X7dWri6WF6eL1NyY9ZBmiKTeOnBow5WippeKQ4Jd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455646; c=relaxed/simple;
	bh=tO06HXuDUFkiQckbEEvMm/sPNj2r0sApMkfRWSALYmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVbEd3goZNIqbyaiS5pfizSQ2J+Ajwz2GAWsbQvsnfVofZmBcX+UFUnyu1UecLgbjvPrpWjLeHVQTxydfrpv2vihBLvFlsa3vuPQmlNRtbgwEyj0AqYxZZK+wZjlORNNgFiRJmNlsE+tvduufgmre13UEhI8mZgx4NDHOTb27GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mmx9hrN1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708455643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QSeB4uZ0c7rbXL9rOKisOf73q7fjczXQY8KjKSHtRXw=;
	b=Mmx9hrN1e5p69fH2XA92PncTWgnltooYz7g8Wzs01c5mNbWVvmwPDsdeTyvMXxsa00LDdq
	X7gzXpcbgHwd+QM5BNIxbnkKsy9cf1fTD3l7EvPlvEV0OZTFE+gAieuaL1TjA72UiLlAzl
	DcJuipl+pm8Ld5mo4D1lkiejMFnaTQE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-xlxqwbWDOE2_D3vXPZ74tA-1; Tue, 20 Feb 2024 14:00:38 -0500
X-MC-Unique: xlxqwbWDOE2_D3vXPZ74tA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CFBA811E79;
	Tue, 20 Feb 2024 19:00:37 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2DB32022AAC;
	Tue, 20 Feb 2024 19:00:35 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Piel <eric.piel@tremplin-utc.net>,
	linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [PATCH regression fix] misc: lis3lv02d_i2c: Fix regulators getting en-/dis-abled twice on suspend/resume
Date: Tue, 20 Feb 2024 20:00:35 +0100
Message-ID: <20240220190035.53402-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

When not configured for wakeup lis3lv02d_i2c_suspend() will call
lis3lv02d_poweroff() even if the device has already been turned off
by the runtime-suspend handler and if configured for wakeup and
the device is runtime-suspended at this point then it is not turned
back on to serve as a wakeup source.

Before commit b1b9f7a49440 ("misc: lis3lv02d_i2c: Add missing setting
of the reg_ctrl callback"), lis3lv02d_poweroff() failed to disable
the regulators which as a side effect made calling poweroff() twice ok.

Now that poweroff() correctly disables the regulators, doing this twice
triggers a WARN() in the regulator core:

unbalanced disables for regulator-dummy
WARNING: CPU: 1 PID: 92 at drivers/regulator/core.c:2999 _regulator_disable
..

Fix lis3lv02d_i2c_suspend() to not call poweroff() a second time if
already runtime-suspended and add a poweron() call when necessary to
make wakeup work.

lis3lv02d_i2c_resume() has similar issues, with an added weirness that
it always powers on the device if it is runtime suspended, after which
the first runtime-resume will call poweron() again, causing the enabled
count for the regulator to increase by 1 every suspend/resume. These
unbalanced regulator_enable() calls cause the regulator to never
be turned off and trigger the following WARN() on driver unbind:

WARNING: CPU: 1 PID: 1724 at drivers/regulator/core.c:2396 _regulator_put

Fix this by making lis3lv02d_i2c_resume() mirror the new suspend().

Fixes: b1b9f7a49440 ("misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/regressions/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
Cc: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index c6eb27d46cb0..15119584473c 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -198,8 +198,14 @@ static int lis3lv02d_i2c_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
 
-	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
+	/* Turn on for wakeup if turned off by runtime suspend */
+	if (lis3->pdata && lis3->pdata->wakeup_flags) {
+		if (pm_runtime_suspended(dev))
+			lis3lv02d_poweron(lis3);
+	/* For non wakeup turn off if not already turned off by runtime suspend */
+	} else if (!pm_runtime_suspended(dev))
 		lis3lv02d_poweroff(lis3);
+
 	return 0;
 }
 
@@ -208,13 +214,12 @@ static int lis3lv02d_i2c_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
 
-	/*
-	 * pm_runtime documentation says that devices should always
-	 * be powered on at resume. Pm_runtime turns them off after system
-	 * wide resume is complete.
-	 */
-	if (!lis3->pdata || !lis3->pdata->wakeup_flags ||
-		pm_runtime_suspended(dev))
+	/* Turn back off if turned on for wakeup and runtime suspended*/
+	if (lis3->pdata && lis3->pdata->wakeup_flags) {
+		if (pm_runtime_suspended(dev))
+			lis3lv02d_poweroff(lis3);
+	/* For non wakeup turn back on if not runtime suspended */
+	} else if (!pm_runtime_suspended(dev))
 		lis3lv02d_poweron(lis3);
 
 	return 0;
-- 
2.43.0


