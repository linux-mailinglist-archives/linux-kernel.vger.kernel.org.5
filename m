Return-Path: <linux-kernel+bounces-101768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323D87AB69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61FF1F23052
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830154E1C4;
	Wed, 13 Mar 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iictL/W7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396160BBB;
	Wed, 13 Mar 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347594; cv=none; b=TUewYAW3H4bhIdsTeklhLqQnZqnmwMIcOOSBfttg6eHDLHVnAWAj11NZ+vjQt5kXGaqdGBrecf5gFSr444BogjzDvbPF95mchLC+2d3apwoiXvPB3Vx90RWN834d7HX4TYiHTZqhSpNL9lNlCtTKN+WN/LLpG6VQK8OFYvaiiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347594; c=relaxed/simple;
	bh=acZBYzTvtkIkUQDMTQnwQfma+JP6bzgHLEAjC9VZXVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hzbi7bSpvdmqe2WQnhuLcHIbL6Q8/qRA8wJxdD9bYXwMzrzS8pbW8EmdCczDcJ/17BsNllnpCukjNWFveaT3hy3hEx+2oqqxcwEKrTbgBWs7ffHE8x9Clxyu1H+f2UaWgwRPON9EQ7FS2Cit5XkG8uihPCJyw2jkCBjsrRDoHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iictL/W7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C918C433A6;
	Wed, 13 Mar 2024 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347594;
	bh=acZBYzTvtkIkUQDMTQnwQfma+JP6bzgHLEAjC9VZXVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iictL/W7x7feLDK89u4By3cSUNb3NvFTjNsTfrXG9b5JNM/dR6Sm0Ro1c/MhDeITc
	 TzK9SqWoEJGbBNWDM/DtiL6531IRAQDJMezTUzII48ujb9Dr44xzsoJVlGsfRoKO69
	 WFAeykTUy9UtwwV4zgft7p9eagQcTi8d/0M27BIo4VeYPvH+n7Tbzu+XWM3lmeQmLY
	 /6zPVBcVdpaDVjo0xd6aUScJesiZk4CDFF84CdMWJaJ4Em3B+Iw9hSpAn/L6za5Q0D
	 JxO+nwzish6XwCwHcNutWZ7N75F2hJLPl/SaDpMF4gUXip2S/WN+UPg4P0h7f9zmbr
	 dbmF/BBdFJYQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 29/61] ice: virtchnl: stop pretending to support RSS over AQ or registers
Date: Wed, 13 Mar 2024 12:32:04 -0400
Message-ID: <20240313163236.613880-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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
index 8872f7a4f4320..d6348f20822e8 100644
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
 
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
index 7d547fa616fa6..588b77f1a4bf6 100644
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


