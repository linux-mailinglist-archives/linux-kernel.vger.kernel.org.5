Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A17BF00D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379311AbjJJBI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379287AbjJJBIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:08:25 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD76A9E;
        Mon,  9 Oct 2023 18:08:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2773f776f49so3718053a91.1;
        Mon, 09 Oct 2023 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696900103; x=1697504903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NyHLoSVe2VzqxLFtpuVYd0zTrzwtQioN6fcJnEB+68=;
        b=Zg3n7NW25xQO+Ebzi+0oP6kaw2STOV6fPCUkXTe080xcJaIQ7I/0plThD5oaD4tFzm
         5Mu+xGBOQUmJKp9+iBU94lIpi9s5UrMIGXJgi9j7fwa6g6yLhzHUZvk6+0JsK9KySs7F
         jBO32YlnIykNKHtvYYk7lU1h6YYbNg7uu5JzFMwgY50RKzkycP0nJwjazZqQXstD6crC
         o0ycC4Vu6h9dQoh2F1i/ifsJWOlp+VosbfGVRUdzMXgHcy6zpJwNSYzkrky1Xc2DuVay
         h0L6fvgo+MrW3WSK87N4WZOWR5lpbjP/JcxZjXbRJ2sP6yHPF8wBDtI0HSN9tJuRqvCA
         5PEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696900103; x=1697504903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NyHLoSVe2VzqxLFtpuVYd0zTrzwtQioN6fcJnEB+68=;
        b=UbgihKqOnic8L0lYHFxG8LY4Fn4taUQ7oS0gemqrarictrDEj7SUU4iko7Cg/fKVjk
         Zclb+vHDkhkB/fg3XnHaXrpr1hutCrns3AU3kdmkdWXW5NEb/bOPan5aop4Z2Ak7wEhB
         akk/oqnDcNp+4iK8UinkNxQEKDWmdVZUmNdwv9nEqFIRa4dPi3PQHsAdFRDjjuioTxru
         rkfJEB2j0yv1753h2lyxhHy8adp883EWBZ+xPpzhN3jT+c1JSIrw0K4zZAyGYiHpDlSV
         +iWgIHPOphmxdOc6B9XoH1uHpud0lOKZdCAaEErS1yHS9+/3dfij0awDJNDjDFZEX2tS
         pvog==
X-Gm-Message-State: AOJu0Yx1R662Z/PuH+Xr8/ZahVQhI05NIeViVu7tRdAGQzgprOHaFFeJ
        c5yiFj7wqxHQdcAUq+Mc82Q=
X-Google-Smtp-Source: AGHT+IFECBKSr0s8fUjcGXDbGeiFvCUGol7oHZ7hXWmqS472RlN1BZp4LPWlMi3ZSAL4Gu7uyUUvTw==
X-Received: by 2002:a17:90a:dd43:b0:273:83ac:5eb9 with SMTP id u3-20020a17090add4300b0027383ac5eb9mr19693687pjv.4.1696900102964;
        Mon, 09 Oct 2023 18:08:22 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id l6-20020a633e06000000b00589eb5b1df7sm3723822pga.35.2023.10.09.18.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 18:08:22 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     syzbot+509238e523e032442b80@syzkaller.appspotmail.com
Cc:     davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] rfkill: fix deadlock in rfkill_send_events
Date:   Tue, 10 Oct 2023 09:08:15 +0800
Message-ID: <20231010010814.1799012-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000e3788c06074e2b84@google.com>
References: <000000000000e3788c06074e2b84@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot report:
syz-executor675/5132 is trying to acquire lock:
ffff8880297ee088 (&data->mtx){+.+.}-{3:3}, at: rfkill_send_events+0x226/0x3f0 net/rfkill/core.c:286

but task is already holding lock:
ffff88801bfc0088 (&data->mtx){+.+.}-{3:3}, at: rfkill_fop_open+0x146/0x750 net/rfkill/core.c:1183

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&data->mtx);
  lock(&data->mtx);

 *** DEADLOCK ***

In 2c3dfba4cf84 insert rfkill_sync() to rfkill_fop_open(), it will call
rfkill_send_events() and then triger this issue.

Fixes: 2c3dfba4cf84 ("rfkill: sync before userspace visibility/changes")
Reported-and-tested-by: syzbot+509238e523e032442b80@syzkaller.appspotmail.com
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
---
 net/rfkill/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 08630896b6c8..a14e0d4a0b00 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1180,7 +1180,6 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 	init_waitqueue_head(&data->read_wait);
 
 	mutex_lock(&rfkill_global_mutex);
-	mutex_lock(&data->mtx);
 	/*
 	 * start getting events from elsewhere but hold mtx to get
 	 * startup events added first
@@ -1191,9 +1190,12 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 		if (!ev)
 			goto free;
 		rfkill_sync(rfkill);
+		mutex_lock(&data->mtx);
 		rfkill_fill_event(&ev->ev, rfkill, RFKILL_OP_ADD);
 		list_add_tail(&ev->list, &data->events);
+		mutex_unlock(&data->mtx);
 	}
+	mutex_lock(&data->mtx);
 	list_add(&data->list, &rfkill_fds);
 	mutex_unlock(&data->mtx);
 	mutex_unlock(&rfkill_global_mutex);
-- 
2.25.1

