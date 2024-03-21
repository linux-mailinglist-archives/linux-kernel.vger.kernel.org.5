Return-Path: <linux-kernel+bounces-110676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C35588624D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C72B1F220EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939DE13667E;
	Thu, 21 Mar 2024 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frgxmtvc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63693135A5F;
	Thu, 21 Mar 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055332; cv=none; b=fLlE2RE8wDV1cSG8Nu8pTmwAiz32zIATfVG6mUP4v039kuzAlKaATD5CZouw0/sFrEL1Vlrresj5k8Cwu28uoDVp6RYS+SszPPSd0tUF3FV3F8WT9hOzkkYJMvkWCXw6+cDCUozYSryVljvCGAURK7t/SytuY1Gd9+l4sB9nm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055332; c=relaxed/simple;
	bh=tAHdcxLcylUOp0OcDrI5LkZ+ZBHBQXHQILLjPqtaq3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sP63tVuIe89R/FsVNyMhQFd8UpZvt+jNIk0v0S+luNlBo/j+FSZ1nhPKCGtX84am01y+X37nSO7b2Ybi65VSe6/sZi5H7tKM20wSDp0blz7XLo4pFt9eNHVle+fa8h80+x2pbDBX5LSDS/BWPd3sr8Cs1j9GOX58JMMi357m2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frgxmtvc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711055332; x=1742591332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tAHdcxLcylUOp0OcDrI5LkZ+ZBHBQXHQILLjPqtaq3s=;
  b=frgxmtvcrydE8FSAr35g3xm7vYWXPGOM4zWzZU3TqTt/g1F9spR0V1jG
   0TGd17mbdCbvnaI+NrYv4tWHpQyFdM8MmbmKs/YI+CNeJQ4ygZ5iraLQb
   wjSSFRvMWoPJDd5+4YKsqpzj0RuWoD0bzKzeF/dvk/du1lw2w/6a1EOkv
   fMZKw6y+4m2PFGa6Kmg6BwIgDmMoAGTQiuTQGe0SvVuQEHU1F2L6GyM+l
   12k4FQE4E161d1aOt4fPQrjIK8McXAy/PoEK2leZ32+wG/M9rlaJ6wIKK
   7OEF7NN4FgbTGkX2OYEOZXG9Zfm3cDU9eJ31BFtEm0GJFqokFTDW1seqD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28551479"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="28551479"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="19362673"
Received: from derragan-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.213.183.52])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:08:50 -0700
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: jsnitsel@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH 1/2] crypto: iaa - Fix nr_cpus < nr_iaa case
Date: Thu, 21 Mar 2024 16:08:45 -0500
Message-Id: <20240321210846.1307596-2-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321210846.1307596-1-tom.zanussi@linux.intel.com>
References: <20240321210846.1307596-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If nr_cpus < nr_iaa, the calculated cpus_per_iaa will be 0, which
causes a divide-by-0 in rebalance_wq_table().

Make sure cpus_per_iaa is 1 in that case, and also in the nr_iaa == 0
case, even though cpus_per_iaa is never used if nr_iaa == 0, for
paranoia.

Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 1cd304de5388..b2191ade9011 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -806,6 +806,8 @@ static int save_iaa_wq(struct idxd_wq *wq)
 		return -EINVAL;
 
 	cpus_per_iaa = (nr_nodes * nr_cpus_per_node) / nr_iaa;
+	if (!cpus_per_iaa)
+		cpus_per_iaa = 1;
 out:
 	return 0;
 }
@@ -821,10 +823,12 @@ static void remove_iaa_wq(struct idxd_wq *wq)
 		}
 	}
 
-	if (nr_iaa)
+	if (nr_iaa) {
 		cpus_per_iaa = (nr_nodes * nr_cpus_per_node) / nr_iaa;
-	else
-		cpus_per_iaa = 0;
+		if (!cpus_per_iaa)
+			cpus_per_iaa = 1;
+	} else
+		cpus_per_iaa = 1;
 }
 
 static int wq_table_add_wqs(int iaa, int cpu)
-- 
2.34.1


