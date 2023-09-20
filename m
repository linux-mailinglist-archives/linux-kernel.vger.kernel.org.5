Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E67A77DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjITJqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjITJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:46:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79609A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695203172; x=1726739172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u4voPDQa+cnIPzLkG1HPDN3ibxpjo/+rdfse8VD10ts=;
  b=fgFT5ghBD4Mb7XZzvXndz3o4Fun5oXerI4TX67AZcacxx+f3dA0gIiLp
   FYoM/phDd2rd/GiYefsE071fNkfC31KV9++WSC9D2PevCr/RlUH9/i06F
   3QbkOmzxzC9b9QGzrzdWh8n22pj+SAlTvbQKzCblsJN5EyMNnCsSXBk4v
   ZsscvQQTD0xloyAF3q3GRekOZZ2nHN9mBUzGnCPrWY5BSeRMokJ64eyH2
   ebuwp/J4ZODYUwqm2TLrZ0m6L0+6QEiA+5V07Cdil3/4Esxamo3sFdgSc
   wSD91pTFfSDMeOY3Lu999/FYbeWHb4PXO8vG08FOkN+6t+L1gpyDwHjpp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370491711"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="370491711"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 02:46:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="861911763"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="861911763"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 02:46:09 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] drm/xe/gsc: add initial gsc support
Date:   Wed, 20 Sep 2023 12:41:47 +0300
Message-Id: <20230920094151.1593505-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial GSC support for DG1 and DG2.
Create mei-gscfi auxiliary device and add
support for device created by Xe to the mei-gsc driver.

This series intended to be merged into Xe tree,
the only patch that touches char-misc is addition
of id and alias in mei-gsc.

V4: no-change rebase over updated drm-xe-next to fix FTBFS

V3: Review comments addressed:
    - xe_heci_gsc_init mover earlier
    - part of init flow moved to dedicated functions
    - KDoc fix

V2: Added heci_ to struct and APIs
    heci_gsc moved under xe_device as GSC is not under GT

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Vitaly Lubart (4):
  drm/xe/gsc: add HECI2 register offsets
  drm/xe/gsc: add has_heci_gscfi indication to device
  drm/xe/gsc: add gsc device support
  mei: gsc: add support for auxiliary device created by Xe driver

 drivers/gpu/drm/xe/Kconfig           |   1 +
 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/regs/xe_regs.h    |   4 +
 drivers/gpu/drm/xe/xe_device.c       |   4 +
 drivers/gpu/drm/xe/xe_device_types.h |   7 +
 drivers/gpu/drm/xe/xe_heci_gsc.c     | 222 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_heci_gsc.h     |  35 +++++
 drivers/gpu/drm/xe/xe_irq.c          |  21 ++-
 drivers/gpu/drm/xe/xe_pci.c          |   9 +-
 drivers/misc/mei/gsc-me.c            |   5 +
 10 files changed, 302 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.c
 create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.h

-- 
2.34.1

