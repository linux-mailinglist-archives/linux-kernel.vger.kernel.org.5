Return-Path: <linux-kernel+bounces-76618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D830285FA12
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D01B28417
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22B1419A2;
	Thu, 22 Feb 2024 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="srD8tATI"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8612FF73;
	Thu, 22 Feb 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609367; cv=none; b=DVy2kHCFDXlONDGn3XT0ftO5jbrqUYBmlgoylj7vpRPvsuV9fJGpw5lX8wgMLOH6p/NpgHs5kyvsAoHH7N3TrjBWO+HACHM2fLLxFdNQbut0ooErsqqfje8WkmPw34jo1gGyArNE4UvRJPiEmh3FaAxI6eY6p4cmtUFcrkRMmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609367; c=relaxed/simple;
	bh=63q07220oMSPgby8d2W559AqbgLaS4GTvuUIbEXFtIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfQeEOEC+FT6wnI3KrzCnCvH7YKHBSdAs81Xfb1dWMWKB7jttcoITRHu3PiK0TYMpIa11vA3A2oWKYONsrrZcS1igpeEZW27AudUcAiwOUlf48zBmzlS3Fid1uOY5i6a0rvoJ9wuAwf2isQyQBfybu2xc0qwp6cn7Dy+bYkurU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=srD8tATI; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 50C63200DF8A;
	Thu, 22 Feb 2024 14:42:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 50C63200DF8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708609357;
	bh=ntM1lJl9v7kyuGzcxYVa7L1YvVosnIeM09eUzJVM3Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srD8tATIIW4Beu36+NZCx685H5fNVEFmgDarHvK3SvBJoSRApxGhihTbS1IS2cJut
	 W80MrrKJ2NvCDWggGR0R1d/RNeZTxJPMOvrKaxLie9z7Q636UEnHUyNHNFBBarYrMt
	 9M5FkNyD6iYlP8FpE755nh6t5em7fYnu1p+BDBVQTHacMf7lFHI4sSn/GOFh61pGdh
	 X3DYSpm+Sxzlih5UxVubatA+zSTz5+scQoSCAONmg0N12ZdpTjcnfrHkhW9Fsx/2lP
	 yqZwks8+CyWaaPkbmR4xRnZd5vOOHvi5rCKaUZCmARAr/NxGRmpGNwLlHckFfT9w3a
	 hlRGYG7NZtRtg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 1/3] uapi: ioam6: API for netlink multicast events
Date: Thu, 22 Feb 2024 14:42:18 +0100
Message-Id: <20240222134220.16698-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222134220.16698-1-justin.iurman@uliege.be>
References: <20240222134220.16698-1-justin.iurman@uliege.be>
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

Suggested-By: Paolo Abeni <pabeni@redhat.com>
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


