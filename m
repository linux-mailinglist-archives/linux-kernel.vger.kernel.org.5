Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE017F91FB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjKZJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:24:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE450107
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700990702; x=1732526702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2XRi+Mv1Pe4HCxVW5KKaethFp6rjHDK3FWrG09d6Yl8=;
  b=jQm8Ac8kRJlyHS5MQx9Sc8Tm7tlm35rVIrAX9fOevp6XzCrCJxh6g1Xz
   khFDF3H+4tTXZK0n8VtcpBN6pOaj6RSWxHHEvGaOHcqphaEm+2W1cT33E
   ob+QmTZHqB6+dWag8vUImnlg10xDwTdwhOD1yFI/IRudqvOfZZzABr3VE
   DITTCcVHk2zFPok4yGWFM9feZusDch85VyS7DAy9AjBpPsmGANHdBRvx8
   Z/Mc6gWUOlA6pPXbXbnT87sa+IDEAtvt66nzJH5tKY+yTnppHGVjbLypt
   Clcjd1HnKKZ0Wpvltu8WXdVNF7/Z7whGHl84473AVFbtWBYo2dThG23ur
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="396462118"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="396462118"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 01:25:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="9515856"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 01:25:00 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-linus for v6.7-rc3 V2] mei: pxp: fix mei_pxp_send_message return value
Date:   Sun, 26 Nov 2023 11:24:49 +0200
Message-ID: <20231126092449.88310-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.43.0
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

From: Alexander Usyskin <alexander.usyskin@intel.com>

mei_pxp_send_message() should return zero on success and
cannot propagate number of bytes as returned by internally
called mei_cldev_send().

Fixes: ee5cb39348e6 ("mei: pxp: recover from recv fail under memory pressure")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: This is a resent for https://lkml.org/lkml/2023/10/31/636
 drivers/misc/mei/pxp/mei_pxp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index f77d78fa50549e69f0a0873b..787c6a27a4be60f9322c6aad 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -84,9 +84,10 @@ mei_pxp_send_message(struct device *dev, const void *message, size_t size, unsig
 				byte = ret;
 			break;
 		}
+		return byte;
 	}
 
-	return byte;
+	return 0;
 }
 
 /**
-- 
2.43.0

