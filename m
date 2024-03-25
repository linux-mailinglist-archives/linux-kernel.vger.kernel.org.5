Return-Path: <linux-kernel+bounces-117569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A89BD88B48C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32C0B2A934
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA61984D11;
	Mon, 25 Mar 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LkzH2Wez"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532C4CB2B;
	Mon, 25 Mar 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387253; cv=none; b=SZe21hUL7/wKWgDAJphEGQdKOyazaEXESXls0Wl2qXfuULfX/SrWr3Tt7NHq2yyEMeUokUe/sJmUhptUu38sftiExSsESCREm/y8G0aneTqsaNX6sZw3+xRXJIWjB6OS3MdoeloyO3rfKkKtrSy7iJ8Rj06qGGwpHR1iQsfEeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387253; c=relaxed/simple;
	bh=yFPO2C6erdgRU5Kib8DaHguXW43QvCj6QKw1VuaREK4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QgA+/CmqS+Mtb1jdZtKwbzSbA55aEMEYy+doRlPNWdx8Fe6AWgVm6tqoR4IgfL/5H9fD1ym38txW4OSoAlOQJFbyGzt7rkSGjlxxN5HWbpqSWA0P7VG35XHcE0ygSQVLUKUkYjju5Ho6ecBPsxfZeYI+GR8BVvhwx+UbXgCnG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LkzH2Wez; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKlKR013514;
	Mon, 25 Mar 2024 12:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387247;
	bh=ARfToB2k26vF8kalaY9fp7GiHROhYzNO7WUc7TdUDJk=;
	h=From:To:CC:Subject:Date;
	b=LkzH2WezGFBflXhpEaFNpVQaZTxrlC01tZrTzRjMKIDFLvxBNVr6qVX4wHCh6VVql
	 sw1nz4RCdT+4mD8H4IV7TfahqbNuICH8bbGcyKdk14I7FJJSXwXNKfhjEQQzI54YqX
	 soMhzMebHKNd/E9WwzQ74QnEdvVRtb0gbqxxTOnY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKldr042949
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:46 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYW075282;
	Mon, 25 Mar 2024 12:20:46 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 00/13] OMAP mailbox FIFO removal
Date: Mon, 25 Mar 2024 12:20:32 -0500
Message-ID: <20240325172045.113047-1-afd@ti.com>
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
 drivers/mailbox/omap-mailbox.c | 515 +++++++--------------------------
 include/linux/omap-mailbox.h   |  13 -
 3 files changed, 106 insertions(+), 431 deletions(-)

-- 
2.39.2


