Return-Path: <linux-kernel+bounces-93183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60475872BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3889DB25CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D46FAF;
	Wed,  6 Mar 2024 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EhS9CfeL"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394E613A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687276; cv=none; b=h6maQfdePQT/VuqgrauEQrLmkBvXwupjTqaXY8jJQgd2BigjxmuAgTF2d5x86Yk8AsasBGpgL/YHZ2fWW1ejjZqyUpUECq8dQVefOrM9qKM/VvZwS/EH8dkXcMH0VQYn+zK8OgQCn6d1sI8pXnxIET/XipgS3YSrEGKt0Lr1pL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687276; c=relaxed/simple;
	bh=HC0c+b9bclv7/ZS4SqlJTTtRzizcXivf4L8XVCBN6c0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q0J9DPTo1s7Th46mUKNToNm9xdwoX8ESP1QA6vfVFsDoUtjYUdFDvcuwLGU3xIgCJ8TEvq2VBNTbXM8j0zZEozccWDX3xPeHUavddWS8SqtysacpFTTACrlc2slyyGNA1F0QFGMfqGAzxm4MknbnSFNnvPPWOC3IWv1crOUwdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EhS9CfeL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so51770805ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 17:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709687274; x=1710292074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QaZ9jvhk8qu3XdlJdh8fnY4fqEE7HpeP8GMXGB4+dFY=;
        b=EhS9CfeL6ImyXiY3jOxJZJci4jQPwC5IcGaRkKss6T8tJaHFQmEPbLmd/JKwKUeDdh
         6YA+x2p2iQOMWr4ZWwo6ZoeL9hGtrClxw1sDX0gloNvOkH9Tl45wSRgsDEwmtO/wBGPb
         zwJDS69oYqmvj1HuGWM+uKBNb1CVwhAPGG2Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709687274; x=1710292074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaZ9jvhk8qu3XdlJdh8fnY4fqEE7HpeP8GMXGB4+dFY=;
        b=w7sS5VG6HpH8p7vGrEj9WFX10RtMgX7aXd+37XpaCHmgQ2801NxItM48ogAulpozk5
         LNM1KYngQWDdDkyhB1zpYTbdqaC/5IAeTqiHIAgl0qnpMb6fUxROyGU7yf5Vq9/9kK3B
         l5Qew9NRe5KTkHD+ZzsLMacpPX/jxq9Y+AWUlhDObS5o9OiMW3ogz59UMr912oulzp1R
         0FYugDarUSP8jOD2lVHdm5kaY+hPwO5MX+pqmse3mE0CZTR3p10hw6IgVrMxUZV6AOi6
         pOUV7iUqBvnhnGVcwMKsbI5x5nGBaiYZTq0C1DEQjz7CagBBh9urWrFvBGeODhyfOnkD
         RHmw==
X-Forwarded-Encrypted: i=1; AJvYcCUFgoHYUUiyZyH7yo3ewHvQ/aqWdabxLSK6av+BxSF1KGJByHOicuBdCykgQc8+qT08gzdmptXHyvsN6fTdxkfeTe7EgkzpJU3oMMhj
X-Gm-Message-State: AOJu0YzZQPw+22bkC4G5AN+mkC0DUm2w4KSEaGRisFTNRCtzYjHdNtAe
	tVja24dgJRulQofrXU55+EetVaD7RsbHHZ6gEpjSTvvvMiaC+sNGSRQl7b6DXQ==
X-Google-Smtp-Source: AGHT+IGBiL2kQlqJOmCkfpFcNXBJR1K6z3fGthY1JUucBfjXOhceDVw02tkJXZvvseF0DUDXxvX9eA==
X-Received: by 2002:a17:902:e98d:b0:1dc:6cda:bcd2 with SMTP id f13-20020a170902e98d00b001dc6cdabcd2mr3347616plb.34.1709687274214;
        Tue, 05 Mar 2024 17:07:54 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b001dcdfb6184asm48301plk.79.2024.03.05.17.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 17:07:53 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] overflow: Change DEFINE_FLEX to take __counted_by member
