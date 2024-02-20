Return-Path: <linux-kernel+bounces-73610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB9E85C518
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC24E1C21EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780314A4D0;
	Tue, 20 Feb 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="EfnG1XlK"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED514A0B5;
	Tue, 20 Feb 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458306; cv=none; b=P0FY0occA5mlIHEO58qLmRSgNo5FITdswKou0WBoxK6Te+GXsUf3JNG94eXk0QvRO2YEXxwMWcsOryD2uncGneC53SZPdr7qZ1AZ0i2LrS51zAh9LEzYZiRqVK+NNiVLmpd4qnF6n2ckSvbft1ihtPdbIMrZL4vsPz+l+Oe22gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458306; c=relaxed/simple;
	bh=xDvA4NOSaHeI0LBT+9dOO/oYhDt7h7z7NwciBr/tMGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWHU+jqcFQOyGc66fxZhGmAHsIriWR95A8MQsvNq5+Oc9U+YKKMe2Qv8DtYZXK3Z05DWNPxn33Gm/1g4+bwvM0KMukeCQxjpFYphgpmLuft3HcDJsQHct+BbAGHlYf79LGVNAjLwEdDqhL7wQYJYtxcEqIMiWJ+nU/U5WoF9uD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=EfnG1XlK; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 578F1200BE63;
	Tue, 20 Feb 2024 20:44:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 578F1200BE63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708458297;
	bh=L6uQoWV8E36c7sTdK4YsBrJRSuQm9ELTPqyqgTvcTrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfnG1XlKxx6HJYxNkJuRa+ksJ6Mn7KjTQOi0nQGXeOQbqdbmWIP+R4yTxWdtSh7gu
	 TJ8MEgsNVrdfeFBz+1yhkjw02j7j7eGZi0X8IxDisfsOOKZLNMLNYOuwsYTB7qH6I7
	 eRAmuSWjvuShTjPLEROKfjbXUsVmKH+ar8UHEnOUHJsxxAZcciivEaQGJ9xtdrGZtd
	 +iidu+HgjmSKitYQCDOGHlTdfGPPZSl7hbJ3474wJSuquxFl3s/ZECLjBWc3tnLPlE
	 SQLnwpNI0dRf/3TfhaINWIdzGQUvMIj50TLzHy7AxYOaD4rqqtTo4TxmXeEHDSJFwt
	 GKJ4u+9iEQbtg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 1/3] uapi: ioam6: API for netlink multicast events
Date: Tue, 20 Feb 2024 20:44:42 +0100
Message-Id: <20240220194444.36127-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220194444.36127-1-justin.iurman@uliege.be>
References: <20240220194444.36127-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new api to support ioam6 events for generic netlink multicast. A
first "trace" event is added to the list of ioam6 events, which will
represent an IOAM Trace. It provides another solution to share IOAM data
with user space (an alternative to IPv6 raw sockets combined with
ancillary data).

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/uapi/linux/ioam6_genl.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/linux/ioam6_genl.h b/include/uapi/linux/ioam6_genl.h
index ca4b22833754..1733fbc51fb5 100644
--- a/include/uapi/linux/ioam6_genl.h
+++ b/include/uapi/linux/ioam6_genl.h
@@ -49,4 +49,24 @@ enum {
 
 #define IOAM6_CMD_MAX (__IOAM6_CMD_MAX - 1)
 
+#define IOAM6_GENL_EV_GRP_NAME "ioam6_events"
+
+enum ioam6_event_type {
+	IOAM6_EVENT_UNSPEC,
+	IOAM6_EVENT_TRACE,
+};
+
+enum ioam6_event_attr {
+	IOAM6_EVENT_ATTR_UNSPEC,
+
+	IOAM6_EVENT_ATTR_TRACE_NAMESPACE,	/* u16 */
+	IOAM6_EVENT_ATTR_TRACE_NODELEN,		/* u8 */
+	IOAM6_EVENT_ATTR_TRACE_TYPE,		/* u32 */
+	IOAM6_EVENT_ATTR_TRACE_DATA,		/* Binary */
+
+	__IOAM6_EVENT_ATTR_MAX
+};
+
+#define IOAM6_EVENT_ATTR_MAX (__IOAM6_EVENT_ATTR_MAX - 1)
+
 #endif /* _UAPI_LINUX_IOAM6_GENL_H */
-- 
2.34.1


