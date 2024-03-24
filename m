Return-Path: <linux-kernel+bounces-114452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB195888A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F811C288CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC617A394;
	Sun, 24 Mar 2024 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XERhz0/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C18156643;
	Sun, 24 Mar 2024 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321872; cv=none; b=gXZ3iRennwVsVIFP69Q8pXhOowmxYyyVJzSz/A1szdwm2JzG+j1vlgQYn1yDiRSF59iVQwgX2aTIggJZS32B0GMaUWToXL3UQ2XhcWDMp/jfeAkPQsRs08kzryzbjlHwjKIP4lb5SYL7lxPxJyBiqlPvWE2LglGGVIpFAvc+m8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321872; c=relaxed/simple;
	bh=S8aahm9GlFFZ6OB1UD/l1rrU0saHd0RKSylzxDy7tKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur4MlnOM3MGTKuGiuuo4JuAzWSjHZfGqTI02NalGI4n+of0EAAhHQorJCWoS6zj7AdKU2/dq4dkQXA0nkIyAes2+y8Gw+IYcIaKzFjpJSG2OdR4t1tRvXlUd8U5RKjyN5/8FlaKeHX4XtNzobfEEf9a45NM2URAsOtMs/l7FimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XERhz0/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9DAC43399;
	Sun, 24 Mar 2024 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321870;
	bh=S8aahm9GlFFZ6OB1UD/l1rrU0saHd0RKSylzxDy7tKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XERhz0/4hyVVuRl15Q8paOuCsAITnuUUpGnOJdp+T2waKfdx9Dk38jtW9jsZ18J17
	 27S3nlGcC7zN9wMJWy+jPkG9sufFa1E6LcgSE9gqJGULWT8Rsa4siuyGAWl2XeLxY/
	 C+KhRA+YktAtVcLTlsycLc53hYyupQJzme8P0aszI5tb4SeIr8M3aQvc0XrX7cyKhx
	 ODEempjmdmRc3d255HxN7Dg/tmqXo2BTAx85vo+1ojGd+64rF7roaGVFvMQC6g1uG/
	 fByj/8Ha0adWPtSg+uN1sl6Qm9qbyCcUpr2kQ7ZTTgIHo5GYTOgvhaRxUIIvTi05H9
	 XHxenD1TaPyYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 599/638] xen/events: increment refcnt only if event channel is refcounted
Date: Sun, 24 Mar 2024 19:00:36 -0400
Message-ID: <20240324230116.1348576-600-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 0c5259c68adeb..9e3b5d21d0987 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1196,7 +1196,7 @@ int xen_pirq_from_irq(unsigned irq)
 EXPORT_SYMBOL_GPL(xen_pirq_from_irq);
 
 static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
-				   struct xenbus_device *dev)
+				   struct xenbus_device *dev, bool shared)
 {
 	int ret = -ENOMEM;
 	struct irq_info *info;
@@ -1230,7 +1230,8 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 		 */
 		bind_evtchn_to_cpu(info, 0, false);
 	} else if (!WARN_ON(info->type != IRQT_EVTCHN)) {
-		info->refcnt++;
+		if (shared && !WARN_ON(info->refcnt < 0))
+			info->refcnt++;
 	}
 
 	ret = info->irq;
@@ -1243,13 +1244,13 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 
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
 
@@ -1301,7 +1302,8 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 
 static int bind_interdomain_evtchn_to_irq_chip(struct xenbus_device *dev,
 					       evtchn_port_t remote_port,
-					       struct irq_chip *chip)
+					       struct irq_chip *chip,
+					       bool shared)
 {
 	struct evtchn_bind_interdomain bind_interdomain;
 	int err;
@@ -1313,14 +1315,14 @@ static int bind_interdomain_evtchn_to_irq_chip(struct xenbus_device *dev,
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
 
@@ -1436,7 +1438,8 @@ static int bind_evtchn_to_irqhandler_chip(evtchn_port_t evtchn,
 {
 	int irq, retval;
 
-	irq = bind_evtchn_to_irq_chip(evtchn, chip, NULL);
+	irq = bind_evtchn_to_irq_chip(evtchn, chip, NULL,
+				      irqflags & IRQF_SHARED);
 	if (irq < 0)
 		return irq;
 	retval = request_irq(irq, handler, irqflags, devname, dev_id);
@@ -1477,7 +1480,8 @@ static int bind_interdomain_evtchn_to_irqhandler_chip(
 {
 	int irq, retval;
 
-	irq = bind_interdomain_evtchn_to_irq_chip(dev, remote_port, chip);
+	irq = bind_interdomain_evtchn_to_irq_chip(dev, remote_port, chip,
+						  irqflags & IRQF_SHARED);
 	if (irq < 0)
 		return irq;
 
-- 
2.43.0


