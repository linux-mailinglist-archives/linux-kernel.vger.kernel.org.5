Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCF77FC64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353762AbjHQQzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353777AbjHQQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:55:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34952D5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692291306; x=1723827306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RujW2N3uO01DgE6BAuRaR/5KHZ9jfA5AxZTtUkVCwQI=;
  b=jkeCSuHHeQoYeumLFZldPdA6IFGaQvJXu3V3tHX97O2AJfz4PC5kbvuZ
   rzZHqDJ44FXRPi4O6UH1nkK4WG5nP3mCRkIFz1R3jctY1z+P7yOvdgDiC
   N74xA5BtwExNluGw6M/AYsmFCfdWHM6oEle0J7vRsdB0TB/JBDI/d+qax
   LrySg3ccyHXS6Jd7iwsks2rhLHszMKA4JMc8tDHwsDfo8JLF3p9qBKRdU
   iNeJiJoarB/tsEpJtqNjmHU9WZZ/ABLwUwK5pyUtuG8uWhwuv9HjMbdLI
   +aBspSpTZohb4YPAk2f9fVDBIQnnl1MElxCslm95GDEG007V7ylfQwmE2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375651655"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="375651655"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="737788824"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="737788824"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 09:54:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C9E7DE4; Thu, 17 Aug 2023 19:54:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [rfc, rft, PATCH v1 0/2] bitmap: clean up and (micro?)optimization
Date:   Thu, 17 Aug 2023 19:54:51 +0300
Message-Id: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to discuss the idea, which is represented by these two
patches. Comments, remarks, tests are all welcome!

Andy Shevchenko (2):
  bitmap: Use constants and macros from bits.h
  bitmap: Optimize memset() calls

 include/linux/bitmap.h | 26 +++++++++++++++++---------
 lib/bitmap.c           |  4 ++--
 2 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

