Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8DB7AB810
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjIVRtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjIVRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:49:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27861B1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:49:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68fb85afef4so2339482b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695404973; x=1696009773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6o8rcy2kYsMziijJ+HwTfBhFIINOkXf/UXn4gSYDrRE=;
        b=KaQNd8Agv/4jMQXtjZ4pQnH2MrXTVAzRfMQo10FGKVbfeLvr9AgriENYzM0PEuokhv
         GlZzQFPtEs0VoKfAGzH493i/UjSzKFJFeZPYpOvhdf35Nn7bpAAkKwm++hpLIAEwfFQF
         r5SyT/oJEOLPA3IRP38C40SsV8aJxZRXkZSMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404973; x=1696009773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o8rcy2kYsMziijJ+HwTfBhFIINOkXf/UXn4gSYDrRE=;
        b=EYIA7/evHsWqc+KX+tLvP+2UyKklNPpf9fteN2fhz/EPDQRrq1XuxAhfoocyC9CKr+
         RNq39CcKkYkGF8uuWPwj+KiOrBUdIzTOliyalliAKK4WgbSAzgMMAFfscmK9jfziB240
         RcK2puw34rMKz4lWvCJG5rcQqk25G/lNtJHpXFGiM/WF6ostT5SEXkc7n8ablKYgDoYK
         ROgmwnbH5qwW080v3sX5FdFiMpgLQc5m413aKCj/QpU4VNS46hTLp+jQI/SPP+mGPbTj
         +R1lxCf0pFegsT5wdNFuFXvROYu7/MlhDMU+Eh7xAz8BAQTYO5IrIMoWzOXpwRRSkQFu
         oLhA==
X-Gm-Message-State: AOJu0YwODxEWjzs2pXr54UT9eLBigTB9J/M4vPQjuMPgoch+/fYrCm/2
        Vx5o3uKsZtqw1d1InpIGuUjAKw==
X-Google-Smtp-Source: AGHT+IGBbYRZZj6iJdxISWqR0rCjwyvcEffe3apxgZbJGOfRTRyOM9w1AParWKjksC8mYeC8yyxppQ==
X-Received: by 2002:a05:6a20:12cf:b0:15d:c40e:5cb3 with SMTP id v15-20020a056a2012cf00b0015dc40e5cb3mr241613pzg.56.1695404973361;
        Fri, 22 Sep 2023 10:49:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t24-20020a62ea18000000b0068a0922b1f0sm3451624pfh.137.2023.09.22.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:49:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, ocfs2-devel@lists.linux.dev,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ocfs2: Annotate struct ocfs2_replay_map with __counted_by
Date:   Fri, 22 Sep 2023 10:49:30 -0700
Message-Id: <20230922174925.work.293-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=keescook@chromium.org;
 h=from:subject:message-id; bh=EI/V/Mukp/n4kMrskYWItkkDhXixF2aSgcv9kFKrUtA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdOp4GqjAOXqDf2PKH6lUrCfLTSmb8x0bIiGt
 qKfvxpE3mmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3TqQAKCRCJcvTf3G3A
 Jsg0D/9sEXbcZd5+u7yKxlCfUg5etMGyF3yjv1d7pHxhN/kLC0sHVcgzTmfkviwXpI4gZPgOLLK
 kh8dMVV6/OBBlVK2lBf9Z3nNlVj1chGDYuoREQRDbDJWyQjVbAhpOeVDZpB0M8JZHFmlkHxRlr3
 GATMiBdaIp/xl7jC27Qug/Gy0fVqWf95G5/ZR9Xx9Hc5Sd/Q+E4tD6SKN7zGXx3GMuVflLhJ3ZA
 CAIY1VDHpLcDWNwdTt4srhnMe5paJjbCgQVbhYlrF1ZL0QjdXvXRts537gqeBZzCxr1Rlrsnx5e
 3ZYNCsrZkaWEJxr3N+WoOsdtD7LFW8e/Htc6FXhCHKDwucfrgI8UJqTGe+LnpK5uOJpqkZWQapy
 N8Is6s+kthMpzwHCUWDwvEwugrQhV1J4lKfQu2eEfSNh/WQZelpyZZZreyEw4Y7duL40VHw4jHk
 u9vZ5VhGVi600kCOwoGgNC1pvLE4yj/o2Tfh89HkJtmfTFqApZEatrd0pjroRWFHXaiSWH1GKwk
 IkD9aaI69iQeRx8t+fS/aCQ/hpnlCDSRVgrWsINZN2QGrVAkuyQZvYOAj9G2JEiZotO7g1R8BX+
 zXAJmZK5/0wHIsrD1hOFOEROBmWxhasTkAPF8Qvb0WFRakdRTPWkUsNDgeCJiBOh75L4Xjlw3+Y
 gHdgVH1 ISyxNZfA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct ocfs2_replay_map.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: ocfs2-devel@lists.linux.dev
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ocfs2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index ce215565d061..604fea3a26ff 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -90,7 +90,7 @@ enum ocfs2_replay_state {
 struct ocfs2_replay_map {
 	unsigned int rm_slots;
 	enum ocfs2_replay_state rm_state;
-	unsigned char rm_replay_slots[];
+	unsigned char rm_replay_slots[] __counted_by(rm_slots);
 };
 
 static void ocfs2_replay_map_set_state(struct ocfs2_super *osb, int state)
-- 
2.34.1

