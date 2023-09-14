Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7736D79FDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjINIGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjINIGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:06:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E5FA1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694678764; x=1726214764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=alarmb21xDs8/wpKmjdMyWqIYrA8sjPPUobI9aXdkIA=;
  b=Gr4Ixok6gVqj5VvJT1QTz6IBxV23tTUFFi0WCPKN1MIs658ut70tMP2g
   ktmXeiAcG1dMhx9mdkuIVdA2XDeQ/r4kR1NQtw6iV7U2bhON7X5ES19Ys
   3oJuM4NYKyLcKa7SHZcIPPwTs26UN9i3scsKGv/639NE1QAPH+Z7vtwlk
   1iNAni/L+mch8FkpFR+DRDMb0Tk0Ti7YgTHDWlsDwzf0NQbjURs2cn1oh
   kYfhqsnh8oEUdCMc/h3+LSpxxbegzdXjQWgRoPy51YGnfGgskO1CSs3A2
   PzTx9Xc/021Ff/HHyLIqu1w7wMMurApAHSyQIi8KQ7R76EmtVS3ELUDy9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="442917347"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="442917347"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="887691557"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="887691557"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:05:29 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] drm/xe/gsc: add initial gsc support
Date:   Thu, 14 Sep 2023 11:01:34 +0300
Message-Id: <20230914080138.4178295-1-alexander.usyskin@intel.com>
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
 drivers/gpu/drm/xe/xe_heci_gsc.c     | 205 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_heci_gsc.h     |  35 +++++
 drivers/gpu/drm/xe/xe_irq.c          |  14 +-
 drivers/gpu/drm/xe/xe_pci.c          |   9 +-
 drivers/misc/mei/gsc-me.c            |   5 +
 10 files changed, 281 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.c
 create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.h

-- 
2.34.1

