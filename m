Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B145C7FFB5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376457AbjK3Tbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376388AbjK3Tbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:31:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8292B93
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701372700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XUKjduYx0sBCtPzyCQgJXjX+AsFij/jhpdfQd/PC2MQ=;
        b=KcraI4vPCsrmIED08agHmpQ/68la+sZcJtws8oC1QXEQDK1Qm0g0A3RX4mPY2IIbrdEhO3
        bvnDBum4xJciZ6b79i5v67xAiV2VqJPZydlN8bzP+a+0qybRmlR1dnYINYdS8c16Dw9Q9b
        gsiwnDwlk5faHK8H2JRgKG3gm81CNiI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ruzrkH6zNcqvsDcI07CyeA-1; Thu, 30 Nov 2023 14:31:38 -0500
X-MC-Unique: ruzrkH6zNcqvsDcI07CyeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACBB485A58C;
        Thu, 30 Nov 2023 19:31:37 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 061F31C060AE;
        Thu, 30 Nov 2023 19:31:35 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] i40e: Fix wrong mask used during DCB config
Date:   Thu, 30 Nov 2023 20:31:34 +0100
Message-ID: <20231130193135.1580284-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mask used for clearing PRTDCB_RETSTCC register in function
i40e_dcb_hw_rx_ets_bw_config() is incorrect as there is used
define I40E_PRTDCB_RETSTCC_ETSTC_SHIFT instead of define
I40E_PRTDCB_RETSTCC_ETSTC_MASK.

The PRTDCB_RETSTCC register is used to configure whether ETS
or strict priority is used as TSA in Rx for particular TC.

In practice it means that once the register is set to use ETS
as TSA then it is not possible to switch back to strict priority
without CoreR reset.

Fix the value in the clearing mask.

Fixes: 90bc8e003be2 ("i40e: Add hardware configuration for software based DCB")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 68602fc375f6..073ffbfcbe8d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1576,7 +1576,7 @@ void i40e_dcb_hw_rx_ets_bw_config(struct i40e_hw *hw, u8 *bw_share,
 		reg = rd32(hw, I40E_PRTDCB_RETSTCC(i));
 		reg &= ~(I40E_PRTDCB_RETSTCC_BWSHARE_MASK     |
 			 I40E_PRTDCB_RETSTCC_UPINTC_MODE_MASK |
-			 I40E_PRTDCB_RETSTCC_ETSTC_SHIFT);
+			 I40E_PRTDCB_RETSTCC_ETSTC_MASK);
 		reg |= ((u32)bw_share[i] << I40E_PRTDCB_RETSTCC_BWSHARE_SHIFT) &
 			 I40E_PRTDCB_RETSTCC_BWSHARE_MASK;
 		reg |= ((u32)mode[i] << I40E_PRTDCB_RETSTCC_UPINTC_MODE_SHIFT) &
-- 
2.41.0

