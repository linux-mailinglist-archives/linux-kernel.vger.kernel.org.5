Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606D7804193
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjLDWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjLDWTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:19:32 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AACCBE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:19:38 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d8f69da4c8so15216037b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701728377; x=1702333177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YjixCCMvWXGgvjOEZP9yI8xNcwVr5lemGtrMuIweNfo=;
        b=2P6JA5qQlREMT52OEUc2cIyZGj9qBE7ezwroygk+1oxeTFUzVQhIEUIrcUilmHVm08
         FlZ8x1P4Iz3Hr6YSvtudwmWGgH4gJRvM5752aROIvTXMxXUKCn3sZ4frU6ukk9cq1j2J
         SuqP+Wztq5G8SPHsi5kiMW0HEZKwuxKuhiQrEKcPysxMg4Qp069GErIuTbdsRc0I1+WN
         ehcJuqCgCju9Q8zPXNmZYuN3ETh0QsaJCDtXzdtykp2h7S8r0ESx1HVMHWR1ZouO+UJZ
         CvrtpOasehfnFyRb67BN4Nwort78gkdF/ZQhlS+7LKshuLKEN+hZEnY2btlK4iXIh33G
         OeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728377; x=1702333177;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjixCCMvWXGgvjOEZP9yI8xNcwVr5lemGtrMuIweNfo=;
        b=uYaigW0EEyGBi5nA6W4bAjRG9x8seo9D9fXglFNc2uRNgFSnagC7MViiNhYMJrfdgb
         wewAkpo0eHZQxb4IDvKqlfi2/MFSUewHElA2272g+p2PqgCx93hnBLHvzRAaUNsBiLf2
         ucpXkbcoG68iLQbsu4G4X+hjKzsDbaWEcQTIwqlDZ3afmtZ4zxNQw5OIK6VM5NITX/Tf
         zrMso1jwaEw262QeRmLmrotpm1Aa7L/H31Mc8Psh4/Oe3tCBo1U9953uZ8+TfyUi0kCO
         FKsMVs6dPhA7GcH+j2rW9MvDcmumvQpaeBhHWIbLu17wh2pgDgOw1K2ogjGvbzUQfonm
         MB7w==
X-Gm-Message-State: AOJu0Yza3FSrDApbwf0jlzh0Zgzjxz+EZtjMJ3gQVGaI/PmPfesat64Z
        cpjEcOLrzs3l33k6pxN+V3sULI98CA==
X-Google-Smtp-Source: AGHT+IG3UzSly7olN8rLOVzLWmjvlzlBKa8sk/0NbpKjrd0oLTQugt5BmAC6ZKFZMeIS6NMXOFkU5H26Nw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:2509:b0:5d8:5d2c:121d with SMTP id
 dt9-20020a05690c250900b005d85d2c121dmr91236ywb.7.1701728377512; Mon, 04 Dec
 2023 14:19:37 -0800 (PST)
Date:   Mon,  4 Dec 2023 22:19:26 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204221932.1465004-1-rmoar@google.com>
Subject: [PATCH v3 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, sadiyakazi@google.com
Cc:     keescook@chromium.org, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alter the linker section of KUNIT_TABLE to move it out of INIT_DATA and
into DATA_DATA.

Data for KUnit tests does not need to be in the init section.

In order to run tests again after boot the KUnit data cannot be labeled as
init data as the kernel could write over it.

Add a KUNIT_INIT_TABLE in the next patch for KUnit tests that test init
data/functions.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/asm-generic/vmlinux.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bae0fe4d499b..1107905d37fc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -370,7 +370,8 @@
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
-	TRACEPOINT_STR()
+	TRACEPOINT_STR()						\
+	KUNIT_TABLE()
 
 /*
  * Data section helpers
@@ -699,8 +700,7 @@
 	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
-	EARLY_LSM_TABLE()						\
-	KUNIT_TABLE()
+	EARLY_LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.43.0.rc2.451.g8631bc7472-goog

