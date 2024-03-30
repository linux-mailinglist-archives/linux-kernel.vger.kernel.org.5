Return-Path: <linux-kernel+bounces-126262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E49893468
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20221B261CA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6BD15D5C0;
	Sun, 31 Mar 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="j1aCOlEw"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0B149DF5;
	Sun, 31 Mar 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903385; cv=fail; b=AZ5wALnTbGom5fImTKJRDCEgMFhlz3NA7zeY+1hAR47Tud3r7312uRCB5qp0XPAyGtocpyVCx8jER1BrEYB3n1XgpYq1bWLRDrC0VOBUXziNXqYs2lo1hwLLpQjQV/hUFJDgiNteySYd7HgeShVx/cxRCzKXCLmECLhoi3UShA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903385; c=relaxed/simple;
	bh=NnGqycWyMgrqtn4VdYQ5lLrY/jrFOUXth/lMty4JYP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6XsDAgYxjdeOa9n54a8pMWApagRHmSUq7aQtJxvPKBfUsd6F2Uiwll6TnLxVSE85YEU5KyVuOv04ApD5bkoHcT3i+cbG/ScnKBjX6yWR+mkuvUb8U13usyGA+vmvwXD1s3OIZ5KI/x9/3SLISOM5YKLfFe8mY2Sid53KiWQ2Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=fail smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=j1aCOlEw; arc=none smtp.client-ip=80.12.242.16; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=wanadoo.fr
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6F42F208C4;
	Sun, 31 Mar 2024 18:43:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-NOWj4FB0vC; Sun, 31 Mar 2024 18:42:59 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 73414208B7;
	Sun, 31 Mar 2024 18:42:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 73414208B7
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 65F6F800060;
	Sun, 31 Mar 2024 18:42:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:42:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:02 +0000
X-sender: <netdev+bounces-83495-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAg4KmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8555
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83495-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 262FF20315
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="j1aCOlEw"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711787619; cv=none; b=uHKInowc5QXZTdrGWSIcO1HyNtkmN/yXJf6teQACgNnAOrVX0WD4ZHeqR1u24I5RS2YXjouYaPoh9lWdEa/mB8bHZv47RxEJNI6jJwR/S8eXJzxNXXZQn3TKAGGaR891zFa0B354Pf/FTpkY+VOleJ8f6zZ5kCjJl+iUo58nkuM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711787619; c=relaxed/simple;
	bh=NnGqycWyMgrqtn4VdYQ5lLrY/jrFOUXth/lMty4JYP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jc5Wq0X6t9/HKjHv7+OsBYJHgS5uC5wJbhTuMvLle6eMIUemfPDnMn2/KPObue5FVnZuUj0kzsJ+V6r6+kUkz4vB6y3xwKd5WWBs0DGyG3SFtd9lAsQVfgBqnTTQ0BigN0qAPz/AvU2GXTGFiQ4GeXgZqYjAPc71T3QTMLp/C4Y=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=j1aCOlEw; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711787541;
	bh=W45diehFRu0ilTy3yuLbniJUjWNxtFJBsavO8BYE9DU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=j1aCOlEwaqP6X3Kc2oB+BS0/FjHi9NYqu72fOLHMt60i9oCMlvfd28cTRXXjCmMna
	 IrzUx3b0TbYkGaVXr10a4dzj4/aAVz0EqKP42YqmiSaQXDrEE9cgeqgVwM1tZuIL1/
	 7zdmEKZylV928aOgF5ltoCVKQ4pg4SkMOrPBVIFesZ6Rj0KMHVeXSg+Lf/neZDty3/
	 +gb4O+iQmJ/lxHcctOKlw0OKsglVHwJ6Oesq/qrmZAA+N4xSyKZKLJ7G6ZkalID+hD
	 KkQ9af6ngzwIjF7L5BVZOa1ApDJXX8IFZ599QOycC5h/uy30lk4gMxPGX8j9ZjE2t0
	 7JqztYzCMuEUQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 30 Mar 2024 09:32:21 +0100
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: rkannoth@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v2] caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
Date: Sat, 30 Mar 2024 09:32:12 +0100
Message-ID: <8c1160501f69b64bb2d45ce9f26f746eec80ac77.1711787352.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

UTILITY_NAME_LENGTH is 16. So better use the former when defining the
'utility_name' array. This makes the intent clearer when it is used around
line 260.

While at it, declare variable in reverse xmas tree style.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
  - Declare variable in reverse xmas tree style [Ratheesh Kannoth]

v1: https://lore.kernel.org/all/af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr/
---
 net/caif/cfctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index 8480684f2762..20139fa1be1f 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -201,14 +201,14 @@ int cfctrl_linkup_request(struct cflayer *layer,
 			  struct cflayer *user_layer)
 {
 	struct cfctrl *cfctrl = container_obj(layer);
+	struct cflayer *dn = cfctrl->serv.layer.dn;
+	char utility_name[UTILITY_NAME_LENGTH];
+	struct cfctrl_request_info *req;
+	struct cfpkt *pkt;
 	u32 tmp32;
 	u16 tmp16;
 	u8 tmp8;
-	struct cfctrl_request_info *req;
 	int ret;
-	char utility_name[16];
-	struct cfpkt *pkt;
-	struct cflayer *dn = cfctrl->serv.layer.dn;
 
 	if (!dn) {
 		pr_debug("not able to send linkup request\n");
-- 
2.44.0



