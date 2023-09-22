Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB47AB8A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjIVRzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjIVRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:55:31 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7B21725
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:30 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34fe2814b0dso8060085ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405209; x=1696010009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7N9zL7GcWxQk4sQJZqxoMP4/Uw63fJhbgd3Z3vvMbM=;
        b=ez96R74hShcdd8Ya5EzenNetEzW/39gkQ/5pqdZC8FHdEPNRKkMzzRwIsZKXrX5x7C
         fmyfdWzGtNDN5JeKFfR91BKFPiXp963dbd1B+53xrv6N8a0gUce+M1jBcoiPacV7vYPi
         l9TRn5d+EnlE8jsHnQKbgTvGY/KC5JB3TOm6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405209; x=1696010009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7N9zL7GcWxQk4sQJZqxoMP4/Uw63fJhbgd3Z3vvMbM=;
        b=QAS3ofwowUY9qEfcY1AGbkjQ/XHPV80ZS3lbVZqA55VJSlccmV1PsnY/H/htwxRJUI
         Yd2xM3EnqXI6sNuUGLeViQH6v4FK3o0RLohg5yxGlNmPEDZujW8amOPukXBTEdW7PyXU
         2FKiXmwHYTEMmkUyRWNOiEctJCVhO8wxomnrKj5845J5u0Ltp+cGmuNeZofEP999Urbe
         y/TB2BSLqq9pXI0choar1K+Sp3NbbFUQwHJEffKuyEWtaRsdAtadJq5i+tOlJV08DAe4
         Q/0tG9PZmlqrNSemITlY0QQcyfRQl26jBKEpkOoeo3HsukS5P/S/b/7J1N8HABrMQKAW
         zqzA==
X-Gm-Message-State: AOJu0YxTpC3GJBrNtrkAbesoMvZDIs6Z0IoHTraRyc33HXQLVvOMTPGa
        x+OqMETxuARtPD+8cOi0IPkF5A==
X-Google-Smtp-Source: AGHT+IFcsVBI4XpXdu09CAhRSEPvj7L8KAU83Z9CrHaDTIyiVJ8tFCIm+4+9IS918fem4DoKo/0vZA==
X-Received: by 2002:a05:6e02:cd2:b0:34f:c996:48e1 with SMTP id c18-20020a056e020cd200b0034fc99648e1mr294450ilj.16.1695405209559;
        Fri, 22 Sep 2023 10:53:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i10-20020a63b30a000000b00577e62e13c5sm3052365pgf.32.2023.09.22.10.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] mm/memcg: Annotate struct mem_cgroup_threshold_ary with __counted_by
Date:   Fri, 22 Sep 2023 10:53:28 -0700
Message-Id: <20230922175327.work.985-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=keescook@chromium.org;
 h=from:subject:message-id; bh=AoVPdbNKBfdH25pODHoRQQXzdXsjHToILrw6Ygq9UYw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSXi8xZrKuBxnaY/CAFiAsKEpAxUSuI0fKv8
 Aihbo26O82JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UlwAKCRCJcvTf3G3A
 JqknD/0UAAXFhz9wIylqjWR7+KoW9lAQVkKZFkjYdo3rRApozaEbVm5ss1cPuIgk2y9PE1Jfu7D
 yL5pqwseOb6BkFm52CuFR5ox3Wqx38f1QGnGlAMPzzR79pbm7txMeOtRGSelgiAEji0Yd4q13iv
 mxTJ2FOFmqTEBhVKnIYIZxwMVYt+ZTp4851Fwj0V1lmKw0LluTCbr/SlUOFUgXUE9Q55U4fN7p8
 k4gFsHTeCNWC1qC7JNdtpiUzQhNTgkWGSfTTQmmPFW1dfNNQMY/X/hCkrE8lr25us2BGHcXKctV
 sJk2SmX2u1+HQTFkvYAXsZpHnWP8Rjyg/7IoaPDGA8R2HQ4/4vKnGyZffHX5Hxu98q29l93JHk4
 KZ6Q6PNKzWaD2vnZy61iz2J8+6II9JM7suWxBHEYFpxQqgU4k/KF4JknHZfSw7Q72vgEZjbuqt5
 ng+YtQ/zKEe6G07KhIgFWHvb6WDo1C1O0ZsVCxzbgBl2GqL8SYHj2QidGFIwwa5U1fMY0+hkjWo
 fCwHgr6IceHQVw/bDMgUucKCWi/+3mS+16+WoPi7v/wJY28HWX6g0gP/ocwdstYWfGUlwCkP6lW
 DpbIGU7g1KG4QPx/Jh4LPoGLQfE4gdEhQsTKrj56HIvlonjMmG0OVSN5Nh28NTEq9U2NlHeRQaH
 pvv5FKB U1LJHI+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mem_cgroup_threshold_ary.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/memcontrol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 45d0c10e86cc..e0cfab58ab71 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -143,7 +143,7 @@ struct mem_cgroup_threshold_ary {
 	/* Size of entries[] */
 	unsigned int size;
 	/* Array of thresholds */
-	struct mem_cgroup_threshold entries[];
+	struct mem_cgroup_threshold entries[] __counted_by(size);
 };
 
 struct mem_cgroup_thresholds {
-- 
2.34.1

