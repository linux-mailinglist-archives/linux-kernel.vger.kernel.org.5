Return-Path: <linux-kernel+bounces-162306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDE8B5945
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0223E1F21899
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625474419;
	Mon, 29 Apr 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJ1/fQ5K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0156B69
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395713; cv=none; b=acvNCYviNsfIAnXoeixZ3LWiyJ1HQ+Aa+gfbHBTNka6rkOZ7D3fe4mpvCvpnK1ILD6ALlkle9Ro65uDlrpmRAs2I76mWlvlHjXqLhJjmechdRIB6/PtzeKDGqCW6mCMZlDBlLsMlUqJmkMJBmsCPMOs4M8o2unZFi5RzS3t5S5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395713; c=relaxed/simple;
	bh=h27EgWOLsss6t7NKo0NXSZGbrkKNJW9OOXO9eHyRHqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBp9F+JCON0KENNvVcAnY794+aPBxEDP0MAUdxyF48vWOeFcDE/s3ovOqJWSfu4Ou4lQtOQG3wN8y2iUFjuLUaOOAxs6hFBBCfIAPoY5eH1g02aPIodbvY51hhnUJSJ1+ahjFsQdLK1pmbdcSThEVpMIvg/bT5rl8eAQcCzsNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJ1/fQ5K; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395712; x=1745931712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h27EgWOLsss6t7NKo0NXSZGbrkKNJW9OOXO9eHyRHqY=;
  b=UJ1/fQ5KyMeYtQZH11BbEELTg4HZ58ATkfRrus579yPzifZ5k2jrTX5h
   SG94JkJjCO6hWrBjoCpbtyCxQ5XUyPwHr72DkLFBvn0CbUyKrrzZaQmSq
   TFO0BlG+McN9dGuZi/9kGGdqw71iy27vVzxPEZQEgJi3dNyU0tBlt5cpw
   8apq3Ua+9t8BZgvhcbiEEsw3IRQTGFrAFd2Eat982djHzSaJ2J1NKFvM5
   YhzG8JVjrRqtzC28+j471UNUkTuzd87YWl0sjoRqBQyFdHSw8bO2IgzG7
   Tl12+ASELDnU22wQ/3lSa1EXASHXvxPv30cudzl60K0ohc/nIC1YEXIQa
   g==;
X-CSE-ConnectionGUID: 94+dWof7SMmt/LwmRigsVg==
X-CSE-MsgGUID: gC9jIFYZTS67DyJ0nlowfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986849"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986849"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:01:51 -0700
X-CSE-ConnectionGUID: 3H4HBRWHSmmlaSRaeGNWLA==
X-CSE-MsgGUID: 17gOKDBURu6647a9Spa7uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507066"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:48 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mikhail Lappo <miklelappo@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 04/15] stm class: sys-t: Improve ftrace source handling
Date: Mon, 29 Apr 2024 16:01:08 +0300
Message-ID: <20240429130119.1518073-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Lappo <miklelappo@gmail.com>

Package messages from ftrace source with SyS-T Structured Binary Data
(later SBD) header and 64-bit ID. This provides modification-free
compatibility between ftrace and SyS-T arguments structure by applying
0xFFFF mask on message ID.

This happens due to the fact that SBD and ftrace structures have the
same principle of data storage: <header><args binary blob>.

The headers are bit-to-bit compatible and both contain event/catalog ID
with the exception, that ftrace header contains more fields within 64
bits which needs to be masked during encoding process, since SBD
standard doesn't support mask of ID field.

        0       15  16   23  24     31  32   39  40  63
ftrace: <event_id>  <flags>  <preempt>  <-pid->  <---->
SBD:    <------- msg_id ------------------------------>

