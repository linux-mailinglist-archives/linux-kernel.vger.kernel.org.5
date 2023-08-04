Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451D576FA6C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjHDGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjHDGuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:50:37 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC614687;
        Thu,  3 Aug 2023 23:50:25 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RHGKl1pwrz9t1l;
        Fri,  4 Aug 2023 08:39:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HBTfEkRAy0hd; Fri,  4 Aug 2023 08:39:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RHGKc5dcgz9t1m;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BC9ED8B763;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AZhLvBRveey1; Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46DCA8B779;
        Fri,  4 Aug 2023 08:39:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3746dhxu629372
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 08:39:43 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3746dhSo629371;
        Fri, 4 Aug 2023 08:39:43 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v1 10/10] net: fs_enet: Use cpm_muram_xxx() functions instead of cpm_dpxxx() macros
Date:   Fri,  4 Aug 2023 08:39:34 +0200
Message-ID: <c8b8fb0a60ce65df7840dc78de09fa395696f172.1691130766.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691130766.git.christophe.leroy@csgroup.eu>
References: <cover.1691130766.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691131164; l=2234; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=h5ydkcduy6lioiqJjfCSwkFEzxsJekIZbyhS9VYCwaM=; b=d/uqUMLaKbwiPSJ+r4dVfYXqS3P2GdU/kvQAV4K8Bpeol5uZP8+X9gbgRac+mewA/PN4HczRe 3qE9pv/blThChkze1IgS009owd0Tb49pk1VwnakzQ/u3jzipj6z4bCY
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

cpm_dpxxx() macros are now always referring to cpm_muram_xxx() fonctions
directly since commit 3dd82a1ea724 ("[POWERPC] CPM: Always use new
binding.")

Use cpm_muram_xxx() functions directly so that the cpm_dpxxx() macros
can be removed in the near future.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c | 2 +-
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
index ce63fd56df89..d903a9012db0 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
@@ -105,7 +105,7 @@ static int do_pd_setup(struct fs_enet_private *fep)
 		goto out_ep;
 
 	fep->fcc.mem = (void __iomem *)cpm2_immr;
-	fpi->dpram_offset = cpm_dpalloc(128, 32);
+	fpi->dpram_offset = cpm_muram_alloc(128, 32);
 	if (IS_ERR_VALUE(fpi->dpram_offset)) {
 		ret = fpi->dpram_offset;
 		goto out_fcccp;
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index 66d40da5cde0..a64cb6270515 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -133,13 +133,13 @@ static int allocate_bd(struct net_device *dev)
 	struct fs_enet_private *fep = netdev_priv(dev);
 	const struct fs_platform_info *fpi = fep->fpi;
 
-	fep->ring_mem_addr = cpm_dpalloc((fpi->tx_ring + fpi->rx_ring) *
-					 sizeof(cbd_t), 8);
+	fep->ring_mem_addr = cpm_muram_alloc((fpi->tx_ring + fpi->rx_ring) *
+					     sizeof(cbd_t), 8);
 	if (IS_ERR_VALUE(fep->ring_mem_addr))
 		return -ENOMEM;
 
 	fep->ring_base = (void __iomem __force*)
-		cpm_dpram_addr(fep->ring_mem_addr);
+		cpm_muram_addr(fep->ring_mem_addr);
 
 	return 0;
 }
@@ -149,7 +149,7 @@ static void free_bd(struct net_device *dev)
 	struct fs_enet_private *fep = netdev_priv(dev);
 
 	if (fep->ring_base)
-		cpm_dpfree(fep->ring_mem_addr);
+		cpm_muram_free(fep->ring_mem_addr);
 }
 
 static void cleanup_data(struct net_device *dev)
-- 
2.41.0

