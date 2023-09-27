Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BADF7B0587
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjI0Ndk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjI0Ndi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:33:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E010A;
        Wed, 27 Sep 2023 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695821616; x=1727357616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=87RSjtyu4aWewiUFDtZNG4QP/LSZrmCD8Y7LqGpGn4w=;
  b=mSm3VXO2umwRjg7pfglv5/Yjs+n/ikJiyEx1HNi7rjJzPp4U+2W3Rq2p
   WZDLx1BM8Io5iybcL4QPdVKTjNtQ7knC0Akt5ALaGPphhywjqt0G9840u
   66G/3vPFrPTIHx9CoydK4DT7+8JevQrPLkUyrD3qdaMoogs42/QauJpBw
   YlnXicM8bvcVwbRQCnru+w7ZiPS7QVtiYBbii7MsgLUwfFPIBjWI4xNtv
   tlEDEERy3mpRVL0Sa6yPkDWgBP9b6bGJanFwLIlu2TWNVvGS1vo0cT5uY
   9UJxxEM5a98++5mfg4m9LEN9zXrk03E616cV3k7+aD7VEddBhGhk5DQ4v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="380700729"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="380700729"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="698866950"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="698866950"
Received: from pglc00352.png.intel.com ([10.221.235.155])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2023 06:09:32 -0700
From:   Rohan G Thomas <rohan.g.thomas@intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Time Based Scheduling
Date:   Wed, 27 Sep 2023 21:09:18 +0800
Message-Id: <20230927130919.25683-2-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230927130919.25683-1-rohan.g.thomas@intel.com>
References: <20230927130919.25683-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new property tbs-enabled to enable Time Based Scheduling(TBS)
support per Tx queues. TBS feature can be enabled later using ETF
qdisc but for only those queues that have TBS support enabled.

Commit 7eadf57290ec ("net: stmmac: pci: Enable TBS on GMAC5 IPK PCI
entry") enables similar support from the stmmac pci driver.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..db1eb0997602 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -399,6 +399,14 @@ properties:
             type: boolean
             description: TX checksum offload is unsupported by the TX queue.
 
+          snps,tbs-enabled:
+            type: boolean
+            description:
+              Enable Time Based Scheduling(TBS) support for the TX queue. TSO and
+              TBS cannot be supported by a queue at the same time. If TSO support
+              is enabled, then default TX queue 0 for TSO and in that case don't
+              enable TX queue 0 for TBS.
+
         allOf:
           - if:
               required:
-- 
2.26.2

