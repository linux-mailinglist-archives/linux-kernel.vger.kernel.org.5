Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F48D7EA92A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjKNDfA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 22:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKNDe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:34:58 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937EA192
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:34:51 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2220D24E28C;
        Tue, 14 Nov 2023 11:34:49 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Nov
 2023 11:34:49 +0800
Received: from localhost.localdomain (161.142.156.149) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Nov
 2023 11:34:47 +0800
From:   Joshua Yeong <joshua.yeong@starfivetech.com>
To:     <alexandre.belloni@bootlin.com>, <miquel.raynal@bootlin.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Joshua Yeong" <joshua.yeong@starfivetech.com>
Subject: [PATCH v2 1/1] i3c: Add fallback method for GETMXDS CCC
Date:   Tue, 14 Nov 2023 11:34:30 +0800
Message-ID: <20231114033430.9623-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114033430.9623-1-joshua.yeong@starfivetech.com>
References: <20231114033430.9623-1-joshua.yeong@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [161.142.156.149]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some I3C hardware will report error when incorrect length is received from
device. GETMXDS CCC are availble in 2 formats; without turnaround time (format
1) and with turnaround time (format 2). There is no mechanics to determine which
format is supported by device. In case sending GETMXDS CCC format 2 resulted
failure, try sending GETMXDS CCC format 1 instead.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/i3c/master.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 0cdc94e4cb77..2fc04d97f07e 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1099,8 +1099,16 @@ static int i3c_master_getmxds_locked(struct i3c_master_controller *master,
 
 	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETMXDS, &dest, 1);
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
-	if (ret)
-		goto out;
+	if (ret) {
+		/*
+		* Retry when the device does not support max read turnaround
+		* while expecting shorter length from this CCC command
+		*/
+		dest->payload.len -= 3;
+		ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+		if (ret)
+			goto out;
+	}
 
 	if (dest.payload.len != 2 && dest.payload.len != 5) {
 		ret = -EIO;
-- 
2.25.1

