Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9EE7D7393
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjJYSue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJYSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:50:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D5F111;
        Wed, 25 Oct 2023 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698259832; x=1729795832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tyuad4CLXZh+vdA2dSWx/kiizQs1zXdiTr0LZZF2EVE=;
  b=Tavz6p3mOcXodSrlTzlQQsL7v68RUYygves+XyA5ItERHHw7N7UT8uVS
   z/yv6ITjqkFqZrlKbw+G2oSY6HOE7F/o6nSPsnpvnYWZvdNZmVvcx05I6
   wgsYJMRluRqcGjdtEjbnKNg7GA93eN5lhjbkjAcJ0IppcPDhKGJJcv3hn
   QP5jXN9jdF+NFfWb7rCNf1fG/br5EHhv0mZ11FFpafxtiHDg9XCj9pZ+3
   9Q/XVXLbEsXQYxQXBDHUwdlmak37vV0t2MjnLBEIrN6WISU79zZxgXk+6
   JgDSOQnclibuPL+ImwRBzWZ1hR4SxbDBRrE0jmklTVmRLzzF8jysTSFUm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="176167"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="176167"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902642575"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902642575"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2023 11:48:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C8283125; Wed, 25 Oct 2023 21:43:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 0/3] gpio: mmio: Make driver agnostic
Date:   Wed, 25 Oct 2023 21:42:56 +0300
Message-Id: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
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

Driver uses so far some OF APIs when generic fwnode ones can be used.
Replace these APIs accordingly. Note, this will help to clean up OF
headers even more.

Andy Shevchenko (3):
  device property: Implement device_is_big_endian()
  gpio: mmio: Make use of device properties
  gpio: mmio: Clean up headers

 drivers/gpio/gpio-mmio.c | 53 +++++++++++++++-------------------------
 include/linux/property.h | 26 ++++++++++++++++++++
 2 files changed, 46 insertions(+), 33 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

