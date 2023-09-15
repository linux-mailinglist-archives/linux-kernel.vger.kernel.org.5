Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBAF7A1BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjIOKEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjIOKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:03:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7294493;
        Fri, 15 Sep 2023 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694772165; x=1726308165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ed4YUZv03FL/7pT0GTcscmk26C9Wo3TferDm4a8fs+I=;
  b=PkhI5gk4YPFyjciC6siFEA9LbLJPsFAkfaJZeJqFi/dGhwtSdkvD6s00
   8LSX8vP8+8cMerKWtRuo3bOlS0v4DPzmcG9Fbl8mmE8Q/fIIdPFz6QqC5
   M2FP9OTDAl2kJ7PB9QI4UoULUS1tVLaw18meFDnstRXYJPktECcz8nZP/
   /mjxNpupZf5ijWN2BBHU/+UBciaCiRjHHAyMzfUO9AMxdrPizOMOa67R/
   k7dr1fx2CCPpHlbr8AQMd2VaUKayTg18iQm54DD/jUKS2wjF8w6xank7c
   ZtnJjkAmrXnYBusn4WvcYCbywdoTx+SQCa6qfKjQqpjuOX1DuqXOj8pEu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381938667"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="381938667"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744916284"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="744916284"
Received: from pglc00032.png.intel.com ([10.221.207.52])
  by orsmga002.jf.intel.com with ESMTP; 15 Sep 2023 02:54:20 -0700
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
        fancer.lancer@gmail.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v6 0/2] net: stmmac: Tx coe sw fallback
Date:   Fri, 15 Sep 2023 17:54:15 +0800
Message-Id: <20230915095417.1949-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
DW xGMAC IP can be synthesized such that it can support tx checksum
offloading only for a few initial tx queues. Also as Serge pointed
out, for the DW QoS IP, tx coe can be individually configured for
each tx queue. This patchset adds support for tx coe sw fallback for
those queues that don't support tx coe. Also, add binding for
snps,coe-unsupported property.

changelog v6:
* Reworked patchset to cover DW QoS Ethernet IP also.

changelog v5:
* As rightly suggested by Serge, reworked redundant code.

changelog v4: 
* Replaced tx_q_coe_lmt with bit flag.

changelog v3: 
* Resend with complete email list.

changelog v2: 
* Reformed binding description.
* Minor grammatical corrections in comments and commit messages.

Rohan G Thomas (2):
  dt-bindings: net: snps,dwmac: Tx coe unsupported
  net: stmmac: Tx coe sw fallback

 Documentation/devicetree/bindings/net/snps,dwmac.yaml |  3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 10 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  3 +++
 include/linux/stmmac.h                                |  1 +
 4 files changed, 17 insertions(+)

-- 
2.25.1

