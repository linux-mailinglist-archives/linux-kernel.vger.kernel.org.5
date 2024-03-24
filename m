Return-Path: <linux-kernel+bounces-114941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C28888D71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41561B29744
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E12DAACE;
	Mon, 25 Mar 2024 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obJc/MRj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AEB17A365;
	Sun, 24 Mar 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323651; cv=none; b=DrWTGV0JnOh7dq6NBPjXefISBYXN4gkmuy8tqFpEul2JzA0ptw5tuRcjuCJvUROvvNkEuxt5G+pkfVg0dMfWEudBzgZxWIPI91vhbjqwTnOQpSYOfAxQYbrjn0K22i3HwDSYZLzAR4W4mny5YJD/e6WccUBa6SsdZuWJoIIXa9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323651; c=relaxed/simple;
	bh=gAqdm49DZG7gHX8FLf99AYsnKM/Po+UYbJY+eyoQle0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VquZZUW42xAo/cBYhgYDx49G55/elXztCTNWzsmsf4tK3fZmgYbQCfzBcUFaqj4xbEmTPGUl766QYE0lCfbKt0nChTsgLal0vyngU/1ugWjZskYM5rQrAOgnHltOQvMe53HoOC2hOUVSKKhubcFgCVD6F4/uZOgqJy3eZec8GPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obJc/MRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8725C43399;
	Sun, 24 Mar 2024 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323650;
	bh=gAqdm49DZG7gHX8FLf99AYsnKM/Po+UYbJY+eyoQle0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obJc/MRjcgkA+mllmrww6+1G284TlnEyeBKJuJvyxJiDaWBAAvKAyA0LM7cX8A6ZZ
	 E7qvzlULLrXuZR4hymU5avc7pUEE6Fl6tng9xg0DLLJRWZIWpN36v1x0M0oJUjwBWs
	 Xl/IhXvU5ypFYqcCOgxRpstMurGAgHN59FE+sLKUMD7I6PIRc1dSKQPl+WKB4BxlkG
	 YI78YirwGVZ/D2OL5XR7kH3HsQoQU8z5Ui+hCWk85W3V6C5v+1jrkK6S8U8kVJ1V6T
	 MOnHJG1rwXaZChjQIFNmjWqnmCKEvu/DZMOeEhVWfYOHYfNny9lmkWsWP8mBizUCeY
	 CP+oYXhwwgQJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Adam Goldman <adamg@pobox.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 022/238] firewire: core: use long bus reset on gap count error
Date: Sun, 24 Mar 2024 19:36:50 -0400
Message-ID: <20240324234027.1354210-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


