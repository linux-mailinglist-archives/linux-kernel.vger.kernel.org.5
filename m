Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7E2800E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379384AbjLAPOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379394AbjLAPOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:14:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E9170B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701443692; x=1732979692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2nPgeu78BldoNDzIaZF7ykkc2+YQvrAlpn9sQnj1FMw=;
  b=X8B+97u06VeSKkzfYRyrRvApJFOStQ0Z8TOqA2J4cwAjOXjheZhlFqde
   zc428PiKrLSc9Prw/fFR9AkiVUVlhXKoN319Q6TWnTGzNKlc4oP9UiFxG
   D9swOzIwC5+HQnooE78PU35EbyxJpLCs9PGEYTgKV6rjaKlxMOJ8A+UBr
   D7yJgrBidsG033vw64BS4mRQUK2SbWgfai8hc8+bCJJDQorMouevOMV/K
   wthKgCm1ODzqXEP/d+KQreXmhyiEOj5LnXSLLT+XNb0yKNDzYfs7Yh+Da
   51DnE8CSZtUje0ZDTZWbV07hti7FJyGR6bZ3snElKDQ4CFAv9sTCGoSwL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="378541626"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="378541626"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 07:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="913604674"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="913604674"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2023 07:14:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5434579F; Fri,  1 Dec 2023 17:14:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] checkpatch: Add dev_err_probe() to the list of Log Functions
Date:   Fri,  1 Dec 2023 17:14:46 +0200
Message-ID: <20231201151446.1593472-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() is missing in the list of Log Functions and hence
checkpatch issues a warning in the cases when any other function
in use won't trigger it. Add dev_err_probe() to the list to behave
consistently.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a94ed6c46a6d..c40f3f784f7e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -593,6 +593,7 @@ our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
 our $logFunctions = qr{(?x:
 	printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
 	(?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
+	dev_err_probe|
 	TP_printk|
 	WARN(?:_RATELIMIT|_ONCE|)|
 	panic|
-- 
2.43.0.rc1.1.gbec44491f096

