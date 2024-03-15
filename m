Return-Path: <linux-kernel+bounces-104622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1232B87D11A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF06F1C22CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AA24595D;
	Fri, 15 Mar 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Y/J0M5H6"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708A3FE47;
	Fri, 15 Mar 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519640; cv=none; b=Msv6rNF992J1jOqsZuwQL6aYQ2IJXLpbmrj1mRU0AOOOZill+s1R7fnEDwgIBphy2ewskHRwgXltqkQWurtLD0tS4AGh2dHciTBtmkLthp78F/hAqhzY3ODLNFf8ECg90MwhfAq4Ew+MBj0Lux3LlAiQZ/ZYdaARw4+onIm78TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519640; c=relaxed/simple;
	bh=1n+G9SuhNWG59T4LbSXCZQEFL6hz0CIwSYG1SoowdRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q6pkMw5n7gXeLR6k3sTIgutzKmOSN8xjcuE8LxCFmorcmqExCZlnWJQ92PXcyFq8SHutllkK8wR8FUpAelwP02indd/3HMbed1a3GBpnw1dRMJI+FgO2RY8JsUFBtEBHtDtSXWXfXbjMvW5gYvJ+xf2vUqWLx7f2YA7rTFcRP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Y/J0M5H6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710519634;
	bh=1n+G9SuhNWG59T4LbSXCZQEFL6hz0CIwSYG1SoowdRA=;
	h=From:Date:Subject:To:Cc:From;
	b=Y/J0M5H6ecU85nrrQagfsKLxMsJ0OroPYVUzQcZSyfX5z3fLGAE2nKzL3QInaStF6
	 EEiFP4+uTA6WWG1q6hG94/9yX7OFU8ojrfxQIfIno2cdXdmWfWvScaGqAmkv/TySNJ
	 +nLFncdAK0VvdJAulLNO+KwHRBfg7nN+7L4QlpPs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 17:20:31 +0100
Subject: [PATCH] net: always initialize sysctl ownership
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240315-sysctl-net-ownership-v1-1-2b465555a292@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAE519GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0NT3eLK4uSSHN281BLd/PK81KLijMwC3aRkk1RD89TE1NREMyWg1oK
 i1LTMCrCx0bG1tQD3JL/EZgAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710519633; l=1185;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1n+G9SuhNWG59T4LbSXCZQEFL6hz0CIwSYG1SoowdRA=;
 b=VzGqNPpGHmW5VNKHjSGPj9uzf63W/DwkC2jy0ZtqKMFt+QnGxgmQBhctYl3eEEqa1pC7oIAOl
 Oxalw9/JZLxCNMwz8VJnIhENKZrFJqdZPFYH2C3BCgE/a/c9yElrEit
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysctl core does not initialize these fields when the set_ownership
callback is present.
So always do it in the callback.

Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to container's owner")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/sysctl_net.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 051ed5f6fc93..03e320ddacc9 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -62,12 +62,10 @@ static void net_ctl_set_ownership(struct ctl_table_header *head,
 	kgid_t ns_root_gid;
 
 	ns_root_uid = make_kuid(net->user_ns, 0);
-	if (uid_valid(ns_root_uid))
-		*uid = ns_root_uid;
+	*uid = uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
 
 	ns_root_gid = make_kgid(net->user_ns, 0);
-	if (gid_valid(ns_root_gid))
-		*gid = ns_root_gid;
+	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
 }
 
 static struct ctl_table_root net_sysctl_root = {

---
base-commit: e5eb28f6d1afebed4bb7d740a797d0390bd3a357
change-id: 20240315-sysctl-net-ownership-bc4e17eaeea6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


