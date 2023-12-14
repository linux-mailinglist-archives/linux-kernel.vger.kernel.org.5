Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB81813678
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjLNQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjLNQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:40:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9811B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:40:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d351cb8b82so10529615ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572031; x=1703176831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ3Qdqt0V+ZhHZ5PlObynzpb2Nb+bXeilCmC71DhFUE=;
        b=NFuagq7EQ1o5adNeSTINoY3k5HDp6hroJuKtLxQTfZljxCRPhY/ExElKll/zwihQ4l
         qCqd+lATftJnwZ90rorN5bPF5e0rwtSPxm2gdyH2ZovbOg1mCVQ+ctJT2j9i+AWURgp/
         mF/RaqiXSUtNWMoIvKSmGXY984KqDFcDcfsZMG7XpHPzVfOZbE7/gd0deafYsWchnECc
         7P/Fz69OWuVF7Ti8JswM0qmSLFfBSMUK8vX8Fd5iY9GtnbHeq2S6ynY7/HOo7GC5UsqY
         HAKb0i8NEmFv5BwofuOIH/sQVWYLMu3F7toDFu1pv6Q7zcD0+H4NocCWT+X9TE8K+Rla
         pcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572031; x=1703176831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQ3Qdqt0V+ZhHZ5PlObynzpb2Nb+bXeilCmC71DhFUE=;
        b=XTb3yfc3yr/p9E/YFtx+XXnF1wtDPh/Ern8oHSFo0Z9fKlyM1MrjH+hQsrnwIsc5WQ
         uyxK3vyX0EnmuryeOVi4IxHikuFMJpRWmvAHozqbSkTtKxNlHQ3fLCcemPJG9cv11CXF
         Ytl5Ei9SFzfIHqGMDC7W3YYFngKX+0weYr4VGdw+F+yZhWv16yx5229hSrw3O7tuq4JL
         qxG3J8BaFkkcJn0Qe2HKG3TgwpFwm3hqJrmuMP9ZDGf4ooOVmQmbjXgXEVk9Sva0JAWm
         f81jMyrFtX+l1+d6UXfuLREDz+KjjJ92fdmXfDGKjzIFUG5pxLl2B+90PijUSSP0o22m
         CoKw==
X-Gm-Message-State: AOJu0YxyhWlwNlVXGas5/ZH3LHn9zVG9YkeXfjNMXM6cG4MdmHwWOq/H
        1T/WlSdfFWm9ZDVgkmF63B+RSkIzmZE=
X-Google-Smtp-Source: AGHT+IH2DfA4x6xKySy2o3svU4hSncEcqlwcYRSA4lqR7ptqakTKaNBJD+2zF0pkzhSr+P6S1sAA7A==
X-Received: by 2002:a17:903:22c8:b0:1d0:6ffd:adfc with SMTP id y8-20020a17090322c800b001d06ffdadfcmr6419298plg.99.1702572031036;
        Thu, 14 Dec 2023 08:40:31 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm12595897plf.79.2023.12.14.08.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:40:30 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Lianbo Jiang <lijiang@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 1/3] x86/crash: remove the unused image parameter from prepare_elf_headers()
Date:   Fri, 15 Dec 2023 00:38:40 +0800
Message-ID: <20231214163842.129139-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214163842.129139-1-ytcoode@gmail.com>
References: <20231214163842.129139-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The image parameter is no longer in use, remove it. Also, tidy up the code
formatting.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/crash.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..792231a56d11 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -198,8 +198,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 }
 
 /* Prepare elf headers. Return addr and size */
-static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz, unsigned long *nr_mem_ranges)
+static int prepare_elf_headers(void **addr, unsigned long *sz,
+			       unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -221,7 +221,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	*nr_mem_ranges = cmem->nr_ranges;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
@@ -349,7 +349,7 @@ int crash_load_segments(struct kimage *image)
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
+	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
@@ -452,7 +452,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
-- 
2.43.0

