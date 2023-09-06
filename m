Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337779345C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbjIFESw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIFESu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:18:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A98B2;
        Tue,  5 Sep 2023 21:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693973927; x=1725509927;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=riQzctx+Sg+R9UfUX4B/xGeJX17wKAuZ+VBM9nHly9Y=;
  b=mtCJDmOmTbpFEeorPv/iTKYcVOvsNvArnL8g+m/7HmYK+n55KcfqsBjo
   GQ/0hHT2QlK/aIar4tOrumSjn3rrRgendTowO9DCDwvNUGfD6OVZOUw+B
   lm5u0LFLK4tImfAkcIDnGjm4Z9DxicIpo88CeDFUfbTf6h18dU4eSdxID
   tysfmEbkN6UrSwHCm9obS21r+2WQWLf4dtMLpQ50RX2Cj58qQyOdo1pGb
   sgq6mIih2FduGxNFoVAgVesaQGqI6ZEE0pnAH0ihW2aFTHYFh7Xt04D74
   kjqRZfqLy0uhNmteiEu0R8NvRJm+DivOHw8fJJDlezmRvGThe7PTCHMJ3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407967839"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="407967839"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="831483414"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="831483414"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2023 21:18:45 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chenzhou Feng <chenzhoux.feng@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2 0/2] Fix the hibernation test_resume's swapfile open mode
Date:   Wed,  6 Sep 2023 12:18:27 +0800
Message-Id: <cover.1693972725.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the regression brought by
commit 5904de0d735b ("PM: hibernate: Do not get block device exclusively
in test_resume mode"), which incorrectly open the swapfile in a wrong
mode, and causes unexpected behavior during non-hibernation operation.

Fix it by really disabling exclusive mode under test_resume.

This is the v2 of the fix for a hibernation test_resume swapfile open issue.
Chenzhou found that v1 has a warning during the stress test. It was due to
broken open mode in swsusp_write(), fixes it in v2.

patch 1 is a renaming of the function parameter, to better reflects the swap
device open mode.
patch 2 is to fix the open mode on the swap device. 

v1: https://lore.kernel.org/lkml/20230823161329.7348-1-yu.c.chen@intel.com/

Chen Yu (2):
  PM: hibernate: Rename the function parameter from snapshot_test to
    exclusive
  PM: hibernate: Fix the exclusive get block device in test_resume mode

 kernel/power/hibernate.c | 12 ++++++------
 kernel/power/power.h     |  4 ++--
 kernel/power/swap.c      | 14 ++++++++------
 3 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.25.1

