Return-Path: <linux-kernel+bounces-119490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8578988C99B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E0A1C63865
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC9D1F60A;
	Tue, 26 Mar 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyO9laU7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815A1C2A8;
	Tue, 26 Mar 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471323; cv=none; b=VM6j+rRrqrFXUkARYNX4GvaFaS0itOzKLu0ed6PEZ/R0pgSDYVTSZ+6FY174ORzJsXfPJP/Tl9roWQcjagS+wEStZd5aFPe1mYcfbFOS3OyT3+JEs0gA12B6CR54I03zUMG1UOuB7gTuWlrh8TgKOllJw1O1BUJBlATDw1aBMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471323; c=relaxed/simple;
	bh=0M19hZnqA3jl1JLaoqiVosY36hhwzDxnFIUtxgxHlNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjKWBs8XQ0E3xOWn2gOP9UqTfd9HN3hv+iMrzZwhPhglY1wHxuthV99c0rcPLfuf8tFj+8g3SeFlGfy3+NI3ofVvKDtIJR8UbPn9GsHwhvsR0Do8gR4xHOninsoEqx4TdGHvCXSgxBdqI1/3oxcYXdtAnNaGyWhRa2tlyDmGKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyO9laU7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711471322; x=1743007322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0M19hZnqA3jl1JLaoqiVosY36hhwzDxnFIUtxgxHlNI=;
  b=HyO9laU7MQOkEIIZO7QyrMoPVYlM30CnFTaQ5EH6oFftNFBI/9LKqAyD
   NwFfyQ4ox/YtyJEVPtM0uBTIoEu1UXvz4e8uExv0CmixQVqFypYaulhia
   0BoD13sE+zJwSxNZ1Tq/O9SdEBpUEm8DidEbKxo97UQgeTGwtGFRTsf8m
   JSUu+nvmhxQl2u8T8QBRo0H7J+nFNdPo+sWKe8nEfxQi58t44Oemk/596
   noiN7ZDo28MgkXQPme4fqfmTiIGC7No6X5xA1pYNIRCpoMnK50t22f46w
   HPQzhPj6wHjJSvLvWuzrIrp/UvBIFm/fZ2Z8l/ZHTeqAmceNznCqclHRc
   Q==;
X-CSE-ConnectionGUID: rcc7u+tHRsOFeEzdb4LhXA==
X-CSE-MsgGUID: 1FwQ0fM6TzetRP2AypL+ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24023341"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="24023341"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20667408"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 26 Mar 2024 09:41:52 -0700
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
Subject: [PATCH net-next 3/3] idpf: sprinkle __counted_by{,_le}() in the virtchnl2 header
Date: Tue, 26 Mar 2024 17:41:16 +0100
Message-ID: <20240326164116.645718-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326164116.645718-1-aleksander.lobakin@intel.com>
References: <20240326164116.645718-1-aleksander.lobakin@intel.com>
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


