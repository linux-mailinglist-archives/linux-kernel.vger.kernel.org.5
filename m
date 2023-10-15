Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4007C980D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjJOFdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjJOFdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:33:40 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F72CE4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:36 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57bca5b9b0aso1849457eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697348016; x=1697952816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=OOTsVBFP4oWmk+2kz41hYADJ0T6odHFSxmF4RASbq8wl7ZKg+I0M6O/c1Nc8Qr4kzx
         i0sxYr0c9CHLkALas/ltv3BxVXNdthKRUGV6HMXpDpJz3oJVHz3ftpWl9cGfJTeVSzXL
         nsbCWxLBcPNNOeej1A4GaE13Ui64nd5pRBofqYi4R6v8GbW+USl7JBEto2/GAgblocS9
         ZzPdMS3sssqIGIuZ7jOW+Q/HJydmwPCcfTDjDJ1cvZK4ldRcC3GKOqkpGGBJyTZmBZca
         +y03BsjrTsZLzu6nwhD8e47Ohf1gkwkyi1BYX/dQkHKl97e+nV8w/KjdBaob9ElDY+9s
         jr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697348016; x=1697952816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=rAq+9o1GzgJp9Z/KF557WWaw0klUU1J6VRjQ6gOrnDuQHse6pbAtbRvXyGO0h+Zy+9
         LsTYcX5pjzafRLVjfCUfzz999g0xJPKKz0SmNNGddzWwhXfejDPu4GLoBS0EBLf+qM5I
         cEYwgFOp6hU73lqCnkUYNQsEswxerjgAIV1zfafSDTNMSi5uos9pm/1PWFJsu6lnK0ij
         WMFGzVonnuQdIY7IlKYwmBnn5Cobe0RF1ydwf4qeB3ZxphU/cIVBj+LERhg67X7Pob+l
         WqX3YNaC5vWVejANOu7RwbpWZbJiUoo8CNtjyQVEwHvOMIeSxWkK+qFYouN74scX6xrS
         M2Hw==
X-Gm-Message-State: AOJu0YzdMCk3IhLHhDT3d5KCVZDk62sy87sRo5Y9U201lff2WKZm3xAL
        WVdv1Lt5Ts4bp8MyW0WN9YfOtQ==
X-Google-Smtp-Source: AGHT+IGZwVfLeI1AyGtyBJxKcT0Y5BvLq3O9dnBCaDHueY5UYLzqrCWi05KyK0QUHLr6I+1FO95MuA==
X-Received: by 2002:a05:6358:3396:b0:132:d32d:d929 with SMTP id i22-20020a056358339600b00132d32dd929mr34182114rwd.20.1697348015684;
        Sat, 14 Oct 2023 22:33:35 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id u22-20020a62ed16000000b00690fe1c928csm16187368pfh.147.2023.10.14.22.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 22:33:35 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v10 5/5] MAINTAINERS: objpool added
Date:   Sun, 15 Oct 2023 13:32:51 +0800
Message-Id: <20231015053251.707442-6-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
References: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objpool, a scalable and lockless ring-array based object pool, was
introduced to replace the original freelist (a LIFO queue based on
singly linked list) to improve kretprobe scalability.

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48abe1a281f2..1c0a38d763a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15328,6 +15328,13 @@ F:	include/linux/objagg.h
 F:	lib/objagg.c
 F:	lib/test_objagg.c
 
+OBJPOOL
+M:	Matt Wu <wuqiang.matt@bytedance.com>
+S:	Supported
+F:	include/linux/objpool.h
+F:	lib/objpool.c
+F:	lib/test_objpool.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.40.1

