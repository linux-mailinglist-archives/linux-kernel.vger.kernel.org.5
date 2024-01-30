Return-Path: <linux-kernel+bounces-45136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49410842C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28C928B0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327F8128388;
	Tue, 30 Jan 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/anzjRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61B762F1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640405; cv=none; b=B/HsvXPpI/hH9YF1SchMietRTn20FP2rSBiydY4ZGdQgjOFaLVAVDhdFAlU/L5xf+0jM6WylKnWtm2R0SIz4yS8grl1gX1xIYuDH3GrrEmzs+EkYxsdJM/lTJfvK5OaaYy1fh5x/bfPo8lb7ythEF6mTHS8AfmCCHYF70rWalG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640405; c=relaxed/simple;
	bh=wEdD348a9MfphH5q9oOA68An6QVp+AVDQ4A3h9ix8BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bm41gDE9tyREQwDOj3L0POD/Tlh87//3/l++xej1MKr3tk4wbTppqa6doSRz/SQIvk+nzaJUSIBQb0f0HU/Foe8X0pHmr5esEZDyxIkcINtH8wQBALhDggVu6Q7ukCAFrzJ7Kdnv8i29tkr44uFXGOfYyt0yfrlCd0t+ZNILoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/anzjRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBE0C43394;
	Tue, 30 Jan 2024 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706640404;
	bh=wEdD348a9MfphH5q9oOA68An6QVp+AVDQ4A3h9ix8BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/anzjRI6nxUAS3DddupnKyfHU+TxhTaG5TlVcxVlu+xaU2bLscMa/6VX5kG407cl
	 Ymw16RH7RUIh3CAuq7XqoidnSiMdU+dMRgOeiuHhfPRI+/dBaDA9//5GK2GrlFxM1H
	 Tucp3mfjk7/OxF3Ox8WFLgMf/6qkabPk1AKpifVE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 5/6] soundwire: sysfs: remove sdw_slave_sysfs_init()
Date: Tue, 30 Jan 2024 10:46:31 -0800
Message-ID: <2024013030-denatured-swaddling-b047@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024013025-spoiling-exact-ad20@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 85
X-Developer-Signature: v=1; a=openpgp-sha256; l=3127; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=wEdD348a9MfphH5q9oOA68An6QVp+AVDQ4A3h9ix8BU=; b=owGbwMvMwCRo6H6F97bub03G02pJDKk7Xdhvzpyex5JSJ/p6auuuCX6mVm/2zdy3SlX24fYlL seUt8gu64hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJnL/IMD/Y2PanvDTLn+ce l1Je3I5VCra8FMGwYNHNTj/200tZlUT1iuPCdP9pzFY4CQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that sdw_slave_sysfs_init() only calls sdw_slave_sysfs_dpn_init(),
just do that instead and remove sdw_slave_sysfs_init() to get it out of
the way to save a bit of logic and code size.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/bus_type.c        |  4 ++--
 drivers/soundwire/sysfs_local.h     |  1 -
 drivers/soundwire/sysfs_slave.c     | 13 -------------
 drivers/soundwire/sysfs_slave_dpn.c |  3 +++
 4 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 5abe5593395a..6085eb8c8d85 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -126,8 +126,8 @@ static int sdw_drv_probe(struct device *dev)
 	if (slave->prop.use_domain_irq)
 		sdw_irq_create_mapping(slave);
 
-	/* init the sysfs as we have properties now */
-	ret = sdw_slave_sysfs_init(slave);
+	/* init the dynamic sysfs attributes we need */
+	ret = sdw_slave_sysfs_dpn_init(slave);
 	if (ret < 0)
 		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
 
diff --git a/drivers/soundwire/sysfs_local.h b/drivers/soundwire/sysfs_local.h
index 3ab8658a7782..fa048e112629 100644
--- a/drivers/soundwire/sysfs_local.h
+++ b/drivers/soundwire/sysfs_local.h
@@ -15,7 +15,6 @@ extern const struct attribute_group *sdw_slave_status_attr_groups[];
 extern const struct attribute_group *sdw_attr_groups[];
 
 /* additional device-managed properties reported after driver probe */
-int sdw_slave_sysfs_init(struct sdw_slave *slave);
 int sdw_slave_sysfs_dpn_init(struct sdw_slave *slave);
 
 #endif /* __SDW_SYSFS_LOCAL_H */
diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 3afc0dc06c98..0eefc205f697 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -221,19 +221,6 @@ const struct attribute_group *sdw_attr_groups[] = {
 	NULL,
 };
 
-int sdw_slave_sysfs_init(struct sdw_slave *slave)
-{
-	int ret;
-
-	if (slave->prop.source_ports || slave->prop.sink_ports) {
-		ret = sdw_slave_sysfs_dpn_init(slave);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
 /*
  * the status is shown in capital letters for UNATTACHED and RESERVED
  * on purpose, to highligh users to the fact that these status values
diff --git a/drivers/soundwire/sysfs_slave_dpn.c b/drivers/soundwire/sysfs_slave_dpn.c
index c4b6543c09fd..a3fb380ee519 100644
--- a/drivers/soundwire/sysfs_slave_dpn.c
+++ b/drivers/soundwire/sysfs_slave_dpn.c
@@ -283,6 +283,9 @@ int sdw_slave_sysfs_dpn_init(struct sdw_slave *slave)
 	int ret;
 	int i;
 
+	if (!slave->prop.source_ports && !slave->prop.sink_ports)
+		return 0;
+
 	mask = slave->prop.source_ports;
 	for_each_set_bit(i, &mask, 32) {
 		ret = add_all_attributes(&slave->dev, i, 1);
-- 
2.43.0


