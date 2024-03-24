Return-Path: <linux-kernel+bounces-113561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E3488854F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0F8283347
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342C913E6A9;
	Sun, 24 Mar 2024 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6n7Eugt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F51C5ADC;
	Sun, 24 Mar 2024 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320363; cv=none; b=C/x0ZR3yCaHk+vjSWGRf61gkr0EhmpccRqgckTM0Xsl3HEokQm7y/c35dWPLrLuVeYVPvR+gF3kj5okQ2fv9+Cps2Q+IqbFbHY/1Owai32XWIMSumwzJClyRZ3EfdTx3bqDUJP53R9MD5f6irQ2alNR5SzQjcLtLVGwf+rSnJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320363; c=relaxed/simple;
	bh=9yc9RzzNYFFCXj9TA2BrTsYbnJHVTSRf/XwLJhzcGW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaQU6WMAF9HAz+IL1foXaKK+dZk9maOnMS3lacRNIvcclGpiNefc3v1bHRvR7X7HhF5wuxWrNxHlN//uYO2vaGwRLmF8WdX+uobEI1eB/Up/JVMUVR8gtbjk/DBDxEb0KhdHSQlJje5GsUhgKMk70e3v5wK2l0nR1jF2ahneNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6n7Eugt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0535C433C7;
	Sun, 24 Mar 2024 22:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320363;
	bh=9yc9RzzNYFFCXj9TA2BrTsYbnJHVTSRf/XwLJhzcGW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6n7Eugt5MKAM/2+nDOgvMkEx3yNj+3Rtihn49xFySzgbxHwkCCOzipHclYW14RW9
	 dbjkcB1ca3l1lGWC7LmLR+iWP95JeAyXIwhphesMeDFPuON7h/Vj8NAMC50Ufy5aiK
	 dElX1K4ltiG0wljo4ynLgFpPB8LX+Xn+bdQwIKAjts4RQyzmxIW+Q/Lu10ETCwFXwB
	 c7QHB5C1cy0yOqczyPxdbaPIYhbzvRfuitalOOvAhXES6fF6kRFQdcqTB91PhiPbcJ
	 01eKsgPa5XhIAvPRLBVmanAW2d62xbwciY2NZ2EpDv8rT3IMAks7G2ygmbP5D3OsUh
	 fMi31Hkg07u7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 670/715] xen/events: increment refcnt only if event channel is refcounted
Date: Sun, 24 Mar 2024 18:34:09 -0400
Message-ID: <20240324223455.1342824-671-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Juergen Gross <jgross@suse.com>

[ Upstream commit d277f9d82802223f242cd9b60c988cfdda1d6be0 ]

In bind_evtchn_to_irq_chip() don't increment the refcnt of the event
channel blindly. In case the event channel is NOT refcounted, issue a
warning instead.

Add an additional safety net by doing the refcnt increment only if the
caller has specified IRQF_SHARED in the irqflags parameter.

Fixes: 9e90e58c11b7 ("xen: evtchn: Allow shared registration of IRQ handers")
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Link: https://lore.kernel.org/r/20240313071409.25913-3-jgross@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/events/events_base.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 3b9f080109d7e..27553673e46bc 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1190,7 +1190,7 @@ int xen_pirq_from_irq(unsigned irq)
 EXPORT_SYMBOL_GPL(xen_pirq_from_irq);
 
 static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
-				   struct xenbus_device *dev)
+				   struct xenbus_device *dev, bool shared)
 {
 	int ret = -ENOMEM;
 	struct irq_info *info;
@@ -1224,7 +1224,8 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 		 */
 		bind_evtchn_to_cpu(info, 0, false);
 	} else if (!WARN_ON(info->type != IRQT_EVTCHN)) {
-		info->refcnt++;
+		if (shared && !WARN_ON(info->refcnt < 0))
+			info->refcnt++;
 	}
 
 	ret = info->irq;
@@ -1237,13 +1238,13 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 
 int bind_evtchn_to_irq(evtchn_port_t evtchn)
 {
-	return bind_evtchn_to_irq_chip(evtchn, &xen_dynamic_chip, NULL);
+	return bind_evtchn_to_irq_chip(evtchn, &xen_dynamic_chip, NULL, false);
 }
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
 
 int bind_evtchn_to_irq_lateeoi(evtchn_port_t evtchn)
 {
-	return bind_evtchn_to_irq_chip(evtchn, &xen_lateeoi_chip, NULL);
+	return bind_evtchn_to_irq_chip(evtchn, &xen_lateeoi_chip, NULL, false);
 }
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irq_lateeoi);
 
@@ -1295,7 +1296,8 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 
 static int bind_interdomain_evtchn_to_irq_chip(struct xenbus_device *dev,
 					       evtchn_port_t remote_port,
-					       struct irq_chip *chip)
+					       struct irq_chip *chip,
+					       bool shared)
 {
 	struct evtchn_bind_interdomain bind_interdomain;
 	int err;
@@ -1307,14 +1309,14 @@ static int bind_interdomain_evtchn_to_irq_chip(struct xenbus_device *dev,
 					  &bind_interdomain);
 
 	return err ? : bind_evtchn_to_irq_chip(bind_interdomain.local_port,
-					       chip, dev);
+					       chip, dev, shared);
 }
 
 int bind_interdomain_evtchn_to_irq_lateeoi(struct xenbus_device *dev,
 					   evtchn_port_t remote_port)
 {
 	return bind_interdomain_evtchn_to_irq_chip(dev, remote_port,
-						   &xen_lateeoi_chip);
+						   &xen_lateeoi_chip, false);
 }
 EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irq_lateeoi);
 
@@ -1430,7 +1432,8 @@ static int bind_evtchn_to_irqhandler_chip(evtchn_port_t evtchn,
 {
 	int irq, retval;
 
-	irq = bind_evtchn_to_irq_chip(evtchn, chip, NULL);
+	irq = bind_evtchn_to_irq_chip(evtchn, chip, NULL,
+				      irqflags & IRQF_SHARED);
 	if (irq < 0)
 		return irq;
 	retval = request_irq(irq, handler, irqflags, devname, dev_id);
@@ -1471,7 +1474,8 @@ static int bind_interdomain_evtchn_to_irqhandler_chip(
 {
 	int irq, retval;
 
-	irq = bind_interdomain_evtchn_to_irq_chip(dev, remote_port, chip);
+	irq = bind_interdomain_evtchn_to_irq_chip(dev, remote_port, chip,
+						  irqflags & IRQF_SHARED);
 	if (irq < 0)
 		return irq;
 
-- 
2.43.0


