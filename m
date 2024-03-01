Return-Path: <linux-kernel+bounces-88495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323FB86E265
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2A81F23BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3F56E5E3;
	Fri,  1 Mar 2024 13:39:45 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32886EEF7;
	Fri,  1 Mar 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300385; cv=none; b=ABLNJlQ3k0oAkV0ALG88dficE0pvxnLGUNWsbSYIhkjxXK0oaT64mTBCRGaUqPviLg29IOQaUD7Q9w/Ch5Qlxvm+JFWuNQx8mKGCOb4fCFkPKkTLwNTwWWZ6441CsaOk8Hk8rSEReUZfUfwZm4IG5MRNb8o5YTvHQTPljPe8l9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300385; c=relaxed/simple;
	bh=E0+vbiUDxoe17ISOEKr8wcAHJ3zgj4S9zufaCp1mH30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q64+B5CoATWDJvv0UrpBEUzWppqLZJyIaoEE9ROzCyKwQTSQPEJZ0ey6qT3t7BW88dQpQHJ9nYykXWoXi+ynqsVA0lb+9rpdQXdVnbypBfP5FZRb5HJTZm34bAbJ69SpGOpSBcBIS0yhsTrvyVeQUaULT1aiYSoqtxxcCcn+yfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from r.smirnovsmtp.omp.ru (10.189.215.22) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 1 Mar
 2024 16:39:34 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Sergey Shtylyov
	<s.shtylyov@omp.ru>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2 0/2] Bluetooth: mgmt: remove useless NULL checks
Date: Fri, 1 Mar 2024 13:39:14 +0000
Message-ID: <20240301133916.1268403-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.25.1
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

Svace reports NULL check after dereference in
mgmt_set_connectable_complete() and add_ext_adv_params_complete().
The following patches remove these checks.

The second version has a more compact subjects compared to the
first version.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Roman Smirnov (2):
  Bluetooth: mgmt: remove useless NULL checks in
    mgmt_set_connectable_complete()
  Bluetooth: mgmt: remove useless NULL checks in
    add_ext_adv_params_complete()

 net/bluetooth/mgmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.34.1

