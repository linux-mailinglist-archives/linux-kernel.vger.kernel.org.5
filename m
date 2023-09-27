Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E661C7AFE96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjI0IdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjI0Icj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B7BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695803513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBPzqP7mvSaTje2m9Bq5UEE3uForpA2ubHE/HpdjFVQ=;
        b=awo61x9i86TbQ3MSerWFKUeFvmQPBp6ZrBiVURvunpPbaJbQ03Gglwm+Z4ZmYtSB7Lflqy
        yjuSE8Vl+M9uyuktpYSO0gE+fyIiWOSb+cc9swoIMrtumb9M8zXQiR54aiw/hQR81l7GSE
        HeRFiIO9kvcmy3/+enpnbAIvei0pj6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-OAH35cB6OoKOLhD-csj3-g-1; Wed, 27 Sep 2023 04:31:50 -0400
X-MC-Unique: OAH35cB6OoKOLhD-csj3-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 104E8185A790;
        Wed, 27 Sep 2023 08:31:50 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 512CA2156702;
        Wed, 27 Sep 2023 08:31:48 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v2 6/9] i40e: Move memory allocation structures to i40e_alloc.h
Date:   Wed, 27 Sep 2023 10:31:32 +0200
Message-ID: <20230927083135.3237206-7-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-1-ivecera@redhat.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Structures i40e_dma_mem & i40e_virt_mem are defined i40e_osdep.h while
memory allocation functions that use them are declared in i40e_alloc.h
Move them there.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  1 +
 drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 14 ++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 12 ------------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 267f2e0a21ce..1c3d2bc5c3f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -4,6 +4,7 @@
 #ifndef _I40E_ADMINQ_H_
 #define _I40E_ADMINQ_H_
 
+#include "i40e_alloc.h"
 #include "i40e_osdep.h"
 #include "i40e_adminq_cmd.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index 4b2d8da048c6..e0dde326255d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -4,8 +4,22 @@
 #ifndef _I40E_ALLOC_H_
 #define _I40E_ALLOC_H_
 
+#include <linux/types.h>
+
 struct i40e_hw;
 
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
 /* prototype for functions used for dynamic memory allocation */
 int i40e_allocate_dma_mem(struct i40e_hw *hw,
 			  struct i40e_dma_mem *mem,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index 70cac3bb31ec..fd18895cfb56 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -29,18 +29,6 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 #define rd64(a, reg)		readq((a)->hw_addr + (reg))
 #define i40e_flush(a)		readl((a)->hw_addr + I40E_GLGEN_STAT)
 
-/* memory allocation tracking */
-struct i40e_dma_mem {
-	void *va;
-	dma_addr_t pa;
-	u32 size;
-};
-
-struct i40e_virt_mem {
-	void *va;
-	u32 size;
-};
-
 #define i40e_debug(h, m, s, ...)				\
 do {								\
 	if (((m) & (h)->debug_mask))				\
-- 
2.41.0