Date: Tue,  5 Mar 2024 17:07:50 -0800
Message-Id: <20240306010746.work.678-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13018; i=keescook@chromium.org;
 h=from:subject:message-id; bh=HC0c+b9bclv7/ZS4SqlJTTtRzizcXivf4L8XVCBN6c0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl58Hmkif6vouXnpT/tpUQ3RHXxH4+0uOi0f4yv
 /qEj3EKciSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZefB5gAKCRCJcvTf3G3A
 JobdEACfLGmcFK8MlL+LopJQvF2ISftjdkt9HemSvGDtUMMMWco7Rp8t+YT9pBBRrOsUuBCXHc6
 aBXf2dRWIP1MgUeIxD3DZVfYneCE9gQz26J/wWqpmj7d2lQqMRUlBzz6yGqweujt4/RD7fHaCK6
 OGvbNzLPFM7c7WLPy9ifqKM/ZoPsbLMol7VQ4+z2uLWQslxgPF9vce0OX7vjXkj08FuxSN8JA4C
 xl0pVWGgbUPNiz+JXHk8JMwOS3mdJ3aZ3RFO/9Z6hBoaeoZIlI8LJU7lIQV+G3wCi97pjw0jKla
 L5IeuyKCX1p7iscsR1cNLtoxYN/lXjavDv4tA//LvfdygVslyG376jjWV1oM+x9FZ520tnvVsdf
 qLm0mt+l9FY4RfYb0LxC+x+V5P7KAV85PajlRL4KKgE9sCDfE81KrOdmLSGyT6U4CtOSec0U8Dc
 VWClMgJPSmOtPBjFqeCdg/X/iTVfA42lH/t1sZxCwLM2najzn7SMbUtYGCOirbi4Fij/RPSGC9+
 xKWUANbyODCnXcgxMF9sq/TxmOJq+h3C+a7/8SqgixzLEocWiQMeau0qzx3NzpyyQWE3n98kR6f
 g3lwASQiDngzlk+Gzqol2NfKst35/asXhfaqFO7KRjmakR8fTNVRoJCNy1KYgGqc0cHEqZjm79a
 zLW+c4 dpYQuOMnw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The norm should be flexible array structures with __counted_by
annotations, so DEFINE_FLEX() is updated to expect that. Rename
the non-annotated version to DEFINE_RAW_FLEX(), and update the few
existing users. Additionally add self-tests to validate syntax and
size calculations.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 drivers/net/ethernet/intel/ice/ice_common.c |  4 +--
 drivers/net/ethernet/intel/ice/ice_ddp.c    |  8 +++---
 drivers/net/ethernet/intel/ice/ice_lag.c    |  6 ++---
 drivers/net/ethernet/intel/ice/ice_lib.c    |  4 +--
 drivers/net/ethernet/intel/ice/ice_sched.c  |  4 +--
 drivers/net/ethernet/intel/ice/ice_switch.c | 10 ++++----
 drivers/net/ethernet/intel/ice/ice_xsk.c    |  2 +-
 include/linux/overflow.h                    | 27 +++++++++++++++++----
 lib/overflow_kunit.c                        | 19 +++++++++++++++
 9 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 10c32cd80fff..ce50a322daa9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4700,7 +4700,7 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		enum ice_disq_rst_src rst_src, u16 vmvf_num,
 		struct ice_sq_cd *cd)
 {
-	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
 	u16 i, buf_size = __struct_size(qg_list);
 	struct ice_q_ctx *q_ctx;
 	int status = -ENOENT;
@@ -4922,7 +4922,7 @@ int
 ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 		      u16 *q_id)
 {
-	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
 	u16 qg_size = __struct_size(qg_list);
 	struct ice_hw *hw;
 	int status = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 8b7504a9df31..03efb2521ca7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1934,8 +1934,8 @@ static enum ice_ddp_state ice_init_pkg_info(struct ice_hw *hw,
  */
 static enum ice_ddp_state ice_get_pkg_info(struct ice_hw *hw)
 {
-	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg_info, pkg_info,
-		    ICE_PKG_CNT);
+	DEFINE_RAW_FLEX(struct ice_aqc_get_pkg_info_resp, pkg_info, pkg_info,
+			ICE_PKG_CNT);
 	u16 size = __struct_size(pkg_info);
 	u32 i;
 
@@ -1986,8 +1986,8 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 					     struct ice_pkg_hdr *ospkg,
 					     struct ice_seg **seg)
 {
-	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg, pkg_info,
-		    ICE_PKG_CNT);
+	DEFINE_RAW_FLEX(struct ice_aqc_get_pkg_info_resp, pkg, pkg_info,
+			ICE_PKG_CNT);
 	u16 size = __struct_size(pkg);
 	enum ice_ddp_state state;
 	u32 i;
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 2a25323105e5..da38edac1c42 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -470,7 +470,7 @@ static void
 ice_lag_move_vf_node_tc(struct ice_lag *lag, u8 oldport, u8 newport,
 			u16 vsi_num, u8 tc)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	struct device *dev = ice_pf_to_dev(lag->pf);
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
@@ -828,7 +828,7 @@ static void
 ice_lag_reclaim_vf_tc(struct ice_lag *lag, struct ice_hw *src_hw, u16 vsi_num,
 		      u8 tc)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	struct device *dev = ice_pf_to_dev(lag->pf);
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
@@ -1852,7 +1852,7 @@ static void
 ice_lag_move_vf_nodes_tc_sync(struct ice_lag *lag, struct ice_hw *dest_hw,
 			      u16 vsi_num, u8 tc)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	struct device *dev = ice_pf_to_dev(lag->pf);
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9be724291ef8..6819e95cec32 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1805,7 +1805,7 @@ int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
 
 int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u16 q_idx)
 {
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
 
 	if (q_idx >= vsi->alloc_txq || !tx_rings || !tx_rings[q_idx])
 		return -EINVAL;
@@ -1854,7 +1854,7 @@ int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
 static int
 ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_tx_ring **rings, u16 count)
 {
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
 	int err = 0;
 	u16 q_idx;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index d174a4eeb899..a1525992d14b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -237,7 +237,7 @@ static int
 ice_sched_remove_elems(struct ice_hw *hw, struct ice_sched_node *parent,
 		       u32 node_teid)
 {
-	DEFINE_FLEX(struct ice_aqc_delete_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_delete_elem, buf, teid, 1);
 	u16 buf_size = __struct_size(buf);
 	u16 num_groups_removed = 0;
 	int status;
@@ -2219,7 +2219,7 @@ int
 ice_sched_move_nodes(struct ice_port_info *pi, struct ice_sched_node *parent,
 		     u16 num_items, u32 *list)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	u16 buf_len = __struct_size(buf);
 	struct ice_sched_node *node;
 	u16 i, grps_movd = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index f84bab80ca42..d4baae8c3b72 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1812,7 +1812,7 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
 			   enum ice_sw_lkup_type lkup_type,
 			   enum ice_adminq_opc opc)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
 	u16 buf_len = __struct_size(sw_buf);
 	struct ice_aqc_res_elem *vsi_ele;
 	int status;
@@ -2081,7 +2081,7 @@ ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u8 *r_bitmap,
  */
 int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
 	u16 buf_len = __struct_size(sw_buf);
 	int status;
 
@@ -4418,7 +4418,7 @@ int
 ice_alloc_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 		   u16 *counter_id)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
 	u16 buf_len = __struct_size(buf);
 	int status;
 
