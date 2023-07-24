Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89FA76020C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGXWOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjGXWOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:14:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E2710EC;
        Mon, 24 Jul 2023 15:14:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fdfefdf5abso463853e87.1;
        Mon, 24 Jul 2023 15:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690236859; x=1690841659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yAsZdb1l2a00omNbaFLi6X9Z1M8KVaOQyZOE0+c0Tbc=;
        b=hYUPPntxc6s6ZI4Cv6z9ft0y9WjAHYLbjp4SyKtPI00sUEkmzSHvNUNDypAdtXKVn7
         ynUhu6KxwYHAZvUCNW+2HRJbaTFRlavjUeajGgTnONjK0MlNiaz5r1Y/geWjqRs1Q1rq
         KwrxAF55ex3j2qhvNLaDm9k6H78/5KU79/fipttlxE9I422PoXt70UVSBB8ey9ClHTr9
         9ju9MM0jTVFy/FPIdtBqZbEYxjJMe5861wtQvpkW/htfOqRfHjGj1vkujcN+phTOa2jY
         fZTh60p+kt1nY5Jw7Y9wBB39JPD2XHqJuHEefozlnjfVXVqWATdaczWsvYN0K1BsJrjl
         oReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690236859; x=1690841659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAsZdb1l2a00omNbaFLi6X9Z1M8KVaOQyZOE0+c0Tbc=;
        b=WqFX6LQsYfSuSrr6XvjYZzBe014m1JPKaKXnvqiVW61njLo1htHYA91Aq0tjNHRjCr
         8zfOxlCaNiKEWmi5/pEK+M2Dh2iu3g0GDaBhaslNy6NfTGvF9XVoUr2+n1fC8ec5hmBU
         mc8U6X9i8OwQ/7EUxrbXW6CodVWHVGzR9oM3TnDC4dF1ZBf7swhQyWxnCxdyXg9mxqk0
         nPoeVu9PSij6Gicj072L+iNsSeQ8S4/FAJzWpIUtUusNt1nb2/mGLXbiZaTl1XxjoCHO
         GUsJiNg805RcJ/zjvX44UbNwpy3IHpSvaMsxerrM78JjsvJSCV322rna2u49mIFAuivD
         E8vA==
X-Gm-Message-State: ABy/qLZiQVJxtoXTS3ao11ih01AewU1UhoABGiIiU8bWWsv8DBlL/DlM
        oiKNf6yZ4PDpwH5chYnWDwI=
X-Google-Smtp-Source: APBJJlHAx+uI4qxDU4os4KVjWZLmaw4hsPui/tQzNXMFfBkFTUJUsBeQZifK5GQTbHM+kZ5qOj9tyg==
X-Received: by 2002:a05:6512:6d4:b0:4f9:58ed:7bba with SMTP id u20-20020a05651206d400b004f958ed7bbamr7337865lff.16.1690236859228;
        Mon, 24 Jul 2023 15:14:19 -0700 (PDT)
Received: from localhost.localdomain ([77.222.25.78])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512048200b004fba077e654sm2401130lfq.194.2023.07.24.15.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 15:14:18 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
        brouer@redhat.com, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH 1/2] drivers: net: use xdp only inside tun_build_skb()
Date:   Tue, 25 Jul 2023 01:13:25 +0300
Message-Id: <20230724221326.384-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

frame_sz < PAGE_SIZE check was introduced in commit c8741e2bfe87
("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But
tun_get_user() still provides an execution path to exceed XDP limits
for packet size. The way to mitigate this is to reduce xdp to be used
only in tun_build_skb(), without falling in tun_alloc_skb(), etc.

Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.com/T/
Link: https://syzkaller.appspot.com/bug?id=5335c7c62bfff89bbb1c8f14cdabebe91909060f
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---
 drivers/net/tun.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d75456adc62a..18ccbbe9830a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1580,8 +1580,14 @@ static void tun_rx_batched(struct tun_struct *tun, struct tun_file *tfile,
 }
 
 static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
-			      int len, int noblock, bool zerocopy)
+			      int len, int noblock, bool zerocopy, int *skb_xdp)
 {
+	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
+	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE) {
+		*skb_xdp = 0;
+		return false;
+	}
+
 	if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 		return false;
 
@@ -1594,10 +1600,6 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	if (zerocopy)
 		return false;
 
-	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
-	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
-		return false;
-
 	return true;
 }
 
@@ -1809,7 +1811,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			zerocopy = true;
 	}
 
-	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
+	if (tun_can_build_skb(tun, tfile, len, noblock, zerocopy, &skb_xdp) && !frags) {
 		/* For the packet that is not easy to be processed
 		 * (e.g gso or jumbo packet), we will do it at after
 		 * skb was created with generic XDP routine.
-- 
2.39.3

