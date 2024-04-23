Return-Path: <linux-kernel+bounces-154666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEFC8ADF89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F395B2152B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0354D58E;
	Tue, 23 Apr 2024 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="RoAScKvx"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E22B9CA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860205; cv=none; b=o00gYMygfLT7aITeomADMWSzld/f8bkwrygJxSA/MjdsCl4VvCA0JmXKLg7WCtLmZ2CTEQ2W9T1/BGYsOi07+OJil3nDP1XXI03bmUEfTv2h8ApzS7iKAfnsyLIAR3D+ryyi2gthyZkXNo1T+VVGl6X8eykBm12lEcSO6NavDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860205; c=relaxed/simple;
	bh=g2gNyTULN0AY2EOR1AVseEuwNgSvrdDVxI1Sdq6Me+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=COC9NqDp0g15PRhLKE3aXLu16E5IZTp2V8udX6xds3+gBp9x0ZgMza27X1BzYWTmrCe4/Ki/JX2WwPr072Bi/BgWi8Oamz+Py/LekqplJQoHpPECJLirhCRleIfKQQHpWrkIXXPklJIXZ5/boEYWNdo9YXYLpGujNU4hn6FMcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=RoAScKvx reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hJ4IBz1KpUVaPBGLBCxprAHOajEX7iUs6IAwoy1sQZw=;
  b=RoAScKvxoHtcWJND5G9KUFHHDE8Kid3LFfC6GeshUeOg77Bq2VRblyPX
   IMDHyZsO5zaKHnfVpOHAlK+ZjfVWNFtGxKTSmsvMbHXnOlpVwzNP6voPH
   EAsdthY4NiMpNwm9S+mo6xuOBh6Bd7nMP1SYtUlRX4EAgNE74C5FOyUXz
   Esw63ZMuA8NBmns0s47N0kAWvGmbW7f3ktoxukZVK65nAEYquMl6mAdf+
   a0Z9PEby7LUUPBbemoDasjIo9h5sLxm429eXK5LAudStVQDRw0xRP9cOM
   cYNTBqdbqnIyTdmR791CUUrjmg44/eJI3Q8Wzctpo1x0cruvRBAadONdS
   g==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 Apr 2024 16:16:33 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 43N8GQLI058282;
	Tue, 23 Apr 2024 16:16:26 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 16:16:25 +0800
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
Subject: [PATCH v6 0/1] drm/bridge: it6505: fix hibernate to resume no display issue
Date: Tue, 23 Apr 2024 16:27:21 +0800
Message-ID: <20240423082722.843587-1-kuro.chung@ite.com.tw>
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
	504B88917C829DE79EBE2A2D777BE7E479886E2CBB53A5258742F56246EEA2142002:8
X-MAIL:mse.ite.com.tw 43N8GQLI058282

From: Kuro <kuro.chung@ite.com.tw>

New patch description for v6 patch

        remove the unrelated patch change (split into anoter patch)
        remove extra line
	
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

 drivers/gpu/drm/bridge/ite-it6505.c | 73 +++++++++++++++++++----------
 1 file changed, 49 insertions(+), 24 deletions(-)

-- 
2.25.1


