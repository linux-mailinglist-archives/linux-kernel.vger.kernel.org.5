Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4427AFE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjI0Ica (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjI0Ic2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8CD6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695803506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZhuG50Q5miV4PoSUjX8aTRuuoG/6ZgIoL2i9m/DJWw=;
        b=eEJJ9PkLI/5gySgt8aE9/IQxfSpQM4bYYF9coM0ns3pkSWNA8btU+7gBCZBr54l/FXiMqH
        92S4jWMYYCDJ5wsaUMgrI8cucaqYkeemwWAraFkMmc1G0yQ1hqWKMvfDJj1RNZgWkIuyW7
        PI9U18NdENswGwLkICHc1u/R1bbcTMY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-j5NcLO0XOpqxZd7AaWyadw-1; Wed, 27 Sep 2023 04:31:42 -0400
X-MC-Unique: j5NcLO0XOpqxZd7AaWyadw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F5F08002B2;
        Wed, 27 Sep 2023 08:31:42 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 817FD215670B;
        Wed, 27 Sep 2023 08:31:40 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v2 2/9] i40e: Move I40E_MASK macro to i40e_register.h
Date:   Wed, 27 Sep 2023 10:31:28 +0200
Message-ID: <20230927083135.3237206-3-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-1-ivecera@redhat.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro is practically used only in i40e_register.h header file except
few I40E_MDIO_CLAUSE* macros that are defined in i40e_type.h
Move I40E_MASK macro to i40e_register.h header, I40E_MDIO_CLAUSE* macros
are refactored in subsequent patch.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 3 +++
 drivers/net/ethernet/intel/i40e/i40e_type.h     | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 7339003aa17c..eebb5735772b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -4,6 +4,9 @@
 #ifndef _I40E_REGISTER_H_
 #define _I40E_REGISTER_H_
 
+/* I40E_MASK is a macro used on 32 bit registers */
+#define I40E_MASK(mask, shift) ((u32)(mask) << (shift))
+
 #define I40E_GL_ATQLEN_ATQCRIT_SHIFT 30
 #define I40E_GL_ATQLEN_ATQCRIT_MASK I40E_MASK(0x1, I40E_GL_ATQLEN_ATQCRIT_SHIFT)
 #define I40E_PF_ARQBAH 0x00080180 /* Reset: EMPR */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 658bc8913278..60b55d66d648 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -11,9 +11,6 @@
 #include "i40e_lan_hmc.h"
 #include "i40e_devids.h"
 
-/* I40E_MASK is a macro used on 32 bit registers */
-#define I40E_MASK(mask, shift) ((u32)(mask) << (shift))
-
 #define I40E_MAX_VSI_QP			16
 #define I40E_MAX_VF_VSI			4
 #define I40E_MAX_CHAINED_RX_BUFFERS	5
-- 
2.41.0

