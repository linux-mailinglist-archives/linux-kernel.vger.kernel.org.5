Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6020A7D0B07
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376566AbjJTJAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376521AbjJTJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:00:33 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 04C4EAB;
        Fri, 20 Oct 2023 02:00:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 5758960494CD8;
        Fri, 20 Oct 2023 17:00:17 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     Su Hui <suhui@nfschina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] net: dsa: mv88e6xxx: add an error code check in mv88e6352_tai_event_work
Date:   Fri, 20 Oct 2023 17:00:04 +0800
Message-Id: <20231020090003.200092-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mv88e6xxx_tai_write() can return error code (-EOPNOTSUPP ...) if failed.
So check the value of 'ret' after calling mv88e6xxx_tai_write().

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index ea17231dc34e..56391e09b325 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -182,6 +182,10 @@ static void mv88e6352_tai_event_work(struct work_struct *ugly)
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS, status[0]);
 	mv88e6xxx_reg_unlock(chip);
+	if (err) {
+		dev_err(chip->dev, "failed to write TAI status register\n");
+		return;
+	}
 
 	/* This is an external timestamp */
 	ev.type = PTP_CLOCK_EXTTS;
-- 
2.30.2

