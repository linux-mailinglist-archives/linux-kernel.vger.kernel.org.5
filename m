Return-Path: <linux-kernel+bounces-45135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E486842C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7204283D80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C3762D7;
	Tue, 30 Jan 2024 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlUdiYBw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42278B7A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640403; cv=none; b=oTb5pv6VFA58Tm5Cw1iF3m0eqmJGh903oKfGqeZNuh7HE6YZbvb5TT270mNFVzbnYJELYgGWcx4S+5dsvRj4i+6Zvfy681tbH8r9aPzb+eNqlVno75kjRZoWhmpbnRH5OEN1xAQofza/TSraKGYFryoXKgjM2ECeC+1vKcFPgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640403; c=relaxed/simple;
	bh=zjX6COLrzX2UnAbnR13vMj+lXPKV02pQPeYFqk/O8jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF1GGIvUPb67BTKtfTIenMGkjVun3ZehBKj3z6yEkbpJQS+45BNXecEYzI22T/bgpMewynv63ohcrM2Xiiw2XJposYB+HlJFHcDQGGtAGfqH5O+13sVXGmcBZaBbpmKvAd5QksC0Q/UZRaY6Wo+RFY3kv4Rv2achfE4ZgOZACMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlUdiYBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662CCC433B1;
	Tue, 30 Jan 2024 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706640403;
	bh=zjX6COLrzX2UnAbnR13vMj+lXPKV02pQPeYFqk/O8jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlUdiYBw+1A31R3cg/zeFou3VlBY2FXsJc2k9fFlothmw0HEIqEvAYL16dRxQycAL
	 2Ad8G0ET9DNs45zDq2jLaVCauoMZ0P5LO07A5Kw/xmq+o8mVI+oYQcrVIjtAWENE7O
	 3RzcN/XIYRO3TVH3L3BrR0T0eLespWFNanVPrR7E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 4/6] soundwire: sysfs: have the driver core handle the creation of the device groups
Date: Tue, 30 Jan 2024 10:46:30 -0800
Message-ID: <2024013030-worsening-rocket-a3cb@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024013025-spoiling-exact-ad20@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 70
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=zjX6COLrzX2UnAbnR13vMj+lXPKV02pQPeYFqk/O8jM=; b=owGbwMvMwCRo6H6F97bub03G02pJDKk7XdgyEnavUmgT0xffUnLtkcSzDOGKlGfCq1+f8uq5f FTmnvurjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIvD0M81POZVT+i332yPDM 3vv9fG8fbt8zI5lhntY6xaNLhE60zDFxWbjeedGtJx+nBwEA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The driver core supports the ability to handle the creation and removal
of device-specific sysfs files in a race-free manner.  Take advantage of
that by converting this driver to use this by moving the sysfs
attributes into a group and assigning the dev_groups pointer to it.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/bus_type.c    | 1 +
 drivers/soundwire/sysfs_local.h | 3 +++
 drivers/soundwire/sysfs_slave.c | 6 +-----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 9fa93bb923d7..5abe5593395a 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -221,6 +221,7 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 	drv->driver.probe = sdw_drv_probe;
 	drv->driver.remove = sdw_drv_remove;
 	drv->driver.shutdown = sdw_drv_shutdown;
+	drv->driver.dev_groups = sdw_attr_groups;
 
 	return driver_register(&drv->driver);
 }
diff --git a/drivers/soundwire/sysfs_local.h b/drivers/soundwire/sysfs_local.h
index 7268bc24c538..3ab8658a7782 100644
--- a/drivers/soundwire/sysfs_local.h
+++ b/drivers/soundwire/sysfs_local.h
@@ -11,6 +11,9 @@
 /* basic attributes to report status of Slave (attachment, dev_num) */
 extern const struct attribute_group *sdw_slave_status_attr_groups[];
 
+/* attributes for all soundwire devices */
+extern const struct attribute_group *sdw_attr_groups[];
+
 /* additional device-managed properties reported after driver probe */
 int sdw_slave_sysfs_init(struct sdw_slave *slave);
 int sdw_slave_sysfs_dpn_init(struct sdw_slave *slave);
diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 8876c7807048..3afc0dc06c98 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -214,7 +214,7 @@ static const struct attribute_group dp0_group = {
 	.name = "dp0",
 };
 
-static const struct attribute_group *slave_groups[] = {
+const struct attribute_group *sdw_attr_groups[] = {
 	&slave_attr_group,
 	&sdw_slave_dev_attr_group,
 	&dp0_group,
@@ -225,10 +225,6 @@ int sdw_slave_sysfs_init(struct sdw_slave *slave)
 {
 	int ret;
 
-	ret = devm_device_add_groups(&slave->dev, slave_groups);
-	if (ret < 0)
-		return ret;
-
 	if (slave->prop.source_ports || slave->prop.sink_ports) {
 		ret = sdw_slave_sysfs_dpn_init(slave);
 		if (ret < 0)
-- 
2.43.0


