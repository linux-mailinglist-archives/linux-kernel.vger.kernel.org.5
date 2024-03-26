Return-Path: <linux-kernel+bounces-118602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E4C88BD23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E8E2E5194
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39DF5FEE3;
	Tue, 26 Mar 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2OSVPM/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9817722;
	Tue, 26 Mar 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443694; cv=none; b=eViYUqDTuSGvt70oF9FA5g8z5VgQOPrHuSDhKploIHC0UDvYWlpdRZM6rJgAOsr54OJwitg3W4wFzjT+cMonqZd4pZegqjFQe8k3S7ktcNcPT5GxnDKVW2LVq/hwVkKVPJ09gqNNVb3GEADiwHOPApqGjUAUuQFIFzfFSSum/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443694; c=relaxed/simple;
	bh=Pv1J/BykIm+R1ZulBCZAwIgEzeYs6ssp0vT1fdQLYFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dg8Nur1zA/e3M1D1EGEnwqnICRe0M7f9zHsti/us8FB9M0lqzg4wXJ2CQTe+sobCSCSSW1KnuZ8mZ4L3+NJxSz7XVc4VtADhdTn1Nt3ZWwL7ge8EPUslJyhYK3hZAkSsScksOEr9H7HFeMLZ0NprIge+ROj14E6VK6PQt+mN4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2OSVPM/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711443693; x=1742979693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pv1J/BykIm+R1ZulBCZAwIgEzeYs6ssp0vT1fdQLYFI=;
  b=l2OSVPM/hTVKcekm62O4slCdsDmZfTLGXu3vjIwolkT6BtNc4KgAvaN5
   XZdJwZTu+eWBVmv5uxyf+gP9/biNXb8fRS2VCJshgXoPLrgxELvaKxmCI
   lmm2YBqaZHrhfZzM7ZwHVuXagKSQgMc3yUpnxuoHB+O4BoVO74FXSOVnZ
   UUFOoy6CJltXj12khn7vrkrBqS+JD3/85Ur+V866GBpMrcespTaYEdiz6
   UYvcCLm2fmfY/6Q8abEs+fCf/LBXvh1vMY9ITfUg/VWBaF+nqKVR+3prD
   MON54uVA7/6LmaQ5rGfRA0Ak1BJfe1eoYZEWNE80bPHAmEQ3Ker6wPqSF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6343349"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6343349"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20614509"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 2/7] soundwire: cadence: remove PDI offset completely
Date: Tue, 26 Mar 2024 09:01:17 +0000
Message-Id: <20240326090122.1051806-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This offset is set to exactly zero and serves no purpose. Remove.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 3e7cf04aaf2a..c2c1463a5c53 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1236,7 +1236,7 @@ EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
 static int cdns_allocate_pdi(struct sdw_cdns *cdns,
 			     struct sdw_cdns_pdi **stream,
-			     u32 num, u32 pdi_offset)
+			     u32 num)
 {
 	struct sdw_cdns_pdi *pdi;
 	int i;
@@ -1249,7 +1249,7 @@ static int cdns_allocate_pdi(struct sdw_cdns *cdns,
 		return -ENOMEM;
 
 	for (i = 0; i < num; i++) {
-		pdi[i].num = i + pdi_offset;
+		pdi[i].num = i;
 	}
 
 	*stream = pdi;
@@ -1266,7 +1266,6 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config)
 {
 	struct sdw_cdns_streams *stream;
-	int offset;
 	int ret;
 
 	cdns->pcm.num_bd = config.pcm_bd;
@@ -1277,24 +1276,15 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 	stream = &cdns->pcm;
 
 	/* we allocate PDI0 and PDI1 which are used for Bulk */
-	offset = 0;
-
-	ret = cdns_allocate_pdi(cdns, &stream->bd,
-				stream->num_bd, offset);
+	ret = cdns_allocate_pdi(cdns, &stream->bd, stream->num_bd);
 	if (ret)
 		return ret;
 
-	offset += stream->num_bd;
-
-	ret = cdns_allocate_pdi(cdns, &stream->in,
-				stream->num_in, offset);
+	ret = cdns_allocate_pdi(cdns, &stream->in, stream->num_in);
 	if (ret)
 		return ret;
 
-	offset += stream->num_in;
-
-	ret = cdns_allocate_pdi(cdns, &stream->out,
-				stream->num_out, offset);
+	ret = cdns_allocate_pdi(cdns, &stream->out, stream->num_out);
 	if (ret)
 		return ret;
 
@@ -1802,7 +1792,6 @@ EXPORT_SYMBOL(cdns_set_sdw_stream);
  * cdns_find_pdi() - Find a free PDI
  *
  * @cdns: Cadence instance
- * @offset: Starting offset
  * @num: Number of PDIs
  * @pdi: PDI instances
  * @dai_id: DAI id
@@ -1811,14 +1800,13 @@ EXPORT_SYMBOL(cdns_set_sdw_stream);
  * expected to match, return NULL otherwise.
  */
 static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
-					  unsigned int offset,
 					  unsigned int num,
 					  struct sdw_cdns_pdi *pdi,
 					  int dai_id)
 {
 	int i;
 
-	for (i = offset; i < offset + num; i++)
+	for (i = 0; i < num; i++)
 		if (pdi[i].num == dai_id)
 			return &pdi[i];
 
@@ -1872,15 +1860,15 @@ struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 	struct sdw_cdns_pdi *pdi = NULL;
 
 	if (dir == SDW_DATA_DIR_RX)
-		pdi = cdns_find_pdi(cdns, 0, stream->num_in, stream->in,
+		pdi = cdns_find_pdi(cdns, stream->num_in, stream->in,
 				    dai_id);
 	else
-		pdi = cdns_find_pdi(cdns, 0, stream->num_out, stream->out,
+		pdi = cdns_find_pdi(cdns, stream->num_out, stream->out,
 				    dai_id);
 
 	/* check if we found a PDI, else find in bi-directional */
 	if (!pdi)
-		pdi = cdns_find_pdi(cdns, 0, stream->num_bd, stream->bd,
+		pdi = cdns_find_pdi(cdns, stream->num_bd, stream->bd,
 				    dai_id);
 
 	if (pdi) {
-- 
2.34.1


