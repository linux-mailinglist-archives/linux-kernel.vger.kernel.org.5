Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1527B387F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjI2RTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjI2RTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:19:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500EA1A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:19:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5ff5f858dso83760095ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696007984; x=1696612784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHLaFEhV7E7Wr2RxX57WFG0eWfYlTCzFdKjwWaRfRTI=;
        b=TevKiKzVLSu//YO+gWTFKSeTqr6dlYRTM1QDKYy5i0LG1BBB3K4BV1vVMdXBR1nrhY
         nGFNNM4JcXv/NxPqIeDCiUnOulp8xRDITSZJK6yTD3GoBIdNSn+3a5+3AJFdUmOUFnX5
         jyG6Qp4Qfhj8776PB7OK1eJFMjUETjSsEdR78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696007984; x=1696612784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHLaFEhV7E7Wr2RxX57WFG0eWfYlTCzFdKjwWaRfRTI=;
        b=SBf9z9LfhWMJYO38BN+bNERAg//I3Z//+a3zKfiolmVLv74SlswhXPD/rR81nvyZ/4
         pI1QKZOpoSaMzbiZt4AykTKWmGoafTAVs/lNwpBr+XfbGGFHWnsgX6Nlt2HOUMbJUTdG
         x85+iDMBtjaur3R1ELEfonO4qlXnfpHIKSinXyNbM/JcUHO3zhhxZppAuyl3FLf7xar7
         pEM5VV9aMqPadtl7GxpimtFaM8CjR1U/JJUFpnl1Q4DLVggZG5Sk8wXKCQLRNwlSiB2Q
         UfUMbe934I6VV7TguDUklzPpP4FuFPhPKHCz3vk+8MNVA6937YeQrucvmYC5RonTcrBW
         zPRA==
X-Gm-Message-State: AOJu0Yx3ltYPEnC+vx1PWnFuog7sYCtY4OlbCeRvdtqb74OOYOBpmOpt
        tvqv0JRbxcJpog4LFjJPW9yoGQ==
X-Google-Smtp-Source: AGHT+IEiXQcH9GATb5XYfyHZHf4WaJe0AMMgIltc0a+kW2oYhDtYfsT0xVxcPSq8DfqSfSPVaFbGSw==
X-Received: by 2002:a17:902:ed01:b0:1c5:f7e2:c5e0 with SMTP id b1-20020a170902ed0100b001c5f7e2c5e0mr4502012pld.51.1696007983764;
        Fri, 29 Sep 2023 10:19:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090311cb00b001c3721897fcsm17194797plh.277.2023.09.29.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:19:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] mm: Fix vm_brk_flags() to not bail out while holding lock
Date:   Fri, 29 Sep 2023 10:19:41 -0700
Message-Id: <20230929171937.work.697-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=keescook@chromium.org;
 h=from:subject:message-id; bh=kjc+Ho0zH8hMf0DrfoD4hY2yzRf3D1zV5oxVn64EmhQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFwcsmyZwvSPygxpmP4hn9DkGcWeEJYFxatCVu
 LY41wP2IpqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcHLAAKCRCJcvTf3G3A
 JlguD/9d9nsZNBs2QjqPxwbWrX6olpQxz+BmHTRDmOKl6koWi9bnlqJ8QU1UTR3wUeG0XljNk4T
 cHSnKajVXQL+tuWV31HM+2HKRSgdBtjjsEkt8PRbBKrFyIg5r9ATi4pNmPDs2lfnobhcju+36Dv
 6wUwdLWAxaQSFlNVzAQmM5Eb4OIfXq7A0/HMMPHXjHnyDNApYafc5/+X784UWzV63b3X/8mnanO
 WcVQpQl/Bl5X0XWiedkXVUVtiFH3+H6NLFRpRKyGOYIlyGKbZFZzU+ZFEDWYL6pKv6ToRTzloNx
 UK/QzZoEBEi88it2hkeKqFpJU6bbmL67TefXFiFfTbLY8fkAKo7qM6aYirnWgo2YrSbb80sR/2K
 tB5RajiedOGGHu/lA+iGrLt3c2CRkcxnUkbfjv/kUmKSZkorYAC5komXHLmlQk8FRIGNhyxO950
 ZA/QPiKwhWYZtYb4O6TjcAbCK/i2rnHJIB5rI5y43nHTap+wWfshxGrZXkx9sLuHiKTjFenqwJd
 CJRbT0/IekKDqGs+Sl6xBlix5bqus6L/VugSgbq3Xhn0+Vs4Cn+WuPPCRJKZXyIb8RRGQZul1Og
 tfW5zP/eiQdXezh0+JkyUPIOQhXySdBrvNCGVhY7APhi9Etin9mclEUOwHxuhg+WsheM1ks5fHL
 /FNiA2i FHjNKwnw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Ott <sebott@redhat.com>

Calling vm_brk_flags() with flags set other than VM_EXEC
will exit the function without releasing the mmap_write_lock.

Just do the sanity check before the lock is acquired. This
doesn't fix an actual issue since no caller sets a flag other
than VM_EXEC.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org
Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 34d2337ace59..c8996fe847c9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3143,13 +3143,13 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	if (!len)
 		return 0;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) != 0)
 		return -EINVAL;
 
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
 	ret = check_brk_limits(addr, len);
 	if (ret)
 		goto limits_failed;
-- 
2.34.1

