Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816407D034E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346565AbjJSUqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346553AbjJSUqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:46:35 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A704A3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:46:33 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7788ebea620so3563385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1697748392; x=1698353192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7EOVMhlF0O2opQmvwajTcnPxn6OrPW52BLfQ9FmcEZk=;
        b=mOSH/3bb6etptMMPdeTl8LJnyyCjFIqrv8bXbiz9zJepXsmXH4BUcaWwfNX5lM/nCz
         oFaBDizx+Q+JWN+0tUI6Yeln0OqrfhJ44wixaYyrh4AfdixTFWeN5aCtU+ThdYON8k1l
         LYCyAaIXs3Q9Z3O0zwLZ6Y89t9f8+4m5jN8S3B0Kgu9ToAjqZkufGxcuM23ZOns544nJ
         kbxjtdxzZoGhI2MTaS8HrWAHBcHwore24m6LKpNbINByt7Le4ArjgJ6/rXoBQBlR+XfZ
         OvJPEzs4izTFY/Ym4XotTrnU88mEDb03sAFBh8M05WjkvEpeS5YIocdw3BDxBQg6DzJR
         ttGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697748392; x=1698353192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EOVMhlF0O2opQmvwajTcnPxn6OrPW52BLfQ9FmcEZk=;
        b=qkyodojJS53HuOE02AK8EmCufPW2/pvUniYG3X9YSx0d0SdfHmKUKVEm1tdOL9K+DD
         R3gDALv+EFPqIFP7UqKfeFDCLievZ3N3z14XnMZXUazoADI53IFAIipLp2pakLFNp2bw
         EKV6+Nd8hPs0c1beXMbJa1XSsM/eAIqKfEx/1PktB5mzdHpGlEVURsnb5gR793nxSYfN
         mJ0uiyq2wzaGrXXTaqEPbeOAmCyPrPjo5uYQV+n0zE1VOsaO9P/5fw/29xq2/1d7AHKn
         3KYed4qyup0gugXkjjLNO2VMXATlAwtRsvnWjgkjH7nhXOtcKNAj5imN6POi7i/RXAqE
         qwNg==
X-Gm-Message-State: AOJu0YxP+TEyTsVBIWciQwsmT882gy2620nPL3wwiYJhEt2G3HNTeC8C
        Uj3WNC6rB7ngeiWRx4yW4XE9KvKW6y4R82kND68=
X-Google-Smtp-Source: AGHT+IF9W+F50XWILHgjNKb+7Qk4mQJUuFgGzMX8DGmE75RBgqQ+wFDOUMMZ3waM5mi/ncWLKdceOw==
X-Received: by 2002:ac8:584f:0:b0:417:a2f9:bba6 with SMTP id h15-20020ac8584f000000b00417a2f9bba6mr3722055qth.60.1697748392295;
        Thu, 19 Oct 2023 13:46:32 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id j9-20020ac84409000000b0041811e71890sm83771qtn.33.2023.10.19.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 13:46:31 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] futex: Don't include process in key on no-MMU
Date:   Thu, 19 Oct 2023 16:45:49 -0400
Message-ID: <20231019204548.1236437-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On no-MMU, all futexes are treated as private because there is no need
to map a virtual address to physical to match the futex across
processes. This doesn't quite work though, because private futexes
include the current process's mm_struct as part of their key. This makes
it impossible for one process to wake up a shared futex being waited on
in another process.

This patch fixes this bug by excluding the mm_struct from the key. With
a single address space, the futex address is already a unique key.

Fixes: 784bdf3bb694 ("futex: Assume all mappings are private on !MMU systems")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 kernel/futex/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 514e4582b863..d4141b054718 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -248,7 +248,17 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 	 *        but access_ok() should be faster than find_vma()
 	 */
 	if (!fshared) {
-		key->private.mm = mm;
+		/*
+		 * On no-MMU, shared futexes are treated as private, therefore
+		 * we must not include the current process in the key. Since
+		 * there is only one address space, the address is a unique key
+		 * on its own.
+		 */
+		if (IS_ENABLED(CONFIG_MMU))
+			key->private.mm = mm;
+		else
+			key->private.mm = NULL;
+
 		key->private.address = address;
 		return 0;
 	}
-- 
2.42.0

