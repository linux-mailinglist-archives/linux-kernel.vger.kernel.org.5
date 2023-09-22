Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277FC7AA7EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjIVEmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjIVEmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:42:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179D0CA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:42:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59e78032ef9so24902407b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695357765; x=1695962565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOSxLadMmyxPzCAuHUscDwKckaObJr5AodXorCq6Mh8=;
        b=fTNUn8rto1MZyCpzbK1R5MD6M4l7IOz2ZCvBccHLtaN4tULJ/SAnPNpnEYMEhWgsvR
         zlB7DtYhn0ZlCX+FTMWImCzlzFM/t5zyABbR7636Cihv7+KMWrTwiBCAdw7gPkvN+KMp
         WcC+/bFwGi79VNZ9MQPyF+wtaIdLQ8JWqzt47GQH1EM3HOtCfLT+sAJxf2geflXVa3bg
         4msDCVKTG2ZMsh7fPU/gbDVkTxTA6e0EXGklaFl07caIyVrSjjtAZ49ml1idWTSNWXiP
         7eJ0HhBx+MvLgI56naWuVwI04dPzZhtbgGyTpj9x7DZ+wwzuDJwltKim6E/mjOGlxTV1
         WlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695357765; x=1695962565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOSxLadMmyxPzCAuHUscDwKckaObJr5AodXorCq6Mh8=;
        b=jgzGu6UGAuzbTKDSBjhjNi95uXu4gYpZwvfGNR4RNVHYSbuwWkiwtw7xOM6cL45haU
         ZXnrX3f1q2MRgQ3kE4JZWAtXc6CqkZ3qtTDea6JzUBv0/IkvJEE5F6u2qqjkoM2qmYKE
         +QuDROfWfWidjJO92bBoRs7S2ilywrxo9oPklCLGsKMqL5Dgx8xpo1mlpAfdulpbrl+L
         EbIZd2858Yl4t/x406hGk0RG2OibHZu17te3lT+qJZYN0KOgACHO4ksKgib9MVVpBMxb
         shPJkX2CWn4ViDsklNB7Md7zG1fjt1bfPlkNpsdLw4dS/UfqYjQLzgwQ1ARp0DmLNZK+
         GRBQ==
X-Gm-Message-State: AOJu0YzUywkWrEIOZUYOKzS/leJ0iGAeZa6cMVkErxstQgMQ5nzd5T63
        PGoYL30BHTRM8n7gop/HBTdSU5M7BeK+9Q==
X-Google-Smtp-Source: AGHT+IGFkPNBuQkD4DINS/cFH5kDu7DzVRnFZDZ/Xi6NfhQQYigH8yAxegiiIIH5LJR6g8b6w63HsC3BlUywOg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:d203:0:b0:59b:d33b:5ddc with SMTP id
 x3-20020a81d203000000b0059bd33b5ddcmr112799ywi.4.1695357765078; Thu, 21 Sep
 2023 21:42:45 -0700 (PDT)
Date:   Fri, 22 Sep 2023 04:42:40 +0000
In-Reply-To: <000000000000aa181605ededf1fa@google.com>
Mime-Version: 1.0
References: <000000000000aa181605ededf1fa@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922044241.322832-1-cmllamas@google.com>
Subject: [PATCH] binder: fix memory leak of spamming work
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hang Lu <hangl@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzkaller-bugs@googlegroups.com, stable@vger.kernel.org,
        syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A transaction complete work is allocated and queued for each
transaction. Under certain conditions the work->type might be marked as
BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT to notify userspace about
potential spamming threads.

However, this work->type is not being handled in binder_release_work()
so it will leak during a clean up. This was reported by syzkaller with
the following kmemleak dump:

BUG: memory leak
unreferenced object 0xffff88810e2d6de0 (size 32):
  comm "syz-executor338", pid 5046, jiffies 4294968230 (age 13.590s)
  hex dump (first 32 bytes):
    e0 6d 2d 0e 81 88 ff ff e0 6d 2d 0e 81 88 ff ff  .m-......m-.....
    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81573b75>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff83d41873>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff83d41873>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83d41873>] binder_transaction+0x573/0x4050 drivers/android/binder.c:3152
    [<ffffffff83d45a05>] binder_thread_write+0x6b5/0x1860 drivers/android/binder.c:4010
    [<ffffffff83d486dc>] binder_ioctl_write_read drivers/android/binder.c:5066 [inline]
    [<ffffffff83d486dc>] binder_ioctl+0x1b2c/0x3cf0 drivers/android/binder.c:5352
    [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fix the leak by kfreeing this work in binder_release_work().

Cc: stable@vger.kernel.org
Fixes: a7dc1e6f99df ("binder: tell userspace to dump current backtrace when detected oneway spamming")
Reported-by: syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f10c1653e35933c0f1e
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 367afac5f1bf..d7aa561f4ef2 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4831,6 +4831,9 @@ static void binder_release_work(struct binder_proc *proc,
 		} break;
 		case BINDER_WORK_NODE:
 			break;
+		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT:
+			kfree(w);
+			break;
 		default:
 			pr_err("unexpected work type, %d, not freed\n",
 			       wtype);
-- 
2.42.0.515.g380fc7ccd1-goog

