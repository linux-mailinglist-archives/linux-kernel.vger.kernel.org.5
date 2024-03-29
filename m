Return-Path: <linux-kernel+bounces-124599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B63891A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC74828357B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B43158D77;
	Fri, 29 Mar 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBOk8ZGy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79C158D81;
	Fri, 29 Mar 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715502; cv=none; b=QFRTTFQZEyNX6LB9DEFU1WE4oKhLho10vHGXtpD/qG49vC8DKNmsA9rZeV+UW6Xvt2v/NM91Az/hL8Hp1ScisLmw05ZbAlA8erWxZLwYIpMDAbq6bTnq99QoSbCq9pPXH9+ohpFvJt6ja/XquKvOO9U8cPh3iCr4KvYHOhxQOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715502; c=relaxed/simple;
	bh=xuO52jC+rzKh9ZGu2ZBZBSIiT9ch8p/qMshlFTcaWgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrKhe7hhuaBAp8BR80XzrScyBzuGR1k/WfJrMvvxUhJgcTKJgtDprN45MegjZxpJAqhcGxEM8/3jVB9U8zm06/Sa88ydGg5Mf4EU7ooHbCkJTbcLG1OkBWA2JsLZ24Ks5nZGebl3+JZXwSW+f9yGtskouiHoVg6HWBm4a1Oqa14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBOk8ZGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85962C433F1;
	Fri, 29 Mar 2024 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715501;
	bh=xuO52jC+rzKh9ZGu2ZBZBSIiT9ch8p/qMshlFTcaWgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBOk8ZGyS+lUM7qFNutKyzMkOhugABcTW3JiURgpbVt+eVOT+fmaqXVcfmxuMBMwI
	 CDHG3wyjoth4UrCAZVUDaVk9d+QiSh0yx/j9e66Ry5qtyDiG/DC+qyADlmkSdCCzh1
	 UddEqtteAyX17BWMO11nbYq7Q1ajH58gb7roTzZeUjUYgJ5m6F8dV+I/amBF/BDGE9
	 gPpk7Fd/awO4k0U7QX8WkfC+7F7WQIYU1Ife7gaxo4SGzvzTQndwdZJ9sAsMCSlDPs
	 CW2RLh9SSvtFdTo+sLBL9vH0rsbW8ugWpLKH8/F5/qHA2mhzCvcsCHaQ+Bk+NdplUZ
	 z17AMdWHOnW5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 48/52] ice: use relative VSI index for VFs instead of PF VSI number
Date: Fri, 29 Mar 2024 08:29:18 -0400
Message-ID: <20240329122956.3083859-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 11fbb1bfb5bc8c98b2d7db9da332b5e568f4aaab ]

When initializing over virtchnl, the PF is required to pass a VSI ID to the
VF as part of its capabilities exchange. The VF driver reports this value
back to the PF in a variety of commands. The PF driver validates that this
value matches the value it sent to the VF.

Some hardware families such as the E700 series could use this value when
reading RSS registers or communicating directly with firmware over the
Admin Queue.

However, E800 series hardware does not support any of these interfaces and
the VF's only use for this value is to report it back to the PF. Thus,
there is no requirement that this value be an actual VSI ID value of any
kind.

The PF driver already does not trust that the VF sends it a real VSI ID.
The VSI structure is always looked up from the VF structure. The PF does
validate that the VSI ID provided matches a VSI associated with the VF, but
otherwise does not use the VSI ID for any purpose.

Instead of reporting the VSI number relative to the PF space, report a
fixed value of 1. When communicating with the VF over virtchnl, validate
that the VSI number is returned appropriately.

This avoids leaking information about the firmware of the PF state.
Currently the ice driver only supplies a VF with a single VSI. However, it
appears that virtchnl has some support for allowing multiple VSIs. I did
not attempt to implement this. However, space is left open to allow further
relative indexes if additional VSIs are provided in future feature
development. For this reason, keep the ice_vc_isvalid_vsi_id function in
place to allow extending it for multiple VSIs in the future.

This change will also simplify handling of live migration in a future
series. Since we no longer will provide a real VSI number to the VF, there
will be no need to keep track of this number when migrating to a new host.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 9 ++-------
 drivers/net/ethernet/intel/ice/ice_virtchnl.h | 9 +++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index e7ab78bb0f861..668afc018a3fc 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -503,7 +503,7 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	vfres->rss_lut_size = ICE_LUT_VSI_SIZE;
 	vfres->max_mtu = ice_vc_get_max_frame_size(vf);
 
-	vfres->vsi_res[0].vsi_id = vf->lan_vsi_num;
+	vfres->vsi_res[0].vsi_id = ICE_VF_VSI_ID;
 	vfres->vsi_res[0].vsi_type = VIRTCHNL_VSI_SRIOV;
 	vfres->vsi_res[0].num_queue_pairs = vsi->num_txq;
 	ether_addr_copy(vfres->vsi_res[0].default_mac_addr,
@@ -549,12 +549,7 @@ static void ice_vc_reset_vf_msg(struct ice_vf *vf)
  */
 bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
 {
-	struct ice_pf *pf = vf->pf;
-	struct ice_vsi *vsi;
-
-	vsi = ice_find_vsi(pf, vsi_id);
-
-	return (vsi && (vsi->vf == vf));
+	return vsi_id == ICE_VF_VSI_ID;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
index cd747718de738..a0d03f350dfc7 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
@@ -19,6 +19,15 @@
 #define ICE_MAX_MACADDR_PER_VF		18
 #define ICE_FLEX_DESC_RXDID_MAX_NUM	64
 
+/* VFs only get a single VSI. For ice hardware, the VF does not need to know
+ * its VSI index. However, the virtchnl interface requires a VSI number,
+ * mainly due to legacy hardware.
+ *
+ * Since the VF doesn't need this information, report a static value to the VF
+ * instead of leaking any information about the PF or hardware setup.
+ */
+#define ICE_VF_VSI_ID	1
+
 struct ice_virtchnl_ops {
 	int (*get_ver_msg)(struct ice_vf *vf, u8 *msg);
 	int (*get_vf_res_msg)(struct ice_vf *vf, u8 *msg);
-- 
2.43.0


