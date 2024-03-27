Return-Path: <linux-kernel+bounces-121422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E388E7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BD72A433F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90D146582;
	Wed, 27 Mar 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Re0GYhPS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234EC14535D;
	Wed, 27 Mar 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549403; cv=none; b=FJcq0pOg8Em11fhfT5CMI28sfcVcv5f2q848QYNZFSunG6NCSqwTgTLKi59gsuxZlQTXNHHZDBx6FsxX+PX4zoD7bzqGzesuERAFToDMltz+qO2ykPpKqiffKjAEiacJijY1rzTdW7nCcK6HT+2e/TPi8NRgvGIdZPigYVWwXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549403; c=relaxed/simple;
	bh=iiy+IT/DztQVWAIWT58TrPOTIu+zB11vMHnxpdfkMvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJ3F9gajsFs9EzblkevWEl3RFBYefPN7EhCrKs/pF4f5vzy+FW3nueP558hK2qujiRMlLH4gzPYfMMP+HybLjLhZQyaTAtxBpOSYtb3O6POO3kAS4iW/5DuyNB+QdRRGnRsIpeI08uoWsok8Mf56gPE1r0BHEqtnVVL1RRO5Qnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Re0GYhPS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711549402; x=1743085402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iiy+IT/DztQVWAIWT58TrPOTIu+zB11vMHnxpdfkMvE=;
  b=Re0GYhPSRqT+9Ck2LNl0UyFzSs2cvMof5Z9Vs4DhFSUNC6OdadPEVdBx
   rAEcLO88pJdCL7NcNU29PWXArvw6IpXyZaPEPWK8oq5Ia1gbiYXjg8KGA
   4pFsLInmr5AYIAR+S9xveDcwA+/TmfAOkTAbQ0KfZkkJKtaRxPEQ9GjjV
   OATr3mFLrpGRjwbWK/IWoskZOcGC5rgjgTSQqgutYa3CgQKOhFypJx/wO
   Vgq8M4dvbst6rjFDLj2Ouw8K92EQHZU/LNO6uc35J7bX7dQ/drfTJdHZh
   vzNapZC+SN4aCFcf3ibZVV8muDfNBUsKswUI9ipVYCsZVlENzRLmd9MZs
   A==;
X-CSE-ConnectionGUID: s+OdSvCbQfqTnGeh9JKTEA==
X-CSE-MsgGUID: C55Xa0mNTsCIpPmqOskaKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6592551"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6592551"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 07:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="20973106"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2024 07:23:19 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] idpf: sprinkle __counted_by{,_le}() in the virtchnl2 header
Date: Wed, 27 Mar 2024 15:22:41 +0100
Message-ID: <20240327142241.1745989-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327142241.1745989-1-aleksander.lobakin@intel.com>
References: <20240327142241.1745989-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both virtchnl2.h and its consumer idpf_virtchnl.c are very error-prone.
There are 10 structures with flexible arrays at the end, but 9 of them
has flex member counter in Little Endian.
Make the code a bit more robust by applying __counted_by_le() to those
9. LE platforms is the main target for this driver, so they would
receive additional protection.
While we're here, add __counted_by() to virtchnl2_ptype::proto_id, as
its counter is `u8` regardless of the Endianness.
Compile test on x86_64 (LE) didn't reveal any new issues after applying
the attributes.

Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 29419211b3d9..63deb120359c 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -555,7 +555,7 @@ VIRTCHNL2_CHECK_STRUCT_LEN(32, virtchnl2_queue_reg_chunk);
 struct virtchnl2_queue_reg_chunks {
 	__le16 num_chunks;
 	u8 pad[6];
-	struct virtchnl2_queue_reg_chunk chunks[];
+	struct virtchnl2_queue_reg_chunk chunks[] __counted_by_le(num_chunks);
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
 
@@ -703,7 +703,7 @@ struct virtchnl2_config_tx_queues {
 	__le32 vport_id;
 	__le16 num_qinfo;
 	u8 pad[10];
-	struct virtchnl2_txq_info qinfo[];
+	struct virtchnl2_txq_info qinfo[] __counted_by_le(num_qinfo);
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_config_tx_queues);
 
@@ -782,7 +782,7 @@ struct virtchnl2_config_rx_queues {
 	__le32 vport_id;
 	__le16 num_qinfo;
 	u8 pad[18];
-	struct virtchnl2_rxq_info qinfo[];
+	struct virtchnl2_rxq_info qinfo[] __counted_by_le(num_qinfo);
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_config_rx_queues);
 
@@ -868,7 +868,7 @@ VIRTCHNL2_CHECK_STRUCT_LEN(32, virtchnl2_vector_chunk);
 struct virtchnl2_vector_chunks {
 	__le16 num_vchunks;
 	u8 pad[14];
-	struct virtchnl2_vector_chunk vchunks[];
+	struct virtchnl2_vector_chunk vchunks[] __counted_by_le(num_vchunks);
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_vector_chunks);
 
@@ -912,7 +912,7 @@ struct virtchnl2_rss_lut {
 	__le16 lut_entries_start;
 	__le16 lut_entries;
 	u8 pad[4];
-	__le32 lut[];
+	__le32 lut[] __counted_by_le(lut_entries);
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(12, virtchnl2_rss_lut);
 
@@ -977,7 +977,7 @@ struct virtchnl2_ptype {
 	u8 ptype_id_8;
 	u8 proto_id_count;
 	__le16 pad;
-	__le16 proto_id[];
+	__le16 proto_id[] __counted_by(proto_id_count);
 } __packed __aligned(2);
 VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
 
@@ -1104,7 +1104,7 @@ struct virtchnl2_rss_key {
 	__le32 vport_id;
 	__le16 key_len;
 	u8 pad;
-	u8 key_flex[];
+	u8 key_flex[] __counted_by_le(key_len);
 } __packed;
 VIRTCHNL2_CHECK_STRUCT_LEN(7, virtchnl2_rss_key);
 
@@ -1131,7 +1131,7 @@ VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_queue_chunk);
 struct virtchnl2_queue_chunks {
 	__le16 num_chunks;
 	u8 pad[6];
-	struct virtchnl2_queue_chunk chunks[];
+	struct virtchnl2_queue_chunk chunks[] __counted_by_le(num_chunks);
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_chunks);
 
@@ -1195,7 +1195,7 @@ struct virtchnl2_queue_vector_maps {
 	__le32 vport_id;
 	__le16 num_qv_maps;
 	u8 pad[10];
-	struct virtchnl2_queue_vector qv_maps[];
+	struct virtchnl2_queue_vector qv_maps[] __counted_by_le(num_qv_maps);
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_queue_vector_maps);
 
@@ -1247,7 +1247,7 @@ struct virtchnl2_mac_addr_list {
 	__le32 vport_id;
 	__le16 num_mac_addr;
 	u8 pad[2];
-	struct virtchnl2_mac_addr mac_addr_list[];
+	struct virtchnl2_mac_addr mac_addr_list[] __counted_by_le(num_mac_addr);
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_mac_addr_list);
 
-- 
2.44.0


