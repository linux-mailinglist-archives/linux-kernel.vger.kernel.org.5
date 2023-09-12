Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B379D1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjILNNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjILNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:13:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2455B10CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694524394; x=1726060394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1b+OZOkcX/TneXJpyWQDBqUe1ZkRUHeBKCJz/xOyBbU=;
  b=Sp/1XoDbWrhjnvlWN3YFzHbxd1uWmwn9QVeGEPW7g3sXcu7o6oGxm06Y
   swTK4c244OlzIGX7RxwePK86ZLgFoJqlzTo2haNIUlGjYBHbGrWYq2GGC
   DATtXVTaWHEPXAdQE4aCQQmzduiDV9lMRYKT0/4JGkr5uJjIb8ECCOJXm
   066GMJZLnOldjwoWRRKm8YjjthaRDo3igvxWedCX5s7PCsIM7wlJoedhO
   LdUQ8aO+HUt+0iNQTgIlZVENd/SzgAeQtgpWQBZr45C10pNRpdNuN/dGw
   FAXkgK/F3rq4hj1zOtSBLDF3oCYB/ipFIzGM3VcAwI/RnyEgejWAJMygL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464740067"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464740067"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737116336"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="737116336"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:13:11 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/xe/gsc: add initial gsc support
Date:   Tue, 12 Sep 2023 16:08:31 +0300
Message-Id: <20230912130835.2488728-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial GSC support for DG1 and DG2.
Create mei-gscfi auxiliary device and add
support for device created by Xe to the mei-gsc driver.

This series intended to be merged intto Xe tree,
the only patch that touches char-misc is addition
of id and alias in mei-gsc.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Vitaly Lubart (4):
  drm/xe/gsc: add HECI2 register offsets
  drm/xe/gsc: add has_heci_gscfi indication to device
  drm/xe/gsc: add gsc device support
  mei: gsc: add support for auxiliary device created by Xe driver

 drivers/gpu/drm/xe/Kconfig           |   1 +
 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/regs/xe_regs.h    |   4 +
 drivers/gpu/drm/xe/xe_device_types.h |   3 +
 drivers/gpu/drm/xe/xe_gt.c           |   4 +
 drivers/gpu/drm/xe/xe_gt_gsc.c       | 218 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_gt_gsc.h       |  36 +++++
 drivers/gpu/drm/xe/xe_gt_types.h     |   4 +
 drivers/gpu/drm/xe/xe_irq.c          |  11 +-
 drivers/gpu/drm/xe/xe_pci.c          |   9 +-
 drivers/misc/mei/gsc-me.c            |   5 +
 11 files changed, 292 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_gt_gsc.c
 create mode 100644 drivers/gpu/drm/xe/xe_gt_gsc.h

-- 
2.34.1

