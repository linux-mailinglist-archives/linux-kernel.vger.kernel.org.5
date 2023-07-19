Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13F0759EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGSTlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGSTlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F521FCD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7A58617DA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B04EC433C7;
        Wed, 19 Jul 2023 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689795663;
        bh=HT6NIJnJjP5XXjL3jAn8RBEdx6VjahZqEGc1GycJOzs=;
        h=From:To:Cc:Subject:Date:From;
        b=glJtml9m0Hgxx78mdXgcgYqU8Aq4I+4WSEAyiStrCFQ6CwHaDQufqKPeshdn1Pu02
         oFYhSswF5yw8PkhEan5XX1ffIV79x44ZeWHxfDT4Krxj2oNwuED3/sNk+pTRO7+LsR
         psri1Wn6WwIu9gKrAKAMIKmya2dEXFgMk1GH6LWhwQeyJbd4fEZsmWqT6nL+oPDi3A
         gNWZrvm0k1exHt07nf/8pM8LOqmwU8bODbgwkNU8Vo3CueJjgofJSs42P9soDODaFT
         NumZ1Loz0WGBO7Bvvqm3AEtHnCOgyDOmUfdv5mjOjQL/jprXnXJcd8EKnSAWAU784h
         3S1rE3mcdV7ug==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vpda: pds: fix building without debugfs
Date:   Wed, 19 Jul 2023 21:40:52 +0200
Message-Id: <20230719194058.1606869-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new debugfs code still gets called when debugfs is disabled, resulting
in a link failure:

ERROR: modpost: "pds_vdpa_debugfs_del_vdpadev" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
ERROR: modpost: "pds_vdpa_debugfs_add_vdpadev" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
ERROR: modpost: "pds_vdpa_debugfs_reset_vdpadev" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
ERROR: modpost: "pds_vdpa_debugfs_create" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
ERROR: modpost: "pds_vdpa_debugfs_add_ident" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
ERROR: modpost: "pds_vdpa_debugfs_destroy" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
ERROR: modpost: "pds_vdpa_debugfs_add_pcidev" [drivers/vdpa/pds/pds_vdpa.ko] undefined!

Add the usual #if/#else block around the declarations to supply empty stubs
for the broken case.

Fixes: 151cc834f3dda ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/vdpa/pds/debugfs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/pds/debugfs.h b/drivers/vdpa/pds/debugfs.h
index c088a4e8f1e92..6fbd64ace13a3 100644
--- a/drivers/vdpa/pds/debugfs.h
+++ b/drivers/vdpa/pds/debugfs.h
@@ -6,6 +6,7 @@
 
 #include <linux/debugfs.h>
 
+#ifdef CONFIG_DEBUG_FS
 void pds_vdpa_debugfs_create(void);
 void pds_vdpa_debugfs_destroy(void);
 void pds_vdpa_debugfs_add_pcidev(struct pds_vdpa_aux *vdpa_aux);
@@ -13,5 +14,14 @@ void pds_vdpa_debugfs_add_ident(struct pds_vdpa_aux *vdpa_aux);
 void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux);
 void pds_vdpa_debugfs_del_vdpadev(struct pds_vdpa_aux *vdpa_aux);
 void pds_vdpa_debugfs_reset_vdpadev(struct pds_vdpa_aux *vdpa_aux);
+#else
+static inline void pds_vdpa_debugfs_create(void) { }
+static inline void pds_vdpa_debugfs_destroy(void) { }
+static inline void pds_vdpa_debugfs_add_pcidev(struct pds_vdpa_aux *vdpa_aux) { }
+static inline void pds_vdpa_debugfs_add_ident(struct pds_vdpa_aux *vdpa_aux) { }
+static inline void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux) { }
+static inline void pds_vdpa_debugfs_del_vdpadev(struct pds_vdpa_aux *vdpa_aux) { }
+static inline void pds_vdpa_debugfs_reset_vdpadev(struct pds_vdpa_aux *vdpa_aux) { }
+#endif
 
 #endif /* _PDS_VDPA_DEBUGFS_H_ */
-- 
2.39.2

