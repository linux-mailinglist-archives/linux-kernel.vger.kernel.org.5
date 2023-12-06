Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C260807037
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378101AbjLFMuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378111AbjLFMus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:50:48 -0500
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C51BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:50:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.Ve3FSsq_1701867048;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.Ve3FSsq_1701867048)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 20:50:48 +0800
From:   "Henry Huang" <henry.hj@antgroup.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
        <akpm@linux-foundation.org>, "Henry Huang" <henry.hj@antgroup.com>
Subject: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
Date:   Wed, 06 Dec 2023 20:50:06 +0800
Message-ID: <cover.1701853894.git.henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Multi-Gen LRU is enabled, we can't use /sys/kernel/mm/page_idle/bitmap
to track memory which is actually been used.

Multi-Gen LRU page-table walker clears pte young flag, but it doesn't
clear page idle flag. When we use /sys/kernel/mm/page_idle/bitmap to check
whether one page is accessed, it would tell us this page is idle,
but actually this page has been accessed.

For those unmapped filecache pages, page idle flag would not been
cleared in folio_mark_accessed if Multi-Gen LRU is enabled.
So we couln't use /sys/kernel/mm/page_idle/bitmap to check whether
a filecache page is read or written.

What's more, /sys/kernel/mm/page_idle/bitmap also clears pte young flag.
If one page is accessed, it would set page young flag. Multi-Gen LRU
page-table walker should check both page&pte young flags.

Changes in V2:

We move folio_clear_idle into get_pfn_folio to improve efficiency of
read /sys/kernel/mm/page_idle/bitmap.

Sometimes memcg of process may be changed, but memcg of page would not be
changed. Page idle flag would not be cleared when multi-gen LRU scan
this process's page-table.
We think it's better to clear page idle flag as soon as possible when
walking page-table. For those non-idle pages, it's not necessary to walk
rmap and clear pte young(read /sys/kernel/mm/page_idle/bitmap) if
multi-gen LRU page-table walker already scanned once before.

Henry Huang (1):
  mm: Multi-Gen LRU: fix use mm/page_idle/bitmap

 mm/swap.c   |  3 +++
 mm/vmscan.c | 40 ++++++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.43.0

