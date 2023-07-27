Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABA7656AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjG0PBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjG0PBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:01:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19453A8D;
        Thu, 27 Jul 2023 08:01:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3177f520802so650511f8f.1;
        Thu, 27 Jul 2023 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690470079; x=1691074879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RvCF/eVSd9hmC6XYT4T1ezXatK3iLtpGtg715fOf/58=;
        b=k/z3jAdPty8pr9RV96/kIt05tsIb/2SPKBH9mAzqzaRfV9MPcKGLKBafnlPqZSR39w
         OEx99Gybqta70dIZrmZVYVmqe/xlIQMgtiwufYvjIhyFL+/wX74CkwpI7FlI27c0e49J
         f+ZqfM7sbc4UpartBigQf0/+AQaj9Wt+/FI9zBWDzKLQqJM4b5c/QOyqUcIl7e+mHIei
         M20V2oR9bBtjSPrl+ReDNM/Bgm8tLf40OJQiDhPnQ4hovaOileJKCxFq2fSJ4MGobcjI
         jbZP0J+wpxWElP8XSyWkXeAE0Qmr0yidt4TXZbF9TpHjDTVRfM9wJKhlAhB8ZPhaIeEJ
         t6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690470079; x=1691074879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvCF/eVSd9hmC6XYT4T1ezXatK3iLtpGtg715fOf/58=;
        b=Uh70v7P9+s0mh5rREm7YbOU7xdCFSWIXQi2eIZpZppi4pBOJg8sygLqgJ/I7aWng20
         s8E/OnbPkg12Gf/j1VRbcgaQ80fJx1uONHnM+Ch7yLkuOUGlpLCibXE0OzK+O/wf0EMB
         zUPfHkj5z9z/HQyH41rUsH20/E+dekTiOxjpaywOtBnvzNnjQ9f1KVb2l+PJLTgwtvt0
         7u3Vsp0+oW79j+8sR+4a7/f+TyuURoEQ+y3utY1Gmi37Kn4fuh50bNcPyP/OBagMe8oC
         SYdIDy3twcZEepoNSSdZahKxTSyUKMR90nSjE9PaG2kxxvWTg1kjju/CGAdMwRnKlGg+
         cv+w==
X-Gm-Message-State: ABy/qLY6gpFlr63j3Hv87Ubn0YdFRfFGWzroGBbRps4DGNd8O5ZxeGNV
        YQinTuWK/MpC+Zevl1w7knE=
X-Google-Smtp-Source: APBJJlGU86bx5VqRAOWDKiY5phwY7+ucGmhvWfqzAJmocNr9VtQu4SXGlFXWERSQXKnGtxkMe5+ADw==
X-Received: by 2002:a05:6000:108e:b0:313:e20c:b90b with SMTP id y14-20020a056000108e00b00313e20cb90bmr2071747wrw.26.1690470078949;
        Thu, 27 Jul 2023 08:01:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b003144b95e1ecsm2280938wrm.93.2023.07.27.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:01:18 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andreas Schwab <schwab@suse.de>,
        linux-trace-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] rtla: Fix uninitialized variable found
Date:   Thu, 27 Jul 2023 16:01:17 +0100
Message-Id: <20230727150117.627730-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable found is not being initialized, in the case where the desired
mount is not found the variable contains garbage. Fix this by initializing
it to zero.

Fixes: a957cbc02531 ("rtla: Add -C cgroup support")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 623a38908ed5..c769d7b3842c 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -538,7 +538,7 @@ static const int find_mount(const char *fs, char *mp, int sizeof_mp)
 {
 	char mount_point[MAX_PATH];
 	char type[100];
-	int found;
+	int found = 0;
 	FILE *fp;
 
 	fp = fopen("/proc/mounts", "r");
-- 
2.39.2

