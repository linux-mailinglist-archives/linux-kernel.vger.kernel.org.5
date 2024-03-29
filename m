Return-Path: <linux-kernel+bounces-124637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA3A891ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0649B25AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A515FA87;
	Fri, 29 Mar 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCFBo2mG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D115FA85;
	Fri, 29 Mar 2024 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715601; cv=none; b=kWUZ7e5DAmVXWZJQ430UbhgXK6vVlLGFJl9f18RvLW54+xWrfTafbX93dsumuBXBxtTw+15TcY8kE6dq/ztZETlNlLtgIQN7WOw8kSF3QgWY3xQ8j97Do1Ga163PWB4CHrd6eAiYKyRKEb6bYeiZ9YIZ4M1tUA/N9HDAA3rkUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715601; c=relaxed/simple;
	bh=v9vlpGsCF0nOaHHd6+aP4ocLIoUxn4ByaujqAgwKQ9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM4A8DL/CDMd6NodQLBdC+4bX7Hm9JkV1HG1p4y9TJoLwWl0cQCrOWCHtm/tlnGy+qJpo83f/AekVaPb5MH5Rj8LkWNhOeSx/1ksBxh/94c585y6kcYyE3XBLRSmlmFgK7xN3j1O1MnHKYzw5sgSTkwPyCoZMUgYt+8HPJhzB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCFBo2mG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CD4C433F1;
	Fri, 29 Mar 2024 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715601;
	bh=v9vlpGsCF0nOaHHd6+aP4ocLIoUxn4ByaujqAgwKQ9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCFBo2mGPTekIUg1yahvAFYM4twUBN7NpFwPpa860KAJYS8uePUKLI8FiI6eb0e53
	 aeJdiebV9ZGz8AF2+Jbf28x4kiu5uEf2OzCGWGueCvJCn+JHHc2y7sK0SWfLR59xmd
	 jqBIRZlI4IjJtSDHo68+VGQNAc6eOJzb6jCn3sxjrP3lfTu1+g39hK96Zb738fF9Nv
	 B/Lc7Hd1fmxqmn/SffYnWXj05Rredv+5ZbeBFrq+0q2wRKQ2ZDI489OvlNL31QDyUs
	 eliOh2GInyOAdj5BL+U2ueWEfWs0eO87IW2KyeMqHDXhNeYVRjNs/48HavZJQugkIn
	 YtrmHMTI9P5sw==
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
Subject: [PATCH AUTOSEL 5.15 03/20] batman-adv: Improve exception handling in batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:32:51 -0400
Message-ID: <20240329123316.3085691-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 5207cd8d6ad83..fba65c5c90bb9 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -688,29 +688,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
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


