Return-Path: <linux-kernel+bounces-28064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018DE82F9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB07289FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E70C1487EE;
	Tue, 16 Jan 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikalkGAq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14111487D8;
	Tue, 16 Jan 2024 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435021; cv=none; b=ZwqoXdmMP14tV1mpMnXeqfRi5TCLy5g9hDX0ptuhdCLSLg3ED0MjxNIOmiFyY8MGYbO4mgwZ3afA0u7gqBZ4tPIb9T53+kLX5B8dLwDd/zeY7looOD6ncP8vFeS65vJLgmdZk7OLfp+57P65gAPPGvAH1odYokFRw5DWPjqvZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435021; c=relaxed/simple;
	bh=nZNveC+6JlLds+sJk1pTx4Lsnovcs7zNLmLzEKnsqZk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=W7weeti6hKXTCFhc0ZFEt+4cu3o/Ow9FJIBfcGRswQK3niNv3Y81pNV+UoOCOLIisfxdjvbUWW4taVip0Ly1EZKksxXf+V9fn8nhQZTKe/YouYIGisdfN3wnPFKm2nErTY2d6mLUyFzvxaofHjSUNtqglnttDPnTTcyXu00FvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikalkGAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF2DC433C7;
	Tue, 16 Jan 2024 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435021;
	bh=nZNveC+6JlLds+sJk1pTx4Lsnovcs7zNLmLzEKnsqZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikalkGAqf04wv5nPLWkuO/GVRJyYxkQHUU84gko00Ioegk6Gqt62GXRGmovT+ne5b
	 Cp61QNUkz85owS+sP/cXRPYbx04wkJ7GB3MeBued33yl151xCzXlAKhXH+9ndxhlNY
	 Q+KmyHHJXi2nemSmACw+MZ8KdsUmOUFXYscX9J81aAV+OKk6H3Pc1mqP2fpUV25ceR
	 n87K1OYHNdBG+6cuaVRFtsqv0b6SDYytzobCkaV2iM+1f2K4Ej2YKm5r0E52/qOERQ
	 u2Paunk0wV0+73QIt+p0JauzYrNMAguSOmbaqNsqyvOidK5QBx92vcR4QDeHZAI4by
	 u499GfPByA+gA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 46/68] ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values
Date: Tue, 16 Jan 2024 14:53:45 -0500
Message-ID: <20240116195511.255854-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

[ Upstream commit 20f73b60bb5c276cee9b1a530f100c677bc74af8 ]

Fix the values of the ICE_AQ_VSI_Q_OPT_RSS_* registers. Shifting is
already done when the values are used, no need to double shift. Bug was
not discovered earlier since only ICE_AQ_VSI_Q_OPT_RSS_TPLZ (Zero) is
currently used.

Also, rename ICE_AQ_VSI_Q_OPT_RSS_XXX to ICE_AQ_VSI_Q_OPT_RSS_HASH_XXX
for consistency.

Co-developed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Link: https://lore.kernel.org/r/20231213003321.605376-5-ahmed.zaki@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  8 ++++----
 drivers/net/ethernet/intel/ice/ice_lib.c        |  4 ++--
 drivers/net/ethernet/intel/ice/ice_virtchnl.c   | 12 +++++-------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1bdc70aa979d..a141680f3c1c 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -483,10 +483,10 @@ struct ice_aqc_vsi_props {
 #define ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M		(0xF << ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_S)
 #define ICE_AQ_VSI_Q_OPT_RSS_HASH_S		6
 #define ICE_AQ_VSI_Q_OPT_RSS_HASH_M		(0x3 << ICE_AQ_VSI_Q_OPT_RSS_HASH_S)
-#define ICE_AQ_VSI_Q_OPT_RSS_TPLZ		(0x0 << ICE_AQ_VSI_Q_OPT_RSS_HASH_S)
-#define ICE_AQ_VSI_Q_OPT_RSS_SYM_TPLZ		(0x1 << ICE_AQ_VSI_Q_OPT_RSS_HASH_S)
-#define ICE_AQ_VSI_Q_OPT_RSS_XOR		(0x2 << ICE_AQ_VSI_Q_OPT_RSS_HASH_S)
-#define ICE_AQ_VSI_Q_OPT_RSS_JHASH		(0x3 << ICE_AQ_VSI_Q_OPT_RSS_HASH_S)
+#define ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ		0x0U
+#define ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ	0x1U
+#define ICE_AQ_VSI_Q_OPT_RSS_HASH_XOR		0x2U
+#define ICE_AQ_VSI_Q_OPT_RSS_HASH_JHASH		0x3U
 	u8 q_opt_tc;
 #define ICE_AQ_VSI_Q_OPT_TC_OVR_S		0
 #define ICE_AQ_VSI_Q_OPT_TC_OVR_M		(0x1F << ICE_AQ_VSI_Q_OPT_TC_OVR_S)
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c051503c3a89..f074a1cf7166 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1085,12 +1085,12 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 	case ICE_VSI_PF:
 		/* PF VSI will inherit RSS instance of PF */
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
-		hash_type = ICE_AQ_VSI_Q_OPT_RSS_TPLZ;
+		hash_type = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 		break;
 	case ICE_VSI_VF:
 		/* VF VSI will gets a small RSS table which is a VSI LUT type */
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
-		hash_type = ICE_AQ_VSI_Q_OPT_RSS_TPLZ;
+		hash_type = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 		break;
 	default:
 		dev_dbg(dev, "Unsupported VSI type %s\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 2b4c791b6cba..6c03ebf81ffd 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -817,8 +817,8 @@ static int ice_vc_handle_rss_cfg(struct ice_vf *vf, u8 *msg, bool add)
 		int status;
 
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
-		hash_type = add ? ICE_AQ_VSI_Q_OPT_RSS_XOR :
-				ICE_AQ_VSI_Q_OPT_RSS_TPLZ;
+		hash_type = add ? ICE_AQ_VSI_Q_OPT_RSS_HASH_XOR :
+				ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 
 		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 		if (!ctx) {
@@ -826,11 +826,9 @@ static int ice_vc_handle_rss_cfg(struct ice_vf *vf, u8 *msg, bool add)
 			goto error_param;
 		}
 
-		ctx->info.q_opt_rss = ((lut_type <<
-					ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
-				       ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				       (hash_type &
-					ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+		ctx->info.q_opt_rss =
+			FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_LUT_M, lut_type) |
+			FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hash_type);
 
 		/* Preserve existing queueing option setting */
 		ctx->info.q_opt_rss |= (vsi->info.q_opt_rss &
-- 
2.43.0


