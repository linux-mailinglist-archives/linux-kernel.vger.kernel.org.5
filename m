Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36797A4C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjIRPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRPh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:37:27 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905BA1998
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:35:20 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-402d63aeea0so36520365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695051165; x=1695655965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jIAk2l8FHhw3IMNFzU025ohtjmLkXGN9K/jxVvhfHgc=;
        b=cVJya7SGwuir6CJhIpajM68/heZe5B+pSsxnBEc/3ocVl2x1z00NtcFlwGF65MTNzh
         GREJtCRbBVDgQknrfT0Dysbj9I2XlBHQ73jvj/QYEQOKr4T1cdfDhP7iSq91AfO3Mmv5
         iOy5Yh6OuJSwJcavN85F3dHnHQt6L3R+ss/7RHiAtn2fENaDgD4+JbwACBklLc6QmKC3
         FlmouhDQh4McaiSj1BG7c8SStyckAIUd3XKk6i+0YxQPk0q+yLwbiLVnenxaG3zsAOY2
         W/7mZnBDcO/d3ZZVl1WGlrxFcZQc5FSBl+jEdwDW7qjbEtwuB8boyTtYcN+7bSsrN5+e
         PjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051165; x=1695655965;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIAk2l8FHhw3IMNFzU025ohtjmLkXGN9K/jxVvhfHgc=;
        b=D5GR+YVwQGKKJpDhZuOOb/0A0Ei5xYnkLykrruaPtCY7ANHKOXXQnpxSRCN0POUaxj
         XkarXQ5xW/l9f6Ytqb6doh7j+eiC3DEEv90J81Od4ZRLrrNPT4/QWQHA+lOFsFXheyZx
         lOTEaMprGVgcrSkB4eikPEC56MdBINpGAWh8pcjXlb70yO/1YRH0v2l0DCmnmhMVEBuf
         01YU6WuC+Lhyewbe89I8vWzg072jHTzE4/GuaOiVGsiKIyrAgA6wgcwaT9kJ2rJK9+OM
         d3NaJnMNOOvNIZ06noLU8Y4sSks+zTaQ28u8dQ6Vnic5+1WhN1SF/kK/jaqZFMSqv/XR
         sqTg==
X-Gm-Message-State: AOJu0YzpCQ0iyzmWVRBZKCt94cgvoxe4lDfcqpeVp4P0vBGwUCZZcF6E
        yWTot1LFf7peXqpb8ozvLw7HazZLrnM=
X-Google-Smtp-Source: AGHT+IELXYJAnoAFGsKSZw5oJYEMng5RjKbSvSMgpNyd71aIXTCRmRDpGxCijCAPRK+nLCipMRwWfsjljr8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:dffe:ac34:a8e2:f442])
 (user=glider job=sendgmr) by 2002:a5d:4b4f:0:b0:317:f046:25e6 with SMTP id
 w15-20020a5d4b4f000000b00317f04625e6mr101610wrs.2.1695051165285; Mon, 18 Sep
 2023 08:32:45 -0700 (PDT)
Date:   Mon, 18 Sep 2023 17:32:41 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230918153241.2942764-1-glider@google.com>
Subject: [PATCH v1] mm: make __GFP_BITS_SHIFT independent of CONFIG_LOCKDEP
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, dvyukov@google.com, elver@google.com,
        akpm@linux-foundation.org, mingo@kernel.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list of GFP flags is sparse already (see 0x200u and flags defined
based on CONFIG_KASAN_HW_TAGS), so it makes little sense to save one
bit at the end of it if CONFIG_LOCKDEP is undefined.

The dependence of __GFP_BITS_SHIFT on CONFIG_LOCKDEP also does not let us
add new flags after ___GFP_NOLOCKDEP.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

An alternative to this patch would be putting all ___GFP_ flags into
enum, so that we they occupy as few bits as possible.
My understanding is that this is doable, because tools/perf/builtin-kmem.c
does not depend on the flag values, but maybe I am missing something?
---
 include/linux/gfp_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 6583a58670c57..bb8d3b31e3b6d 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -249,7 +249,7 @@ typedef unsigned int __bitwise gfp_t;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (27)
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
-- 
2.42.0.459.ge4e396fd5e-goog

