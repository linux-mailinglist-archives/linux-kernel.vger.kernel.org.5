Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01B7E312B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjKFXTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjKFXSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:18:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBE92712;
        Mon,  6 Nov 2023 15:16:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DADEC433B9;
        Mon,  6 Nov 2023 23:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312585;
        bh=TcDSIxb+++aqpFbhWYpeTEv6e5YqHt/PWH70rPLcxR0=;
        h=From:To:Cc:Subject:Date:From;
        b=dcqpOyhReFbQayGm+fhqCJSxjD3vq5PQhgg9e244J1ATe8oGZh3CYiwSm8RZTK56f
         gTclvQn+DUJDY1HpAypBId9soNbsY0KYNecNGeem76/Uc42Pa32tGuKqs2FsN767ik
         t9XyJGCDvsph9EvR22+u+DTGzDm5kVgdsAg0Wi8LOG0qDYU1Ht0mdi6XRErI0FHUNw
         IqEkabXQluuWaT5u6/ijhwCW8YHat2LmHAkBDTMIDKQxWEIHXLv0XMmTlHayTrduFS
         yyzD1Ds3fzbsGKyk3ugRwjoJh3sWkX2f/+iMzhlitbYG4e5X4FT21a1qlEPKk5v83s
         FZmsqzJqEVRcw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/6] perf/core: Bail out early if the request AUX area is out of bound
Date:   Mon,  6 Nov 2023 18:16:14 -0500
Message-ID: <20231106231622.3735613-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuai Xue <xueshuai@linux.alibaba.com>

[ Upstream commit 54aee5f15b83437f23b2b2469bcf21bdd9823916 ]

When perf-record with a large AUX area, e.g 4GB, it fails with:

    #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
    failed to mmap with 12 (Cannot allocate memory)

and it reveals a WARNING with __alloc_pages():

	------------[ cut here ]------------
	WARNING: CPU: 44 PID: 17573 at mm/page_alloc.c:5568 __alloc_pages+0x1ec/0x248
	Call trace:
	 __alloc_pages+0x1ec/0x248
	 __kmalloc_large_node+0xc0/0x1f8
	 __kmalloc_node+0x134/0x1e8
	 rb_alloc_aux+0xe0/0x298
	 perf_mmap+0x440/0x660
	 mmap_region+0x308/0x8a8
	 do_mmap+0x3c0/0x528
	 vm_mmap_pgoff+0xf4/0x1b8
	 ksys_mmap_pgoff+0x18c/0x218
	 __arm64_sys_mmap+0x38/0x58
	 invoke_syscall+0x50/0x128
	 el0_svc_common.constprop.0+0x58/0x188
	 do_el0_svc+0x34/0x50
	 el0_svc+0x34/0x108
	 el0t_64_sync_handler+0xb8/0xc0
	 el0t_64_sync+0x1a4/0x1a8

'rb->aux_pages' allocated by kcalloc() is a pointer array which is used to
maintains AUX trace pages. The allocated page for this array is physically
contiguous (and virtually contiguous) with an order of 0..MAX_ORDER. If the
size of pointer array crosses the limitation set by MAX_ORDER, it reveals a
WARNING.

So bail out early with -ENOMEM if the request AUX area is out of bound,
e.g.:

    #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
    failed to mmap with 12 (Cannot allocate memory)

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/ring_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index f40da32f5e753..6808873555f0d 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -696,6 +696,12 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		watermark = 0;
 	}
 
+	/*
+	 * kcalloc_node() is unable to allocate buffer if the size is larger
+	 * than: PAGE_SIZE << MAX_ORDER; directly bail out in this case.
+	 */
+	if (get_order((unsigned long)nr_pages * sizeof(void *)) > MAX_ORDER)
+		return -ENOMEM;
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
 				     node);
 	if (!rb->aux_pages)
-- 
2.42.0

