Return-Path: <linux-kernel+bounces-124631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478A9891AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BE71F28593
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616B515EFAD;
	Fri, 29 Mar 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgSV/DS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75415ECF1;
	Fri, 29 Mar 2024 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715581; cv=none; b=pcaWzBqfh6Bo6cY/MsSKsU/TEzmxCTbfP9fzdjdRHvUgsPC9GbD58bdyWBRth3Xg4jVHZ+7UwHlldxpcqWai7ZgVh+mu8txJNxhJPEZ2/DdpdeFy6IfQHtwJqoE81kb8sxqMtXNcYN5P3hHQMvSF2P+t1PTceV3vDSVCP4Kfos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715581; c=relaxed/simple;
	bh=aSBzOgThcesMCBVYD8sSDS7JOXh9jaKZ0CAgz+tz7fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mzr6VZMhj6WDYiuBYPrn4dGjdk9aGbaEOy/mFiILmPvy0b0Fwi7bd5zOfb5okQk9CTKkcvjEvVU+TGK/QSZPSSNuwOToWgeSgxlZNXMFZmndtXiUOQUgX7OX3kiw1B2oD32TJregFUkw2Jh5ilZ6nigyLo+pdDnOoNVJ/sRTrPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgSV/DS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27AEC433C7;
	Fri, 29 Mar 2024 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715581;
	bh=aSBzOgThcesMCBVYD8sSDS7JOXh9jaKZ0CAgz+tz7fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BgSV/DS9GtEYrrVc0c9FZNlU/th0nUCZD18XrvwqIFj9SbnKnCSjfVvBP44bJh330
	 GlCFuA2SaeGKxphOrmGraHpYGT22VDCIr8KegiRTbSZDSae17xQ4RnneR7LU8RW1/M
	 gf7CGi6vd8Ap4oU35gJoJJeWFSunIMoPaPLJ6wf3Jr055rSRFhOWbicFkh5E1IFi43
	 mWNz9/6ycvv20+6aRJDy+xUW31DMiux1stVghCiuuGNdmqpG7uwyeo/7Ri8o6Lrf+s
	 eAT7ovrvya9gFw9ImhlohUDj+2etamv0j5nM0bI4xvAoWazq+0VIF85OfGn6KHyULg
	 Sy5Fwy8/+J/ww==
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
Subject: [PATCH AUTOSEL 6.1 28/31] ice: use relative VSI index for VFs instead of PF VSI number
Date: Fri, 29 Mar 2024 08:31:47 -0400
Message-ID: <20240329123207.3085013-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 6c03ebf81ffda..e2a737157c3dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -500,7 +500,7 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	vfres->rss_lut_size = ICE_VSIQF_HLUT_ARRAY_SIZE;
 	vfres->max_mtu = ice_vc_get_max_frame_size(vf);
 
-	vfres->vsi_res[0].vsi_id = vf->lan_vsi_num;
+	vfres->vsi_res[0].vsi_id = ICE_VF_VSI_ID;
 	vfres->vsi_res[0].vsi_type = VIRTCHNL_VSI_SRIOV;
 	vfres->vsi_res[0].num_queue_pairs = vsi->num_txq;
 	ether_addr_copy(vfres->vsi_res[0].default_mac_addr,
@@ -546,12 +546,7 @@ static void ice_vc_reset_vf_msg(struct ice_vf *vf)
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
index b5a3fd8adbb4e..6073d3b2d2d65 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
@@ -18,6 +18,15 @@
  */
 #define ICE_MAX_MACADDR_PER_VF		18
 
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


