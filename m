Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0157671AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjG1QPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjG1QPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:15:31 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E396D4217;
        Fri, 28 Jul 2023 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690560925; x=1722096925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AKGrusEfmjGs5zEr3mhPbr/2FvOKxjtxXpulNBDQ1G0=;
  b=Tlmw0NLp5OjFBW+kI6cKXzgiDRskSgEKT4WCrr9booZP6GVGYaC3mgrh
   P2e87n9FxPSJOKIukvK/gQe60PV5Z+/zKSpypIfy41glXdZYBaUpix0Ps
   DFjM4B0AUAQ0Td0nq8Cqjc52Q+bM8/wTYbraTU+gY/6H+SsNkH94c2jM1
   pxNkFVwFlMhuIRgGvVxdS9ReLyro737ZCgauH6zOs5nsDa9vI8Q9k5cfj
   +vI6z7+CPlnqGYCNNiiY5R51qLuRd3U1fIKUFiGw/ai+6eeeIqMrRmVJl
   vqZC42s94uVmEj6zjJXLuc+qz0MAIPwokwu97Jz3Kbd/V1razSHlFxSn0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="366092840"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="366092840"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 09:15:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="721313805"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="721313805"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga007.jf.intel.com with ESMTP; 28 Jul 2023 09:15:21 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, minchan@kernel.org, yuzhao@google.com,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH 0/2] don't use mapcount() to check large folio sharing
Date:   Sat, 29 Jul 2023 00:13:54 +0800
Message-Id: <20230728161356.1784568-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
folio_mapcount() is used to check whether the folio is shared. But it's
not correct as folio_mapcount() returns total mapcount of large folio.

Use folio_estimated_sharers() here as the estimated number is enough.

Yin Fengwei (2):
  madvise: don't use mapcount() against large folio for sharing check
  madvise: don't use mapcount() against large folio for sharing check

 mm/huge_memory.c | 2 +-
 mm/madvise.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.39.2

