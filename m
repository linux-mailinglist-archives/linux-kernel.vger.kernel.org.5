Return-Path: <linux-kernel+bounces-118607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948B88BD28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3221C3586F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204026E614;
	Tue, 26 Mar 2024 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRKkGHV8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E365197;
	Tue, 26 Mar 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443697; cv=none; b=QXPiQ1ywPet//1fXROOcfnHyAw2PCJk5xxFdonD855XGhsHPpd/SjlvsV+4/voNXY7IQOcUTT6cKUlP/tYFRLZnVk4jmQwxqYnXVmRFDv3O5HHiuBfF+uCDxgMssYVLBLOl52C6DCHjRPUlXj+ljiyKqHH9BQ4Yjr+wMYqrjwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443697; c=relaxed/simple;
	bh=c+MuKXOKkKdXjy1Y8M+WHe8wQaylbGo3X0SgvA9A7To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ud5V2oFVq9VWoTIcJ76rECC3rZBLZCmyswGv4XdMVKJk/W3F45fLRU1HGgzPMRFMzRg2EpqazlD+B4BDC9+f3ggU2SGBuvCcWWVrbcuGwO0O1UVeQAHJsXIIiVNpQeBGcdjRZVB53cFn7at6QR6hIydFJifiIkykkdKeqH2UkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRKkGHV8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711443696; x=1742979696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+MuKXOKkKdXjy1Y8M+WHe8wQaylbGo3X0SgvA9A7To=;
  b=TRKkGHV8S1N4SBA8jbemQLLf9oneHKnDcqipVzQkEoAhdaZp+/30A7aQ
   zmYXbAOalgCBRAsAYrWXrGiMsXC8U2yebVc9HHpBJ6UtFEUTqQ3cCqWPn
   oANGGlDDjZ8K1x8avgJsg/Hw8ojgG1Eoy3z7BxHqki4QFRtLLQzHdA+2R
   foFdT3BEnxcgVmfewZUyKrNCcgg+HPiibUsk1MyJonXh7ZtTYMqgGCdWQ
   Rnt6pzUcCq+v0PNaPfIbcWRALaJuWnVyxp0Ym2Wg8SnoMhShT0pXvs5ZK
   Lbm+BsYat4ZcUzsX+KZnVABUErKu7I+A+aN1Ik69FUDl+pqxRxDACSAon
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6343366"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6343366"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20614525"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 7/7] soundwire: bus: add stream refcount
Date: Tue, 26 Mar 2024 09:01:22 +0000
Message-Id: <20240326090122.1051806-8-yung-chuan.liao@linux.intel.com>
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

The notion of stream is by construction based on a multi-bus
capability, to allow for aggregation of Peripheral devices or
functions located on different segments. We currently count how many
master_rt contexts are used by a stream, but we don't have the dual
refcount of how many streams are allocated on a given bus. This
refcount will be useful to check if BTP/BRA streams can be allocated.

Note that the stream_refcount is modified in sdw_master_rt_alloc() and
sdw_master_rt_free() which are both called with the bus_lock mutex
held, so there's no need for refcount_ primitives for additional
protection.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c    | 5 +++++
 include/linux/soundwire/sdw.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 4e9e7d2a942d..7aa4900dcf31 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1181,6 +1181,8 @@ static struct sdw_master_runtime
 	m_rt->bus = bus;
 	m_rt->stream = stream;
 
+	bus->stream_refcount++;
+
 	return m_rt;
 }
 
@@ -1217,6 +1219,7 @@ static void sdw_master_rt_free(struct sdw_master_runtime *m_rt,
 			       struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt, *_s_rt;
+	struct sdw_bus *bus = m_rt->bus;
 
 	list_for_each_entry_safe(s_rt, _s_rt, &m_rt->slave_rt_list, m_rt_node) {
 		sdw_slave_port_free(s_rt->slave, stream);
@@ -1226,6 +1229,8 @@ static void sdw_master_rt_free(struct sdw_master_runtime *m_rt,
 	list_del(&m_rt->stream_node);
 	list_del(&m_rt->bus_node);
 	kfree(m_rt);
+
+	bus->stream_refcount--;
 }
 
 /**
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index e3a4bccc2a7e..71a7031f7b3a 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -902,6 +902,7 @@ struct sdw_master_ops {
  * meaningful if multi_link is set. If set to 1, hardware-based
  * synchronization will be used even if a stream only uses a single
  * SoundWire segment.
+ * @stream_refcount: number of streams currently using this bus
  */
 struct sdw_bus {
 	struct device *dev;
@@ -931,6 +932,7 @@ struct sdw_bus {
 	u32 bank_switch_timeout;
 	bool multi_link;
 	int hw_sync_min_links;
+	int stream_refcount;
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.34.1


