Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC03793E7E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbjIFOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIFOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377810D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694009659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3LS+PCrZ9Y+5x4zHwbiw3gcL0/Pd5/+nV+sWy8MMaWE=;
        b=gPtiZqsRvNjBhQYD4qZ7KjndEysBXRwKHpnXrCoT8OwIT8rzS/mSNbuXaszLt9xsAStSw1
        TUvGbq8aasS9BlMHSzejoq9LSEuj6MQnp6NkIG1BjKO1HrICanLEc82isHe4JTuXHh9mR0
        XaZAt+s3lYU88l/QLtbdB673NmzEgJA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-UT3cyqdiMY-V2igVRSxDVA-1; Wed, 06 Sep 2023 10:14:14 -0400
X-MC-Unique: UT3cyqdiMY-V2igVRSxDVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A52123822555;
        Wed,  6 Sep 2023 14:14:13 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.225.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2FB61121314;
        Wed,  6 Sep 2023 14:14:11 +0000 (UTC)
From:   Petr Oros <poros@redhat.com>
To:     netdev@vger.kernel.org
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org, mschmidt@redhat.com,
        ivecera@redhat.com
Subject: [PATCH net 1/2] iavf: add iavf_schedule_aq_request() helper
Date:   Wed,  6 Sep 2023 16:14:10 +0200
Message-ID: <20230906141411.121142-1-poros@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper for set iavf aq request AVF_FLAG_AQ_* and imediately
schedule watchdog_task. Helper will be used in cases where it is
necessary to run aq requests asap

Signed-off-by: Petr Oros <poros@redhat.com>
Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h         |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 10 ++++------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 85fba85fbb232b..e110ba3461857b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -521,7 +521,7 @@ void iavf_down(struct iavf_adapter *adapter);
 int iavf_process_config(struct iavf_adapter *adapter);
 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
 void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags);
-void iavf_schedule_request_stats(struct iavf_adapter *adapter);
+void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64 flags);
 void iavf_schedule_finish_config(struct iavf_adapter *adapter);
 void iavf_reset(struct iavf_adapter *adapter);
 void iavf_set_ethtool_ops(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index a34303ad057d00..90397293525f71 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -362,7 +362,7 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
 	unsigned int i;
 
 	/* Explicitly request stats refresh */
-	iavf_schedule_request_stats(adapter);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_REQUEST_STATS);
 
 	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7b300c86ceda73..86d472dfdbc10c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -314,15 +314,13 @@ void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags)
 }
 
 /**
- * iavf_schedule_request_stats - Set the flags and schedule statistics request
+ * iavf_schedule_aq_request - Set the flags and schedule aq request
  * @adapter: board private structure
- *
- * Sets IAVF_FLAG_AQ_REQUEST_STATS flag so iavf_watchdog_task() will explicitly
- * request and refresh ethtool stats
+ * @flags: requested aq flags
  **/
-void iavf_schedule_request_stats(struct iavf_adapter *adapter)
+void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64 flags)
 {
-	adapter->aq_required |= IAVF_FLAG_AQ_REQUEST_STATS;
+	adapter->aq_required |= flags;
 	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
 }
 
-- 
2.42.0

