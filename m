Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6729B7AB87B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjIVRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjIVRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:53:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0451F11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7fd4c23315so3060941276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695405101; x=1696009901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPoesx7eIkvIyN/ECBqYvUwy9riOVetGjUtm7GvkcAQ=;
        b=M9FspRTRg5iKLUT95ZRx1RxpmyXULmaFRUAZqosCYnVR31gFlY6u+D4PFBqe7NINL9
         zfpnmUF/72y2Lis/TtDgeSTllv3Bq4R3Z98haB2R8jeEThB3/jEcPxHHrJPPvAGQ54yT
         gn1iSn6XzJ4lDMhyInnHNHBsSdxv7ORmP3QZlmtz80rmb3OgVuEb5l9P/hHPmlGC47QZ
         9gPBeX7WRpj8qaiAvM8Z0m6NmbmkTIklSI4LqY2ErmwnSRQ4diwdqB4bpaq+gYYavFNH
         GGjwT/hqHqiKpL5cxscIkPIf4djBExHMjeqwXCxMJ9kwEWMESRMst5aPQiuiQXIq6D88
         GuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405101; x=1696009901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPoesx7eIkvIyN/ECBqYvUwy9riOVetGjUtm7GvkcAQ=;
        b=uTub0mOm6RASmbbQZF35p1Q6d1+go6w09CdVtcQPyCxhbz41PyG66ckrkC3wx0nUtM
         L/EnqRxFbi/sqFlTL4top0KoHkdmdfdnJeKLyxtow0uQsktvHzQxUqoSLpRQCVmMJ+8J
         7bUvtq5O0lnaqUy15Yn73UvXqkbm/1ynE5+R2sdnUfuFkxUeZVaM9ujHIb+tSvEVWf7v
         XSafN7kmWWO0OELs5CkhQqrA8QAg1XUz2Umg4BJUSE99dv7XSHz3aktGgehd3q1uJeWp
         4ViLj7q2sXT6pOsriBuaQ+Y559rVUJDHgEgfkx1vsBNQUJGWCZecq6lZrUroJl9GXjIB
         GKAg==
X-Gm-Message-State: AOJu0YxQwEedjmrv8paqGbhixy9KBrHz0S5LG3D4CBbw2kb/yNIktvxb
        kAP1dzX9m+0GTYCy68EukLWLyCrcORlE/g==
X-Google-Smtp-Source: AGHT+IEIodY6P8AEfYuvD2zh3y3p9HhvCqmHHHxKT05y8cUv8VPdaP2I7/YajTg2Gkalk2g6RpbDy0/vf2J8Jg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a5b:d0b:0:b0:d85:ae1e:f696 with SMTP id
 y11-20020a5b0d0b000000b00d85ae1ef696mr927ybp.0.1695405101036; Fri, 22 Sep
 2023 10:51:41 -0700 (PDT)
Date:   Fri, 22 Sep 2023 17:51:37 +0000
In-Reply-To: <20230922044241.322832-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230922044241.322832-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922175138.230331-1-cmllamas@google.com>
Subject: [PATCH v2] binder: fix memory leaks of spam and pending work
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Li Li <dualli@google.com>, Hang Lu <hangl@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzkaller-bugs@googlegroups.com, stable@vger.kernel.org,
        syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com,
        Alice Ryhl <aliceryhl@google.com>, Todd Kjos <tkjos@google.com>
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
potential spamming threads or as BINDER_WORK_TRANSACTION_PENDING when
the target is currently frozen.

However, these work types are not being handled in binder_release_work()
so they will leak during a cleanup. This was reported by syzkaller with
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

Fix the leaks by kfreeing these work types in binder_release_work() and
handle them as a BINDER_WORK_TRANSACTION_COMPLETE cleanup.

Cc: stable@vger.kernel.org
Fixes: 0567461a7a6e ("binder: return pending info for frozen async txns")
Fixes: a7dc1e6f99df ("binder: tell userspace to dump current backtrace when detected oneway spamming")
Reported-by: syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f10c1653e35933c0f1e
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v2 - Handle also peding work and merge with transaction complete as
     suggested by Alice Ryhl. Add corresponding new tags.
v1 - https://lore.kernel.org/all/20230922044241.322832-1-cmllamas@google.com/
---
 drivers/android/binder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 367afac5f1bf..92128aae2d06 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4812,6 +4812,8 @@ static void binder_release_work(struct binder_proc *proc,
 				"undelivered TRANSACTION_ERROR: %u\n",
 				e->cmd);
 		} break;
+		case BINDER_WORK_TRANSACTION_PENDING:
+		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT:
 		case BINDER_WORK_TRANSACTION_COMPLETE: {
 			binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
 				"undelivered TRANSACTION_COMPLETE\n");
-- 
2.42.0.515.g380fc7ccd1-goog