Signed-off-by: Mikhail Lappo <miklelappo@gmail.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/stm/p_sys-t.c | 90 ++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
index 5b4b9f350ec1..1e75aa0025a3 100644
--- a/drivers/hwtracing/stm/p_sys-t.c
+++ b/drivers/hwtracing/stm/p_sys-t.c
@@ -20,6 +20,7 @@ enum sys_t_message_type {
 	MIPI_SYST_TYPE_RAW	= 6,
 	MIPI_SYST_TYPE_SHORT64,
 	MIPI_SYST_TYPE_CLOCK,
+	MIPI_SYST_TYPE_SBD,
 };
 
 enum sys_t_message_severity {
@@ -53,6 +54,19 @@ enum sys_t_message_string_subtype {
 	MIPI_SYST_STRING_PRINTF_64	= 12,
 };
 
+/**
+ * enum sys_t_message_sbd_subtype - SyS-T SBD message subtypes
+ * @MIPI_SYST_SBD_ID32: SBD message with 32-bit message ID
+ * @MIPI_SYST_SBD_ID64: SBD message with 64-bit message ID
+ *
+ * Structured Binary Data messages can send information of arbitrary length,
+ * together with ID's that describe BLOB's content and layout.
+ */
+enum sys_t_message_sbd_subtype {
+	MIPI_SYST_SBD_ID32 = 0,
+	MIPI_SYST_SBD_ID64 = 1,
+};
+
 #define MIPI_SYST_TYPE(t)		((u32)(MIPI_SYST_TYPE_ ## t))
 #define MIPI_SYST_SEVERITY(s)		((u32)(MIPI_SYST_SEVERITY_ ## s) << 4)
 #define MIPI_SYST_OPT_LOC		BIT(8)
@@ -75,6 +89,20 @@ enum sys_t_message_string_subtype {
 #define CLOCK_SYNC_HEADER	(MIPI_SYST_TYPES(CLOCK, TRANSPORT_SYNC)	| \
 				 MIPI_SYST_SEVERITY(MAX))
 
+/*
+ * SyS-T and ftrace headers are compatible to an extent that ftrace event ID
+ * and args can be treated as SyS-T SBD message with 64-bit ID and arguments
+ * BLOB right behind the header without modification. Bits [16:63] coming
+ * together with message ID from ftrace aren't used by SBD and must be zeroed.
+ *
+ *         0       15  16   23  24     31  32   39  40  63
+ * ftrace: <event_id>  <flags>  <preempt>  <-pid->  <----> <args>
+ * SBD:    <------- msg_id ------------------------------> <BLOB>
+ */
+#define SBD_HEADER (MIPI_SYST_TYPES(SBD, ID64) | \
+			 MIPI_SYST_SEVERITY(INFO)		| \
+			 MIPI_SYST_OPT_GUID)
+
 struct sys_t_policy_node {
 	uuid_t		uuid;
 	bool		do_len;
@@ -284,6 +312,59 @@ sys_t_clock_sync(struct stm_data *data, unsigned int m, unsigned int c)
 	return sizeof(header) + sizeof(payload);
 }
 
+static inline u32 sys_t_header(struct stm_source_data *source)
+{
+	if (source && source->type == STM_FTRACE)
+		return SBD_HEADER;
+	return DATA_HEADER;
+}
+
+static ssize_t sys_t_write_data(struct stm_data *data,
+				struct stm_source_data *source,
+				unsigned int master, unsigned int channel,
+				bool ts_first, const void *buf, size_t count)
+{
+	ssize_t sz;
+	const unsigned char nil = 0;
+
+	/*
+	 * Ftrace is zero-copy compatible with SyS-T SBD, but requires
+	 * special handling of first 64 bits. Trim and send them separately
+	 * to avoid damage on original ftrace buffer.
+	 */
+	if (source && source->type == STM_FTRACE) {
+		u64 compat_ftrace_header;
+		ssize_t header_sz;
+		ssize_t buf_sz;
+
+		if (count < sizeof(compat_ftrace_header))
+			return -EINVAL;
+
+		/* SBD only makes use of low 16 bits (event ID) from ftrace event */
+		compat_ftrace_header = *(u64 *)buf & 0xffff;
+		header_sz = stm_data_write(data, master, channel, false,
+					   &compat_ftrace_header,
+					   sizeof(compat_ftrace_header));
+		if (header_sz != sizeof(compat_ftrace_header))
+			return header_sz;
+
+		buf_sz = stm_data_write(data, master, channel, false,
+					buf + header_sz, count - header_sz);
+		if (buf_sz != count - header_sz)
+			return buf_sz;
+		sz = header_sz + buf_sz;
+	} else {
+		sz = stm_data_write(data, master, channel, false, buf, count);
+	}
+
+	if (sz <= 0)
+		return sz;
+
+	data->packet(data, master, channel, STP_PACKET_FLAG, 0, 0, &nil);
+
+	return sz;
+}
+
 static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
 			   unsigned int chan, const char *buf, size_t count,
 			   struct stm_source_data *source)
@@ -291,8 +372,7 @@ static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
 	struct sys_t_output *op = output->pdrv_private;
 	unsigned int c = output->channel + chan;
 	unsigned int m = output->master;
-	const unsigned char nil = 0;
-	u32 header = DATA_HEADER;
+	u32 header = sys_t_header(source);
 	u8 uuid[UUID_SIZE];
 	ssize_t sz;
 
@@ -349,11 +429,7 @@ static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
 	}
 
 	/* DATA */
-	sz = stm_data_write(data, m, c, false, buf, count);
-	if (sz > 0)
-		data->packet(data, m, c, STP_PACKET_FLAG, 0, 0, &nil);
-
-	return sz;
+	return sys_t_write_data(data, source, m, c, false, buf, count);
 }
 
 static const struct stm_protocol_driver sys_t_pdrv = {
-- 
2.43.0


