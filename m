Return-Path: <linux-kernel+bounces-49557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688B6846BD4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73F0297A5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CF7A72D;
	Fri,  2 Feb 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqXzvyTy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302637A729;
	Fri,  2 Feb 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865727; cv=none; b=RGcU1HNKEt1sNeCJ5uyGzGIfxsKajdbEtWC1zysIH8VyWNedYaX2yCp8iENXlZmdDheiR752lJ2F32uAH0sVfJdvTF+TzQyt3Cq/RyUG29zRV+Aa6z7UUVzxS59V4ytv/TPJy/QlJyVl73fzIDnaWkZ7PQ8f9vmNeoZcbjiHjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865727; c=relaxed/simple;
	bh=cOvTivQwCKSNAmVU6sv7hOu2Ay14QYpymwDJPYGTOZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgHpIw5CPI+sgw3GToGa7V8MtiwLvopV06CkmZKWKpN01MkpDKlFprvOXOvRCfYRYL1Cg3nnZ+Z7M3YegBeG+UCsPsh0OkcUzebTQyRv9ndBmTJN3VjOowuMwBd/i9iL5EFXfZ8E6dZJhxUeUOvOGkk7aMB0Sm0lx/dVXJQgFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqXzvyTy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865727; x=1738401727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cOvTivQwCKSNAmVU6sv7hOu2Ay14QYpymwDJPYGTOZY=;
  b=eqXzvyTyzhJgRAgMZsRBTzjzsWgxKEiNNKUkux3HPMQ72b7XC6kCpuiS
   NSfiOWKl7MWSAobrChTsB3PVgm4kd/D6AxnT6zUqxEDKZ5iM4ToR8AODg
   S5sM2YIZwyouDv79q/51Qbd+dsDFILABMqTU/aDrS3PIoIsb/LKr6qnTM
   4RrpjmL07spWmj3Awck22gQgJgzYpddSKHy5TLp1q2JMNpNPCmg3Z6n8a
   3vkiDiKT67yvgF1zs6/zHG2foAFNwEMYyGjtdWrsbCm0z435/93efsXo9
   nxbePgu1lg7+ckTBdkwlfn6KRLUzbWukr3COsRF/2TUlSedrb7GHSIKwR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483056"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483056"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639710"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:03 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/11] hwmon: (coretemp) Introduce enum for attr index
Date: Fri,  2 Feb 2024 17:21:37 +0800
Message-Id: <20240202092144.71180-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202092144.71180-1-rui.zhang@intel.com>
References: <20240202092144.71180-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce enum coretemp_attr_index to better describe the index of each
sensor attribute.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index b8fc8d1ef20d..32f99cf6308b 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -43,10 +43,18 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
-#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
-#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
 
+enum coretemp_attr_index {
+	ATTR_LABEL,
+	ATTR_CRIT_ALARM,
+	ATTR_TEMP,
+	ATTR_TJMAX,
+	ATTR_TTARGET,
+	MAX_CORE_ATTRS = ATTR_TJMAX + 1,	/* Maximum no of basic attrs */
+	TOTAL_ATTRS = ATTR_TTARGET + 1		/* Maximum no of possible attrs */
+};
+
 #ifdef CONFIG_SMP
 #define for_each_sibling(i, cpu) \
 	for_each_cpu(i, topology_sibling_cpumask(cpu))
-- 
2.34.1


