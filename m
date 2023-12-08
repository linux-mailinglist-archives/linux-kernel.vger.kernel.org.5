Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C66180A77B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574339AbjLHPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLHPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:33:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F8FB;
        Fri,  8 Dec 2023 07:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702049613; x=1733585613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fBpBvVgDI3VB/uh0uVrS3zppoHSQdeCuhhTEagLg3nA=;
  b=kFJdJfaP1qyVJik2WCEKikSgsEJPDqXGenDfSVwPH8wxDUBuijLaz0My
   7szgX0v4uywLuB8TQYy1JBL8Np11kTC4eAL5KIrQGyXFcZ4cZ4Of/DemR
   Ts1/NUQxCXBkl5yQ1Si9+Mq9xBSMoIwysXFlgWXDmeMDVzB/8ECMnh1CH
   j9BSes9EY7LdmF/RfLTBWHCF4AOBkH1WM/MQs9n2gQOP/68aGfhcH/ncN
   asCM4FvwlEYkOu6BISyj47ta3UfjggSGjbSAcdAVKZFHd7YGgqbAepiOs
   z4xb9OhXw2HjrUPhr917ufB2eq6ZXEzoWEVsUzrU2xrHR3tRcM0naDDLC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="397211578"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="397211578"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 07:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="772156050"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="772156050"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2023 07:33:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7B744154; Fri,  8 Dec 2023 17:33:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH net-next v1 1/1] net: dl2k: Use proper conversion of dev_addr before IO to device
Date:   Fri,  8 Dec 2023 17:33:27 +0200
Message-ID: <20231208153327.3306798-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is using iowriteXX()/ioreadXX() APIs which are LE IO
accessors simplified as

  1. Convert given value _from_ CPU _to_ LE
  2. Write it to the device as is

The dev_addr is a byte stream, but because the driver uses 16-bit
IO accessors, it wants to perform double conversion on BE CPUs,
but it took it wrong, as it effectivelly does two times _from_ CPU
_to_ LE. What it has to do is to consider dev_addr as an array of
LE16 and hence do _from_ LE _to_ CPU conversion, followed by implied
_from_ CPU _to_ LE in the iowrite16().

To achieve that, use get_unaligned_le16(). This will make it correct
and allows to avoid sparse warning as reported by LKP.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312030058.hfZPTXd7-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index db6615aa921b..7bfeae04b52b 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -565,8 +565,7 @@ static void rio_hw_init(struct net_device *dev)
 	 * too. However, it doesn't work on IP1000A so we use 16-bit access.
 	 */
 	for (i = 0; i < 3; i++)
-		dw16(StationAddr0 + 2 * i,
-		     cpu_to_le16(((const u16 *)dev->dev_addr)[i]));
+		dw16(StationAddr0 + 2 * i, get_unaligned_le16(&dev->dev_addr[2 * i]));
 
 	set_multicast (dev);
 	if (np->coalesce) {
-- 
2.43.0.rc1.1.gbec44491f096

