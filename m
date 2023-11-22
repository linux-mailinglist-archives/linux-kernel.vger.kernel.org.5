Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACF7F5477
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjKVXZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKVXZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:25:30 -0500
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70AC199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:25:25 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700695524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dIP68Sfayd7Btc+B0Ey1P6bn1vCBpsnFEN+7f1RnHmY=;
        b=a+xYFgN1q5vbNFYogOWrJxLSQUs5HjfgpzE8YsBiaqKzWEpu679gb012GNy5KvmGxwMPh2
        nDedlShTYQe6N2NuhmsVtN6HcMmZDU3EMYJrrbZTL3SXPOb6w3m/iG0T9k3jLDSI5ZHna9
        Fm2PzoldoaOMxM8HbrfLwqsX9mb4lkQ=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 0/7] shrinker debugging improvements
Date:   Wed, 22 Nov 2023 18:25:05 -0500
Message-ID: <20231122232515.177833-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset does a few things to aid in OOM debugging, in particular
when shrinkers are involved:

 - improves the show_mem OOM report: it now reports on shrinkers, and
   for both shrinkers and slab we only report the top 10 entries,
   sorted, not the full list

 - add shrinker_to_text(), for the show_mem report and debugfs, and a
   an optional shrinker.to_text() callback to report extra
   driver-specific information

 - add extra counters for the shrinker_to_text() report

 - implement shrinker.to_text() for bcachefs, giving an example of how
   to use the callbacks

Daniel Hill (1):
  bcachefs: add counters for failed shrinker reclaim

Kent Overstreet (6):
  seq_buf: seq_buf_human_readable_u64()
  mm: shrinker: Add a .to_text() method for shrinkers
  mm: shrinker: Add new stats for .to_text()
  mm: Centralize & improve oom reporting in show_mem.c
  mm: shrinker: Add shrinker_to_text() to debugfs interface
  bcachefs: shrinker.to_text() methods

 fs/bcachefs/btree_cache.c     | 102 +++++++++++++++++++++++++++-------
 fs/bcachefs/btree_cache.h     |   2 +-
 fs/bcachefs/btree_key_cache.c |  14 +++++
 fs/bcachefs/btree_types.h     |  10 ++++
 fs/bcachefs/sysfs.c           |   2 +-
 include/linux/seq_buf.h       |   4 ++
 include/linux/shrinker.h      |  12 +++-
 lib/seq_buf.c                 |  10 ++++
 mm/oom_kill.c                 |  23 --------
 mm/show_mem.c                 |  20 +++++++
 mm/shrinker.c                 |  89 ++++++++++++++++++++++++++++-
 mm/shrinker_debug.c           |  18 ++++++
 mm/slab.h                     |   6 +-
 mm/slab_common.c              |  52 ++++++++++++++---
 14 files changed, 305 insertions(+), 59 deletions(-)

-- 
2.42.0