@@ -4446,7 +4446,7 @@ int
 ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 		  u16 counter_id)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
 	u16 buf_len = __struct_size(buf);
 	int status;
 
@@ -4476,7 +4476,7 @@ ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
  */
 int ice_share_res(struct ice_hw *hw, u16 type, u8 shared, u16 res_id)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
 	u16 buf_len = __struct_size(buf);
 	u16 res_type;
 	int status;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8b81a1677045..92ffa8de5171 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -217,7 +217,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
  */
 static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 {
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
 	u16 size = __struct_size(qg_buf);
 	struct ice_q_vector *q_vector;
 	struct ice_tx_ring *tx_ring;
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index aa691f2119b0..77f3f7990555 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -396,9 +396,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * @name: Name for a variable to define.
  * @member: Name of the array member.
  * @count: Number of elements in the array; must be compile-time const.
- * @initializer: initializer expression (could be empty for no init).
+ * @initializer...: initializer expression (could be empty for no init).
  */
-#define _DEFINE_FLEX(type, name, member, count, initializer)			\
+#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
 	_Static_assert(__builtin_constant_p(count),				\
 		       "onstack flex array members require compile-time const count"); \
 	union {									\
@@ -408,8 +408,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 	type *name = (type *)&name##_u
 
 /**
- * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
- * flexible array member.
+ * DEFINE_RAW_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member, when it does not have a __counted_by annotation.
  *
  * @type: structure type name, including "struct" keyword.
  * @name: Name for a variable to define.
@@ -420,7 +420,24 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * flexible array member.
  * Use __struct_size(@name) to get compile-time size of it afterwards.
  */
-#define DEFINE_FLEX(type, name, member, count)			\
+#define DEFINE_RAW_FLEX(type, name, member, count)	\
 	_DEFINE_FLEX(type, name, member, count, = {})
 
+/**
+ * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member.
+ *
+ * @TYPE: structure type name, including "struct" keyword.
+ * @NAME: Name for a variable to define.
+ * @COUNTER: Name of the __counted_by member.
+ * @MEMBER: Name of the array member.
+ * @COUNT: Number of elements in the array; must be compile-time const.
+ *
+ * Define a zeroed, on-stack, instance of @TYPE structure with a trailing
+ * flexible array member.
+ * Use __struct_size(@NAME) to get compile-time size of it afterwards.
+ */
+#define DEFINE_FLEX(TYPE, NAME, COUNTER, MEMBER, COUNT)	\
+	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
+
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 65e8a72a83bf..9188b482999b 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1172,6 +1172,24 @@ static void castable_to_type_test(struct kunit *test)
 #undef TEST_CASTABLE_TO_TYPE
 }
 
+struct foo {
+	int a;
+	u32 counter;
+	s16 array[] __counted_by(counter);
+};
+
+static void DEFINE_FLEX_test(struct kunit *test)
+{
+	DEFINE_RAW_FLEX(struct foo, two, array, 2);
+	DEFINE_FLEX(struct foo, eight, counter, array, 8);
+	DEFINE_FLEX(struct foo, empty, counter, array, 0);
+
+	KUNIT_EXPECT_EQ(test, __struct_size(two),
+			sizeof(struct foo) + sizeof(s16) + sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __struct_size(eight), 24);
+	KUNIT_EXPECT_EQ(test, __struct_size(empty), sizeof(struct foo));
+}
+
 static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(u8_u8__u8_overflow_test),
 	KUNIT_CASE(s8_s8__s8_overflow_test),
@@ -1194,6 +1212,7 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(overflows_type_test),
 	KUNIT_CASE(same_type_test),
 	KUNIT_CASE(castable_to_type_test),
+	KUNIT_CASE(DEFINE_FLEX_test),
 	{}
 };
 
-- 
2.34.1


