Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622CA7B5D28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjJBWbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjJBWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:31:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E255591;
        Mon,  2 Oct 2023 15:31:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so2704591fa.3;
        Mon, 02 Oct 2023 15:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696285906; x=1696890706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ4SCtr/9Ft8mS+V0BNVYtsyfhk4Y7ExsowxzrXeKBE=;
        b=JmTjjquVy3zaYTwmj9jfpuRLdW9NuuzWJAu4xLUy9imQUudOumRvaFgNEoFTItHYDh
         nISsmueDItWViU1u4O87vT7lYzofVwX2S7MhNQVqALXESaHn3Z6Z/bU+BSmPNJiSzL7n
         qcq6enzRBQKSyQoYg1eZf/KxCQsylNSBnQ5qU0/i8x7LxZ2q8uLimUBiF9NYvhORbNt+
         ttaMpKnTUoj0rdNkTnUJcU4xpqtJfKh44dysFKDqNXnvWEtiKcW4fEv45GFQSRvpd1+B
         CKuyxTpOY95BCxG60V0OWhNytumUSUgP7YvBQy8CW9XwU1moFkKdyjYi/V35qJMuFr66
         0GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696285906; x=1696890706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZ4SCtr/9Ft8mS+V0BNVYtsyfhk4Y7ExsowxzrXeKBE=;
        b=ERnAGR+9kt+o4B3cqhoB3wrVS3moKZxdGan+DUE0iMVDYTioa2KYU/i0zv/Xhc1wUd
         m3Gti4hLXOBq9Ifh7NaD73+oFMArPxfQnB0vuittCCa2Rnzgl2HEwPoa+JQ+yB9rJCjV
         lDllT3aSyoqJSe2Fs5x/YrdW4nEMmLo5sVYh8xx/fnFwuZnlOSAH7nbMauHVbTc4FJ0F
         7qt9knTCYajo42xIEwYCKxiGl3qDGXVEeNboyCauupssUmDd8I3ZuQUp/W+2yf7swaFS
         T2GRtj+29H/cWY7CvYYZjjj73fJuX9DQpIbMzhQOAN7lkRqSvhjaL2al+qPsrbD1zDwn
         xuMg==
X-Gm-Message-State: AOJu0Yzf2WjSGJBWFBdYyLkbTmgvQJXMw00jdzwuYB33qtcPls/bk3x5
        iU9ZaYmV+eksul1zyGZjBao=
X-Google-Smtp-Source: AGHT+IFaCQPJjfeaLO3tHZxSeqKnLvLg9cAsOZG2hZ+Nt8TEFFFBRge3VNTurmBZC9EWyG7/QMIyAQ==
X-Received: by 2002:a2e:8505:0:b0:2bc:b9c7:7ba3 with SMTP id j5-20020a2e8505000000b002bcb9c77ba3mr10509789lji.12.1696285905850;
        Mon, 02 Oct 2023 15:31:45 -0700 (PDT)
Received: from localhost.localdomain ([77.222.24.78])
        by smtp.gmail.com with ESMTPSA id j3-20020a2eb703000000b002c0414c3b6csm5451574ljo.121.2023.10.02.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 15:31:45 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, daniel@iogearbox.net
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH net-next v2] net/xdp: fix zero-size allocation warning in xskq_create()
Date:   Tue,  3 Oct 2023 01:29:40 +0300
Message-Id: <20231002222939.1519-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 2807 at mm/vmalloc.c:3247 __vmalloc_node_range (mm/vmalloc.c:3361)
 Modules linked in:
 CPU: 0 PID: 2807 Comm: repro Not tainted 6.6.0-rc2+ #12
 Hardware name: Generic DT based system
 unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
 show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
 dump_stack_lvl from __warn (kernel/panic.c:633 kernel/panic.c:680)
 __warn from warn_slowpath_fmt (./include/linux/context_tracking.h:153 kernel/panic.c:700)
 warn_slowpath_fmt from __vmalloc_node_range (mm/vmalloc.c:3361 (discriminator 3))
 __vmalloc_node_range from vmalloc_user (mm/vmalloc.c:3478)
 vmalloc_user from xskq_create (net/xdp/xsk_queue.c:40)
 xskq_create from xsk_setsockopt (net/xdp/xsk.c:953 net/xdp/xsk.c:1286)
 xsk_setsockopt from __sys_setsockopt (net/socket.c:2308)
 __sys_setsockopt from ret_fast_syscall (arch/arm/kernel/entry-common.S:68)

xskq_get_ring_size() uses struct_size() macro to safely calculate the
size of struct xsk_queue and q->nentries of desc members. But the
syzkaller repro was able to set q->nentries with the value initially
taken from copy_from_sockptr() high enough to return SIZE_MAX by
struct_size(). The next PAGE_ALIGN(size) is such case will overflow
the size_t value and set it to 0. This will trigger WARN_ON_ONCE in
vmalloc_user() -> __vmalloc_node_range().

The issue is reproducible on 32-bit arm kernel.

Reported-and-tested-by: syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000c84b4705fb31741e@google.com/T/
Link: https://syzkaller.appspot.com/bug?extid=fae676d3cf469331fc89
Fixes: 9f78bf330a66 ("xsk: support use vaddr as ring")
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---

Notes (akanner):
    v2:
      - use unlikely() optimization for the case with SIZE_MAX return from
        struct_size(), suggested by Alexander Lobakin
        <aleksander.lobakin@intel.com>
      - cc-ed 4 more maintainers, mentioned by cc_maintainers patchwork
        test
    
    v1: https://lore.kernel.org/all/20230928204440.543-1-andrew.kanner@gmail.com/T/
      - RFC notes:
        It was found that net/xdp/xsk.c:xsk_setsockopt() uses
        copy_from_sockptr() to get the number of entries (int) for cases
        with XDP_RX_RING / XDP_TX_RING and XDP_UMEM_FILL_RING /
        XDP_UMEM_COMPLETION_RING.
    
        Next in xsk_init_queue() there're 2 sanity checks (entries == 0)
        and (!is_power_of_2(entries)) for which -EINVAL will be returned.
    
        After that net/xdp/xsk_queue.c:xskq_create() will calculate the
        size multipling the number of entries (int) with the size of u64,
        at least.
    
        I wonder if there should be the upper bound (e.g. the 3rd sanity
        check inside xsk_init_queue()). It seems that without the upper
        limit it's quiet easy to overflow the allocated size (SIZE_MAX),
        especially for 32-bit architectures, for example arm nodes which
        were used by the syzkaller.
    
        In this patch I added a naive check for SIZE_MAX which helped to
        skip zero-size allocation after overflow, but maybe it's not quite
        right. Please, suggest if you have any thoughts about the
        appropriate limit for the size of these xdp rings.
    
        PS: the initial number of entries is 0x20000000 in syzkaller
        repro: syscall(__NR_setsockopt, (intptr_t)r[0], 0x11b, 3,
        0x20000040, 0x20);
    
        Link:
        https://syzkaller.appspot.com/text?tag=ReproC&x=10910f18280000

 net/xdp/xsk_queue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index f8905400ee07..b03d1bfb6978 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -34,6 +34,9 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 	q->ring_mask = nentries - 1;
 
 	size = xskq_get_ring_size(q, umem_queue);
+	if (unlikely(size == SIZE_MAX))
+		return NULL;
+
 	size = PAGE_ALIGN(size);
 
 	q->ring = vmalloc_user(size);
-- 
2.39.3

