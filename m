Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0D7525D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjGMO7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjGMO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBB22D74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689260284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oL/Daj3H+kT6hkli1QIioUjzvo7OTPi2aNIjM7rXu8k=;
        b=AfWMX4ITMMjqd1ZzByNWYdvFXxDkSWkxUEzyKpogG0ApdlcLKT8YyBYacdBFEEnqLwIM3k
        n0ohj2Wxqaq7iGv5a1OdUcKSXQGgMPyXAcKlIcKzOC6PMneytrMU5lADOSZCOI3Oyx2iWY
        aBWrfSkA+ly07lkX8BNWSVK6kIDabIU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-AyF78o2TOvGLHZDMVG36XQ-1; Thu, 13 Jul 2023 10:58:00 -0400
X-MC-Unique: AyF78o2TOvGLHZDMVG36XQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8726B28EC100;
        Thu, 13 Jul 2023 14:57:59 +0000 (UTC)
Received: from p1.luc.cera.cz.com (unknown [10.45.224.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9137940C2063;
        Thu, 13 Jul 2023 14:57:57 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Simon Horman <simon.horman@corigine.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Ma Yuying <yuma@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 1/2] i40e: Add helper for VF inited state check with timeout
Date:   Thu, 13 Jul 2023 16:57:54 +0200
Message-ID: <20230713145755.1629442-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the check for VF inited state (with optional up-to 300ms
timeout to separate helper i40e_check_vf_init_timeout() that
will be used in the following commit.

Tested-by: Ma Yuying <yuma@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 49 +++++++++++++------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index be59ba3774e1..b203465357af 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4304,6 +4304,38 @@ static int i40e_validate_vf(struct i40e_pf *pf, int vf_id)
 	return ret;
 }
 
+/**
+ * i40e_check_vf_init_timeout
+ * @vf: the virtual function
+ *
+ * Check that the VF's initialization was successfully done and if not
+ * wait up to 300ms for its finish.
+ *
+ * Returns true when VF is initialized, false on timeout
+ **/
+static bool i40e_check_vf_init_timeout(struct i40e_vf *vf)
+{
+	int i;
+
+	/* When the VF is resetting wait until it is done.
+	 * It can take up to 200 milliseconds, but wait for
+	 * up to 300 milliseconds to be safe.
+	 */
+	for (i = 0; i < 15; i++) {
+		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
+			return true;
+		msleep(20);
+	}
+
+	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
+		dev_err(&vf->pf->pdev->dev,
+			"VF %d still in reset. Try again.\n", vf->vf_id);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * i40e_ndo_set_vf_mac
  * @netdev: network interface device structure
@@ -4322,7 +4354,6 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	int ret = 0;
 	struct hlist_node *h;
 	int bkt;
-	u8 i;
 
 	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
 		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
@@ -4335,21 +4366,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		goto error_param;
 
 	vf = &pf->vf[vf_id];
-
-	/* When the VF is resetting wait until it is done.
-	 * It can take up to 200 milliseconds,
-	 * but wait for up to 300 milliseconds to be safe.
-	 * Acquire the VSI pointer only after the VF has been
-	 * properly initialized.
-	 */
-	for (i = 0; i < 15; i++) {
-		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
-			break;
-		msleep(20);
-	}
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
-			vf_id);
+	if (!i40e_check_vf_init_timeout(vf)) {
 		ret = -EAGAIN;
 		goto error_param;
 	}
-- 
2.41.0

