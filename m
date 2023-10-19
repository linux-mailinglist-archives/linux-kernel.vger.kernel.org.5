Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB87CFBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjJSNyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345498AbjJSNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F782B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697723631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HhuLAtEC9vvHEOX4edXMkoJRK35YOO0BifovbLT07EE=;
        b=h6vOHpXWO6Jm8RLCp14DXSMM8RZMnOzHrwUf2rpXM4De4i/YSPPt19EOtNAszxeLWUrQ12
        wVaSHVHwhYUosVJIqYn9X8eKvArurLc3O/brfK34R0iTUqXUkPh5muzbiS9HBgjndCNaXj
        tXn6AYN0RC/dDc6YRdhGTtqWeyqMYxQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-kWHLDIYfO7KaAiIWsoYliQ-1; Thu, 19 Oct 2023 09:53:47 -0400
X-MC-Unique: kWHLDIYfO7KaAiIWsoYliQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFD1E185A78E;
        Thu, 19 Oct 2023 13:53:45 +0000 (UTC)
Received: from p1.luc.com (unknown [10.45.226.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8BF1111D782;
        Thu, 19 Oct 2023 13:53:43 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Catherine Sullivan <catherine.sullivan@intel.com>,
        Anjali Singhai Jain <anjali.singhai@intel.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR
Date:   Thu, 19 Oct 2023 15:53:42 +0200
Message-ID: <20231019135342.1209152-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I40E_TXR_FLAGS_WB_ON_ITR is i40e_ring flag and not i40e_pf one.

Fixes: 8e0764b4d6be42 ("i40e/i40evf: Add support for writeback on ITR feature for X722")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 0b3a27f118fb97..9c36540846f7a9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2847,7 +2847,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+	if (q_vector->tx.ring[0].flags & I40E_TXR_FLAGS_WB_ON_ITR)
 		q_vector->arm_wb_state = false;
 
 	/* Exit the polling mode, but don't re-enable interrupts if stack might
-- 
2.41.0

