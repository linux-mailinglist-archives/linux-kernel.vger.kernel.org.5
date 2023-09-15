Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633377A27EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbjIOUQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbjIOUQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:16:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D9D3C26
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:15:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fbb10dec7so2356707b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808930; x=1695413730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5U9yAMmxUGtlu2RTV+opnsRR/vKyQ1Eg6VpI2oRXqGs=;
        b=KAmubKzx8NgJFenHA874q1LD61JK7Y10xRge5wQGTGZYqkXIt0FNRsL+ExPJfy1A+0
         sLj6OWKx0fcCoAkUf/gtePg7Za7cb7NDxiGY9xrQbHvUqrKNcX4+EIQ77EXfPkYO7hG3
         n0ecJWgDnJ0kqISTSTjPbPKjNMvXOTxUTwOiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808930; x=1695413730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5U9yAMmxUGtlu2RTV+opnsRR/vKyQ1Eg6VpI2oRXqGs=;
        b=oWe2sbXd1H/3nHiTPl1/8a6vpQHz99+azzor8jOaVlK423GTBhFlJOp0KEmLOpuna+
         nzcrPvSZ3qiIZHAqiY0BH/Igi0LfplKF9xLP3WW4laD5qdwDVFMhQiIYIbhlSKjrG4Np
         EHczt6CDlN8p8XSblzPADP3FEEj83S5WiVQuWwa1wKOmZTffbv2VQEI24SGgcLRsEfck
         gvG5eOnOvGwBzRfVcWiL79JxBmkqzSa5lzVIwVmxLA6/pNZKVuHkZlGWFDfdRhyek5dK
         ld6Ze4+kY7WENBWjHFYb+Nc81dJkLzNRrY2PS4zMNDmu8os1Ica3Sl+u/MgzxyHoGhG6
         rmhA==
X-Gm-Message-State: AOJu0YyrYXxyoZJ1DcjZsMDFyw3LwQfKooLOOicQY3RoG5hHtkSo4Kju
        PNfA6qWkC7VlxWNfgdcGvMCDAg==
X-Google-Smtp-Source: AGHT+IFiEOjtKML9hAMj7s89s+YrjEI9Ics/TkDbK27NvmtLHbxAe68D4A4yHfRZWvo9JI7q0ksJ7Q==
X-Received: by 2002:a05:6a20:2583:b0:153:8754:8a7f with SMTP id k3-20020a056a20258300b0015387548a7fmr3347558pzd.4.1694808930405;
        Fri, 15 Sep 2023 13:15:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u4-20020a62ed04000000b0068fb9965036sm3308876pfh.109.2023.09.15.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:15:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] ocfs2: Annotate struct ocfs2_slot_info with __counted_by
Date:   Fri, 15 Sep 2023 13:15:23 -0700
Message-Id: <20230915201522.never.979-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=keescook@chromium.org;
 h=from:subject:message-id; bh=vVg/lwd/xTHPf1ncyCo+ObbQAlMJgY5cAnP5s625GBY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLta7z/D+qrhNioYhLhzv1EUA9eiYGgPkff5E
 WkJ6ZVV9kOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7WgAKCRCJcvTf3G3A
 Jm5LD/9AgxrbRwWNmusFfPJ9QxfnI7oMtHew9CbcXH9J5762zPWuOe5jVw8WhT+uByyd1i1mixz
 5el5s969WpfACTpAWuJhC/dB7M4vQwfkdYngKRmI9ur1PJ+4t2AN44FzbEL0g2b3dm2/nYJqU2B
 6Bn0Nq+cC8LlgpdU6T5vaEUHoMtls5+suDayovc5HuVQiWgA63f0jqxtvXW/eXzZ7PjtEuZrvut
 XMJyOwUDGcR86O4hFOt3lBOxZB/WNl/iYEJiAjksnRhkdshPp4fXzHQTxaHF4VgS993Y3T+1IWV
 8GlRsZ/6SOwuRU8ZyH3298IY06+Ri3SP6ZGZTdDYELWaSBKTxDG8PTveGNZKjOy+whqwYugCb4p
 xp7eLci8exro42aA49ZptpY+0KaTLA10QN78NVp9rsHmzi1dV7bX9FbkeAk+gVE2mcy+iDmc65O
 6bLjfR2vvXY8zgk250FYcXj8HrxcGjXAjw8ZWIEFRjY9IiH+F+8aGhc7QICsw/u0gUDjWZskoa2
 6ir7iarUGsxSiSF0PfeRvgLppdp0iyrKw6u1FIdu1hVbHgTwK32rVJP3eENfmy9GK+DZrEKnVOq
 wXmADnU5lgUCfc3hTRxQhalNw9D6NVB3UClIcZ3ZI3ve7LH3ObESB1Q8b/RkX/Ks9y2PWyYg2Bf
 x8VFe1R RW1mYTMA==
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

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ocfs2_slot_info.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ocfs2/slot_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index da7718cef735..e544c704b583 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -37,7 +37,7 @@ struct ocfs2_slot_info {
 	unsigned int si_blocks;
 	struct buffer_head **si_bh;
 	unsigned int si_num_slots;
-	struct ocfs2_slot si_slots[];
+	struct ocfs2_slot si_slots[] __counted_by(si_num_slots);
 };
 
 
-- 
2.34.1

