Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198E6812418
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442805AbjLNAr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLNAry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:47:54 -0500
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE399A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:48:00 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702514878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cJEulgYn/h7q3QFVAp5zsWImEtvD0ben3q7crmppy9w=;
        b=f+afQX0wFs1xoeMdRosudkjUDhhaUDWmxywT7rSErc7biX7YulrrtLhocNi1BOL/Dtrnmt
        oHmDRjCkjF3IQ8ZGEabXb1ZDHPfxmN+rJZ/4XBN+nx4LLVcfaAlp8nqZpsDTBT1othp+u3
        F4f1YEnUQMpvcQ/su0nsiQsfnh5UXxc=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH -v2 mm 0/4] lib/stackdepot, kasan: fixes for stack eviction series
Date:   Thu, 14 Dec 2023 01:47:50 +0100
Message-Id: <cover.1702514411.git.andreyknvl@google.com>
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

From: Andrey Konovalov <andreyknvl@google.com>

A few fixes for the stack depot eviction series.

Changes v1->v2:
- Add Fixes tags.
- Use per-object spinlock for protecting aux stack handles instead of a
  global one.

Andrey Konovalov (4):
  lib/stackdepot: add printk_deferred_enter/exit guards
  kasan: handle concurrent kasan_record_aux_stack calls
  kasan: memset free track in qlink_free
  lib/stackdepot: fix comment in include/linux/stackdepot.h

 include/linux/stackdepot.h |  2 --
 lib/stackdepot.c           |  9 +++++++++
 mm/kasan/generic.c         | 32 +++++++++++++++++++++++++++++---
 mm/kasan/kasan.h           |  2 ++
 mm/kasan/quarantine.c      |  2 +-
 5 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.25.1

