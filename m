Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EA576BE55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjHAUNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHAUNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:13:30 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B74EB1;
        Tue,  1 Aug 2023 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690920809; x=1722456809;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=NeJN8F4X63iN++kJnkzTRl/LpBnHdF5EROGjeqP4Mg0=;
  b=X1VnuTorY9O8LDeZEVla+26XsoFf0zsR2JJIXktDO2mM8tkb0kioVBKo
   cry+aJyREPhK63e8nNwMn5yFYA9Wlo+9p8+sDpuZW/YhmzcJ4v+2vbCvw
   Hs/kkWfV/CMI2c13li3JdhNvGGr8DW95LZjYqt04ibxbFauByCYTnchmW
   r/oyzK4krRRzXKeOcIwBfURxk8Y+uLI/qGeFdcg6PJdp8+SohIse4MimB
   6tiRgH0N1Fh1cIjB7dx1IuCvDK3Tq1PTCECBeyJy2T9F+mJxAA8eNatOB
   9xSqY/Imsn0uQbKmuDQeu8aGwZ5rIS3NN6OWn9vzRhLsdHcxCudIGint0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369403663"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="369403663"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794320081"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="794320081"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.100.136])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:13:28 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/2] CXL/events: Fix and improve event dev_dbg()
 messages
Date:   Tue, 01 Aug 2023 13:13:27 -0700
Message-Id: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdnyWQC/42OTQ6CMBCFr0K6dkxbBNSV9zAs+jNAE2jJFBsM4
 e4WTuBuvveS783GIpLDyJ7FxgiTiy74DPJSMDMo3yM4m5lJLkvelALMOkLnVjAjKgJM6BewqD8
 9zOTyXeqqsYrjo6oNyxatIoIm5c1weCYVF6SjmAmz55x+t5kHF5dA3/OTJI70/9EkQMBNGl7fu
 4pzK145xfFqwsTafd9/TigZP+cAAAA=
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690920808; l=638;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=NeJN8F4X63iN++kJnkzTRl/LpBnHdF5EROGjeqP4Mg0=;
 b=j6LRYS/DXpPmT5OI6xpvckODQIYMUhRNYiB0Re6A43qUNvgC38Cf7al0/V2ifLA1bhNYk/h7M
 o6ulr6FfIo3AzlulNVWnVByKMIW90hGkkYV9HpUuePcK05O8UAogG/e
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- [Dan] split fix from additional debug message
- Link to v1: https://lore.kernel.org/r/20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com

---
Ira Weiny (2):
      cxl/mbox: Use correct handle in events debug message
      cxl/mbox: Add handle to event processing debug

 drivers/cxl/core/mbox.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230731-cxl-fix-clear-event-debug-print-3b57da0e956c

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

