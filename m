Return-Path: <linux-kernel+bounces-126172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E489331C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75F9283345
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75578152187;
	Sun, 31 Mar 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="j1aCOlEw"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732B1474C1;
	Sun, 31 Mar 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902491; cv=fail; b=pO3+CUCBkbjJdWJJcKBsl/hbSwxH9bt6kAviAjv/24oqmfSKLiq8sMGfMG7FWAXBht/BTIipujsRIqWaChYH2op8qhDq7dAKk/yKroNRKy24NveudRGRFgNfL47YqEfk197O9WVdBNhb5lhocGbrUa7H0DDwvbBDMsbMWLUFFZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902491; c=relaxed/simple;
	bh=NnGqycWyMgrqtn4VdYQ5lLrY/jrFOUXth/lMty4JYP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rrYjYUAczfgGVUqKiIctzBIPRV+0RV17codTK5mvJy1zsGfmqqOJE41iRMOk+pgdeyCmHLCry6Q5jVYgjkNx6NLr6rogFxjg3mmCVULhlf0oeGj2VTIsONR+0wl9GnDji/iqYMFFiOiiKt4+obnRz6igrpVBYtuGRcrjfGYEQP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=fail smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=j1aCOlEw; arc=none smtp.client-ip=80.12.242.16; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=wanadoo.fr
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 099DC208C2;
	Sun, 31 Mar 2024 18:28:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tterbB3-3B2R; Sun, 31 Mar 2024 18:28:05 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id DCE6E2082B;
	Sun, 31 Mar 2024 18:28:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DCE6E2082B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id CFF17800056;
	Sun, 31 Mar 2024 18:28:04 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:04 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:46 +0000
X-sender: <netdev+bounces-83495-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAbAACAAAFAAwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwAPAAAAU2NodW1hbm4sIFBldGVyBQA8AAIAAAUAHQAPAAwAAABtYngtZXNzZW4tMDEFAA4AEQAuyVP5XtO9RYbNJlr9VbVbBQALABcAvgAAAEOSGd+Q7QVIkVZ3ffGxE8RDTj1EQjQsQ049RGF0YWJhc2VzLENOPUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpLENOPUFkbWluaXN0cmF0aXZlIEdyb3VwcyxDTj1zZWN1bmV0LENOPU1pY3Jvc29mdCBFeGNoYW5nZSxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlY3VuZXQsREM9ZGUFABIADwBgAAAAL289c2VjdW5ldC9vdT1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKS9jbj1SZWNpcGllbnRzL2NuPVBldGVyIFNjaHVtYW5uNWU3BQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAFQAWAAIAAAAPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoANKPp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgDoAAAAlooAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1pdENvdW50BwABAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1YgUAKQACAAE=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12995
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83495-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 083FD2025D
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



