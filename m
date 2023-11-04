Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3747E0EE2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjKDK6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 06:58:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B2B19D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 03:58:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso2536997a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699095497; x=1699700297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIpIp4e2K8Nc4AhNSaTNAZwdwE2Uw0hQHoQ7glzurrs=;
        b=ftUo43wd0o8JgjtYwNYropXd5csC0GB+KaVJHh1NSXyhrBEmlNho+KJBqgeGiJk7W0
         13FvbS5VHhi4+qe2aQfCrAKMlDaZzIqlQw1LjRjW21PjAdPB4TPsZ7iBgCujDTLeDldf
         2yZu0R0BO8kTC5BRBULC1aKZZW+7g6arHgl+7DxCUZahApNnW8moJ3UV6RiaG2QZxeW2
         6zByVlipGUbNTa3Z+iaObEIjTbcwHPPEbfJUM8ebHuUdt8EsxBygYxisky93omneMem8
         XZwePe/Y6ziGuVEHauhpdmnY4oqt9+JekD9kFpiw15OdQdooGPE6SSJ46FkYLyh9zX+u
         /HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699095497; x=1699700297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIpIp4e2K8Nc4AhNSaTNAZwdwE2Uw0hQHoQ7glzurrs=;
        b=pfKxok8YwqSJeqH/UwyGmOyEkcw8BO69WGcWsJb5oR44l4AwKX7RTRW3oH5CBReEOY
         1uolyrlkDZloTddmTwDRsfASt+HlzcnFP4OIARwdRArrkz0CPA/tNbV3xCWJnutau2n+
         2lHUSH9y1aJwxCawZvzA0L0xYKKEKvOHWe6+EG1Zw0P/HWPM0/vwaH462JiU6ten4iO4
         ZIijPfdjJduNd8nY9RkPesFKjJzN22yYn3bPbxzXvBYgmlwcVQQGVVNutwGQH9/ept4L
         5PMVDxvjWwAsqW0vkSQsNVS7p849D+LLy85fRvwoFSX+xj8Iq0VLuDaN7ixzsa+wf8jE
         YPlw==
X-Gm-Message-State: AOJu0YzRG+scmTMykWstE+ew2o0BQV//Y2mNjMnOTmBnfs3KZIU4SdJy
        fog1M9pgpZgcAoErhC/j7l/rRw==
X-Google-Smtp-Source: AGHT+IGTYVuyBzC8FdqpewZL+3URTXEXK7BrlVZ2Bat6sBfwGwN9gHvBm3Ld9xLXP/oQYzT9d9pL5w==
X-Received: by 2002:a17:90b:1bc5:b0:27d:a14c:eba6 with SMTP id oa5-20020a17090b1bc500b0027da14ceba6mr3619065pjb.21.1699095497147;
        Sat, 04 Nov 2023 03:58:17 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ge13-20020a17090b0e0d00b0026801e06ac1sm2675636pjb.30.2023.11.04.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 03:58:16 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     jcmvbkbc@gmail.com
Cc:     andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        chris@zankel.net, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, mattwu@163.com, palmer@rivosinc.com,
        wuqiang.matt@bytedance.com
Subject: [PATCH v2] locking/atomic: xtensa: define arch_cmpxchg_local as __cmpxchg_local
Date:   Sat,  4 Nov 2023 18:58:01 +0800
Message-Id: <20231104105801.12320-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAMo8BfK4zDfdh9-WLq+gg1B47ht5hxhvH_j5veEj6JG38meTuw@mail.gmail.com>
References: <CAMo8BfK4zDfdh9-WLq+gg1B47ht5hxhvH_j5veEj6JG38meTuw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xtensa architecture already has __cmpxchg_local defined, which makes
arch_cmpxchg_local's definition as __generic_cmpxchg_local unreasonable.

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 arch/xtensa/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 675a11ea8de7..956c9925df1c 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -108,7 +108,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
  * them available.
  */
 #define arch_cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
+	((__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),        \
 			(unsigned long)(n), sizeof(*(ptr))))
 #define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #define arch_cmpxchg64(ptr, o, n)    arch_cmpxchg64_local((ptr), (o), (n))
-- 
2.40.1

