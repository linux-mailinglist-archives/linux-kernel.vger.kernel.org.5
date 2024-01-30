Return-Path: <linux-kernel+bounces-45134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B2842C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E32B1F25607
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5078B7C;
	Tue, 30 Jan 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gxE/1m3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E778B62
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640403; cv=none; b=KjbhpmTARIXwSMs0sv7CxClw2Evz47kMsNCyoH8jobElX6LSw8pLWPlaclmqjBnmQvt3h8mkgjLnEl29Kc+XydOFQm8+WHHIIC5r0jzDqzFyjawtzdBcLVHAK5KRUy2FkDkxY76xzTr5AT11shc+bzjvKxtwph7RD7cRgz4xBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640403; c=relaxed/simple;
	bh=+h2BNyNBH2PQ5+Cwjewz2w+MpDwd4+tscGSgxiN4bBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONPVfvsjeGc6tjNUm44Sdc64rNaDX3cynwhqygD/+aXxPvjUqXQyBGURCH8v8w1vO2AEmo/MpKW36jKP+KAAlula0pNDhlgv+K+L9rKLG51uaXirOZ3uTpRKzkBcv+xJh53TK1TAbSEAJ9ohoBSn2HafeEEmz/HYOiAqKBmU2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gxE/1m3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99253C43390;
	Tue, 30 Jan 2024 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706640402;
	bh=+h2BNyNBH2PQ5+Cwjewz2w+MpDwd4+tscGSgxiN4bBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxE/1m3LBF4/0Uug8Ja3628zL9XNu1jPKRDjIb+WoJn9bSz80+kQE1VSaK8IGV36w
	 kY6fxwphK6yqq4kk4NJSjj89nLgrv9NOzmBSNj/AeKTgQYNP73fFIr+OMI9g4eIS2q
	 bOWkXgSN95hGjetUpnZIgmPF5aJFt6dD6DXjrFjU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 3/6] soundwire: sysfs: cleanup the logic for creating the dp0 sysfs attributes
Date: Tue, 30 Jan 2024 10:46:29 -0800
Message-ID: <2024013029-budget-mulled-5b34@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024013025-spoiling-exact-ad20@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 80
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=+h2BNyNBH2PQ5+Cwjewz2w+MpDwd4+tscGSgxiN4bBw=; b=owGbwMvMwCRo6H6F97bub03G02pJDKk7XVhfd9kz3i+ziuUsbZn91kua31/nxW6Lq/e7v0ZWH 3Hb2FLYEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABOpz2WYn5egX7lZUK/wMuuz qjcsv3dWRTbuY5jvNWNKbtb0F41zllTeZXxww81vwYR8AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

There's no need to special-case the dp0 sysfs attributes, the
is_visible() callback in the attribute group can handle that for us, so
add that and add it to the attribute group list making the logic simpler
overall.

This is a step on the way to moving all of the sysfs attribute handling
into the default driver core attribute group logic so that the soundwire
core does not have to do any of it manually.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/sysfs_slave.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 83e3f6cc3250..8876c7807048 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -184,18 +184,40 @@ static struct attribute *dp0_attrs[] = {
 	NULL,
 };
 
+static umode_t dp0_attr_visible(struct kobject *kobj, struct attribute *attr,
+			      int n)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
+
+	if (slave->prop.dp0_prop)
+		return attr->mode;
+	return 0;
+}
+
+static bool dp0_group_visible(struct kobject *kobj)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
+
+	if (slave->prop.dp0_prop)
+		return true;
+	return false;
+}
+DEFINE_SYSFS_GROUP_VISIBLE(dp0);
+
 /*
  * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
  * for dp0-level properties
  */
 static const struct attribute_group dp0_group = {
 	.attrs = dp0_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(dp0),
 	.name = "dp0",
 };
 
 static const struct attribute_group *slave_groups[] = {
 	&slave_attr_group,
 	&sdw_slave_dev_attr_group,
+	&dp0_group,
 	NULL,
 };
 
@@ -207,12 +229,6 @@ int sdw_slave_sysfs_init(struct sdw_slave *slave)
 	if (ret < 0)
 		return ret;
 
-	if (slave->prop.dp0_prop) {
-		ret = devm_device_add_group(&slave->dev, &dp0_group);
-		if (ret < 0)
-			return ret;
-	}
-
 	if (slave->prop.source_ports || slave->prop.sink_ports) {
 		ret = sdw_slave_sysfs_dpn_init(slave);
 		if (ret < 0)
-- 
2.43.0


