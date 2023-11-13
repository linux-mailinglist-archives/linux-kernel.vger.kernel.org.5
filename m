Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019907EA209
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjKMRhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjKMRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:37:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D51171C;
        Mon, 13 Nov 2023 09:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897047; x=1731433047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PEsWLDyeJovIwkzQRPz9VNsiJJHg4EVtH32TvYtHmOU=;
  b=ZK51rE6ac7ztB7qn6sWcdwEiRJaPYZVZ7qOLFpUYSv82XVo7IYlSU0kO
   gkoEBp8Cen1K3HqLMsN1ExEJCJzmzaO7q6s5rsyGOlqe6NHVwxP3OrVtK
   9jQFvEltDcPvdfR33J6WqkRGFPuBCOdLrCs/gxB6oPch/uIP3yj02pQpU
   c4OVYDZk0WhFmqNhTOyc+sU1tq4GgpRtc4Qs5JrzbiKnNQopJkDENCyhg
   LSu0Z+0lspDO58dhOrbLluckHnjZ3kG3icfve82GF776w7+7Vu3WE85Sn
   E1wUXGYiD5aB8pORVoR6oELRN67lPkTaoGI06w1usVSHlAz9ibfGUCKxg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370671507"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370671507"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095812628"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095812628"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 09:37:24 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] bitops: add missing prototype check
Date:   Mon, 13 Nov 2023 18:37:07 +0100
Message-ID: <20231113173717.927056-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113173717.927056-1-aleksander.lobakin@intel.com>
References: <20231113173717.927056-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8238b4579866 ("wait_on_bit: add an acquire memory barrier") added
a new bitop, test_bit_acquire(), with proper wrapping in order to try to
optimize it at compile-time, but missed the list of bitops used for
checking their prototypes a bit below.
The functions added have consistent prototypes, so that no more changes
are required and no functional changes take place.

Fixes: 8238b4579866 ("wait_on_bit: add an acquire memory barrier")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..f7f5a783da2a 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -80,6 +80,7 @@ __check_bitop_pr(__test_and_set_bit);
 __check_bitop_pr(__test_and_clear_bit);
 __check_bitop_pr(__test_and_change_bit);
 __check_bitop_pr(test_bit);
+__check_bitop_pr(test_bit_acquire);
 
 #undef __check_bitop_pr
 
-- 
2.41.0

