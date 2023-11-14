Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A987EA92D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjKNDmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNDmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:42:23 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212B619B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:42:20 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso4187204a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699933339; x=1700538139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBnWxULz4sB1k282R2qRVUVWhPl11XVq897JPJpGZLo=;
        b=IIpLaHMTw5oIil4R5tl9aVdqLPRwFpWsBhBMJkO/tmlJxhoCpK8P8l+0xPgGA/nFyQ
         dvL1c8/wxsVp3xiIdY2vfSZ1Cej2QNjScNuOdHvMqOEyVHE2FMHVVH7eVEba1zihneFI
         CfQYl//cLHRZz6X+0QM8pZNxq3dFzX6tt87Z+ljHT2ALuIBpzjHLPBvc9MiJ3MfSSCbp
         sOmYfzqZSqRxwuiTvhOJQV36u2Ak+7H7aTqdos186MQDrL7lNHsSY8SR3IqDwkErBs4P
         TBQGgjs+9PrHrm5d+0HZsblIhQtOiPB2bBqbTPRhi1zL7gpXigEhQ2ps5zMpM3IcxqTf
         z1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699933339; x=1700538139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBnWxULz4sB1k282R2qRVUVWhPl11XVq897JPJpGZLo=;
        b=WiQPHwXhoBADSHs1KAcwDXEkhMq8sVMAvDZhiUICkg1CaDGCmk3vVhwxUQB1D4ekLX
         9rrFivg+U0PbnK/cwG6Vo01J/qagap5btF4RW/8x5dGKiRCDM9LwXGX5gaMNTshcD63x
         oC6kQEUvsZ1WKNqTTBb2YCtnRW5tvQ8UC1A/2mDXq1m5jbm+AGzVzC1t5EakJXwgoYLt
         53qXTbA5tB0VvU13toipK2aFr2QZ5iKXmPkaH7IsS+z5UCi6rUkn8qsxu9ZKcQBF2iK2
         2JVE3LI3SRm9H8mgXhLunBTkcgelHmNTkN5gmLjMm5WmG1k26ulajAmnrmnPYoOMdoQ0
         HeCA==
X-Gm-Message-State: AOJu0YybmEVm/O1wfirQ+CPiKmAe8X7gqXze05YCzYphD3T5CYLJMkVJ
        SghXjplcFtunsgKJFh4kJWk=
X-Google-Smtp-Source: AGHT+IFZKyWTgOnAf2RyU4KYRqc/ajBaxuHyq8HIRTRHEhtfedd4oYxuHtV1own8Sm6lL4ko3S23Pw==
X-Received: by 2002:a17:902:e54f:b0:1cc:520a:544 with SMTP id n15-20020a170902e54f00b001cc520a0544mr1322488plf.48.1699933339496;
        Mon, 13 Nov 2023 19:42:19 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:4df7:6a7e:83c8:9693])
        by smtp.gmail.com with ESMTPSA id jd12-20020a170903260c00b001ae0152d280sm4774143plb.193.2023.11.13.19.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 19:42:19 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        iamjoonsoo.kim@lge.com, audra@redhat.com
Cc:     linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com,
        quic_yingangl@quicinc.com, 42.hyeyoo@gmail.com,
        Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v2] mm/page_owner: record and dump free_pid and free_tgid
Date:   Tue, 14 Nov 2023 16:42:02 +1300
Message-Id: <20231114034202.73098-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating some complex memory allocation and free bugs
especially in multi-processes and multi-threads cases, from time
to time, I feel the free stack isn't sufficient as a page can be
freed by processes or threads other than the one allocating it.
And other processes and threads which free the page often have
the exactly same free stack with the one allocating the page. We
can't know who free the page only through the free stack though
the current page_owner does tell us the pid and tgid of the one
allocating the page. This makes the bug investigation often hard.

Thus, This patch adds free pid and tgid in page_owner, so that we
can easily figure out if the freeing is crossing processes or
threads.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2:
 add missed free_pid and free_tgid copy in __folio_copy_owner

 mm/page_owner.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4f13ce7d2452..e7eba7688881 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -32,6 +32,8 @@ struct page_owner {
 	char comm[TASK_COMM_LEN];
 	pid_t pid;
 	pid_t tgid;
+	pid_t free_pid;
+	pid_t free_tgid;
 };
 
 static bool page_owner_enabled __initdata;
@@ -152,6 +154,8 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_owner = get_page_owner(page_ext);
 		page_owner->free_handle = handle;
 		page_owner->free_ts_nsec = free_ts_nsec;
+		page_owner->free_pid = current->pid;
+		page_owner->free_tgid = current->tgid;
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
@@ -253,6 +257,8 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	new_page_owner->handle = old_page_owner->handle;
 	new_page_owner->pid = old_page_owner->pid;
 	new_page_owner->tgid = old_page_owner->tgid;
+	new_page_owner->free_pid = old_page_owner->free_pid;
+	new_page_owner->free_tgid = old_page_owner->free_tgid;
 	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
 	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
 	strcpy(new_page_owner->comm, old_page_owner->comm);
@@ -495,7 +501,8 @@ void __dump_page_owner(const struct page *page)
 	if (!handle) {
 		pr_alert("page_owner free stack trace missing\n");
 	} else {
-		pr_alert("page last free stack trace:\n");
+		pr_alert("page last free pid %d tgid %d stack trace:\n",
+			  page_owner->free_pid, page_owner->free_tgid);
 		stack_depot_print(handle);
 	}
 
-- 
2.34.1

