Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD07AF2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjIZS2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjIZS2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E3CCCD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695752841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZhuG50Q5miV4PoSUjX8aTRuuoG/6ZgIoL2i9m/DJWw=;
        b=Ztj4FnWaypRbQIAIIc9HbrpMar3Jb6HqKgO43sn45yEZGh/NGMXBSu/rcLuhwrsn5TB9Yd
        Vy2FGnNR3/3EyL1xJhoLbShaYg4oiDqp+JgppVn9T7QPIhFGf0tVXIk4u5aM/KJ+lNsJWW
        2RTkmHJEIsFMhnvlSjN2aWhFH5sNxG4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-A5drtdzlOamPXT2UA02Ffg-1; Tue, 26 Sep 2023 14:27:17 -0400
X-MC-Unique: A5drtdzlOamPXT2UA02Ffg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EE721C0653D;
        Tue, 26 Sep 2023 18:27:17 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AB3640C6EA8;
        Tue, 26 Sep 2023 18:27:15 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/9] i40e: Move I40E_MASK macro to i40e_register.h
Date:   Tue, 26 Sep 2023 20:27:03 +0200
Message-ID: <20230926182710.2517901-3-ivecera@redhat.com>
In-Reply-To: <20230926182710.2517901-1-ivecera@redhat.com>
References: <20230926182710.2517901-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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

