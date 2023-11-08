Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD7B7E5AC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjKHQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKHQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:02:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1FC1BD7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699459273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rQ51b9eM0IFRwZBnxfiG5qJhLYeuJ0C09QIPA+aM9L8=;
        b=fAihju2MQ0Jq7f/+fCZ7Gjhu2di3FL0HbYqDuIK1L/TG1FIaWPyaIqihuFwgd15I3VVZWZ
        ee/Y412Jkfk73/fvNMjFNPWhpUqSZhnT2kDKvX+zscy9wNXYHAesKFZtOaWeB5Wb/y2xuZ
        UfUpguQnmAtZl5nTT0RINOCjHdoDw2s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-3s9y6T4AMICaPuwOeGB2SA-1; Wed,
 08 Nov 2023 11:01:08 -0500
X-MC-Unique: 3s9y6T4AMICaPuwOeGB2SA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A634A3810D35;
        Wed,  8 Nov 2023 16:01:06 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C75042166B27;
        Wed,  8 Nov 2023 16:01:04 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Neerav Parikh <neerav.parikh@intel.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] i40e: Fix waiting for queues of all VSIs to be disabled
Date:   Wed,  8 Nov 2023 17:01:03 +0100
Message-ID: <20231108160104.86140-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function i40e_pf_wait_queues_disabled() iterates all PF's VSIs
up to 'pf->hw.func_caps.num_vsis' but this is incorrect because
the real number of VSIs can be up to 'pf->num_alloc_vsi' that
can be higher. Fix this loop.

Fixes: 69129dc39fac ("i40e: Modify Tx disable wait flow in case of DCB reconfiguration")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6a2907674583..de19d753ba83 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5340,7 +5340,7 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
 {
 	int v, ret = 0;
 
-	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
+	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v]) {
 			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
 			if (ret)
-- 
2.41.0

