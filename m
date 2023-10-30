Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016D57DBB70
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjJ3OKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjJ3OKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:10:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC53C6;
        Mon, 30 Oct 2023 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698675046; x=1730211046;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ZN+8Pb5OI1UF1/6729gEA7QacpEfMQH2+X0z4a4j5Y=;
  b=PfUVvPFN8q4IEM9EwU38fQZijNIELDlqIq9LBhnWFLC9bvG5jY4asfip
   yT0huXBmffLZKdiKiOlEjpk/0YZ0IzqAFx6wMpWicgDITZ0Ns5goPfIMI
   LH4eY6iwEK4yupal9lPmOfe9P7C82188NUULGNFWvTVXzRCn4HvfT3y6E
   eMYOVh0EasYczhaNhmwEJdOgTLLcUmHmqD1YSuOX9gYSMtV0rcfRM81FT
   sC/2mqn7v3m1ObGHnem6zKkZzvYl+OU5wQDmSwvyeL9dZ3ofOvkfeHxkg
   R0bSj/atTKQv/ScXaTj7X5B9EJak6Ftn7R5mE7LJTT5R2iaIWu37/FLpO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378447168"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="378447168"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 07:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="710102227"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710102227"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2023 07:10:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E9F02D2; Mon, 30 Oct 2023 16:10:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 0/3] pinctrl: intel: Add generic platform driver
Date:   Mon, 30 Oct 2023 16:10:31 +0200
Message-Id: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Intel platforms one-by-one will be switching to use generic
approach for the pin control description in ACPI, hence this driver.

It depends on the patches in current Linux Next (will be part of
v6.7-rc1) and this series
https://lore.kernel.org/r/20231030120734.2831419-1-andriy.shevchenko@linux.intel.com.

Andy Shevchenko (3):
  pinctrl: intel: Revert "Unexport intel_pinctrl_probe()"
  pinctrl: intel: Add a generic Intel pin control platform driver
  pinctrl: intel: Add ACPI ID to the generic platform driver

 drivers/pinctrl/intel/Kconfig                 |   8 +
 drivers/pinctrl/intel/Makefile                |   1 +
 .../pinctrl/intel/pinctrl-intel-platform.c    | 224 ++++++++++++++++++
 drivers/pinctrl/intel/pinctrl-intel.c         |   5 +-
 drivers/pinctrl/intel/pinctrl-intel.h         |   3 +
 5 files changed, 239 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pinctrl/intel/pinctrl-intel-platform.c

-- 
2.40.0.1.gaa8946217a0b

