Return-Path: <linux-kernel+bounces-124607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7569891A84
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630E3B230DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79715A4AE;
	Fri, 29 Mar 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO+xz6iG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6415A49B;
	Fri, 29 Mar 2024 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715533; cv=none; b=QFpN28WRXoi45U/73Anxnisop0N4MRPrw3oXin39fBwB4iYxU+wGXfKgif3TY/uGseJOpm07sBlwd+nOUXVpsbel2UlYVR8ckiCH0wtVXQY5cOkH2HmlWPJ53VTp7Dt18xlyOb01Z55VneDBnXv/FQeEbD+uAhx6Enan+gVu0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715533; c=relaxed/simple;
	bh=S82mcnLoAgLHLLUc/tmsd7zTZGwm1HRCO6vTX9LS/lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC5nKv3T2XZ7gGsHVpEzwJ/tziDOinExaTO22FOB4e/QWLwd4BdNQKzGo+ImoewgBraK7Q7AaEeYZGE5cuBOH/qz8KpYFKulgJPMsNl1qymlWJRFviy3y3B2Ru6qZau3BDWjFindn5ERfc/9DUeXEGs11gfieyUWkazH2kkhRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO+xz6iG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6C2C43390;
	Fri, 29 Mar 2024 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715533;
	bh=S82mcnLoAgLHLLUc/tmsd7zTZGwm1HRCO6vTX9LS/lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KO+xz6iGzGYExW+tc6fK9ZjqI2Til+gK25fmCjCK4mIVUX0N+Y9Oi6HJPOpCMRUgm
	 Q+RQ2eOhzLyGeaOhd5aa7HpPh+DHpLOPp9TsmrZ9PP6cJsc3tbOJLRwwy+RCixZapm
	 06226FlibBUvBXMf/0yHaZ0z7Jv0KfBW+ipVRJ9+1VdcjjpT8iY30FCgrKctx5E0aj
	 u2rouCRFNly7ypEWAE2zv2jqJkJORozsir9L5y6Q3eG0OpTkytvMUi4djBr0fXQaBO
	 8Q6NQPfnWHve8N2Kc84i3+JzjOkxcqY3Etz2Aa2+bafhcHgvejs0EtzgORc2A+omyr
	 4HCUr9KRNwj1g==
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
Subject: [PATCH AUTOSEL 6.1 04/31] batman-adv: Improve exception handling in batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:31:23 -0400
Message-ID: <20240329123207.3085013-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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


