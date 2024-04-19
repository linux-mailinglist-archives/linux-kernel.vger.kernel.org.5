Return-Path: <linux-kernel+bounces-151106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D3B8AA92B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BADB1C20BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BDD405EC;
	Fri, 19 Apr 2024 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="pjhK20HN"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989D3FBB1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511710; cv=none; b=sAI/MikaL8f40iEN6+yLNNXlRfNyKIrLHPppoefgpdJzUaAhiWj2syoNCqKn2XdjmK2NOgSvnGaN135JUyqucjR9ap/ku1ugd6zJd0+LAOPmGWA4kk75D5n5U0Hev0mqFHqqr22e8MAl07SYbwVzRwhNdmqZOEOCVcp37ErxohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511710; c=relaxed/simple;
	bh=Pg6YhqEJ7ZfYOKsbitrn4qz1ERhWtLvpO+EWSH0ocgo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l2YOe6WGJIqqrjaUKtfJNNjmyJIVO6sWNagdaGS36on29ewWHnExPqJjtALaPXrcVaqiA+BypPvPOgWDmpboBd5iVrHu7IvSpnvw4HXalneEUgaPHNKazxd2M2N8d0H86vH8nhJDcM50ojR/Q3ReXcEc4VcVXpIaWKLdvt4MZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=pjhK20HN reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T+Ztn+2yf3o6zBSPphj743Io9F2W5o5ZAKQconu0ZWE=;
  b=pjhK20HN2hyVi9X6x+FfD6dz67rGGosa8l1akxujpvGZto13T/g1nYFy
   4KatoPQQbYjFbdG9iSmPf/N6Qbfp5ckW/RJr/xj5HjAKuz7Ecy3+PS8BG
   IUTBso2847CCiwpawjPLYNn0p4AcrlhC5HEcYnZCg1XmIEHc5lIuPq6uf
   CIdnPIApH7wjtiP07Qe5+9UoR2CgYs8Q/1RUwRk0PH/PCyn8IvIhpagHC
   AH3hTlr/mlZiGfIn63k+k7QGnV0KBClhT342A2HE4iWl0WjbMNDppAnz9
   3xskYoLKx2V5wNRBd7oJmG6dobWnezashfE/yHAQGetS8papaKHpU2avW
   A==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 19 Apr 2024 15:27:16 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 43J7RDbO011974;
	Fri, 19 Apr 2024 15:27:13 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 15:27:14 +0800
From: kuro <kuro.chung@ite.com.tw>
To:
CC: Allen Chen <allen.chen@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>,
        Kuro Chung <kuro.chung@ite.com.tw>,
        Kenneth Haung <kenneth.hung@ite.com.tw>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/1] drm/bridge: it6505: fix hibernate to resume no display issue
Date: Fri, 19 Apr 2024 15:38:06 +0800
Message-ID: <20240419073809.706471-1-kuro.chung@ite.com.tw>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	9BD95BE845961D5F40378580C0137BF3EF857CE80068BC8D89636A8820A2BD242002:8
X-MAIL:mse.ite.com.tw 43J7RDbO011974

From: Kuro <kuro.chung@ite.com.tw>


New patch description for v5 patch

        after customer feedback and test finished, update again, kernel build pass.
        
New patch description for v4 patch

        update by reviewer Pin-yen Lin comment, remove function it6505_irq_video_fifo_error/it6505_irq_io_latch_fifo_overflow
        update by reviewer Pin-yen Lin comment, update Signed-off-by column

New patch description for v3 patch

        update upstream MAINTAINERS mail list

New patch description for v2 patch

        Missing declaration for i variable in function it6505_irq_video_error_handler
        , add it by this patch

Origianl description for v1 patch

        drm/bridge: it6505: fix hibernate to resume no display issue

        ITE added a FIFO reset bit for input video. When system power resume,
        the TTL input of it6505 may get some noise before video signal stable
        and the hardware function reset is required.
        But the input FIFO reset will also trigger error interrupts of output module rising.
        Thus, it6505 have to wait a period can clear those expected error interrupts
        caused by manual hardware reset in one interrupt handler calling to avoid interrupt looping.


allen (1):
  UPSTREAM: drm/bridge: it6505: fix hibernate to resume no display issue

 drivers/gpu/drm/bridge/ite-it6505.c | 181 +++++++++++++++++++---------
 1 file changed, 124 insertions(+), 57 deletions(-)

-- 
2.25.1


