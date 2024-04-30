Return-Path: <linux-kernel+bounces-163803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA228B7124
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239471F2189B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F312C54B;
	Tue, 30 Apr 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tzWSFHll"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E612C490;
	Tue, 30 Apr 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474396; cv=none; b=ivLotGuJqlP3CMB2VKmJ5ZEUfuw/Y4HtoByLhnZvW3kiP4sA7uHHsxGK+NIPuK+X7gecIay0x/9gmaFVf/gGUk39QTyQKNlozQHfGezuxKNQpnlWzuaPQOSO84zHbL1qx4kdsdui7WkqCt3St4EJGFlttnRduuH2OXEmgFNYulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474396; c=relaxed/simple;
	bh=RWRXpLCKdKSQs2XuJN03r9hEXbuXWjMhl2cAlMgAKaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XtQnurGgEZBZAecsX7ZAXo5JcdnMTK19fl2YtQJl+9JSEsPABfKBfYevzJvy1dOokCxCtAjxqrFa7rChwwjqX3eocdCO9NSIhcNi0BUNCZPfRgtsRauUd4HtTIBBfYQa7Dzj2UPAp063U+7OESu18u11L6VL0hhwI9GfHhoGL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tzWSFHll; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UArCWV130406;
	Tue, 30 Apr 2024 05:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714474392;
	bh=/S2o4fuM/8KSLXddRuXzzl3ArTQb6LjGDSIjynvSBeE=;
	h=From:To:CC:Subject:Date;
	b=tzWSFHll6BhIJfv4TEZK5d0zamDSqyPUKJkqcjJ7epNkQuJlOv37VK3QJjb1Qfb7y
	 xlfK61KdjzJPzmKS5OrL0x249Zy29Ww7rexEHE64nPzy4aPIfV4pjmgCnhjyWnUxRl
	 U2pllCVYx0fkzSrskT4zqlBxC/lzMFbmDVvas3TY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UArCKx004449
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 05:53:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 05:53:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 05:53:11 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UAr8Dp038508;
	Tue, 30 Apr 2024 05:53:09 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <andersson@kernel.org>
CC: <mathieu.poirier@linaro.org>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <nm@ti.com>, <devarsht@ti.com>, <hnagalla@ti.com>
Subject: [PATCH v3 0/2] remoteproc: k3-r5: Wait for core0 power-up before powering up core1
Date: Tue, 30 Apr 2024 16:23:05 +0530
Message-ID: <20240430105307.1190615-1-b-padhi@ti.com>
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

v3: Changelog:
1) Added my own Signed-off-by in PATCH 1, specifying the changes done
2) Addressed changes requested by adding comments in code in PATCH 1

Link to v2:
https://lore.kernel.org/all/20240424130504.494916-1-b-padhi@ti.com/

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

 drivers/remoteproc/ti_k3_r5_remoteproc.c | 56 +++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

-- 
2.34.1


