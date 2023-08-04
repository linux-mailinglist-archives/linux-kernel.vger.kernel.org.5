Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF87576FA69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjHDGuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjHDGuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:50:19 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89575E53;
        Thu,  3 Aug 2023 23:50:18 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RHGKY0KLJz9t1K;
        Fri,  4 Aug 2023 08:39:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PBkbf-SYzAEb; Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RHGKX6jwTz9t11;
        Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF5138B779;
        Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7WqvV--2KeIG; Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 85A428B778;
        Fri,  4 Aug 2023 08:39:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3746dadg629327
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 08:39:36 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3746dZeL629290;
        Fri, 4 Aug 2023 08:39:35 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v1 00/10] net: fs_enet: Driver cleanup
Date:   Fri,  4 Aug 2023 08:39:24 +0200
Message-ID: <cover.1691130766.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691131163; l=1724; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=NMUfvHd1Ivx2h5MBFE/4m/aSsKWUI9X9JLiIVGg+yys=; b=gcH9l4OhKTgKy9wZXQxvOCgGGCCmDxTMignpXDTvOVXvUntmMccsxxh1oQdKejks6fLSf+N/K 61JbL+O9erIAhEstgFmunehOrMHTnUi+coanAyfqdGBmbFlcJVwCKgY
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

Over the years, platform and driver initialisation have evolved into
more generic ways, and driver or platform specific stuff has gone
away, leaving stale objects behind.

This series aims at cleaning all that up for fs_enet ethernet driver.


Christophe Leroy (10):
  net: fs_enet: Remove set but not used variable
  net: fs_enet: Fix address space and base types mismatches
  net: fs_enet: Remove fs_get_id()
  net: fs_enet: Remove unused fields in fs_platform_info struct
  net: fs_enet: Remove has_phy field in fs_platform_info struct
  net: fs_enet: Remove stale prototypes from fsl_soc.c
  net: fs_enet: Move struct fs_platform_info into fs_enet.h
  net: fs_enet: Don't include fs_enet_pd.h when not needed
  net: fs_enet: Remove linux/fs_enet_pd.h
  net: fs_enet: Use cpm_muram_xxx() functions instead of cpm_dpxxx()
    macros

 MAINTAINERS                                   |   1 -
 arch/powerpc/platforms/8xx/adder875.c         |   1 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c  |   1 -
 arch/powerpc/platforms/8xx/tqm8xx_setup.c     |   1 -
 arch/powerpc/sysdev/fsl_soc.c                 |   3 -
 .../ethernet/freescale/fs_enet/fs_enet-main.c |   2 -
 .../net/ethernet/freescale/fs_enet/fs_enet.h  |  19 +-
 .../net/ethernet/freescale/fs_enet/mac-fcc.c  |   4 +-
 .../net/ethernet/freescale/fs_enet/mac-fec.c  |  14 --
 .../net/ethernet/freescale/fs_enet/mac-scc.c  |   8 +-
 .../ethernet/freescale/fs_enet/mii-bitbang.c  |   4 +-
 .../net/ethernet/freescale/fs_enet/mii-fec.c  |   1 +
 include/linux/fs_enet_pd.h                    | 165 ------------------
 13 files changed, 27 insertions(+), 197 deletions(-)
 delete mode 100644 include/linux/fs_enet_pd.h

-- 
2.41.0

