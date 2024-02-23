Return-Path: <linux-kernel+bounces-78510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C3B861452
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310D91C22DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC11C680;
	Fri, 23 Feb 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="lpuxA5Fp"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B017493;
	Fri, 23 Feb 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699312; cv=none; b=c4w1mI2NDpE25dI89mXlQeJchifTPZowi59Q3fqmuSk4Egi+4BkTnncPd31vMYAFx+PTCjWP4IyUfLIsnK1C1BlhbpcocEtHpT5DsofZVy/abP3TUoYoMfmUW6q3VbJywvgMFnogGXrVC9gh/KTObMvWjo5Y4ZeyssRtiYM0lEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699312; c=relaxed/simple;
	bh=lYSbqhb9aelgiyV2bHdQgyY0ObK/yrK8TqQKdtUu/qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekGqSvyO2dIChQMBavP2lYBXUtaRJjW5hnD3x0hlKOrxgP13ILBufosLlWQDCxLzN7d0HlDg/XGcZ7HxFMCrL8XFb4wyXFXekHjPWDIYXX8upPh/jXQCm7Ve9MlCoqTpljbCanYEfy8cLicGLFhFYdgGFTELJrqVfLlOCy6Fj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=lpuxA5Fp; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 64142200C982;
	Fri, 23 Feb 2024 15:41:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 64142200C982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708699303;
	bh=LcVhwtN+UqJjMSh3FfAL9zHi7+WPp9yvrVRqAgObzSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpuxA5FplMiOqb/KbsHnDkgK9+wxn6OZTR4X17vi1Za2CxMkPSP95T5NOS8oJOTtX
	 Qdh3fos5tVvMNnksWZeyYT1JPnFslBUX17zHkwWvgzW4A2ktCyU2SQtufOO6LHZAmF
	 afDM4Fx7S+ISfovXy2zQy7IB2xG/GD0T4U66tzkC0nQCSW7xam2JXX9YR3fmIbLw+4
	 b0fPKj0yWmaP7jAPuFEImXh4FLpdBHFqgigPbTgzIG1btadvch0Xu9nnsxbEocNMP7
	 4cy/aHy0uluXUYwV3UP7VhPWY55fg/zAJjFe5hI33iIkbyz90QmTIdh4gGGeA9Vxvn
	 zv62Zmu82IhjQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v4 1/3] uapi: ioam6: API for netlink multicast events
Date: Fri, 23 Feb 2024 15:41:33 +0100
Message-Id: <20240223144135.12826-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223144135.12826-1-justin.iurman@uliege.be>
References: <20240223144135.12826-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new api to support ioam6 events for generic netlink multicast. A
first "trace" event is added to the list of ioam6 events, which will
represent an IOAM Pre-allocated (or Incremental) Trace Option-Type. It
provides another solution to share IOAM data with user space.

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


