Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67D57AF2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjIZS2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjIZS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EFE1B3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695752843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOdpRRmlT6qkR0PxQiDpaRKdKCFdimWO6PH13eyZPP4=;
        b=DFRooOQqxlmxsixu16zrckbvcmO3hLqMu3uMwvkNxwRR5sEsmb+QXyRc3MAYdYfjk6kDFa
        Ci2myOuOr0/XYLkwO8mRzGYRGq3r7oTuzxiPgBkSTe1hIZBaLhNUbt3SXMic0qaVzLsvc7
        /n+2uvD//iUq2T7CHtnHsbtpu0y0FCI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-691-NMIPV221NR6rzheQLUjLLA-1; Tue, 26 Sep 2023 14:27:19 -0400
X-MC-Unique: NMIPV221NR6rzheQLUjLLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F190185A78E;
        Tue, 26 Sep 2023 18:27:19 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71DFB40C6E77;
        Tue, 26 Sep 2023 18:27:17 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/9] i40e: Refactor I40E_MDIO_CLAUSE* macros
Date:   Tue, 26 Sep 2023 20:27:04 +0200
Message-ID: <20230926182710.2517901-4-ivecera@redhat.com>
In-Reply-To: <20230926182710.2517901-1-ivecera@redhat.com>
References: <20230926182710.2517901-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros I40E_MDIO_CLAUSE22* and I40E_MDIO_CLAUSE45* are using I40E_MASK
together with the same values I40E_GLGEN_MSCA_STCODE_SHIFT and
I40E_GLGEN_MSCA_OPCODE_SHIFT to define masks.
Introduce I40E_GLGEN_MSCA_OPCODE_MASK and I40E_GLGEN_MSCA_STCODE_MASK
for both shifts in i40e_register.h and use them to refactor the macros
mentioned above.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../net/ethernet/intel/i40e/i40e_register.h   |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 23 +++++++------------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index eebb5735772b..f408fcf23ce8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -205,7 +205,9 @@
 #define I40E_GLGEN_MSCA_DEVADD_SHIFT 16
 #define I40E_GLGEN_MSCA_PHYADD_SHIFT 21
 #define I40E_GLGEN_MSCA_OPCODE_SHIFT 26
+#define I40E_GLGEN_MSCA_OPCODE_MASK(_i) I40E_MASK(_i, I40E_GLGEN_MSCA_OPCODE_SHIFT)
 #define I40E_GLGEN_MSCA_STCODE_SHIFT 28
+#define I40E_GLGEN_MSCA_STCODE_MASK I40E_MASK(0x1, I40E_GLGEN_MSCA_STCODE_SHIFT)
 #define I40E_GLGEN_MSCA_MDICMD_SHIFT 30
 #define I40E_GLGEN_MSCA_MDICMD_MASK I40E_MASK(0x1, I40E_GLGEN_MSCA_MDICMD_SHIFT)
 #define I40E_GLGEN_MSCA_MDIINPROGEN_SHIFT 31
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 60b55d66d648..63cbf7669827 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -67,21 +67,14 @@ enum i40e_debug_mask {
 	I40E_DEBUG_ALL			= 0xFFFFFFFF
 };
 
-#define I40E_MDIO_CLAUSE22_STCODE_MASK	I40E_MASK(1, \
-						  I40E_GLGEN_MSCA_STCODE_SHIFT)
-#define I40E_MDIO_CLAUSE22_OPCODE_WRITE_MASK	I40E_MASK(1, \
-						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-#define I40E_MDIO_CLAUSE22_OPCODE_READ_MASK	I40E_MASK(2, \
-						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-
-#define I40E_MDIO_CLAUSE45_STCODE_MASK	I40E_MASK(0, \
-						  I40E_GLGEN_MSCA_STCODE_SHIFT)
-#define I40E_MDIO_CLAUSE45_OPCODE_ADDRESS_MASK	I40E_MASK(0, \
-						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-#define I40E_MDIO_CLAUSE45_OPCODE_WRITE_MASK	I40E_MASK(1, \
-						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-#define I40E_MDIO_CLAUSE45_OPCODE_READ_MASK	I40E_MASK(3, \
-						I40E_GLGEN_MSCA_OPCODE_SHIFT)
+#define I40E_MDIO_CLAUSE22_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK
+#define I40E_MDIO_CLAUSE22_OPCODE_WRITE_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(1)
+#define I40E_MDIO_CLAUSE22_OPCODE_READ_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(2)
+
+#define I40E_MDIO_CLAUSE45_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK
+#define I40E_MDIO_CLAUSE45_OPCODE_ADDRESS_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(0)
+#define I40E_MDIO_CLAUSE45_OPCODE_WRITE_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(1)
+#define I40E_MDIO_CLAUSE45_OPCODE_READ_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(3)
 
 #define I40E_PHY_COM_REG_PAGE                   0x1E
 #define I40E_PHY_LED_LINK_MODE_MASK             0xF0
-- 
2.41.0

