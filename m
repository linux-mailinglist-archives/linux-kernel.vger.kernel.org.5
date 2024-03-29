Return-Path: <linux-kernel+bounces-124681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D2B891B57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D043B26A11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B5171E77;
	Fri, 29 Mar 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwnii0iI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD91171E60;
	Fri, 29 Mar 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715690; cv=none; b=q7hBJ4Lh1540eXAM/aL7EuSJwR9OMEZkARInDE0vVk0brzqm7CGa36lvvOa0VjAk2Duz7+oZHYArYyzyGCbK5ugo1GAd3EcMIYp/8t44Nl1kNkdqs23yexGytnxLAd0e9ug7ILtBhX8Hi1dqFYVV5Dr5AVD/OCJ/ouk/eSoMLl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715690; c=relaxed/simple;
	bh=VzxgSt9qr0sgRrcyGHyXM3zzqjFvvX/PIaRhKFdq/l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kW+iC5vB4sYY/7Wa9b/vh6RcoVTw8wHHf2JGJWLEPv4caWryQCGJttxCAm7rdTeduTzlMJIY1dh2ldamLZxi/551PUjpiMb179JI7aJTkNmDWPAWIPxis6HLJ6A/7fiqY7VS1lSIuXkY7KJzgcGzj7855SCZSzUMehzo6lpK/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwnii0iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E81DC433F1;
	Fri, 29 Mar 2024 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715690;
	bh=VzxgSt9qr0sgRrcyGHyXM3zzqjFvvX/PIaRhKFdq/l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rwnii0iIV0qySSYOb1wU81wvuYilwB33l2jDT5GB2D8Z/n1PrwbiAJX6iwFmAyIyT
	 iU5Y84FR1y/uNuYrDiMAlcL2J8rzlv0voS7Kkgs4eB1VionphStmaFLDy/ftlb2Qez
	 yM5s+zwiNI7gt49s3vjFbI10iOOzFjz8kRrjo8bHS69Rwv0F45HAks3nmLp198UOvT
	 NWueQbDt989+hGXd0OzeO/K8+eOeKHCKSS7mqPw4L7rg+tLjdARNdISw8p+DTyZbPq
	 T0t+SxtjsW5k7OigChvBAMNXHplWFeIETW87r/0AbP66VrmOp3VlT+0lwdXP6DhChl
	 1UR4fdGWL/LGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>,
	mareklindner@neomailbox.ch,
	a@unstable.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/15] batman-adv: Improve exception handling in batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:34:26 -0400
Message-ID: <20240329123445.3086536-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
Content-Transfer-Encoding: 8bit

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 5593e9abf1cf2bf096366d8c7fd933bc69d561ce ]

The kfree() function was called in up to three cases by
the batadv_throw_uevent() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus adjust jump targets.

* Reorder kfree() calls at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6a183c94cdeb4..62425d19bd598 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -733,29 +733,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 				  "%s%s", BATADV_UEV_TYPE_VAR,
 				  batadv_uev_type_str[type]);
 	if (!uevent_env[0])
-		goto out;
+		goto report_error;
 
 	uevent_env[1] = kasprintf(GFP_ATOMIC,
 				  "%s%s", BATADV_UEV_ACTION_VAR,
 				  batadv_uev_action_str[action]);
 	if (!uevent_env[1])
-		goto out;
+		goto free_first_env;
 
 	/* If the event is DEL, ignore the data field */
 	if (action != BATADV_UEV_DEL) {
 		uevent_env[2] = kasprintf(GFP_ATOMIC,
 					  "%s%s", BATADV_UEV_DATA_VAR, data);
 		if (!uevent_env[2])
-			goto out;
+			goto free_second_env;
 	}
 
 	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
-out:
-	kfree(uevent_env[0]);
-	kfree(uevent_env[1]);
 	kfree(uevent_env[2]);
+free_second_env:
+	kfree(uevent_env[1]);
+free_first_env:
+	kfree(uevent_env[0]);
 
 	if (ret)
+report_error:
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
 			   batadv_uev_type_str[type],
-- 
2.43.0


