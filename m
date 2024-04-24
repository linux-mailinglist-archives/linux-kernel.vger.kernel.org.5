Return-Path: <linux-kernel+bounces-156921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF78B0A61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0051C23054
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7815B14B;
	Wed, 24 Apr 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mr6bsXSG"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC815ADA5;
	Wed, 24 Apr 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963916; cv=none; b=Fc1+n3HF+Q9Emfq36lpmkEaEO4KMeEhs7yWeH3ugYdy5eyjG877EHSkKpsVec3wdSTcdXj5QqPGaMYCbQpoCEkZqDEJeQAXYS8y5J6RNPIGd9fB7ldyjPfkMHjWnKBT0iY52iez3Uq/tmHJMIh1uJDkmLi7bnVLU6nP7sUSEwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963916; c=relaxed/simple;
	bh=trZv5sD4FjAPbHiMr1RJMNDyj7jQZo+hKTtHm5ljoSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=usR2RMSrp0JDuT0EkesNb6h1ZLImIyL+j17ZzVVIpYM3YEm2HsnGKTNJyLqADVH6XKQr3MVKupiH5pIRxbg0vh83kaTjPXajiMGaAVLtSBrnXzehuynBvXQzIKAeFGvvE8wdt3+7Ut4+7Y2Krxodn0P9hbdXe7kWhZJI/3vRWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mr6bsXSG; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43OD58If026252;
	Wed, 24 Apr 2024 08:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713963908;
	bh=n6Gm8aFsB7jXyyx0SKj7OlRHLpLiF56JlQ+Nni+T9QQ=;
	h=From:To:CC:Subject:Date;
	b=Mr6bsXSGSIsScvlmsCMTJc0QBys+RMSj4c8Pc66Wen2EAVQvt/bsxJQQWQxxmS09W
	 3KcRX6+Zo1Mf2KYiy/8usYqQKGckKGfAvV7j6MpKQkAY+2XTS11SDUOgFykoqOJuVy
	 zhqveFwlu9rJ9ovbD/Dp2Pcw5MepIoi4tzX3+VMg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43OD58pW063776
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 08:05:08 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 08:05:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 08:05:07 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43OD54bP029300;
	Wed, 24 Apr 2024 08:05:05 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <andersson@kernel.org>
CC: <mathieu.poirier@linaro.org>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <nm@ti.com>, <devarsht@ti.com>, <hnagalla@ti.com>
Subject: [PATCH v2 0/2] remoteproc: k3-r5: Wait for core0 power-up before powering up core1
Date: Wed, 24 Apr 2024 18:35:02 +0530
Message-ID: <20240424130504.494916-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

PSC controller has a limitation that it can only power-up the second core
when the first core is in ON state. Power-state for core0 should be equal
to or higher than core1, else the kernel is seen hanging during rproc
loading.

Make the powering up of cores sequential, by waiting for the current core
to power-up before proceeding to the next core, with a timeout of 2sec.
Add a wait queue event in k3_r5_cluster_rproc_init call, that will wait
for the current core to be released from reset before proceeding with the
next core.

Also, ensure that core1 can not be powered on before core0 when starting
cores from sysfs. Similarly, ensure that core0 can not be shutdown
before core1 from sysfs.

v2: Changelog:
1) Fixed multi-line comment format
2) Included root cause of bug in comments
3) Added a patch to ensure power-up/shutdown is sequential via sysfs

Link to v1:
https://lore.kernel.org/all/20230906124756.3480579-1-a-nandan@ti.com/

Apurva Nandan (1):
  remoteproc: k3-r5: Wait for core0 power-up before powering up core1

Beleswar Padhi (1):
  remoteproc: k3-r5: Do not allow core1 to power up before core0 via
    sysfs

 drivers/remoteproc/ti_k3_r5_remoteproc.c | 51 +++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

-- 
2.34.1


