Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4CE7559F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjGQDMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGQDM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:12:26 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 50EB2E4C;
        Sun, 16 Jul 2023 20:12:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 13C246012605B;
        Mon, 17 Jul 2023 11:12:06 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     steve.glendinning@shawell.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH net-next v3 6/9] ethernet: smsc: remove unnecessary (void*) conversions
Date:   Mon, 17 Jul 2023 11:12:04 +0800
Message-Id: <20230717031204.54912-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (voidd*) to (struct smsc911x_data *) or
(struct smsc9420_pdata *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 4 ++--
 drivers/net/ethernet/smsc/smsc9420.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 174dc8908b72..c362bff3cb83 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -552,7 +552,7 @@ static void smsc911x_mac_write(struct smsc911x_data *pdata,
 /* Get a phy register */
 static int smsc911x_mii_read(struct mii_bus *bus, int phyaddr, int regidx)
 {
-	struct smsc911x_data *pdata = (struct smsc911x_data *)bus->priv;
+	struct smsc911x_data *pdata = bus->priv;
 	unsigned long flags;
 	unsigned int addr;
 	int i, reg;
@@ -591,7 +591,7 @@ static int smsc911x_mii_read(struct mii_bus *bus, int phyaddr, int regidx)
 static int smsc911x_mii_write(struct mii_bus *bus, int phyaddr, int regidx,
 			   u16 val)
 {
-	struct smsc911x_data *pdata = (struct smsc911x_data *)bus->priv;
+	struct smsc911x_data *pdata = bus->priv;
 	unsigned long flags;
 	unsigned int addr;
 	int i, reg;
diff --git a/drivers/net/ethernet/smsc/smsc9420.c b/drivers/net/ethernet/smsc/smsc9420.c
index 71fbb358bb7d..3b26f1d86beb 100644
--- a/drivers/net/ethernet/smsc/smsc9420.c
+++ b/drivers/net/ethernet/smsc/smsc9420.c
@@ -102,7 +102,7 @@ static inline void smsc9420_pci_flush_write(struct smsc9420_pdata *pd)
 
 static int smsc9420_mii_read(struct mii_bus *bus, int phyaddr, int regidx)
 {
-	struct smsc9420_pdata *pd = (struct smsc9420_pdata *)bus->priv;
+	struct smsc9420_pdata *pd = bus->priv;
 	unsigned long flags;
 	u32 addr;
 	int i, reg = -EIO;
@@ -140,7 +140,7 @@ static int smsc9420_mii_read(struct mii_bus *bus, int phyaddr, int regidx)
 static int smsc9420_mii_write(struct mii_bus *bus, int phyaddr, int regidx,
 			   u16 val)
 {
-	struct smsc9420_pdata *pd = (struct smsc9420_pdata *)bus->priv;
+	struct smsc9420_pdata *pd = bus->priv;
 	unsigned long flags;
 	u32 addr;
 	int i, reg = -EIO;
-- 
2.30.2

