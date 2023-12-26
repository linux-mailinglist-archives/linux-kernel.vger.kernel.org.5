Return-Path: <linux-kernel+bounces-11395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671CD81E595
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B451C21CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEED14C610;
	Tue, 26 Dec 2023 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NUbaH8WP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m6035.netease.com (mail-m6035.netease.com [210.79.60.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A384C3C4;
	Tue, 26 Dec 2023 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=NUbaH8WPk7Gp/LNITR7TS7RPV6Zq7I7EWqJlbmY7yyofcqBSrLKaMG5A6uvIA40dLawouKfgAavs8GqJ3VYqXH6Cm7IrzkxkYw1mOLbkisX8cXVn8cCEqPzg8z5Y5htrBdQm/30sMN+ISjZJ+bTObheCAjPr+oYP5/A6QkOe6f0=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=gywcpbvFq4giP2vj7hMAbUeXdCN7KyEFaon8oL7guFQ=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by mail-m12773.qiye.163.com (Hmail) with ESMTPA id 1AFC32C0564;
	Tue, 26 Dec 2023 15:20:02 +0800 (CST)
From: William Wu <william.wu@rock-chips.com>
To: hminas@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	william.wu@rock-chips.com,
	frank.wang@rock-chips.com,
	jianwei.zheng@rock-chips.com,
	yangbin@rock-chips.com
Subject: [PATCH] usb: dwc2: Disable clock gating feature on Rockchip SoCs
Date: Tue, 26 Dec 2023 15:19:59 +0800
Message-Id: <1703575199-23638-1-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJPSFZIGk9JQ0wdTB8dSk1VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8ca4fea9f1b249kuuu1afc32c0564
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OT46Pzo*KDw2KxURMRQXTiI8
	MT1PFB1VSlVKTEtITkxOSUtISklLVTMWGhIXVQwSFxcSGhZVDA47CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTUtDNwY+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The DWC2 IP on the Rockchip SoCs doesn't support clock gating.
When a clock gating is enabled, system hangs.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index fb03162..eb677c3 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -130,6 +130,7 @@ static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
 	p->lpm_clock_gating = false;
 	p->besl = false;
 	p->hird_threshold_en = false;
+	p->no_clock_gating = true;
 }
 
 static void dwc2_set_ltq_params(struct dwc2_hsotg *hsotg)
-- 
2.0.0


