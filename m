Return-Path: <linux-kernel+bounces-117982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C188B665
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329B4C61D38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D63570CB3;
	Mon, 25 Mar 2024 20:46:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE415D738
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399604; cv=none; b=p5tKlS9iB7OeDwVeJkkIG973jX8Hbg0jroCqkOqwG/E2J993E8JtzNuMC69WF/8ej9ZbRiW5qySW6r75fAa/fSREQRn9MELb7raYuEKysfUw5K21pxKth765DJK+Na92A0IEj8NwViu1ovi7eFi6YtyKsDyND40c9syIdPQH+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399604; c=relaxed/simple;
	bh=NzoWAmhlNMrynHgIEM+sPtA7EMAquK1BebI41cCyErg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj3GR/zqrw6Z0twVfWYUH+husa+Ei+1p/7sezkgglQiEe07Aq1BY7uB2BXphn9Q5WdahTxiHgOP0vVKqHFa+X3WY5VxtA7iju1IaIwBvN3n+H8zHaqHtaCruS91VAsNRtdDreccKGmwTzGAG4fujghUfUNDe5wPdgwCn2PWPO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498BD339;
	Mon, 25 Mar 2024 13:47:15 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F09D23F64C;
	Mon, 25 Mar 2024 13:46:40 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 1/5] include: trace: Widen the tag buffer in trace_scmi_dump_msg
Date: Mon, 25 Mar 2024 20:46:16 +0000
Message-ID: <20240325204620.1437237-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325204620.1437237-1-cristian.marussi@arm.com>
References: <20240325204620.1437237-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bigger buffer allow for more diverse tag names.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/trace/events/scmi.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index 422c1ad9484d..127300481123 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -7,6 +7,8 @@
 
 #include <linux/tracepoint.h>
 
+#define TRACE_SCMI_MAX_TAG_LEN	6
+
 TRACE_EVENT(scmi_fc_call,
 	TP_PROTO(u8 protocol_id, u8 msg_id, u32 res_id, u32 val1, u32 val2),
 	TP_ARGS(protocol_id, msg_id, res_id, val1, val2),
@@ -150,7 +152,7 @@ TRACE_EVENT(scmi_msg_dump,
 		__field(u8, channel_id)
 		__field(u8, protocol_id)
 		__field(u8, msg_id)
-		__array(char, tag, 5)
+		__array(char, tag, TRACE_SCMI_MAX_TAG_LEN)
 		__field(u16, seq)
 		__field(int, status)
 		__field(size_t, len)
@@ -162,7 +164,7 @@ TRACE_EVENT(scmi_msg_dump,
 		__entry->channel_id = channel_id;
 		__entry->protocol_id = protocol_id;
 		__entry->msg_id = msg_id;
-		strscpy(__entry->tag, tag, 5);
+		strscpy(__entry->tag, tag, TRACE_SCMI_MAX_TAG_LEN);
 		__entry->seq = seq;
 		__entry->status = status;
 		__entry->len = len;
-- 
2.44.0


