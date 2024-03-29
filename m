Return-Path: <linux-kernel+bounces-124555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386708919DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695F31C24CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF08D41A80;
	Fri, 29 Mar 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCfenm15"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE34B5DA;
	Fri, 29 Mar 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715404; cv=none; b=nlnxhZJzMCUZr0ild4YUBbIyCSWhnTTqGbybohqZ2n40W+4Ph6qr9WYuhxlgOTmTEdFr/5CyAawdkP1053IPkVt2/ygoExhxjlwQcZ/dCQJohIqkMmNf70tiogHlq5EHzQFVCM55fDtNzgvnyjZVZcgJSnYeigIE75QBMUmzJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715404; c=relaxed/simple;
	bh=S82mcnLoAgLHLLUc/tmsd7zTZGwm1HRCO6vTX9LS/lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJNadiJKedll9rjZyPqppSMAImFjO+6+WWQAPeoB+msGx0oAfd8qLUvQ08tfCpNqgViYVmoIohT6tTnVgScchWJ+vYuU9ulKYI7EUXJvPW2zH2+DdgNu4aJO6JH7NtRX/F25nMyfz9OuhWhX8fy7w3GcfW+0WxMqxHWv41u06hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCfenm15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7885BC433A6;
	Fri, 29 Mar 2024 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715404;
	bh=S82mcnLoAgLHLLUc/tmsd7zTZGwm1HRCO6vTX9LS/lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCfenm15SPCGDSOPhE2O/fE87l9wLWkmoGGr8Nipx22ZYsLvch5Y/hHdTgJLQ2THK
	 9hsmWqDfHQqqFPtjgGbZdSKq8ju8Ks8XFFEt8zlsMyhN0PjjhHVzTanXSSNvx3/f32
	 zfKlNUR/1109KZBoaPDw6AMLqjzb0urwZ601Vkewa9yJD1eCUbdPZdkmGxglCaxpsm
	 PVbQaaEyqFZGzUVAxnVXex9J5U5lKbPcUXqT/kS5p8JFAUZ0BAEeQPch60Kw0MHCWf
	 BKK0vG2BiKJ2Qr8Ud2gWkEIUNdkj/+a+lL7XOWoz+H2YWnHrzPlp8MqMYF+xwsa16C
	 +CKdjakmOW/1w==
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
Subject: [PATCH AUTOSEL 6.6 05/52] batman-adv: Improve exception handling in batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:28:35 -0400
Message-ID: <20240329122956.3083859-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index e8a4499155667..100e43f5e85aa 100644
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


