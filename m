Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A5777B95
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjHJPFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:05:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F62026B2;
        Thu, 10 Aug 2023 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691679947; x=1723215947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z+1vviIBmgueRkTK+vn9A1VWVZa0pIGPVtXHtItRiqE=;
  b=RqCLzc4SXsuFF1sxBDEFToCevjZWwceJ5ojomEOUS5cl2F+aG3818fTI
   rU2hVhORYVqOhJtIyCFVdz/YsYPrCP7xDCQLzD/C41XQeP2SGZwbugJi8
   oA7/lY6LkriSZNSS6OpGPlAEq5g9whOj1dAIiKp5dIWHc4EKp7J/Dp85H
   BpmVR3djGiMJP0ZNyoj8CKE4QC6NJY4EcfOdxa9FGui5fbIx090KCkTWJ
   PnY6xFUHc0vYAcmsRPj47ofaUMtTiBfGCC84rf6Y0pNZW5z82gmveC1LI
   J+lVclxD5ivR4PvJ0qFAUpakIyRY3iPa1UMg5v0KV/ni2dPRCbQi6o0Jn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="368901620"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="368901620"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="978821424"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="978821424"
Received: from pglc00052.png.intel.com ([10.221.207.72])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2023 08:03:38 -0700
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
        Conor Dooley <conor+dt@kernel.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next 0/2] Tx coe sw fallback for unsupported queues
Date:   Thu, 10 Aug 2023 23:03:26 +0800
Message-Id: <20230810150328.19704-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.19.0
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

Hi,
Some DWMAC IPs support tx coe only for few initial tx queues, starting 
from tx queue 0. This patchset adds support for tx coe sw fallback for 
those queue that doesn't support tx coe. Also, add binding for
snps,tx-queues-with-coe property.

Rohan G Thomas (2):
  dt-bindings: net: snps,dwmac: Tx queues with coe
  net: stmmac: Tx coe sw fallback

 .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 ++++
 include/linux/stmmac.h                        |  1 +
 5 files changed, 29 insertions(+)

-- 
2.26.2

