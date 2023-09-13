Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4248E79E100
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbjIMHlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjIMHls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:41:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA41729;
        Wed, 13 Sep 2023 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694590904; x=1726126904;
  h=from:to:cc:subject:date:message-id;
  bh=xkd+enwWC/o97hoGExYV8Dw54JNG5oupVOp/1MwZry4=;
  b=UidyyCCuerW2cFP/yc2pMzfmyG/h99R8sOZGn88oae+/gVdcfjvlsM3H
   IwPLNirW+xGG0k8HDirfKlSr0BkGWLCPsEjPJCdzorvcETuZsZmwpPjRy
   T8cSVs4yCyWmfoinGPrxovZ4703ZYaMUJqzeE761XIaV+T1UrDzYSy2VA
   ETyWzIsMvvFwTlGaHOMqY+SjzhYSevcTEx+wZR6xXlbz76P+S/kjV4DZ5
   0/51ep265eeTUcL3CCMysoJUhnPlvdu+94g816ONZZ/9Eeao8G2taLtXn
   OoknQ+zZORjAAoMddymwHCtnyut5y0GDOpn5pddP/G6bIez7F7Hu8/Ds2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368859091"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="368859091"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 00:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747208878"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747208878"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2023 00:41:40 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael.j.wysocki@intel.com, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, paul@crapouillou.net,
        andriy.shevchenko@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [RFC v1 0/2] Fix symbol export for _SIMPLE_ variants of _PM_OPS()
Date:   Wed, 13 Sep 2023 13:10:30 +0530
Message-Id: <20230913074032.27927-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently EXPORT_*_SIMPLE_DEV_PM_OPS() use EXPORT_*_DEV_PM_OPS() set of
macros to export dev_pm_ops symbol, which export the symbol in case
CONFIG_PM=y but don't take CONFIG_PM_SLEEP into consideration.

Since _SIMPLE_ variants of _PM_OPS() do not include runtime PM handles
and are only used in case CONFIG_PM_SLEEP=y, we should not be exporting
dev_pm_ops symbol for them in case CONFIG_PM_SLEEP=n.

This can be fixed by having two distinct set of export macros for both
_RUNTIME_ and _SIMPLE_ variants of _PM_OPS(), such that the export of
dev_pm_ops symbol used in each variant depends on CONFIG_PM and
CONFIG_PM_SLEEP respectively.

PS: This needs a few (~6) drivers to be updated with new set of macros,
which will be done in following versions if this is worth moving forward.

Raag Jadav (2):
  PM: Introduce export macros for _SIMPLE_ variants of _PM_OPS()
  PM: Update EXPORT_*_DEV_PM_OPS() to EXPORT_*_RUNTIME_PM_OPS()

 include/linux/pm.h         | 38 ++++++++++++++++++++++++--------------
 include/linux/pm_runtime.h | 13 +++++++++----
 2 files changed, 33 insertions(+), 18 deletions(-)

-- 
2.17.1

