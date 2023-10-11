Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B47C4D42
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjJKIeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjJKIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:34:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A498;
        Wed, 11 Oct 2023 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697013244; x=1728549244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v8b36hzg0ZJAEO27CltsIvMZPSTrKWI+beze9I7e8Mo=;
  b=EFw91vB4/xej0KGUSrFs/tX94qbtFBaqHwlOr21M2Bb/5lzUGMfDZExK
   A7J7EkCKZkwrmCcoEjlE4JenajXsCx8oXQPf1MMrbLcBlgAhjIEbDxOkq
   lwIWtikjcNYv3o47iwqHUcp8KDyYYCMKe+CmXHCcgVgJE3V6FWZ3QUtjd
   N5Qd0mb9q7UfwOAXmX3HvpDsNIa0ftYEPEe+dBAaphbkuJFifDD8aOwmo
   onfG4F2Z3xbWKgpyPiz4KVSqOBPxpAHi/dFNMlC2ynCjl1x9VpUnBn/fy
   sZy39cQEZQL9nM4Z3uFoHFHEDQ6gJxWMJGpAD+e2YWc22DWs6+3+5ORkt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388480155"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388480155"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897548169"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897548169"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:32:09 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 0/6] Replace acpi_driver with platform_driver
Date:   Wed, 11 Oct 2023 11:33:28 +0300
Message-ID: <20231011083334.3987477-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a number of drivers that somewhat incorrectly
register themselves as acpi_driver, while they should be registering as
platform_drivers. acpi_device was never meant to represent actual
device, it only represents an entry in the ACPI table and ACPI driver
should be treated as a driver for the ACPI entry of the particular
device, not the device itself. Drivers of the devices itself should
register as platform_drivers. Replace acpi_driver with platform_driver
for all relevant drivers in drivers/acpi directory. This is just the
first part of the change, as many acpi_drivers are present in many files
outside of drivers/acpi directory.

Additionally during internal review we've decided that it's best to send
the relevant patches sequentially, in order not to overwhelm the reviewers.
So I'm starting with NFIT and AC drivers.

This change is possible thanks to recent .notify callback removal in
drivers/acpi [1]. So flow for the remaining acpi_drivers will look like
this:

1) Remove .notify callback with separate patchset for drivers/platform
   and other outstanding places like drivers/hwmon, drivers/iio etc.
2) Replace acpi_driver with platform_driver, as aside for .notify
   callback they're mostly functionally compatible.

Most of the patches in this series could be considered independent, and
could be merged separately, with a notable exception of the very first
patch in this series that changes notify installer wrappers to be more
generic. I decided it would be best not to force the user of this
wrappers to pass any specific structure, like acpi_device or
platform_device. It makes sense as it is very often the case that
drivers declare their own private structure which gets allocated during
the .probe() callback, and become the heart of the driver. In that case
it makes much more sense to pass this structure to notify handler.
Additionally some drivers, like acpi_video that already have custom
notify handlers do that already.

Link: https://lore.kernel.org/linux-acpi/20230703080252.2899090-1-michal.wilczynski@intel.com/ [1]

v3:
 - in AC transformation patch replaced struct device* with
   struct acpi_device*, as suggested.

v2:
 - dropped first, second and last commit. Last commit was deemed
   pointless, first and second are already merged.
 - rebased on top of modified first commit (changes in the wrappers)

Michal Wilczynski (6):
  ACPI: AC: Remove unnecessary checks
  ACPI: AC: Use string_choices API instead of ternary operator
  ACPI: AC: Replace acpi_driver with platform_driver
  ACPI: AC: Rename ACPI device from device to adev
  ACPI: NFIT: Replace acpi_driver with platform_driver
  ACPI: NFIT: Remove redundant call to to_acpi_dev()

 drivers/acpi/ac.c        | 103 +++++++++++++++++----------------------
 drivers/acpi/nfit/core.c |  38 +++++++--------
 2 files changed, 64 insertions(+), 77 deletions(-)

-- 
2.41.0

