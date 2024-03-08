Return-Path: <linux-kernel+bounces-96530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9A875D96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4BC1C21B48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93503218B;
	Fri,  8 Mar 2024 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kOmE/ZkL"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533E1E536;
	Fri,  8 Mar 2024 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709876067; cv=none; b=l2SA8gVTAClkRHl0I+jlXkCr8shqluTg/V0rDxXSyTUsm5lhTwWs3zQSYlRavrodUUt382McYTxx2XTPBEKQb6oaZ64tBsNj3Bf460o4Qv/KhZY0LaPHdQfBoF1ub/t2R7Tet5hhEN8j1P4Rh9cKggH1s68HZa6AHKL96GdafUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709876067; c=relaxed/simple;
	bh=YwaMj8OxKhbhgSm2YdeZYbZgnCMpwoZo7BgGT64eeoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCoCpApEb5lf3hLl+f9G5MDlFEiSvjJy3ewqKuPsDryvohgOTnYMrUfHi6EfPtHAeCSJDkK4cdNpdtbi1t3+hheqaWe10kgprzIKI1K1vAPXzfmHcXblRPlQe0hhHBeq/fC31QhhR9CPRM57opvT1d2zh6Ri0IxQ1WI3KTJOqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kOmE/ZkL; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (1.general.khfeng.us.vpn [10.172.68.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0ACD23F6CA;
	Fri,  8 Mar 2024 05:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709876055;
	bh=jGaP/9i8KsRXJscPtFKRu9e1FyFkCOLKnNjl8D0Gs4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=kOmE/ZkLJY8t3f8peh8ddo762kmj7mq12NyE00rlKzPbIU7lJK/oF6ylfLQ3i7YBW
	 d8MqlmkQZMt3b2++/5Y6g8r4B2dTC26wsVMUprrLPC0PpnvvxL4H8ufTrPNkigtILM
	 ZCcN2hrXvliEM4gTB55Wvq1RN9ipwQPuYjZcJdcKXBvz+ZQ9P3jaQ4P+2jnWNDIReb
	 +IsyJW1S8TjYJx8YPAaE6WWREK7Ce3c9df8qyfoyJoTH7r3PNARfciO2Psopsrf0Qe
	 NhfDED3wEM7p/C5ITbdFMhLgn2822903ghA/GzFnLsgPweSJWxtYdFGP2sD5eJRglK
	 mrskrOw0Wct9A==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: corentin.chary@gmail.com,
	luke@ljones.dev,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: asus-wmi: Consider device is absent when the read is ~0
Date: Fri,  8 Mar 2024 13:32:55 +0800
Message-Id: <20240308053255.224496-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AAEON PICO-TGU4 board doesn't have any LED but there are bogus LED
controls under /sys/class/leds:
$ ls /sys/class/leds
asus::kbd_backlight asus::lightbar  platform::micmute

The reason is that the ~0 read from asus_wmi_get_devstate() is treated
as a valid state, in truth it means the device is absent.

So filter out ~0 read to prevent bogus LED controls being created.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/platform/x86/asus-wmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 18be35fdb381..8cb2afafde16 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -489,7 +489,17 @@ static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
 
 static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
 {
-	return asus_wmi_evaluate_method(asus->dsts_id, dev_id, 0, retval);
+	int err;
+
+	err = asus_wmi_evaluate_method(asus->dsts_id, dev_id, 0, retval);
+
+	if (err)
+		return err;
+
+	if (*retval == ~0)
+		return -ENODEV;
+
+	return 0;
 }
 
 static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
-- 
2.34.1


