Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8CF77468E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjHHS6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHHS5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:57:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9321D472;
        Tue,  8 Aug 2023 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691515044; x=1723051044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RaKiTBiaD9BsjOO0Nilkq1si5mCIBl34JpYb7gEASig=;
  b=HZtdjIDL+H9BaDEXMdrFR+OFQkzcDoZnD3YHFqV71qAAHBwBLIoR8hsA
   igH1gSne7mn5NHMmNEZzRvceECnD/xAPq3+JKSyIIlE/bxVmfrCbmMw/x
   w6QdLGqXDMsm+JNnKzP+BKNo6LlDS0js1B0BlrZAiRWjD2iKDvARl/FdT
   R1zxSyH2NIUI65ASDOMG5UmBJOf1yeUTq7oxveQ7iuyQoRcWc/QpYk10h
   mlZQiAsSHU5VkLhEM6Igsz1wIWyebpuZOlGbcvmE2MGSWfjPa17Ts6tR4
   lTPyuiS/uKP/L6PpqkQGoZ+0tbvwLNtnatgW4TvDY+c3Hdd5hRY/sbt7o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360970361"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="360970361"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845525000"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="845525000"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 09:24:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C1A21B4; Tue,  8 Aug 2023 19:28:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 0/6] iio: Introduce and use device_property_match_property_string()
Date:   Tue,  8 Aug 2023 19:27:54 +0300
Message-Id: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least 4 drivers in the kernel are open coding functionality of
proposed device_property_match_property_string() helper.

There are also more existing users, but I want to limit this to one
(biggest user so far) subsystem. Hence, assuming Greg KH is okay
this can be routed via IIO (and again via Greg :-).

The +28 statistics in particular due to documentation.
With more users converted we may actually get rid of some
lines of code in the future.

Andy Shevchenko (6):
  device property: Use fwnode_property_string_array_count()
  device property: Add fwnode_property_match_property_string()
  iio: frequency: adf4377: Switch to
    device_property_match_property_string()
  iio: frequency: admv1014: Switch to
    device_property_match_property_string()
  iio: magnetometer: tmag5273: Switch to
    device_property_match_property_string()
  iio: proximity: sx9324: Switch to
    device_property_match_property_string()

 drivers/base/property.c             | 37 ++++++++++++++++++++++++++++-
 drivers/iio/frequency/adf4377.c     | 16 +++++--------
 drivers/iio/frequency/admv1014.c    | 31 ++++++++++--------------
 drivers/iio/magnetometer/tmag5273.c | 10 +++-----
 drivers/iio/proximity/sx9324.c      | 24 ++++++++-----------
 include/linux/property.h            | 12 ++++++++++
 6 files changed, 79 insertions(+), 51 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

