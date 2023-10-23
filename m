Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FED7D3C93
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjJWQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjJWQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5090D7A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698078581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3ZRVRPYlzLKSEwVSMpWF6MYksG9m8/cnJFghvaOFDE=;
        b=LjpUOCqkESYv3dWDs6xdAjksCdZcQ2oGGKl4Le/eAzMWzIoMVWjsKu60/S7hZgudsJ0K4i
        JHWUpHY/I1sF0MveoP9CLBCIORaRqA9ypg0D9ydcs/iY3fN6qG3vQNu5PHGaTy8R9gn6f9
        1pl6JT1y9m7S9I77WFOMJVurziAy2vE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-PBYY7xKIOQSo5EZ1aDcToA-1; Mon, 23 Oct 2023 12:29:38 -0400
X-MC-Unique: PBYY7xKIOQSo5EZ1aDcToA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7747D185AD0A;
        Mon, 23 Oct 2023 16:29:36 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 922AC25C0;
        Mon, 23 Oct 2023 16:29:34 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>, mschmidt@redhat.com,
        dacampbe@redhat.com, poros@redhat.com
Subject: [PATCH iwl-next 2/3] i40e: Add other helpers to check version of running firmware and AQ API
Date:   Mon, 23 Oct 2023 18:29:27 +0200
Message-ID: <20231023162928.245583-3-ivecera@redhat.com>
In-Reply-To: <20231023162928.245583-1-ivecera@redhat.com>
References: <20231023162928.245583-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another helper functions that will be used by subsequent
patch to refactor existing open-coded checks whether the version
of running firmware and AdminQ API is recent enough to provide
certain capabilities.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_type.h | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 050d479aeed3..bb62c14aa3d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -608,6 +608,60 @@ static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
 		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
 }
 
+/**
+ * i40e_is_aq_api_ver_lt
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current HW API version is less than provided.
+ **/
+static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return !i40e_is_aq_api_ver_ge(hw, maj, min);
+}
+
+/**
+ * i40e_is_fw_ver_ge
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is greater/equal than provided.
+ **/
+static bool inline i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
+{
+        return (hw->aq.fw_maj_ver > maj ||
+                (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));
+}
+
+/**
+ * i40e_is_fw_ver_lt
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is less than provided.
+ **/
+static bool inline i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return !i40e_is_fw_ver_ge(hw, maj, min);
+}
+
+/**
+ * i40e_is_fw_ver_eq
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is equal to provided.
+ **/
+static bool inline i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
+{
+        return (hw->aq.fw_maj_ver > maj ||
+                (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
+}
+
 struct i40e_driver_version {
 	u8 major_version;
 	u8 minor_version;
-- 
2.41.0

