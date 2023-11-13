Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704F67E9C94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjKMM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjKMM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:59:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC67C1729
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699880346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2n6Jd9cJZiwfOrraes5mYcb5r/O/LRHhuTYwSStRcs=;
        b=Q9T5U5sfC1RVCbEgiquMVxmn+ksd8eK+4ykBXAIoimEgkxaSuQabnziEG0UhrzbB4XT4zy
        d5xhPJd0xR3ydsoIPzZ6ePWe/MKMprWShuXpRsHrhGvSSqtPgiB09RmD5L5KKhdGaiA9vC
        ZdNts1Wze+Lu2nnb0KvWXRyuYKBFgJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-qFwntDouPq-_dXZsz23hbA-1; Mon, 13 Nov 2023 07:59:02 -0500
X-MC-Unique: qFwntDouPq-_dXZsz23hbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A3078007B3;
        Mon, 13 Nov 2023 12:59:01 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84407370;
        Mon, 13 Nov 2023 12:58:59 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Simon Horman <horms@kernel.org>, mschmidt@redhat.com
Subject: [PATCH iwl-next 1/5] i40e: Use existing helper to find flow director VSI
Date:   Mon, 13 Nov 2023 13:58:52 +0100
Message-ID: <20231113125856.346047-2-ivecera@redhat.com>
In-Reply-To: <20231113125856.346047-1-ivecera@redhat.com>
References: <20231113125856.346047-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use existing i40e_find_vsi_by_type() to find a VSI
associated with flow director.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 51ee870ffa36..90966878333c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15645,6 +15645,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #ifdef CONFIG_I40E_DCB
 	enum i40e_get_fw_lldp_status_resp lldp_status;
 #endif /* CONFIG_I40E_DCB */
+	struct i40e_vsi *vsi;
 	struct i40e_pf *pf;
 	struct i40e_hw *hw;
 	u16 wol_nvm_bits;
@@ -15655,7 +15656,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #endif /* CONFIG_I40E_DCB */
 	int err;
 	u32 val;
-	u32 i;
 
 	err = pci_enable_device_mem(pdev);
 	if (err)
@@ -16005,12 +16005,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_LIST_HEAD(&pf->vsi[pf->lan_vsi]->ch_list);
 
 	/* if FDIR VSI was set up, start it now */
-	for (i = 0; i < pf->num_alloc_vsi; i++) {
-		if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
-			i40e_vsi_open(pf->vsi[i]);
-			break;
-		}
-	}
+	vsi = i40e_find_vsi_by_type(pf, I40E_VSI_FDIR);
+	if (vsi)
+		i40e_vsi_open(vsi);
 
 	/* The driver only wants link up/down and module qualification
 	 * reports from firmware.  Note the negative logic.
-- 
2.41.0

