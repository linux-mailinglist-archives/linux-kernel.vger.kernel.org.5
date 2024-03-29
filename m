Return-Path: <linux-kernel+bounces-124486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B38918C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB04F1F24BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49D013AA48;
	Fri, 29 Mar 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR9qSkav"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6A139D1D;
	Fri, 29 Mar 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715221; cv=none; b=cMUyFg+SN2mJHlOoeUhZtefPqOZryTpPDTqjLTBnHtlmuXElE05rzWKIQAbRzONxXlxvtsT+RKtMG7VcXr6Q3vpBrobsd0v4U/Vo7VHIRQOsIrEByaW4KRybr8Xk8oWKm/XZXEj+aH7MeYxTpHPsKYDHTXAYckCiJ7GS9yoSWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715221; c=relaxed/simple;
	bh=5HU0tVK2jo0gIkWQ4u9tXr3Io81w6m8ndoau/SdGV7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roqZGfBGjCP2/miBZ4ZG5kUGxOO7FsaqENkYe9cEvEmX73wZ9+WzgO4xrEDCm2tAa38Om9OoJ3d/g/T1bBEWRdl78YvVxNCXanGjAJbwUGXv1BtYu47I/leMfTT379Il1k/YiQmSdhFJRu3rPw9XykGHYOJ+Xzmll7qQo+GOkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR9qSkav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F98C43390;
	Fri, 29 Mar 2024 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715220;
	bh=5HU0tVK2jo0gIkWQ4u9tXr3Io81w6m8ndoau/SdGV7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rR9qSkav7WR4Jhy5mb/49maMO/L6ZMiGgUkwgiA98R347uDq1/790umHWMwBx2tiA
	 WMW/2CZcAd7kNOlHgTRuHAK/9V0M2kZMYwVmTHCTP08fc9e7lNWrbeym8z2T/vC2Q6
	 /I2OL/LRdB3D/d55TKLc2ID3An72bQIa31qvOZkkaodkQ1sL9JXjUaP+omanBEcrKL
	 Phx7gavj1PM3Q8kmX9Y5CjBL10SG1/ILDGaVgQdfJGXKG5tryQZkc7gKNcn59W0ADi
	 Yf5ORtNP10YFAOF8jHZYkYmUB3CFLaKE5/Y6Rd1/e0AW9WdiCfCp4bt4ll2m6vjr4U
	 +W5dxh53E7WwA==
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
Subject: [PATCH AUTOSEL 6.8 05/68] batman-adv: Improve exception handling in batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:25:01 -0400
Message-ID: <20240329122652.3082296-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 5fc754b0b3f7f..75119f1ffcccf 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -691,29 +691,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
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


