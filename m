Return-Path: <linux-kernel+bounces-78174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E8860FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57029289B00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872B663121;
	Fri, 23 Feb 2024 10:47:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C8D29B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685256; cv=none; b=SgMwgve3f14eb+Jr5X3/e+j6JUy0U0QQiKtBz0wLqsEFV2LGzHzesCE+3V6UujPWrppVrJFH0xqz+tqZNZ7kZ53EFXCVsdyEV+/3J8LxnIaHNLK8yorTgVvnGHrOqjdBgV0wTxdGBFrVJZYDyay/IKoeTFUTXezcOo0jttSowyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685256; c=relaxed/simple;
	bh=s4MMU7+jsaZJjz9oik9m7Bh8k11l3m1ojNylen52K70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ViknMJTw5C2xKMI5Jjy4rgQ8Trc/fH0Me8Zq4Z4vu81+rIgxa/DfdH4RGtTQwUHA1T23SU2xwambPj0tkx8o2Kv1Xy47UlNDn0yI6Q/gnONDmYrHoMKBI7XMX/kkRoWMWmyd6uz7fcJ/HLNIN/CKlO3innD4jUeiK+RSyGisFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rdT5S-0007T7-5B; Fri, 23 Feb 2024 11:47:26 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: robh+dt@kernel.org,
	frowand.list@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] of: property: lower loglevel of of_graph_get_next_endpoint
Date: Fri, 23 Feb 2024 11:47:21 +0100
Message-Id: <20240223104721.4140880-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Drivers like the tcpm.c do search for a remote endpoint on different
places to be dt-bindings compatible. The search is done on the device
itself or on the child fwnode in case it was not found the first time.

This indicates that not finding the remote endpoint at the first try is
a valid use-case and should not cause an error printing.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Hi,

I'm not 100% certain if this is the correct place but if our platform
follows the dt-bindings we receive

| OF: graph: no port node found in /soc@0/bus@30800000/i2c@30a30000/tcpc@50

a few times because of the below pr_err() and EPROBE_DEFER.

Regards,
  Marco

 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 641a40cf5cf3..155df04a9512 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -665,7 +665,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 		of_node_put(node);
 
 		if (!port) {
-			pr_err("graph: no port node found in %pOF\n", parent);
+			pr_notice("graph: no port node found in %pOF\n", parent);
 			return NULL;
 		}
 	} else {
-- 
2.39.2


