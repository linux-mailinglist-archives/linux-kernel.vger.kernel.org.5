Return-Path: <linux-kernel+bounces-101877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FEC87AC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D7D1C209A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965EF4A9BF;
	Wed, 13 Mar 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU6lyHxW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDD077626;
	Wed, 13 Mar 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348011; cv=none; b=cX6Qdw1dufDjLqDXW13D0Bg8XZ0SEGcBixUTReF7KH6QbIcwi968gz8ajtF6fhzRxr9vVbtG1cSCFUElBrKYpHX0Wbb7OjRlWL4LtqRFQu/BsvLoGo2MRLPqb0W+G4bOAysVtDFHZEeZaxmwbjIT4TQMx0YiQKKDaaCQSx8QyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348011; c=relaxed/simple;
	bh=cuNje/dQxVswmlWNqA5c0Nua4Eecldgx5fZ2VRMP2HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQfAWW6hevgJijSAiVPAfQ1kCVwy/jmUNQlH8DzClAhBI0eBSAlNcXxnFo5Q4VGDccbI4S6HkpxCwFre90g00/SyCbTY6EhM2eIwbNqYL+IbMlibcmp+8Zz+PsIDKEvjFPCkah8P4YyrfrnTr0LIwrdJQeHo/jRTLEp4igLWTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU6lyHxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AA0C43399;
	Wed, 13 Mar 2024 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348011;
	bh=cuNje/dQxVswmlWNqA5c0Nua4Eecldgx5fZ2VRMP2HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IU6lyHxW+kMOocuI5Ju7SAHCAnUEiUeHu9up9naLMpRH+sgy5bNMyTvj4b5Hu+faz
	 bHacrTaUp9L+gg7s9E+4zAgAmlnuIxoi8ivOhUIVqcmFEUKPFHCnknoK/TxYYZ3Cmh
	 NinTJwclmZ+pwBAihrq246ez0Z3fMydVoNfxyfkAmXosbsvLgmT4Xa22m0MRjS3LYs
	 Q3Ju61ik771PN4le6PiExWH2n70jXRXDWVl2K7qQdnBc5o4GtYbTa6iJphVPxaUHqS
	 jVF1mYYVIYIBNwqoRT+6i2cFra6zhXzJOvt77umGAUR7zZlOVtc+uC2luHGzLZnt5/
	 V4iXN5GTI0Qyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 09/71] ice: virtchnl: stop pretending to support RSS over AQ or registers
Date: Wed, 13 Mar 2024 12:38:55 -0400
Message-ID: <20240313163957.615276-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 2652b99e43403dc464f3648483ffb38e48872fe4 ]

The E800 series hardware uses the same iAVF driver as older devices,
including the virtchnl negotiation scheme.

This negotiation scheme includes a mechanism to determine what type of RSS
should be supported, including RSS over PF virtchnl messages, RSS over
firmware AdminQ messages, and RSS via direct register access.

The PF driver will always prefer VIRTCHNL_VF_OFFLOAD_RSS_PF if its
supported by the VF driver. However, if an older VF driver is loaded, it
may request only VIRTCHNL_VF_OFFLOAD_RSS_REG or VIRTCHNL_VF_OFFLOAD_RSS_AQ.

The ice driver happily agrees to support these methods. Unfortunately, the
underlying hardware does not support these mechanisms. The E800 series VFs
don't have the appropriate registers for RSS_REG. The mailbox queue used by
VFs for VF to PF communication blocks messages which do not have the
VF-to-PF opcode.

Stop lying to the VF that it could support RSS over AdminQ or registers, as
these interfaces do not work when the hardware is operating on an E800
series device.

In practice this is unlikely to be hit by any normal user. The iAVF driver
has supported RSS over PF virtchnl commands since 2016, and always defaults
to using RSS_PF if possible.

In principle, nothing actually stops the existing VF from attempting to
access the registers or send an AQ command. However a properly coded VF
will check the capability flags and will report a more useful error if it
detects a case where the driver does not support the RSS offloads that it
does.

Fixes: 1071a8358a28 ("ice: Implement virtchnl commands for AVF support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Alan Brady <alan.brady@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c           | 9 +--------
 drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 6c03ebf81ffda..4b71392f60df1 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -440,7 +440,6 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 		vf->driver_caps = *(u32 *)msg;
 	else
 		vf->driver_caps = VIRTCHNL_VF_OFFLOAD_L2 |
-				  VIRTCHNL_VF_OFFLOAD_RSS_REG |
 				  VIRTCHNL_VF_OFFLOAD_VLAN;
 
 	vfres->vf_cap_flags = VIRTCHNL_VF_OFFLOAD_L2;
@@ -453,14 +452,8 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	vfres->vf_cap_flags |= ice_vc_get_vlan_caps(hw, vf, vsi,
 						    vf->driver_caps);
 
-	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
+	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PF)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_PF;
-	} else {
-		if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_AQ)
-			vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_AQ;
-		else
-			vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_REG;
-	}
 
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_FDIR_PF)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_FDIR_PF;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
index 5a82216e7d034..63e83e8b97e55 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
@@ -13,8 +13,6 @@
  * - opcodes needed by VF when caps are activated
  *
  * Caps that don't use new opcodes (no opcodes should be allowed):
- * - VIRTCHNL_VF_OFFLOAD_RSS_AQ
- * - VIRTCHNL_VF_OFFLOAD_RSS_REG
  * - VIRTCHNL_VF_OFFLOAD_WB_ON_ITR
  * - VIRTCHNL_VF_OFFLOAD_CRC
  * - VIRTCHNL_VF_OFFLOAD_RX_POLLING
-- 
2.43.0


