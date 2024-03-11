Return-Path: <linux-kernel+bounces-99104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6D878379
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1B32817BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AB657C2;
	Mon, 11 Mar 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXdahz/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52288657A8;
	Mon, 11 Mar 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170061; cv=none; b=a8taDuelEB+LA9WBc+g+aI6LNq150t2CBhQgc2PGQ1BGPJzoHn1fegFENc5nOfOnNR+4ZXr9ahcEtTeAXz5KOKweFCxUI6qebyZfdKfrY/Z7MmCbB+BIS3X7N3C+EpS1DnvP8a0ioleA8c8M8G30TFKkIzxqdBEO5ykheB9Tr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170061; c=relaxed/simple;
	bh=CIckCfCvElbP7qNZyEFS868bjqgWhDCd+IzI7ldl7Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkELtfXPHdWg16TcS45mvrwtBq94afGSgasdVebNXZ7gKeADJHrCqGgQ1jAxVBaaCrrx7Vsgfg3RdyfQ2jQCdXEM8g3dUmCBCydlVoHisI35lvyZ6Q7HvU1KaW6/3ugS4ZPswwsGHw+SQPr9rH/Mt2o3zVqyos75hDzvF3B0X+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXdahz/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78342C43394;
	Mon, 11 Mar 2024 15:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170061;
	bh=CIckCfCvElbP7qNZyEFS868bjqgWhDCd+IzI7ldl7Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXdahz/35VWEIMAPrTAprS3MVHK5R13ChjoZg80H9SQF9N6HX3SI4i+aNGWeRKNLX
	 a+ZTP2nUxWv3xiFVZIDQNNT8hUDsuX3cnkpj1x3Qu7QBMf7idLd1VAIIlm0/DtDkLl
	 3Be4T5fWQIcHAyAhQajBE07E+VTQOB6iWETOjHbXPLWbALYFHWmvvvxVcMYvmV2xUF
	 2HIqMVQQ59dgjtK85JFBoVn+W2LkxEjXdWFSrpAYVrjSsBzZ33d5ManC2srRf8IV+h
	 mPUnd+crB2pTHqw6xJhZtsL37PRTGUfbBSsErhoe2zj6mvU9yQ8+X3FlVOWdcP777Z
	 kdAnj4ECwgXZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Adam Goldman <adamg@pobox.com>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 13/13] firewire: core: use long bus reset on gap count error
Date: Mon, 11 Mar 2024 11:13:48 -0400
Message-ID: <20240311151354.318293-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151354.318293-1-sashal@kernel.org>
References: <20240311151354.318293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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
index 8aaa7fcb2630d..401a77e3b5fa8 100644
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


