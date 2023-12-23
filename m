Return-Path: <linux-kernel+bounces-10243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471D081D1B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796FC1C227F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0633A8CC;
	Sat, 23 Dec 2023 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNuBqnfK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE239FF9;
	Sat, 23 Dec 2023 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300389; x=1734836389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+6J77JDqTiJN5j8IBkCDiN5nsC96D4OujctoP2BKkx4=;
  b=jNuBqnfKahPAKDJJrRwnOItMuiiaX08HLq7NFFBiTEkFWczkzYcl5tua
   lFYGLEbrQzofBP+KqF5eUKTbM2TFz3cWt3+ZVmeLs7aFYA9D95wuEkzGY
   Y18U9SIoTLb9oEY80wNsXNpLSps2Nx4Gm/OtkvkPAYu4p0DyE+g/sh7wI
   81hPMM5cXjemOKWZmJAkhPL5OJpEZqXTdSxLMykgPVQ+mY8GjOOUeh+wN
   YZzdJuY2USvPnBoQaT2WFmNn9stFJYWTGt1YK97+NomvHjfz8ZoGQQokh
   u1R8dy43noUj9Hm3tKXOU/rPn/6+M7S3P9vOr/LjQx11AVCxqN9FMWO4/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611051"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611051"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537650"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:46 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 27/34] idpf: add support for sw interrupt
Date: Sat, 23 Dec 2023 03:55:47 +0100
Message-ID: <20231223025554.2316836-28-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

Sometimes, it may be needed to be able to trigger a HW interrupt
without a "real" interrupt from the hardware.
Add the corresponding register fields to the register table.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 3 +++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 4 ++++
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 2c6776086130..335bf789d908 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -100,6 +100,9 @@ static int idpf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
 		intr->dyn_ctl_intrvl_s = PF_GLINT_DYN_CTL_INTERVAL_S;
 		intr->dyn_ctl_wb_on_itr_m = PF_GLINT_DYN_CTL_WB_ON_ITR_M;
+		intr->dyn_ctl_swint_trig_m = PF_GLINT_DYN_CTL_SWINT_TRIG_M;
+		intr->dyn_ctl_sw_itridx_ena_m =
+					PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_PF_ITR_IDX_SPACING);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 20f484712ac2..fa21feddd204 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -347,6 +347,8 @@ struct idpf_vec_regs {
  * @dyn_ctl_itridx_m: Mask for ITR index
  * @dyn_ctl_intrvl_s: Register bit offset for ITR interval
  * @dyn_ctl_wb_on_itr_m: Mask for WB on ITR feature
+ * @dyn_ctl_swint_trig_m: Mask for SW ITR trigger register
+ * @dyn_ctl_sw_itridx_ena_m: Mask for SW ITR enable index
  * @rx_itr: RX ITR register
  * @tx_itr: TX ITR register
  * @icr_ena: Interrupt cause register offset
@@ -360,6 +362,8 @@ struct idpf_intr_reg {
 	u32 dyn_ctl_itridx_m;
 	u32 dyn_ctl_intrvl_s;
 	u32 dyn_ctl_wb_on_itr_m;
+	u32 dyn_ctl_swint_trig_m;
+	u32 dyn_ctl_sw_itridx_ena_m;
 	void __iomem *rx_itr;
 	void __iomem *tx_itr;
 	void __iomem *icr_ena;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index f5b0a0666636..a78ae0e618ca 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -99,6 +99,9 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl_intena_msk_m = VF_INT_DYN_CTLN_INTENA_MSK_M;
 		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
 		intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
+		intr->dyn_ctl_itridx_m = VF_INT_DYN_CTLN_ITR_INDX_M;
+		intr->dyn_ctl_sw_itridx_ena_m =
+			VF_INT_DYN_CTLN_SW_ITR_INDX_ENA_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_VF_ITR_IDX_SPACING);
-- 
2.43.0


