Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9913080036A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377563AbjLAFxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377548AbjLAFxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:53:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F323170C;
        Thu, 30 Nov 2023 21:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701410020; x=1732946020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=72Q5T4Gt/E6LRMKubjDuW89gTEGgYKk1Pow/mso1yHI=;
  b=BiBQsozW9SdCP0I3CONN7NslERUvByyjsKmtjqQY0U7u2B+/iWQyvE4e
   M0kweCVy1jo8ZBQdAWh1znJChCNmGOopxcIEPN9Cy+OGn9BKGZ038XPdI
   3KT2aDrCTBgAY9qmqNn44ptCeaLaj2WjpXxYo/DHJI5+gnEG7uH6XNWqx
   ylPdMTSXPjkb9wm9IBC+3P+vSa95oHpa8OXY7j7vzLUzh1IqMoNnrD4/A
   vI/W3WdoQ1l03ybeUJdiFh9GW6X8GeRceX6OJPqfFiu4V5kdmbml34NZj
   R01JAgIDPdGPrneyFcSEtny8nFPU1Eeutvi9IuD+xOs+GI0rh1x5X5D6y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="373624051"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="373624051"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 21:53:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="763004581"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="763004581"
Received: from ppgyli0104.png.intel.com ([10.126.160.64])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2023 21:53:33 -0800
From:   Rohan G Thomas <rohan.g.thomas@intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Rohan G Thomas <rohan.g.thomas@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 3/3] net: stmmac: Add support for EST cycle-time-extension
Date:   Fri,  1 Dec 2023 13:52:52 +0800
Message-Id: <20231201055252.1302-4-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231201055252.1302-1-rohan.g.thomas@intel.com>
References: <20231201055252.1302-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for cycle-time-extension. TER GCL-register needs to be
updated with the cycle-time-extension. Width of TER register is EST
time interval width + 7 bits.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index d4ee4684bc70..287767f6d671 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -975,6 +975,8 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		return -EINVAL;
 	if (!qopt->cycle_time)
 		return -ERANGE;
+	if (qopt->cycle_time_extension >= BIT(wid + 7))
+		return -ERANGE;
 
 	if (!plat->est) {
 		plat->est = devm_kzalloc(priv->device, sizeof(*plat->est),
@@ -1041,6 +1043,8 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 	priv->plat->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
 	priv->plat->est->ctr[1] = (u32)ctr;
 
+	priv->plat->est->ter = qopt->cycle_time_extension;
+
 	if (fpe && !priv->dma_cap.fpesel) {
 		mutex_unlock(&priv->plat->est->lock);
 		return -EOPNOTSUPP;
-- 
2.26.2

