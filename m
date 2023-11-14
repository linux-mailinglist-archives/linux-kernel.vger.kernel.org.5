Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6317EADB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjKNKOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKNKN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:13:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DB8197
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699956835; x=1731492835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=czLBxCG0ycMVlzSI8YTc4LkTPbQ2ByuuFTnPd0JyF1A=;
  b=k27v+xpK+QpHksd2FiUEoaiNjXoaWuiw1ox8ySTKCW/oJsqI2rqMIHsr
   NRQt2heVAsKjId/DB5V/ruBVnbde5NrWYYnOwbmIak/y0pjrMgtNNS+KO
   o8SPjZ8fduquhhO1x9vkstKBiHvioCiqnf+7aWjvShpGT4KXNBtUA9XSC
   XNssORDr7LJxJSCmvg23gntHp3y0xKrgV1nUqMlEQT76+2LntsL9y8IyJ
   IHiB2gYeV0m2bSf3fp4DDkHWuEMnJYuSnIX2WCFV1qtNLb9o+8M8XRgDY
   74nNclNKtJJATrIt9qnE1KhskVPDbkI6u88yUVjgFAfZvEwm4P2uCzw8+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375669075"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="375669075"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:13:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="5974142"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:13:53 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] mei: hdcp/pxp: adapt for Xe driver
Date:   Tue, 14 Nov 2023 12:08:38 +0200
Message-Id: <20231114100843.1923977-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update mei-hdcp and mei-pxp drivers to work with Xe driver
alongside with i195 driver.
Revert previous partial attempt.
Update match functions to match without driver name
and update module dependencies to optionally depend on Xe.

GregKH: this series intended to bake and merge through drm-xe tree
where Xe driver is developed.

V2:
 - drop first empty line cleanup, will be sent separately
 - add commit message to revert patch

Alexander Usyskin (5):
  Revert "mei/hdcp: Also enable for XE"
  mei: hdcp: match without driver name
  mei: pxp: match without driver name
  mei: hdcp: add dependency on Xe driver
  mei: pxp: add dependency on Xe driver

 drivers/misc/mei/hdcp/mei_hdcp.c | 15 ++++++++++++---
 drivers/misc/mei/pxp/Kconfig     |  2 +-
 drivers/misc/mei/pxp/mei_pxp.c   | 14 ++++++++++++--
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.34.1

