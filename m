Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62337FDCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjK2QTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjK2QSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:18:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045A1FC9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701274638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MHQSQ4CAY7xcBlGAQeueCnB5UbNDO9BjNEjw8iOleu4=;
        b=R7yvfrhiSmORQar/0+XR95uNFymVucTV1esmlzwmylQkofxIVswxUVtts9NAgZk4Vnqyn3
        IeJlHnASlySFLaMNjM43VoQnvlutU437b1crJYD/NuMeV6ZqmWROxkIWixwFcAyONf40O0
        jm6gkz8cIuBe90Eq9n4DPY9uJL61Stc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-iZs6RrVmNO2ue-SGduHBlA-1; Wed,
 29 Nov 2023 11:17:14 -0500
X-MC-Unique: iZs6RrVmNO2ue-SGduHBlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 055F93803509;
        Wed, 29 Nov 2023 16:17:14 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AEBD1121308;
        Wed, 29 Nov 2023 16:17:12 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] i40e: Fix ST code value for Clause 45
Date:   Wed, 29 Nov 2023 17:17:10 +0100
Message-ID: <20231129161711.771729-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ST code value for clause 45 that has been changed by
commit 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
is currently wrong.

The mentioned commit refactored ..MDIO_CLAUSE??_STCODE_MASK so
their value is the same for both clauses. The value is correct
for clause 22 but not for clause 45.

Fix the issue by adding a parameter to I40E_GLGEN_MSCA_STCODE_MASK
macro that specifies required value.

Fixes: 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index f408fcf23ce8..f6671ac79735 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -207,7 +207,7 @@
 #define I40E_GLGEN_MSCA_OPCODE_SHIFT 26
 #define I40E_GLGEN_MSCA_OPCODE_MASK(_i) I40E_MASK(_i, I40E_GLGEN_MSCA_OPCODE_SHIFT)
 #define I40E_GLGEN_MSCA_STCODE_SHIFT 28
-#define I40E_GLGEN_MSCA_STCODE_MASK I40E_MASK(0x1, I40E_GLGEN_MSCA_STCODE_SHIFT)
+#define I40E_GLGEN_MSCA_STCODE_MASK(_i) I40E_MASK(_i, I40E_GLGEN_MSCA_STCODE_SHIFT)
 #define I40E_GLGEN_MSCA_MDICMD_SHIFT 30
 #define I40E_GLGEN_MSCA_MDICMD_MASK I40E_MASK(0x1, I40E_GLGEN_MSCA_MDICMD_SHIFT)
 #define I40E_GLGEN_MSCA_MDIINPROGEN_SHIFT 31
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 2a5c7aec0bb1..eb808e3bcf55 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -37,11 +37,11 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
 #define I40E_QTX_CTL_VM_QUEUE	0x1
 #define I40E_QTX_CTL_PF_QUEUE	0x2
 
-#define I40E_MDIO_CLAUSE22_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK
+#define I40E_MDIO_CLAUSE22_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK(1)
 #define I40E_MDIO_CLAUSE22_OPCODE_WRITE_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(1)
 #define I40E_MDIO_CLAUSE22_OPCODE_READ_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(2)
 
-#define I40E_MDIO_CLAUSE45_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK
+#define I40E_MDIO_CLAUSE45_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK(0)
 #define I40E_MDIO_CLAUSE45_OPCODE_ADDRESS_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(0)
 #define I40E_MDIO_CLAUSE45_OPCODE_WRITE_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(1)
 #define I40E_MDIO_CLAUSE45_OPCODE_READ_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(3)
-- 
2.41.0

