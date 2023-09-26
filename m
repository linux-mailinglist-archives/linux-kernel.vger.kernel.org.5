Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD947AF2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjIZS2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbjIZS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E1CD0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695752852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YugJO58QiEhXf81Efgja2EtjA+zTSsmC76yLkbmUhCk=;
        b=K01zoEBeW1putzCU1fFqCkPzAziLmEc4HhtfIRZCBNFFKw0FnvT/vJwN3/Z06z7Qgnf5QZ
        +3KdnaNGQqiPjC58Oz55xk1slDjoJ9xLRIgmMGVYuTu02MjPQL8/BtnOJF8JkzMSFPxQiM
        4hr+3LCVvuqwlE2aVSfJI977WoWYeVs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-vC1P8WReNnGWUQA6P-2Qwg-1; Tue, 26 Sep 2023 14:27:27 -0400
X-MC-Unique: vC1P8WReNnGWUQA6P-2Qwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A6C08007A4;
        Tue, 26 Sep 2023 18:27:26 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 065B740C6EA8;
        Tue, 26 Sep 2023 18:27:24 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/9] i40e: Move memory allocation structures to i40e_alloc.h
Date:   Tue, 26 Sep 2023 20:27:08 +0200
Message-ID: <20230926182710.2517901-8-ivecera@redhat.com>
In-Reply-To: <20230926182710.2517901-1-ivecera@redhat.com>
References: <20230926182710.2517901-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Structures i40e_dma_mem & i40e_virt_mem are defined i40e_osdep.h while
memory allocation functions that use them are declared in i40e_alloc.h
Move them to i40e_alloc.h and remove this header file dependency on
i40e_osdep.h header.

Due to removal of this dependency we have to include i40e_osdep.h in files
that requires it.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 21 ++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  1 +
 drivers/net/ethernet/intel/i40e/i40e_diag.c   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    |  1 +
 drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  2 +-
 .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  1 +
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  1 +
 drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 19 -----------------
 11 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 088ef4696818..bf4de913435e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -3,6 +3,7 @@
 
 #include <linux/delay.h>
 #include "i40e_alloc.h"
+#include "i40e_osdep.h"
 #include "i40e_register.h"
 #include "i40e_prototype.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 95c902700f63..2c0341469122 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -6,7 +6,7 @@
 
 #include <linux/mutex.h>
 #include "i40e_adminq_cmd.h"
-#include "i40e_osdep.h"
+#include "i40e_alloc.h"
 
 #define I40E_ADMINQ_DESC(R, i)   \
 	(&(((struct i40e_aq_desc *)((R).desc_buf.va))[i]))
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index 5d9a0b56133e..e0186495ef02 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -4,7 +4,7 @@
 #ifndef _I40E_ALLOC_H_
 #define _I40E_ALLOC_H_
 
-#include "i40e_osdep.h"
+#include <linux/types.h>
 
 struct i40e_hw;
 
@@ -21,6 +21,25 @@ enum i40e_memory_type {
 	i40e_mem_reserved
 };
 
+/* memory allocation tracking */
+struct i40e_dma_mem {
+	void *va;
+	dma_addr_t pa;
+	u32 size;
+};
+
+struct i40e_virt_mem {
+	void *va;
+	u32 size;
+};
+
+#define i40e_allocate_dma_mem(h, m, unused, s, a) \
+			i40e_allocate_dma_mem_d(h, m, s, a)
+#define i40e_free_dma_mem(h, m) i40e_free_dma_mem_d(h, m)
+
+#define i40e_allocate_virt_mem(h, m, s) i40e_allocate_virt_mem_d(h, m, s)
+#define i40e_free_virt_mem(h, m) i40e_free_virt_mem_d(h, m)
+
 /* prototype for functions used for dynamic memory allocation */
 int i40e_allocate_dma_mem(struct i40e_hw *hw,
 			  struct i40e_dma_mem *mem,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 6d1042ca0317..8fb8f9e5c5d7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include "i40e_adminq_cmd.h"
 #include "i40e_devids.h"
+#include "i40e_osdep.h"
 #include "i40e_prototype.h"
 #include "i40e_register.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 68602fc375f6..7d51e58d94bd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -3,6 +3,7 @@
 
 #include "i40e_alloc.h"
 #include "i40e_dcb.h"
+#include "i40e_osdep.h"
 #include "i40e_prototype.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.c b/drivers/net/ethernet/intel/i40e/i40e_diag.c
index b1ad7c4259b9..824f97931f57 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include "i40e_diag.h"
+#include "i40e_osdep.h"
 #include "i40e_prototype.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index 0bc398757283..74b3a5b0bc4a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -3,6 +3,7 @@
 
 #include "i40e_alloc.h"
 #include "i40e_hmc.h"
+#include "i40e_osdep.h"
 #include "i40e_type.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index 76610455cb90..78e6e9144331 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -4,7 +4,7 @@
 #ifndef _I40E_HMC_H_
 #define _I40E_HMC_H_
 
-#include "i40e_osdep.h"
+#include "i40e_alloc.h"
 #include "i40e_register.h"
 
 #define I40E_HMC_MAX_BP_COUNT 512
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
index 6f40c640e310..08f0c90acd9a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
@@ -4,6 +4,7 @@
 #include "i40e_alloc.h"
 #include "i40e_type.h"
 #include "i40e_lan_hmc.h"
+#include "i40e_osdep.h"
 
 /* lan specific interface functions */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 77cdbfc19d47..2e8d2dd4b920 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -3,6 +3,7 @@
 
 #include <linux/delay.h>
 #include "i40e_alloc.h"
+#include "i40e_osdep.h"
 #include "i40e_prototype.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index 23be11a45761..f4f02dd722ba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -28,25 +28,6 @@ do {										\
 #define rd64(a, reg)		readq((a)->hw_addr + (reg))
 #define i40e_flush(a)		readl((a)->hw_addr + I40E_GLGEN_STAT)
 
-/* memory allocation tracking */
-struct i40e_dma_mem {
-	void *va;
-	dma_addr_t pa;
-	u32 size;
-};
-
-#define i40e_allocate_dma_mem(h, m, unused, s, a) \
-			i40e_allocate_dma_mem_d(h, m, s, a)
-#define i40e_free_dma_mem(h, m) i40e_free_dma_mem_d(h, m)
-
-struct i40e_virt_mem {
-	void *va;
-	u32 size;
-};
-
-#define i40e_allocate_virt_mem(h, m, s) i40e_allocate_virt_mem_d(h, m, s)
-#define i40e_free_virt_mem(h, m) i40e_free_virt_mem_d(h, m)
-
 #define i40e_debug(h, m, s, ...)				\
 do {								\
 	if (((m) & (h)->debug_mask))				\
-- 
2.41.0

