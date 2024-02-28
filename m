Return-Path: <linux-kernel+bounces-85316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766FA86B41B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F4C28321B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130A15DBCE;
	Wed, 28 Feb 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEnWwjqM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918815D5CE;
	Wed, 28 Feb 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136255; cv=none; b=hFXTS0RPOd2mZrI40OblKjyyNwNoXSNuGKlLOzMtroKO9tMI1Imtf8djPRBLjUTiBL8JOLLZuvi+0isloByCCMaZMSTgPVLhgCgTgru01ovQPpDnGZl756pLiX7mtTstOHx9rhc+WrVMvY4OOI0RJf+LJEICeKuzYSAa79kLn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136255; c=relaxed/simple;
	bh=OUeJ0q/Q4TSugz58SFBLkzeTCYbClmf+g/buseTVPBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzC0cZmO6LuZ9YApUlzV6cz154qwjHx31RPh4f+zlLm5uhCWLkdVZbFzxYfJL4s8nlIOXNMaCM1FNvvmB4hjp7eHKq43FydnXTV0sewhxPUyAPucvr77YDZXNGgQ2J4pFFtWFjIPBlE4rHlSj7DmR3ZE53t28JaQ79VvdZhF59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEnWwjqM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709136254; x=1740672254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OUeJ0q/Q4TSugz58SFBLkzeTCYbClmf+g/buseTVPBw=;
  b=YEnWwjqMLxPo702o4EjLFENJMkCU1T2MkfjU0XXtM4bJU2yIKAF4Bzr9
   OUxwAQTBH6Z3bDbx7MC5661Zdf/hK363VLFhIMN3oxrRFXnboKMyfuMY4
   caE7MIEz4WOqp9bDBTf/o704VybhYlPHvV3tvEcZmDnGYPNWKJrIbaOve
   vjcJmd4MmjZ9maqd0602Gv3Ycxqfhr9Bfomfgyl2+UF/m+tQ5XwC6ZX6B
   zkDobeLm272P82f9EMKh6kqLgriZFJAt6SNF7WVO+kR/z8qZq8TltqHwh
   L+5eDdyBWKFrctcPOQDm+eC6Q6S/mlkxpIcXBzRCmw+pr3koY+cizO5ta
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3706577"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3706577"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:04:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7527702"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 28 Feb 2024 08:04:10 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DA1AD36825;
	Wed, 28 Feb 2024 16:04:04 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-net 1/5] ice: Add function to get VF from device struct
Date: Wed, 28 Feb 2024 16:59:45 +0100
Message-ID: <20240228155957.408036-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228155957.408036-1-larysa.zaremba@intel.com>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Introduce a helper ice_get_vf_by_dev() to look up VF for a given struct
device.

Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 30 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h |  6 +++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 2ffdae9a82df..21d22e3ad0ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -45,6 +45,36 @@ struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id)
 	return NULL;
 }
 
+/**
+ * ice_get_vf_by_dev - Get pointer to VF by device
+ * @dev: the device structure
+ *
+ * Locate and return a pointer to the VF structure associated with a given
+ * device.
+ * Return: valid VF structure associated with the device, NULL if none exists
+ */
+struct ice_vf *ice_get_vf_by_dev(struct device *dev)
+{
+	struct pci_dev *vfdev;
+	struct pci_dev *pdev;
+	struct ice_pf *pf;
+	struct ice_vf *vf;
+	unsigned int bkt;
+
+	vfdev = container_of(dev, struct pci_dev, dev);
+	pdev = vfdev->physfn;
+	pf = pci_get_drvdata(pdev);
+
+	rcu_read_lock();
+	ice_for_each_vf_rcu(pf, bkt, vf) {
+		if (vf->vfdev == vfdev)
+			break;
+	}
+	rcu_read_unlock();
+
+	return vf;
+}
+
 /**
  * ice_release_vf - Release VF associated with a refcount
  * @ref: the kref decremented to zero
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 0cc9034065c5..48f4cdbd6d27 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -213,6 +213,7 @@ static inline u16 ice_vf_get_port_vlan_tpid(struct ice_vf *vf)
 
 #ifdef CONFIG_PCI_IOV
 struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id);
+struct ice_vf *ice_get_vf_by_dev(struct device *dev);
 void ice_put_vf(struct ice_vf *vf);
 bool ice_has_vfs(struct ice_pf *pf);
 u16 ice_get_num_vfs(struct ice_pf *pf);
@@ -237,6 +238,11 @@ static inline struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id)
 	return NULL;
 }
 
+static inline struct ice_vf *ice_get_vf_by_dev(struct device *dev)
+{
+	return NULL;
+}
+
 static inline void ice_put_vf(struct ice_vf *vf)
 {
 }
-- 
2.43.0


