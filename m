Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30107E59CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjKHPLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjKHPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9AB1BE5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699456233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PDc6Ow/bSblo3GhUEPhnVNdc0LfbXdgWx7MoQyklJ7Q=;
        b=c6i+IAqZYAVdJv8JsaPFTiodQ6FJ8rSVqcWt/qWci4wabfmV4MRPU0v0lqc9dxgcsthAFN
        C3+4tQjBhMjJBvDeV7hIJi8VRhmSq4fV4CO1FvrIfbnY/4HUuJzmA470GRa3trLkuvfSeC
        mfWuYO9Kna/ejzxheWMAYeeu3krXkjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-ClR-7Y0IOCeBTJnzrMdaPg-1; Wed, 08 Nov 2023 10:10:26 -0500
X-MC-Unique: ClR-7Y0IOCeBTJnzrMdaPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC718892281;
        Wed,  8 Nov 2023 15:10:21 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C48DDC12911;
        Wed,  8 Nov 2023 15:10:19 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Todd Fujinaka <todd.fujinaka@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] i40e: Fix max frame size check
Date:   Wed,  8 Nov 2023 16:10:18 +0100
Message-ID: <20231108151018.72670-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set") added
a check for port's MFS (max frame size) value. The value is stored
in PRTGL_SAH register for each physical port. According datasheet this
register is defined as:

PRTGL_SAH[PRT]: (0x001E2140 + 0x4*PRT, PRT=0...3)

where PRT is physical port number.

The existing check does not take port number into account and reads
actually MFS value always for port 0 that is correct for PF 0 but
not for other PFs.

Update PRTGL_SAH register definition so it takes a port number as
an argument and fix the check by passing the port number.
Also fix the warning message that use for a port number a local
variable 'i' that really does not contain such information.

Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
Cc: Todd Fujinaka <todd.fujinaka@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_register.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4f445f6835de..6a2907674583 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16219,11 +16219,11 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* make sure the MFS hasn't been set lower than the default */
 #define MAX_FRAME_SIZE_DEFAULT 0x2600
-	val = (rd32(&pf->hw, I40E_PRTGL_SAH) &
+	val = (rd32(&pf->hw, I40E_PRTGL_SAH(pf->hw.port)) &
 	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 	if (val < MAX_FRAME_SIZE_DEFAULT)
 		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 i, val);
+			 pf->hw.port, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index f408fcf23ce8..75edfe3d43f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -498,7 +498,7 @@
 #define I40E_VSILAN_QBASE_VSIQTABLE_ENA_SHIFT 11
 #define I40E_VSILAN_QBASE_VSIQTABLE_ENA_MASK I40E_MASK(0x1, I40E_VSILAN_QBASE_VSIQTABLE_ENA_SHIFT)
 #define I40E_VSILAN_QTABLE(_i, _VSI) (0x00200000 + ((_i) * 2048 + (_VSI) * 4)) /* _i=0...7, _VSI=0...383 */ /* Reset: PFR */
-#define I40E_PRTGL_SAH 0x001E2140 /* Reset: GLOBR */
+#define I40E_PRTGL_SAH(_PRT) (0x001E2140 + ((_PRT) * 4)) /* _PRT=0...3 */ /* Reset: GLOBR */
 #define I40E_PRTGL_SAH_FC_SAH_SHIFT 0
 #define I40E_PRTGL_SAH_FC_SAH_MASK I40E_MASK(0xFFFF, I40E_PRTGL_SAH_FC_SAH_SHIFT)
 #define I40E_PRTGL_SAH_MFS_SHIFT 16
-- 
2.41.0

