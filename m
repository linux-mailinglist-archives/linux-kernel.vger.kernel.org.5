Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5057CA8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjJPNKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjJPNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF050E8;
        Mon, 16 Oct 2023 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461790; x=1728997790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FpyMkWTaSMiOJg/zrSh3Kkfek6DFC2dej1hPH9Rx2iI=;
  b=iti1+qk5lLoIzKFMKfK9pGJ5Yv8dq8063BbTdUPgcRor8F6cef0JEGqW
   xvgElhXeErzxXAaLXW0Yy4CMdzka19oO51AGa3DQOuWfqBKg0YRxDvkmD
   3gLwROnzSVvK3SRu2+lQvc1lvy74G401TvAJyuCY9L1rurOZ5/q1VXsTI
   zdclEqF4aXxXLMT1H+u1EdoMjb+6ekV5ovdTv5/XnDGVgCR1qGTDHdVSE
   ysJgkhoxKtEygCcfG36Hwo+vygqegbk1MxYcv9KjmOudcWeq+axuBQWB8
   3R6edTTdMnYmwKLgI3jxCJG0mZ3rLWm1JG9sgBmZsLBYWfMCQddplocPo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4133291"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4133291"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1087067135"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087067135"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 06:09:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB53B385; Mon, 16 Oct 2023 16:09:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 00/10] xhci: dbc: Update driver to use modern APIs
Date:   Mon, 16 Oct 2023 16:09:24 +0300
Message-Id: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update driver to use some of modern APIs. It's not a full clean up
series, just a set of ad-hoc changes.

In v2:
- fixed mistakes pointed by Mathias and LKP
- sent with a cover letter

Andy Shevchenko (10):
  xhci: dbc: Drop duplicate checks for dma_free_coherent()
  xhci: dbc: Convert to use sysfs_streq()
  xhci: dbc: Use sysfs_emit() to instead of scnprintf()
  xhci: dbc: Use ATTRIBUTE_GROUPS()
  xhci: dbc: Check for errors first in xhci_dbc_stop()
  xhci: dbc: Don't shadow error codes in store() functions
  xhci: dbc: Replace custom return value with proper Linux error code
  xhci: dbc: Use sizeof_field() where it makes sense
  xhci: dbc: Use sizeof(*pointer) instead of sizeof(type)
  xhci: dbc: Add missing headers

 drivers/usb/host/xhci-dbgcap.c | 132 +++++++++++++++++----------------
 drivers/usb/host/xhci-dbgcap.h |   1 +
 2 files changed, 70 insertions(+), 63 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

