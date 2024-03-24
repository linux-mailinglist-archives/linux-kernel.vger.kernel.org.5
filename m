Return-Path: <linux-kernel+bounces-113236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D770888289
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10FC1F220A6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55D183B92;
	Sun, 24 Mar 2024 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0TWsthv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7318432A;
	Sun, 24 Mar 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320037; cv=none; b=GjpaXKVCpdlVRz6eU6YU5aeDEZ06d6sX02Tb89TzD8QAsEUD4VdP/gGaNjHN+6cWc21bco/pzYixMK9n+YhlRUcOWtE/JWbaDm0yCz95clzG5yZJzwscd72br/n6kaR1CiUlDUk1/br7kKPc+hY/2YTGy+S0vvK0uoWFrpZWG4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320037; c=relaxed/simple;
	bh=PCEyESqUONtKRMCY+7M47ejrQsTEtigs2brUjBJLI5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOdNl5WiQmcLsJSod9qRFZLwLGOFcrUkg7uwEr4zFr+/qrqOjX/B9wCZRQMJIf4o9KV8weeanKJHFu5YrWutD4YvtzxQHC4uqLP1nTcRIx1H1eZd8yIkxHMGIcZkhajseEn31KWso9UGIfucTrvHtZrjTjR7Ps4Tg2b3P7aXwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0TWsthv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E186C43390;
	Sun, 24 Mar 2024 22:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320036;
	bh=PCEyESqUONtKRMCY+7M47ejrQsTEtigs2brUjBJLI5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0TWsthvJPdSzen/rMPbd7sSyC0EbHN/lt/3pZxFRTcSUwLuT13iNsQBxWWZ240ke
	 ZNDNxzrbuUbmct4mjdkQp0yP9W7cLXwZ2gDfvD/S4bwMSK2YPFGRFxMBeA9mYnzzQm
	 fRADRn2cxZqXOX3NThaS5kUcc1ZS2/re+0iTSeAj4D/Ni3JRlZrAI6qq2fzbYyt9le
	 Md63F0gfBdO7n6SK9HQY1y+c2vvoM0u4UrxoIi/yXMGUcRjXLHUXpj4GtBjcmQfIC+
	 4nw/d4BIJhUPU3i2nX8UdZN4H/y9w5wNaniUhXFwYUtxxmThit17DTwIOdwt/kNj2t
	 VvVPnaz1OhS0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 345/715] nfp: flower: handle acti_netdevs allocation failure
Date: Sun, 24 Mar 2024 18:28:44 -0400
Message-ID: <20240324223455.1342824-346-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 84e95149bd341705f0eca6a7fcb955c548805002 ]

The kmalloc_array() in nfp_fl_lag_do_work() will return null, if
the physical memory has run out. As a result, if we dereference
the acti_netdevs, the null pointer dereference bugs will happen.

This patch adds a check to judge whether allocation failure occurs.
If it happens, the delayed work will be rescheduled and try again.

Fixes: bb9a8d031140 ("nfp: flower: monitor and offload LAG groups")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Louis Peens <louis.peens@corigine.com>
Link: https://lore.kernel.org/r/20240308142540.9674-1-duoming@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index 361d7c495e2d8..2c7bd6e80d993 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -337,6 +337,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 
 		acti_netdevs = kmalloc_array(entry->slave_cnt,
 					     sizeof(*acti_netdevs), GFP_KERNEL);
+		if (!acti_netdevs) {
+			schedule_delayed_work(&lag->work,
+					      NFP_FL_LAG_DELAY);
+			continue;
+		}
 
 		/* Include sanity check in the loop. It may be that a bond has
 		 * changed between processing the last notification and the
-- 
2.43.0


