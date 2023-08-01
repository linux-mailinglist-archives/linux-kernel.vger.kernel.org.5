Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8876C027
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjHAWJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHAWJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:09:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD926AA;
        Tue,  1 Aug 2023 15:09:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so67870921fa.1;
        Tue, 01 Aug 2023 15:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690927767; x=1691532567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSpmN52R4zvJ1S+i6B6OGYZwzIS1/5yW5wWragBrFA0=;
        b=XaniT5r6suwpR7jjJvcmJOh5zqRrMucOLpNrGei5m8doTVhDnRJgRnqGz4phmQsdLD
         nzXezpAZXhLt7Ph6121T6v0zExcd2XJdiF0GOMSC9PuIx2pHAlbb9tPR/UWGlfRVH3wZ
         ejpBzUQxLFfJHTa6zEpY1J3TZ7qAdMzgPMTQy7Y8kiCABW+2fACQY8cT8kIl2w3pw8Ht
         oAHfupQqrwFQq+i7VgGvg209uSclzOJSLpWRYGz7WxUEQGpYd0qyJyv9t3HZsPlKCiTq
         pkKAtjAliHu35zGMGRlAcA7QJwo7Azk84djCD7yXwzJZPfuSqbIRYDP5AxjDBsPqVIkL
         4UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927767; x=1691532567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSpmN52R4zvJ1S+i6B6OGYZwzIS1/5yW5wWragBrFA0=;
        b=UDQJqeacLJFC2QnxmBWeitBbtsbZj8Q2NUG0q3TRAsAu4CYQmrV5gnYWpPmffJbB3C
         C4pwQSOOWvKHQAPdITFPmfPP2vEgV/W4914ATmIIrQCwaUGSH0320JX58GX+YXkiT2oT
         VvmtaCEVtQnR5r/QYsQBo40n9VZ8UA7mXUXCI0xWGgz13jhQRDNCiKLf68ztPYqv/fYj
         bEQZpwRXtyFeLcxFLcC7QLtChgN03srERkN+ajfueYb9VW1BxNQBx1kSIa0dCaiee1Y2
         gHsZFyqmgO14n1+aX2WKYP4xrQK6xFRxknEkDsnTSe4rZv54jv3Xft05/ANocb7OhLnp
         aK8w==
X-Gm-Message-State: ABy/qLZK2wzYwfZAOUdNjJ8lkqRcOVenCmIEWd9WLUskekISFYJ9GAQ3
        BYd0MY5GrB7BnYMzZ9VHLLs=
X-Google-Smtp-Source: APBJJlERRP6xJs2BKH/KZpMsUDEY7EYHNGhvbI9dYp3bWCLckdTMj77kulkRDU1t+LxiGszftcRpFA==
X-Received: by 2002:a05:651c:cf:b0:2b9:b067:9559 with SMTP id 15-20020a05651c00cf00b002b9b0679559mr3382679ljr.23.1690927766923;
        Tue, 01 Aug 2023 15:09:26 -0700 (PDT)
Received: from localhost.localdomain ([77.222.27.96])
        by smtp.gmail.com with ESMTPSA id y18-20020a2e95d2000000b002b9ea00a7bbsm1391013ljh.60.2023.08.01.15.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 15:09:26 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
        brouer@redhat.com, dsahern@gmail.com, jbrouer@redhat.com,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH v4 2/2] net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()
Date:   Wed,  2 Aug 2023 01:07:13 +0300
Message-Id: <20230801220710.464-2-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230801220710.464-1-andrew.kanner@gmail.com>
References: <20230801220710.464-1-andrew.kanner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:
=======================================
Too BIG xdp->frame_sz = 131072
WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
  ____bpf_xdp_adjust_tail net/core/filter.c:4121 [inline]
WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
  bpf_xdp_adjust_tail+0x466/0xa10 net/core/filter.c:4103
...
Call Trace:
 <TASK>
 bpf_prog_4add87e5301a4105+0x1a/0x1c
 __bpf_prog_run include/linux/filter.h:600 [inline]
 bpf_prog_run_xdp include/linux/filter.h:775 [inline]
 bpf_prog_run_generic_xdp+0x57e/0x11e0 net/core/dev.c:4721
 netif_receive_generic_xdp net/core/dev.c:4807 [inline]
 do_xdp_generic+0x35c/0x770 net/core/dev.c:4866
 tun_get_user+0x2340/0x3ca0 drivers/net/tun.c:1919
 tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2043
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

xdp->frame_sz > PAGE_SIZE check was introduced in commit c8741e2bfe87
("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But Jesper
Dangaard Brouer <jbrouer@redhat.com> noted that after introducing the
xdp_init_buff() which all XDP driver use - it's safe to remove this
check. The original intend was to catch cases where XDP drivers have
not been updated to use xdp.frame_sz, but that is not longer a concern
(since xdp_init_buff).

Running the initial syzkaller repro it was discovered that the
contiguous physical memory allocation is used for both xdp paths in
tun_get_user(), e.g. tun_build_skb() and tun_alloc_skb(). It was also
stated by Jesper Dangaard Brouer <jbrouer@redhat.com> that XDP can
work on higher order pages, as long as this is contiguous physical
memory (e.g. a page).

Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.com/T/
Link: https://syzkaller.appspot.com/bug?extid=f817490f5bd20541b90a
Link: https://lore.kernel.org/all/20230725155403.796-1-andrew.kanner@gmail.com/T/
Fixes: 43b5169d8355 ("net, xdp: Introduce xdp_init_buff utility routine")
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---
 net/core/filter.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..28a59596987a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4116,12 +4116,6 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
 	if (unlikely(data_end > data_hard_end))
 		return -EINVAL;
 
-	/* ALL drivers MUST init xdp->frame_sz, chicken check below */
-	if (unlikely(xdp->frame_sz > PAGE_SIZE)) {
-		WARN_ONCE(1, "Too BIG xdp->frame_sz = %d\n", xdp->frame_sz);
-		return -EINVAL;
-	}
-
 	if (unlikely(data_end < xdp->data + ETH_HLEN))
 		return -EINVAL;
 
-- 
2.39.3

