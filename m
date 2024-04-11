Return-Path: <linux-kernel+bounces-139778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8654A8A0798
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1332BB238F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B8A13C824;
	Thu, 11 Apr 2024 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="NbzEkW4X"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DB13C807;
	Thu, 11 Apr 2024 05:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813044; cv=none; b=gOg9xv77LNUHXYC3MTcplG4b7aJYVLZBHsR/7YdjTLR7w3WoYM/WjC3ZkAcm5zuqMVkKZMUzJo5YkcXSoOY6rsIRjeZrmafiNL3tlNTlimZimb4Ic/9iHp6saNyGAYRpffXgaULdYV1jLnmurdRkMqZ4zLFQU5gDmgikOiN41LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813044; c=relaxed/simple;
	bh=RxRBurBGdPk3v0RcZD82O+R1FR1mCURyTzkpzUuQ/vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akrFvtzV3kwX4Ll1Z4oXQsLb1btD93DwKhydPdUlCNlxCm7L/PAC2bJhFtzFzYQagLsWe9DR92T8E5ZU6OBsXkTbyjJbqWZUz7q0/FGRLkxFF7XVE/hg/KvhRwdczCj60Ubw072HqSdrHjN+GlU8pwj1Z4kMMrjBpsUeG5ZPdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=NbzEkW4X; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id BEBE7603E6;
	Thu, 11 Apr 2024 05:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712813042;
	bh=RxRBurBGdPk3v0RcZD82O+R1FR1mCURyTzkpzUuQ/vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbzEkW4XkG/SqlwO7q/4+GMiTqUo6d4uGZop/AeLCJo5hWWGv6sZYC1aZDU20pHFf
	 2mODQjLanR372gLIaP4F0PhidfjvQH49RpGXp7DoFpW58o47x74V3Sea+azNwDUsf4
	 Yg+6icKsntQIFbRkaMUCqGxoyGtR1G5P62xbuNCV28hcLEF0OZ1s/dRSZfyqLoApCx
	 f0gxQusk0Z243byf7VMLp9ry4sFqxqH5zEfMyQZ2jbD6/4kVlgiR9tr74DZ7i6B+KU
	 v3mDXJAMLfzcg2jRGx0Y2rx0o7vr7CJQk9myafAiUudCsddTmx0Yp2a9p9gVrzsj5r
	 YZn52SqSJaRvw==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 2/4] reset: Allow removing a lookup
Date: Thu, 11 Apr 2024 08:22:55 +0300
Message-ID: <20240411052257.2113-3-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411052257.2113-1-tony@atomide.com>
References: <20240411052257.2113-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a parent device provides resets for the child devices using a lookup
table, let's also allow removal of the lookup table when removing the
child devices.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/reset/core.c             | 27 +++++++++++++++++++++++++++
 include/linux/reset-controller.h |  7 +++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -217,6 +217,33 @@ void reset_controller_add_lookup(struct reset_control_lookup *lookup,
 }
 EXPORT_SYMBOL_GPL(reset_controller_add_lookup);
 
+/**
+ * reset_controller_remove_lookup - unregister a set of lookup entries
+ * @lookup: array of reset lookup entries
+ * @num_entries: number of entries in the lookup array
+ */
+void reset_controller_remove_lookup(struct reset_control_lookup *lookup,
+				    unsigned int num_entries)
+{
+	struct reset_control_lookup *entry;
+	unsigned int i;
+
+	mutex_lock(&reset_lookup_mutex);
+	for (i = 0; i < num_entries; i++) {
+		entry = &lookup[i];
+
+		if (!entry->dev_id || !entry->provider) {
+			pr_warn("%s(): reset lookup entry badly specified, skipping\n",
+				__func__);
+			continue;
+		}
+
+		list_del(&entry->list);
+	}
+	mutex_unlock(&reset_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(reset_controller_remove_lookup);
+
 static inline struct reset_control_array *
 rstc_to_array(struct reset_control *rstc) {
 	return container_of(rstc, struct reset_control_array, base);
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -93,6 +93,8 @@ int devm_reset_controller_register(struct device *dev,
 
 void reset_controller_add_lookup(struct reset_control_lookup *lookup,
 				 unsigned int num_entries);
+void reset_controller_remove_lookup(struct reset_control_lookup *lookup,
+				    unsigned int num_entries);
 #else
 static inline int reset_controller_register(struct reset_controller_dev *rcdev)
 {
@@ -113,6 +115,11 @@ static inline void reset_controller_add_lookup(struct reset_control_lookup *look
 					       unsigned int num_entries)
 {
 }
+
+static inline void reset_controller_remove_lookup(struct reset_control_lookup *lookup,
+						  unsigned int num_entries)
+{
+}
 #endif
 
 #endif
-- 
2.44.0

