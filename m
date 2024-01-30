Return-Path: <linux-kernel+bounces-45133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84499842C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D46288EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D078B6D;
	Tue, 30 Jan 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JEoAujC5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354C78B67
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640402; cv=none; b=eWMbpl7w5Q5GMvEgizi6lZcHrZTZRA2FPP0f/1M9CU92PY+7yPVIvqIcAOFaU3r239tkRXz3qrmu0i55j6OmcKSYU9JeCPnDwPJbYVtxRquiQy8QMgbJtLfArcf+rBRsBNIApFerIqZtVtxDSn7+gdQACJc4szVzXbz+tnEQMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640402; c=relaxed/simple;
	bh=/Scr6QfMZ0RCV35H3B6N+LHXt3JnpeduIhhpHaToKUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kel272UqBhhuC8UeBZa8WpZFkwN+ORuUh0Vddq+FtzXFCvPJBeh+HR5yIfUbJgfkXSMFpiokVc6DRj97akvQr+0Xrycwm1/ewNg7dcyKiEE+gbvph1wJ4p3IdcJ4fYFjAHNucDUM+dFTmo/qFx4XWPEB53CSyLTU4DU/tLkVnrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEoAujC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C46C433C7;
	Tue, 30 Jan 2024 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706640401;
	bh=/Scr6QfMZ0RCV35H3B6N+LHXt3JnpeduIhhpHaToKUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEoAujC5s2u7BS20jS5iQkeHDhaHoO14PWbNCx/yT6GTbPSKfGvmPQWHo3EAY6Oz5
	 qqrMzz9jvfZWiFbdRVKYJeu1QXh6S8SaVntmOj+kZGARof2B8kb7yeMLcxwflkkeAe
	 OAkS89eEpD6BPw6c5QQPup8vAd7UvIMDmyPwLbKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 2/6] soundwire: sysfs: move sdw_slave_dev_attr_group into the existing list of groups
Date: Tue, 30 Jan 2024 10:46:28 -0800
Message-ID: <2024013029-afternoon-suitably-cb59@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024013025-spoiling-exact-ad20@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 61
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=/Scr6QfMZ0RCV35H3B6N+LHXt3JnpeduIhhpHaToKUk=; b=owGbwMvMwCRo6H6F97bub03G02pJDKk7XVjXmhzm99L80ysUunDv2iTNrm7uN7MCJ7MIXvn3f 8uCWZcPdcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEAuIZ5hnuTOeNfiPWvsVX /e7WpMUnV77XfsGw4PycJgOeGN6sFzc/K/YWPBXY5LUrDwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The sysfs logic already creates a list of groups for the device, so add
the sdw_slave_dev_attr_group group to that list instead of having to do
a two-step process of adding a group list and then an individual group.

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
 drivers/soundwire/sysfs_slave.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 3210359cd944..83e3f6cc3250 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -105,7 +105,10 @@ static struct attribute *slave_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(slave);
+
+static const struct attribute_group slave_attr_group = {
+	.attrs = slave_attrs,
+};
 
 static struct attribute *slave_dev_attrs[] = {
 	&dev_attr_mipi_revision.attr,
@@ -190,6 +193,12 @@ static const struct attribute_group dp0_group = {
 	.name = "dp0",
 };
 
+static const struct attribute_group *slave_groups[] = {
+	&slave_attr_group,
+	&sdw_slave_dev_attr_group,
+	NULL,
+};
+
 int sdw_slave_sysfs_init(struct sdw_slave *slave)
 {
 	int ret;
@@ -198,10 +207,6 @@ int sdw_slave_sysfs_init(struct sdw_slave *slave)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_device_add_group(&slave->dev, &sdw_slave_dev_attr_group);
-	if (ret < 0)
-		return ret;
-
 	if (slave->prop.dp0_prop) {
 		ret = devm_device_add_group(&slave->dev, &dp0_group);
 		if (ret < 0)
-- 
2.43.0


