Return-Path: <linux-kernel+bounces-138695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C889F920
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC35028C1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7316D9D7;
	Wed, 10 Apr 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FIe9lP7p"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5515F400;
	Wed, 10 Apr 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757590; cv=none; b=SBZbLA44sy7i07j1YAHNUP8Q4zGa6zJIere8MvpeS1SY6I4eS0QC2TpcwKWhdFmSGQEpc9Ku4hKc+JG96BIOnEQ+rr/XkGxX+zuVzvjnhahCB7TWKRcyGWZtYmpdc/61pXrSSHQTXcPzt9aRHkkLEnklzNbi0Izwdw6cjtXPXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757590; c=relaxed/simple;
	bh=VyssH3HwGA8ttPNbt05cbLQnHU3BKOP+QGZgSD7GjKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tEFwWrKipnWFTY95n/rcboxemIbojvtISiXBIWrLWwPjU+T3+x5MHhsXjzm6ZdgY8GyMAa+iGJkXfLCEEmLzY9YtmfqPmXnkIY82UErn/nheRXQh753cjQjMccMJwjfaCU+RWUfSnjkASSftXiFdAJA//7sYSMuxPRDwZPPgZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FIe9lP7p; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ADximh056735;
	Wed, 10 Apr 2024 08:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712757584;
	bh=wohS1UWkRM7giv/XyIaRHM0QVxnTPGRnJbLhd8440+w=;
	h=From:To:CC:Subject:Date;
	b=FIe9lP7pGVrH5IL58fh9ZElM9Hmi0tbJdEBi2sBHgQHRXnzU9nBU0NQJZAOugYrwY
	 wxt7pXt+x0GEG2aWgfrRJ36NIWGt9YXiA3ynDMz/KrmT6lzr0tPW9GKRjbylL0CoXZ
	 gWS2TcnZVca1VSjrM6TRbA0S/OMD8JFk9cf8uW+M=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ADxhP1011473
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 08:59:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 08:59:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 08:59:43 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxhak067183;
	Wed, 10 Apr 2024 08:59:43 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 00/13] OMAP mailbox FIFO removal
Date: Wed, 10 Apr 2024 08:59:29 -0500
Message-ID: <20240410135942.61667-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

Core of this series is the last patch removing the message FIFO
from OMAP mailbox. This hurts our real-time performance. It was a
legacy leftover from before the common mailbox framework anyway.

The rest of the patches are cleanups found along the way.

Thanks,
Andrew

Changes for v2:
 - Use threaded irq as suggested by Hari and to
     fix possible "scheduling while atomic" issue
 - Use oneshot irq as we do not want to enable the
     irq again until we clear our the messages
 - Rebase on v6.9-rc3

Andrew Davis (13):
  mailbox: omap: Remove unused omap_mbox_{enable,disable}_irq()
    functions
  mailbox: omap: Remove unused omap_mbox_request_channel() function
  mailbox: omap: Move omap_mbox_irq_t into driver
  mailbox: omap: Move fifo size check to point of use
  mailbox: omap: Remove unneeded header omap-mailbox.h
  mailbox: omap: Remove device class
  mailbox: omap: Use devm_pm_runtime_enable() helper
  mailbox: omap: Merge mailbox child node setup loops
  mailbox: omap: Use function local struct mbox_controller
  mailbox: omap: Use mbox_controller channel list directly
  mailbox: omap: Remove mbox_chan_to_omap_mbox()
  mailbox: omap: Reverse FIFO busy check logic
  mailbox: omap: Remove kernel FIFO message queuing

 drivers/mailbox/Kconfig        |   9 -
 drivers/mailbox/omap-mailbox.c | 519 +++++++--------------------------
 include/linux/omap-mailbox.h   |  13 -
 3 files changed, 108 insertions(+), 433 deletions(-)

-- 
2.39.2


