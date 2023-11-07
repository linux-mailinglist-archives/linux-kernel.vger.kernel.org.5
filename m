Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F587E4135
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbjKGNw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjKGNwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:52:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B2BEA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699365085; x=1730901085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E01dNaIZ7sifAyHCTfEZLk4oJc1QCnh6hSfZPqfKYJw=;
  b=bg6isNIhpvpwM/GffXu77wBNmPE3RPKzVZWnt3zgNmIScuxSS/wJS0Fj
   h5IO/mhMgxCJS8c/j88qum79ijmLuqz3mLqygI86adAsN50vkwcrMzx1B
   uWc//uuwHIzthNauO1QWWplKXPDYA9Kmqp2rHqqEuc/Th2w1b1OTORk60
   rT3TDLQro2yiUAdJGNTAmYXbJpYwY/5aaxq28c+x6Nzf9O5CwzEzqnfeh
   zet3PjX8Z75glbHYueiOv+Q4m9grsB2XcQnC3mnSLo77I5whJoPdSX/xG
   obU4o5haHMczdaiesIoZMXPCNf/tuw/tGQQot708BvL0kUkrspqrR2fHB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="420618963"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="420618963"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 05:51:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762705078"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="762705078"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 05:51:22 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mei: hdcp/pxp: adapt for Xe driver
Date:   Tue,  7 Nov 2023 15:46:01 +0200
Message-Id: <20231107134606.316651-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Alexander Usyskin (5):
  Revert "mei/hdcp: Also enable for XE"
  mei: hdcp: match without driver name
  mei: pxp: match without driver name
  mei: hdcp: add dependency on Xe driver
  mei: pxp: add dependency on Xe driver

 drivers/misc/mei/hdcp/mei_hdcp.c | 15 ++++++++++++---
 drivers/misc/mei/pxp/Kconfig     |  3 +--
 drivers/misc/mei/pxp/mei_pxp.c   | 14 ++++++++++++--
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.34.1

