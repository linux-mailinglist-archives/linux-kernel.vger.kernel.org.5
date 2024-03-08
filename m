Return-Path: <linux-kernel+bounces-96708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0FF876058
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB08A281B19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672C4F883;
	Fri,  8 Mar 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="U+DIYKfh"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665622C85C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888084; cv=none; b=V8wk+BCjPDWdBCe1c1AOdaTU1yGAgU2KZ4hNAxEintzJbcyhlL1COJfg0/nIwn206A+xLx9Rx7engcMJ8X3/JZQO23tDoyAxwwMcsLVzFx8T7QKzYR4UR9K9JFEFDmNKjuSUIhIMRqW+rSIXfpdcvnwwsdDSQK7q8sWOSq7RwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888084; c=relaxed/simple;
	bh=z4hLB/fY9KztPv+9M7jWfOpVmDxi/McpzD+W7P2T/lA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uU8/GBbOwzafZuy/xBNMsfKzjKKuQzrDnYN0g0PaQkytutL5klUK2d3be+yyeN0PC+hjC4zTgzt/pnLXY7U7XVjJfRtQ88s9MYIWWibIgdCVLJXN0iqTXwTCx+kY9Ro5aglKKEuuFPoNoL/rQiKp+q5td8/IPSMslNkLcUFhlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=U+DIYKfh reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ueYuErBzNOQow9i3cCLMsyBomG/pby6aV6w567ivZY4=;
  b=U+DIYKfhbKZmmrLVBDFw3kOcAYxoAfbWLFcr2qyIseEx3IpE98uMol8O
   zjGrA9YYi+QPHqcGkS7GKCYOAPuyyyUFsUomknrqmcPIQVJBpiDBcbims
   3aHDBxF1AxsetHjCE1jP3irdXgBCSzQ4yRoCAQS6AwJ/HGc9Zr/LSaWI6
   ylWB2rehzjySN60GE6UwEaF6Wy+jx6FGDOKXpNIudrwn0wjZlIlun8s2X
   beWM24ydrBRJu9ik/ps/vsysgkV9Qu8CGRSucNxRQ+9Vyom9NejAU0bxP
   4gPkj2P+X/fptLAsqzEjSKUMWcafVMOik4U0YfDCi0VAKHYTNpfhj12TT
   Q==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 08 Mar 2024 16:54:33 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 4288sSeO079655;
	Fri, 8 Mar 2024 16:54:28 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 16:54:28 +0800
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
Subject: [PATCH v4 0/1] drm/bridge: it6505: fix hibernate to resume no display issue
Date: Fri, 8 Mar 2024 17:05:46 +0800
Message-ID: <20240308090548.269625-1-kuro.chung@ite.com.tw>
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
	0787A66D1D05A46525F5F1DB9E5BA4C8B4B3FFE9486B63953D78B7D6F5C182042002:8
X-MAIL:mse.ite.com.tw 4288sSeO079655

From: Kuro Chung <kuro.chung@ite.com.tw>


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

 drivers/gpu/drm/bridge/ite-it6505.c | 50 ++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 15 deletions(-)

-- 
2.25.1


