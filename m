Return-Path: <linux-kernel+bounces-101145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB187A30A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D2D1F224E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7814A8C;
	Wed, 13 Mar 2024 06:46:08 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15C12E54;
	Wed, 13 Mar 2024 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710312367; cv=none; b=H/yfz2EtZI3vPU/ZaUyHCzLUcPamsMJqjixpxppMBO17x/MV57K4bnRV6LYBtfaWT9NnI6MBHhgTE60EwKjAFID+JvVRCBxBVfkJfyPQVg8h1PyN31FOHV7AdAVZWErHdG05L70x+HNrrL178wXR8iKKWBPRUhoeKlOCZb3jC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710312367; c=relaxed/simple;
	bh=x6A3+YRDJy6D5VShC3JZYQD8PUTdLv32V7wLfBdaaNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F6ZqgQr18/WEH8RndzvYPa/xFMx5F/0UdaH19c2Ywb1dlpr/YNiBf64KxWz6goqMQV/52e99vT9t4qExfHohSjQqrBfp6F35wUEameAauVZXZPE/XCuffyqL5eMzzY5jHNlFDRRYHQk1d8FaY009ffi0RlVFOaCaC91vYPj+NdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp77t1710312238tb949ddw
X-QQ-Originating-IP: YaSZ14Ejv+mg7px1aOgJ0ZyZYJFeibWVGBRXtzRN4OI=
Received: from localhost.trustnetic.com ( [122.235.139.233])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Mar 2024 14:43:56 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: qpc/lE38OU3h9Zfd7U7Xil0QlHB1aAbpq2g+HV8TDhkqW3lWCPyjoCxp0okWi
	YLIeN7DLNozoLFIShVsqHhIlGfcAtdAFWARYjniXVp/HkSEK4YDK+uxSooBx6pXN2pYZlk+
	xkwkRJ4TTW8i/HkkWe8ZG7PwpvHk0il3Fcq8CiIX30HEVgqwLbvAy1SwIiRi72m7ux+oYdL
	x/1WSIhMM3wL25WT7fLkT/F+t9zInp/NEzGEF1QE+MurOTC5HvRLxJHq6CAqGk/BSTbNY3e
	XqqUCjFsk1ziCMVMKQJhhg25io4D+VWBRZt+KBT3nxSaOe/4Pv6JJIGcfq8gjdsznLMzVy6
	CWHOMFB0j2B9el3LuGeN3GG7OjJLc1UJj8jnujCokZ/JX5VEDyGgbuw/4GnkpberhB70MRV
	p0KVRaeVUF8=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13348156188099089633
From: Duanqiang Wen <duanqiangwen@net-swift.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	linux@armlinux.org.uk,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH clk] clk: clkdev: add error messages for name exceeding maximum length
Date: Wed, 13 Mar 2024 14:42:52 +0800
Message-Id: <20240313064252.50233-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

if one device register clkdev with dev_id or con_id
greater than maximum length, clkdev_create functions
will not return err, but clk_find functions will not
match the device, it's difficult to identify issues
for developers.So add error messages for dev_id greater
than 20 characters and con_id greater than 16 characters.

Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
 drivers/clk/clk.c            |  6 ++++++
 drivers/clk/clkdev.c         | 11 +++++++++++
 include/linux/clk-provider.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a824..10d3e0d93648 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -295,6 +295,12 @@ struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_parent);
 
+struct device *clk_hw_get_dev(const struct clk_hw *hw)
+{
+	return hw->core->dev;
+}
+EXPORT_SYMBOL_GPL(clk_hw_get_dev);
+
 static struct clk_core *__clk_lookup_subtree(const char *name,
 					     struct clk_core *core)
 {
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index ee37d0be6877..620dc1e80b48 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -158,6 +158,9 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
 {
 	struct clk_lookup_alloc *cla;
+	struct device *dev;
+
+	dev = clk_hw_get_dev(hw);
 
 	cla = kzalloc(sizeof(*cla), GFP_KERNEL);
 	if (!cla)
@@ -165,11 +168,19 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 
 	cla->cl.clk_hw = hw;
 	if (con_id) {
+		if (strlen(dev_fmt) >= MAX_CON_ID) {
+			pr_err("%s:con_id string cannot be greater than 16 characters\n", dev_fmt);
+			return NULL;
+		}
 		strscpy(cla->con_id, con_id, sizeof(cla->con_id));
 		cla->cl.con_id = cla->con_id;
 	}
 
 	if (dev_fmt) {
+		if (strlen(dev_fmt) >= MAX_DEV_ID) {
+			pr_err("%s:dev_id string cannot be greater than 20 characters\n", dev_fmt);
+			return NULL;
+		}
 		vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
 		cla->cl.dev_id = cla->dev_id;
 	}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1293c38ddb7f..88f3e3dde147 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1318,6 +1318,7 @@ int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long clk_hw_get_flags(const struct clk_hw *hw);
+struct device *clk_hw_get_dev(const struct clk_hw *hw);
 #define clk_hw_can_set_rate_parent(hw) \
 	(clk_hw_get_flags((hw)) & CLK_SET_RATE_PARENT)
 
-- 
2.27.0


