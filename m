Return-Path: <linux-kernel+bounces-126347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6AB893562
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1995DB229F5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD31292EC;
	Sun, 31 Mar 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="ZvPwJ0Wa"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A00614430E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909501; cv=none; b=ULV/l1LMRM3P9KIektBFOHL+iwRYZfnCDPrd+fWNdLBdQAJ45mcCensIQXUBGb30yITxE48R5RU1InBnd5Tc5LAtFGnk0qAh0aWVAB6iuLGz8Gp2krs5gg44GkoW63l9gzn7YUYY9nFLIxK3D+QeWRehVYwrq0oT0BQEUETVDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909501; c=relaxed/simple;
	bh=ttD+I28/H5fZk3Z1KHLbwkIvnLCPHXXOtwwQ0WArJDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sk9DzZkC4xJSZdEv9AaNqf98EeUXVMfn8cZ3ApYSg4XVBswRpTmg9eivDh3cHV/99RbcBXTAFEgyEmb3vdyG2IIpMAMqRra4lk2v3cDWZpYJ6mvyf7ToEN2ULw7loRpNVwUJQQJAx4picEyb93OD5sqbtXf7/2HT73vg2sxqFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=ZvPwJ0Wa; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1711909496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EI27Gbi1RUhnwj3kJsMGW9RaQTEh1qbj9ww5Kfmqrh8=;
	b=ZvPwJ0WaWX42UNXtliny1YR5St0hemxsRkxenJFzJ6D49aIuHmqLQCAPl/4ICK31tI8Qz9
	TDYUZYYucIaGQi1sGZZj5Yy8nVcO0ETDyqLDnuF/wdHQBF7aP4OAjnucQVmdVTEWcCDTG8
	YutqCanKWBijn5Z+GoANiAApHpnVlC4Vc9agMcnDq1z9mMPkHTUZ3ub6NaAZRRNHmeM1dv
	d0X+H4K5C++dM9kUZb2H0TcwFKWElKzFyM/G1sqz/WWeloURvnZmkEvROZH4zD7smMsCO3
	SCMeoHrWJeSjZ0IpBKrjJgfqG8jq9WlHI28XKJprgYChvWcs3i7bUxH21H5SUg==
From: Kenny Levinsen <kl@kl.wtf>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kenny Levinsen <kl@kl.wtf>
Subject: [PATCH v2] HID: i2c-hid: Revert to await reset ACK before reading report descriptor
Date: Sun, 31 Mar 2024 20:24:40 +0200
Message-ID: <20240331182440.14477-1-kl@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In af93a167eda9, i2c_hid_parse was changed to continue with reading the
report descriptor before waiting for reset to be acknowledged.

This has lead to two regressions:

1. We fail to handle reset acknowledgement if it happens while reading
   the report descriptor. The transfer sets I2C_HID_READ_PENDING, which
   causes the IRQ handler to return without doing anything.

   This affects both a Wacom touchscreen and a Sensel touchpad.

2. On a Sensel touchpad, reading the report descriptor this quickly
   after reset results in all zeroes or partial zeroes.

The issues were observed on the Lenovo Thinkpad Z16 Gen 2.

The change in question was made based on a Microsoft article[0] stating
that Windows 8 *may* read the report descriptor in parallel with
awaiting reset acknowledgement, intended as a slight reset performance
optimization. Perhaps they only do this if reset is not completing
quickly enough for their tastes?

As the code is not currently ready to read registers in parallel with a
pending reset acknowledgement, and as reading quickly breaks the report
descriptor on the Sensel touchpad, revert to waiting for reset
acknowledgement before proceeding to read the report descriptor.

[0]: https://learn.microsoft.com/en-us/windows-hardware/drivers/hid/plug-and-play-support-and-power-management

Fixes: af93a167eda9 ("HID: i2c-hid: Move i2c_hid_finish_hwreset() to after reading the report-descriptor")
Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 2df1ab3c31cc..72d2bccf5621 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -735,9 +735,12 @@ static int i2c_hid_parse(struct hid_device *hid)
 	mutex_lock(&ihid->reset_lock);
 	do {
 		ret = i2c_hid_start_hwreset(ihid);
-		if (ret)
+		if (ret == 0)
+			ret = i2c_hid_finish_hwreset(ihid);
+		else
 			msleep(1000);
 	} while (tries-- > 0 && ret);
+	mutex_unlock(&ihid->reset_lock);
 
 	if (ret)
 		goto abort_reset;
@@ -767,16 +770,8 @@ static int i2c_hid_parse(struct hid_device *hid)
 		}
 	}
 
-	/*
-	 * Windows directly reads the report-descriptor after sending reset
-	 * and then waits for resets completion afterwards. Some touchpads
-	 * actually wait for the report-descriptor to be read before signalling
-	 * reset completion.
-	 */
-	ret = i2c_hid_finish_hwreset(ihid);
 abort_reset:
 	clear_bit(I2C_HID_RESET_PENDING, &ihid->flags);
-	mutex_unlock(&ihid->reset_lock);
 	if (ret)
 		goto out;
 
-- 
2.44.0


