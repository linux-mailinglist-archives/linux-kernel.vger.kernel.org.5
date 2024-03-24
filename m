Return-Path: <linux-kernel+bounces-114731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7288F8890C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127671F2B9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEA1A437D;
	Mon, 25 Mar 2024 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fptCTFpw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EA174ED2;
	Sun, 24 Mar 2024 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323326; cv=none; b=kvLzGZ7U81hfbZw2d7iyxqOTdydTFD83zcQ3fntaIQpmgkKkuaSNgeVeDBgAwt0kVjIITwy/iW59FLgd10zk9F6qTkmlMpbsJJf8jWfRCAN0Fb2nUR/hP1v/wUFtPme7EmZWK6afLWjSTzBmNIlp+JlD8SuOq0ZdDNyYi9d3mb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323326; c=relaxed/simple;
	bh=gAqdm49DZG7gHX8FLf99AYsnKM/Po+UYbJY+eyoQle0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ln0RZRK8jh3/uPqHe7bL+uMf0qva90BxkC5HbMfES3TMeBr7iUWfOo3hjj7nQCewumaOapW4R/Qr3USrgkffiJDBG0AxarajlXCqNtukyKWyiqbHqNEndRUuYGxljWb9SXJtHBIi4zmO+56mWX7kgJBMIXLICeZVNaTtft3ftEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fptCTFpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A787C433A6;
	Sun, 24 Mar 2024 23:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323324;
	bh=gAqdm49DZG7gHX8FLf99AYsnKM/Po+UYbJY+eyoQle0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fptCTFpwxF+yiTOQft/RcW2DAuDJBSfEen6HPrQvJwfvp2/GyvYV0claeDUWvDtG7
	 0/8SJ2j+5d9eVniS9BRb7ZRKhG9LxWbH6SUsf/LGGrmKIBR7CJU7o/R9FvOAOWsqoJ
	 atDUjuckdJbKB9NKGR/rlQC3fhaHgSU4erWRjuLMNEgJL4ariIHMO6Td4xJIEILuO1
	 WRZagIXB2HYWGr5a7p5Vm3TJyTql00o2nNdadlS3Yrdbi4MPMoGbSqBvWE09dpbKP1
	 uCkIbXEDP/b5C3z9lrjH0D31Ryu+s011sHXViTQK9+E1+0TlMNpDuRAjFQST7P+rRa
	 t8zxKpwSByLqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Adam Goldman <adamg@pobox.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 025/317] firewire: core: use long bus reset on gap count error
Date: Sun, 24 Mar 2024 19:30:05 -0400
Message-ID: <20240324233458.1352854-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit d0b06dc48fb15902d7da09c5c0861e7f042a9381 ]

When resetting the bus after a gap count error, use a long rather than
short bus reset.

IEEE 1394-1995 uses only long bus resets. IEEE 1394a adds the option of
short bus resets. When video or audio transmission is in progress and a
device is hot-plugged elsewhere on the bus, the resulting bus reset can
cause video frame drops or audio dropouts. Short bus resets reduce or
eliminate this problem. Accordingly, short bus resets are almost always
preferred.

However, on a mixed 1394/1394a bus, a short bus reset can trigger an
immediate additional bus reset. This double bus reset can be interpreted
differently by different nodes on the bus, resulting in an inconsistent gap
count after the bus reset. An inconsistent gap count will cause another bus
reset, leading to a neverending bus reset loop. This only happens for some
bus topologies, not for all mixed 1394/1394a buses.

By instead sending a long bus reset after a gap count inconsistency, we
avoid the doubled bus reset, restoring the bus to normal operation.

Signed-off-by: Adam Goldman <adamg@pobox.com>
Link: https://sourceforge.net/p/linux1394/mailman/message/58741624/
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firewire/core-card.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index be195ba834632..d446a72629414 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -500,7 +500,19 @@ static void bm_work(struct work_struct *work)
 		fw_notice(card, "phy config: new root=%x, gap_count=%d\n",
 			  new_root_id, gap_count);
 		fw_send_phy_config(card, new_root_id, generation, gap_count);
-		reset_bus(card, true);
+		/*
+		 * Where possible, use a short bus reset to minimize
+		 * disruption to isochronous transfers. But in the event
+		 * of a gap count inconsistency, use a long bus reset.
+		 *
+		 * As noted in 1394a 8.4.6.2, nodes on a mixed 1394/1394a bus
+		 * may set different gap counts after a bus reset. On a mixed
+		 * 1394/1394a bus, a short bus reset can get doubled. Some
+		 * nodes may treat the double reset as one bus reset and others
+		 * may treat it as two, causing a gap count inconsistency
+		 * again. Using a long bus reset prevents this.
+		 */
+		reset_bus(card, card->gap_count != 0);
 		/* Will allocate broadcast channel after the reset. */
 		goto out;
 	}
-- 
2.43.0


