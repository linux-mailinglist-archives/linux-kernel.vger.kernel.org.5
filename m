Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5397D00B2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbjJSRfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346316AbjJSRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:35:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685DC106;
        Thu, 19 Oct 2023 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736905; x=1729272905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gBdBqK0lr5M7oMLjhnyfiZtfTMF/bpomSSs0LTiNgSs=;
  b=JksnQeSfy+KRhHPNCOC6a27QyhSac0gmNtntkm8qAS7C+I59vRe+YoNR
   YdD/HaR9iDAqpcMGUDeVtk+s1scWOdyM24EFAKvrGwHxc70UlwSQV7lZ5
   UbIwpD8gIzBTypgN8yWGEtEniAdQ2prdI7q55JUdHKC16lrDgt1Bf6kJk
   uoneM9plqNxoH/QgUTUPGnkQDvdPsADxuYf0T0Rm2zMdJaR9KB+/m+Ej5
   tejhg9uAgIbbJD5ElF4YOTgOgL/kDmi4a/Zq+coCqchu+1NGHV3eYp2A8
   zyRnBAxv45YqBgNPcdRzM7i/nrGJkh7AUUjCtelRQbESs8zxldXXPfFa/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389184242"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389184242"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760723565"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760723565"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2023 10:35:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3162E17D; Thu, 19 Oct 2023 20:35:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 0/3] gpiolib: acpi: More fixes to the consolidation rework
Date:   Thu, 19 Oct 2023 20:34:54 +0300
Message-Id: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top what Hans already fixed, Ferry reported a few bugs that pointed
out to the same consolidation rework done in v6.2.

The first is most serious issue, that needs to be fixed ASAP.

The second is good to have.

And the third one I'm not fully okay with, so open for advice on
how to improve.

Note, that long list of parameters to a _find_gpio() functions
can be hidden in the specifically crafted a new data structure,
but this is out of scope of the _fixes_ series. I'm all ears as
well for that one.

Andy Shevchenko (3):
  gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()
  gpiolib: Fix debug messaging in gpiod_find_and_request()
  gpiolib: Make debug messages in gpiod_find_by_fwnode() less confusing

 drivers/gpio/gpiolib-acpi.c   | 10 ++++-----
 drivers/gpio/gpiolib-acpi.h   | 13 ++++++------
 drivers/gpio/gpiolib-of.c     | 13 ++++++------
 drivers/gpio/gpiolib-of.h     |  8 ++++----
 drivers/gpio/gpiolib-swnode.c |  4 ++--
 drivers/gpio/gpiolib-swnode.h |  1 +
 drivers/gpio/gpiolib.c        | 38 ++++++++++++++++++++---------------
 7 files changed, 48 insertions(+), 39 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

