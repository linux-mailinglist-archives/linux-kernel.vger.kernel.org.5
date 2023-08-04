Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7FB76FA6E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjHDGvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjHDGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:50:42 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07624C0D;
        Thu,  3 Aug 2023 23:50:33 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RHGKc4F16z9t1F;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r2bBQvFyGrGk; Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RHGKX716Mz9t1H;
        Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB10A8B776;
        Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5li719ylwqPz; Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F1E28B763;
        Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3746daiY629335
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 08:39:36 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3746davJ629334;
        Fri, 4 Aug 2023 08:39:36 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v1 02/10] net: fs_enet: Fix address space and base types mismatches
Date:   Fri,  4 Aug 2023 08:39:26 +0200
Message-ID: <25c7965e6aeeb6bbe1b6be5a3c2c7125182fcb02.1691130766.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691130766.git.christophe.leroy@csgroup.eu>
References: <cover.1691130766.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691131163; l=2593; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ZgDtmZ1i65wM+0RHDGG/TwwCzh2fNr2ZIgPm+CzmuSU=; b=c+CP+D+hhVLxaAq5lsPhzWat6SFilzC+iP2yP6+3StxbGuXKikwwLead3JqiuuvyKHz8y1r6+ 3cSk4idyXs9A4148XcQQ7OxSp+FG+otkDdfxya5+Y+uq0cVahW0AFmS
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  CHECK   drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
drivers/net/ethernet/freescale/fs_enet/mac-fcc.c:550:9: warning: cast removes address space '__iomem' of expression
drivers/net/ethernet/freescale/fs_enet/mac-fcc.c:550:9: error: subtraction of different types can't work (different address spaces)
  CC      drivers/net/ethernet/freescale/fs_enet/mii-bitbang.o
  CHECK   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:95:31: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:95:31:    expected unsigned int [noderef] [usertype] __iomem *p
drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:95:31:    got restricted __be32 [noderef] [usertype] __iomem *dat
...
drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:63:31: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:63:31:    expected unsigned int [noderef] [usertype] __iomem *p
drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:63:31:    got restricted __be32 [noderef] [usertype] __iomem *dir
...

Fix those address space and base type mismatches reported by sparse.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c     | 2 +-
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
index 925428f1b0c8..ce63fd56df89 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
@@ -547,7 +547,7 @@ static void tx_restart(struct net_device *dev)
 	}
 	/* Now update the TBPTR and dirty flag to the current buffer */
 	W32(ep, fen_genfcc.fcc_tbptr,
-		(uint) (((void *)recheck_bd - fep->ring_base) +
+		(uint)(((void __iomem *)recheck_bd - fep->ring_base) +
 		fep->ring_mem_addr));
 	fep->dirty_tx = recheck_bd;
 
diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
index 91a69fc2f7c2..f965a2329055 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
@@ -29,8 +29,8 @@
 
 struct bb_info {
 	struct mdiobb_ctrl ctrl;
-	__be32 __iomem *dir;
-	__be32 __iomem *dat;
+	u32 __iomem *dir;
+	u32 __iomem *dat;
 	u32 mdio_msk;
 	u32 mdc_msk;
 };
-- 
2.41.0

