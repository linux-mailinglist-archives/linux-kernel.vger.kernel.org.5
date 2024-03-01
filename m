Return-Path: <linux-kernel+bounces-88497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EF486E269
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C3C1C20983
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3366F07A;
	Fri,  1 Mar 2024 13:39:55 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1376EB6B;
	Fri,  1 Mar 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300394; cv=none; b=pj6DGNAJnpHsiIGG/xw4+5EBvHrO2nFz90CMVlO9wEjU6cgP1H6tBWjBaLAnEnhLm9BBNo6tyVXhTAR+znVjLIny5GSFTNavdRGj0GeEmRWBESMWu9JVzKZpfb6Z8I7AmEyvMTAsI1Qfc3SiR1H/qD4E6MQTX1kTH4UTVqPyooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300394; c=relaxed/simple;
	bh=V2rng/KDEPN7OaZoxlqZdAX9L9wicAGD3trWoJMgFDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NB1UbnczrKXcCyhos3W7RdenUAiTG2/TX64lWR1b4rJMhsTObrsSrk1iUG34cGFejtAorcXmFLEQO4qurB6xExmOAFt2d/WvU+blMh+lNmJgb+D1aoxDPPTiFoq9OWTlKhryXg6HfHD4W/i3s2Tbt6f42r6G9yd4xDw54Gwj6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from r.smirnovsmtp.omp.ru (10.189.215.22) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 1 Mar
 2024 16:39:35 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Sergey Shtylyov
	<s.shtylyov@omp.ru>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2 2/2] Bluetooth: mgmt: remove NULL check in add_ext_adv_params_complete()
Date: Fri, 1 Mar 2024 13:39:16 +0000
Message-ID: <20240301133916.1268403-3-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301133916.1268403-1-r.smirnov@omp.ru>
References: <20240301133916.1268403-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/01/2024 13:19:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 183893 [Mar 01 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;r.smirnovsmtp.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/01/2024 13:26:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/1/2024 10:14:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Remove the cmd pointer NULL check in add_ext_adv_params_complete()
because it occurs earlier in add_ext_adv_params(). This check is
also unnecessary because the pointer is dereferenced just before it.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 net/bluetooth/mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cd8c4e094c55..b48d2d974263 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8826,8 +8826,7 @@ static void add_ext_adv_params_complete(struct hci_dev *hdev, void *data,
 	}
 
 unlock:
-	if (cmd)
-		mgmt_pending_free(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 }
-- 
2.34.1

