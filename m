Return-Path: <linux-kernel+bounces-158397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7008D8B1F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF7C281BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE082137E;
	Thu, 25 Apr 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t8KtZk+e"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6E1BF40;
	Thu, 25 Apr 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041127; cv=none; b=IA/lJnl1mSOivb4xuiqSBPvYUsPINt6EA5tueNUArm3hjz1kM0PfjVlFvJLMBH2/DXp5rdiQ7bSeo8mKjSVqjwFZdIEA5HKspG51S3r/Pk1hOHLMTVZLcpfCgyFgZuvGCTjGaV1aoo2NFOR5AHb7RYJgfYKJq+cJkRwxt4Ts2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041127; c=relaxed/simple;
	bh=RMkbX26fdGoh43r6FT0+j6A0gxpNeQAV1acti6JwF98=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QqgABKEAwuyJImRq8mw0TPc5tE+DqGPRjIr6HtXWz8En56RTJ7lXLsfMZKsZL70bPHrOtTM5gju2NwddVOS86jLTpv2aKhxIFHQN59ntGvYBFFuyqBiVk7/b6QdDJMRMWsxJ+Ws/6/HCGHcQBERo1iKXkdDUIyPNHBTLinPUmbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t8KtZk+e; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PAVjsQ124968;
	Thu, 25 Apr 2024 05:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714041105;
	bh=28BXa8VxttMfc0TEExNi0FUUh3WfxcfWgxA0Q4ZUKPE=;
	h=From:To:CC:Subject:Date;
	b=t8KtZk+ecxXD8doaTgt1wGov/UDpusI/gGnUiENiBh+P1TO8UBQw8psil/SXcF9eq
	 wvDmT7hSS6o30ZSIhgZso5P2mikYF+8aGBtg+keEGPy4Jm4e9RpZT1lIUzG2kkUtGb
	 5+tO050xIM6jnIqS0fjCt8GGzbuC4pz/COsdWPSk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PAVjg8056078
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 05:31:45 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 05:31:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 05:31:44 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PAVim4024030;
	Thu, 25 Apr 2024 05:31:44 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Tanmay Patil <t-patil@ti.com>,
        =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
        Simon
 Horman <horms@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>, <s-vadapalli@ti.com>,
        <srk@ti.com>, <danishanwar@ti.com>, <r-gunasekaran@ti.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH net-next] net: ethernet: ti: am65-cpsw-qos: Add support to taprio for past base_time
Date: Thu, 25 Apr 2024 16:01:42 +0530
Message-ID: <20240425103142.1999123-1-c-vankar@ti.com>
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

From: Tanmay Patil <t-patil@ti.com>

If the base-time for taprio is in the past, start the schedule at the time
of the form "base_time + N*cycle_time" where N is the smallest possible
integer such that the above time is in the future.

Signed-off-by: Tanmay Patil <t-patil@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on net-next commit d80687161271.

 drivers/net/ethernet/ti/am65-cpsw-qos.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 16f192a5b160..fa96db7c1a13 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -9,6 +9,7 @@
 
 #include <linux/pm_runtime.h>
 #include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/units.h>
 #include <net/pkt_cls.h>
@@ -837,6 +838,7 @@ static int am65_cpsw_taprio_replace(struct net_device *ndev,
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	struct am65_cpts *cpts = common->cpts;
 	struct am65_cpsw_est *est_new;
+	u64 cur_time, n;
 	int ret, tact;
 
 	if (!netif_running(ndev)) {
@@ -888,13 +890,21 @@ static int am65_cpsw_taprio_replace(struct net_device *ndev,
 	if (tact == TACT_PROG)
 		am65_cpsw_timer_stop(ndev);
 
-	if (!est_new->taprio.base_time)
-		est_new->taprio.base_time = am65_cpts_ns_gettime(cpts);
-
 	am65_cpsw_port_est_get_buf_num(ndev, est_new);
 	am65_cpsw_est_set_sched_list(ndev, est_new);
 	am65_cpsw_port_est_assign_buf_num(ndev, est_new->buf);
 
+	/* If the base-time is in the past, start schedule from the time:
+	 * base_time + (N*cycle_time)
+	 * where N is the smallest possible integer such that the above
+	 * time is in the future.
+	 */
+	cur_time = am65_cpts_ns_gettime(cpts);
+	if (est_new->taprio.base_time < cur_time) {
+		n = div64_u64(cur_time - est_new->taprio.base_time, est_new->taprio.cycle_time);
+		est_new->taprio.base_time += (n + 1) * est_new->taprio.cycle_time;
+	}
+
 	am65_cpsw_est_set(ndev, 1);
 
 	if (tact == TACT_PROG) {
-- 
2.34.1


