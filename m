Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5942680FB25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377996AbjLLXRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377983AbjLLXRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:17:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10091DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:17:16 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d03bcf27e9so39463435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423035; x=1703027835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL+BTz2K9JmfgWW40zZKnYHQ0fFwxEyXyS5r4SraM1c=;
        b=TyBjuWlz2QWPbohiHkWTUANQfk4hCqqFjbNhgTsqEpaS3knwjlCsXJVWKWwzvBHIyV
         iew2Ew/6Ai7U/QGnuhP/wf45FSx+1sw8siUl2EpanVEvmZsyDwijfgEO/P33jP7y+b/S
         4g95Imryk63/kRG8ozB3rZyt10UIxvTHCM6ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423035; x=1703027835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL+BTz2K9JmfgWW40zZKnYHQ0fFwxEyXyS5r4SraM1c=;
        b=iEL/D4GuAHRS8/LpqW58OdXTNxuWIb8HdbhtwodqJ1DzN1n1pUTy/XB2bZlawFbuzu
         F4f7TwJvwDmj+wHJ1R+dGH8DY1V+pEObxne/s4o4ogl4tE1IU9Z5URGTeYpcX4swoeCM
         dHkPjSimUTo1ANoLlOuNiQOA/MLEjnWrnH14WjAm9X0cEKZJjDSj6G7ntdSPssvBqLkd
         99HcnCd36AqKtk4VaiAJY9eQMM91XFGX2UPczrzR7n77v7y4QX8g6ncsPj0zXsoUWDEK
         yFVQVQSlyMHfk5rteH5NF7f6nSdjdfZqsfPi8QeC8ToAzJYGZ7ssKYHZ8N18SUcqveZz
         eyFA==
X-Gm-Message-State: AOJu0YzT1ff+x+V000Vi/1RkFJ7nK6wwu88O472/tQL0G15xdJqFQ8pD
        5aoQgLTvq0l9vDXmHcrXoi/yIA==
X-Google-Smtp-Source: AGHT+IGFBfEL94OuzDJXPeAX8v2gc5zss9OFnE/JNle1zzc7v4J2psWLGmJv7VyTMrs5itl5BiG+DQ==
X-Received: by 2002:a17:902:b702:b0:1d0:7d83:fdd9 with SMTP id d2-20020a170902b70200b001d07d83fdd9mr3543832pls.122.1702423035559;
        Tue, 12 Dec 2023 15:17:15 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id h2-20020a170902f54200b001cfc67d46efsm9074320plf.191.2023.12.12.15.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:15 -0800 (PST)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v3 05/11] mseal: add MM_SEAL_PROT_PKEY
Date:   Tue, 12 Dec 2023 23:16:59 +0000
Message-ID: <20231212231706.2680890-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212231706.2680890-1-jeffxu@chromium.org>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

Seal PROT and PKEY of the address range, in other words, mprotect()
and pkey_mprotect() will be denied if the memory is sealed with
MM_SEAL_PROT_PKEY.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/mprotect.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..1527188b1e92 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -32,6 +32,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/memory-tiers.h>
+#include <uapi/linux/mman.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -753,6 +754,15 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+	/*
+	 * checking if PROT and PKEY is sealed.
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(current->mm, start, end, MM_SEAL_PROT_PKEY)) {
+		error = -EACCES;
+		goto out;
+	}
+
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-- 
2.43.0.472.g3155946c3a-goog

