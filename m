Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759527F2D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjKUMeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjKUMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:34:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46E9138;
        Tue, 21 Nov 2023 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700570082; x=1732106082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JOor8boF+dUQadwIIvn/dAw0I268VWJyO3494Evc3UY=;
  b=FzTt21z0tuDU1uaqST+7f90cpxtDrql+nHHx+BIXKW4rJMc+a2W31op0
   KfCoYMO5xKBIcXWv32kaKlIB7zyEmIMsFRJoJSZ4Js/0/A1YiuZfpv+Vs
   q5MKQF6dZB9LX4amkF02pYE2mcLlv7GfqW7bBMH9GevD7UagDjerf8rvs
   VLxH3kiwa4cad25i++OgkNJ/sx89luks5pxemmt0RqY5ApU5TV6MknKAA
   oFg4VY2aM/WNQNK3ktwXmmx2Kno/aawot1rsbQm9CV7xsYM0eYLSj9w1U
   ZvU7m4NKl+kYpQqRcQdqQ++lcQaBLNh9ynOzIiCH8maMsc0v+m8h6yw/p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371165813"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371165813"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 04:34:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="760095975"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="760095975"
Received: from wpastern-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.57.17])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 04:34:36 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/3] net/ethernet/intel: PCI cleanups
Date:   Tue, 21 Nov 2023 14:34:25 +0200
Message-Id: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending these PCI related cleanups for Intel Ethernet drivers. No
other changes except removing the accepted patches in v4.

These can go through the usual driver tree as there are no PCI tree
related dependencies.

v4:
- Removed accepted patches

Ilpo Järvinen (3):
  igb: Use FIELD_GET() to extract Link Width
  e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom
    defines/code
  e1000e: Use pcie_capability_read_word() for reading LNKSTA

 drivers/net/ethernet/intel/e1000e/defines.h |  3 ---
 drivers/net/ethernet/intel/e1000e/mac.c     | 18 ++++++++----------
 drivers/net/ethernet/intel/igb/e1000_mac.c  |  6 +++---
 3 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.30.2

