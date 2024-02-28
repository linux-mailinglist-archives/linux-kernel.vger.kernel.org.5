Return-Path: <linux-kernel+bounces-85601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC3986B82F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5EB6B23E86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C45135A71;
	Wed, 28 Feb 2024 19:33:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D374413
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148790; cv=none; b=aYnIN7Vem0ncIctMbc0e36gSL8JnP87NwHkCWD7yit5iYRBg4OfA+Xsm/Eky0ejBLsIBy+ebIwX9UQ135Oxjp47+Smik1Mt9l23oDY03mSwzjULvbJT4II81ky2yNCLoW+2NqNbOIVnac+EhOC97ZFtEQqnQecsVhg2v98IGM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148790; c=relaxed/simple;
	bh=7IGzCLQMLGkVRkVb5V5G0IQKCXdsrlywwviMolD2M04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fh0Z6Zf2ZNeL3OygjcgpT+o2FNxcEy4+oWh6oJbxAOOQWERWvJqGq1+Y83YUFLhbcdlGzsxQ/z8+Q158O3CzSxl/JF6nrMBNOzZDj/Qtfyw9JhC8FcBXw5ARrPTkG+kRv4Ud/7doPDYrQqG6WyIaW2bBnYweyBVTQ5ts88emNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E139DA7;
	Wed, 28 Feb 2024 11:33:46 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5693F73F;
	Wed, 28 Feb 2024 11:33:05 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/4] include: trace: Widen the tag buffer in trace_scmi_dump_msg
Date: Wed, 28 Feb 2024 19:32:35 +0000
Message-ID: <20240228193238.2102157-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228193238.2102157-1-cristian.marussi@arm.com>
References: <20240228193238.2102157-1-cristian.marussi@arm.com>
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
 include/trace/events/scmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index 422c1ad9484d..3be75752c56f 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -150,7 +150,7 @@ TRACE_EVENT(scmi_msg_dump,
 		__field(u8, channel_id)
 		__field(u8, protocol_id)
 		__field(u8, msg_id)
-		__array(char, tag, 5)
+		__array(char, tag, 7)
 		__field(u16, seq)
 		__field(int, status)
 		__field(size_t, len)
@@ -162,7 +162,7 @@ TRACE_EVENT(scmi_msg_dump,
 		__entry->channel_id = channel_id;
 		__entry->protocol_id = protocol_id;
 		__entry->msg_id = msg_id;
-		strscpy(__entry->tag, tag, 5);
+		strscpy(__entry->tag, tag, 7);
 		__entry->seq = seq;
 		__entry->status = status;
 		__entry->len = len;
-- 
2.43.0


