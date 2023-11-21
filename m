Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C177F3833
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjKUVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjKUVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:20:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C7D76;
        Tue, 21 Nov 2023 13:20:43 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc5b705769so53531915ad.0;
        Tue, 21 Nov 2023 13:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700601643; x=1701206443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8UP31zz2tzNyQ1XI1JgNxsSlBbVYVcKRejtDKCckFA=;
        b=EQvFRD4xS0Od02YOZ89FSXUma5aS1JF8NLEsj3EHY2PokkTlrckc/oaQGvN+T+GqIz
         oUbBAQmU9m9bdG5GULvBeGmc6ddF8O+8dhT9wiUOrikXEd6vGDCk5Z6qT+oXzonIeOBj
         sOmUMfxnplAyO80Wlrx/LVHjJBNH+ab2kZSmll2Qo3gIlRYBFdNnnbh1yfLiC2JxDgE5
         dE7UpZ5X9IOf/ISlPzN8MthizhHvgM+MZMeAYGzmJ0eg/dDcgtwBh7hLmO4CHcW7Ads0
         sSYWh9MgW/CnXlhPB03cNXdABx5fmbDglcPoD1p6zruaw3ieE38hwDQLGPopCnWxHose
         QMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601643; x=1701206443;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r8UP31zz2tzNyQ1XI1JgNxsSlBbVYVcKRejtDKCckFA=;
        b=stjgxx6USQfk8Ap7GZ8JXFAId15KpZAxbEGFul8xgAbgGYyERhrq1DfeHB8smYJrKR
         s48wbyhlm2yr4tuOlAwVyX9l2A7Jj7DhKOYdKSpZSTb5HmjNyyyAfe/5ntNHhvNQtApA
         WRQRn4YysUeFuzhc9hCV3h1Az9H93LYAnsDkewEkglwdoTaBpCOdKG6wMAPhTR7nohhQ
         bw94a7c1ym2kI98sOw7q0oYFvFCIR1tWla4SzoaRN2j8Et2yQ+GjKWKCbIxrGWeEiI5v
         3TcwmZf7tqtY3QRRqe3QLvEzgkL/OgSYjJXySmL6VsS9PBxlDBAbdXmLek+zaMUlpL4K
         Vfng==
X-Gm-Message-State: AOJu0Yxvf3FnvzfvVXeqj6uecIVACvPFi75j4wNyPMFkU+yXHyqi7BKp
        a/QEEzMKydsIH6ohs4Z2zLc=
X-Google-Smtp-Source: AGHT+IGw2VRIF1KG5D53DbB1/O4g2GnYpBfD7Y44LMA28ENuVB/Zgq+24fLWa4HnCMkuyOoJyBsYkg==
X-Received: by 2002:a17:903:1107:b0:1cf:73ff:b196 with SMTP id n7-20020a170903110700b001cf73ffb196mr470013plh.8.1700601643193;
        Tue, 21 Nov 2023 13:20:43 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001bf52834696sm8281924pll.207.2023.11.21.13.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:42 -0800 (PST)
From:   mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        thomas.lendacky@amd.com, ardb@kernel.org, jroedel@suse.de,
        seanjc@google.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 8/8] x86/mm: Add comments about errors in set_memory_decrypted()/encrypted()
Date:   Tue, 21 Nov 2023 13:20:16 -0800
Message-Id: <20231121212016.1154303-9-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121212016.1154303-1-mhklinux@outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mhklinux@outlook.com>

The functions set_memory_decrypted()/encrypted() may leave the input
memory range in an inconsistent state if an error occurs.  Add comments
describing the situation and what callers must be aware of.  Also add
comments in __set_memory_enc_dec() with more details on the issues and
why further investment in error handling is not likely to be useful.

No functional change.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/mm/pat/set_memory.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7365c86a7ff0..f519e5ca543b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2133,6 +2133,24 @@ int set_memory_global(unsigned long addr, int numpages)
 /*
  * __set_memory_enc_dec() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
+ *
+ * If an error occurs in making the transition between encrypted and
+ * decrypted, the transitioned memory is left in an indeterminate state.
+ * The encryption status in the guest page tables may not match the
+ * hypervisor's view of the encryption status, making the memory unusable.
+ * If the memory consists of multiple pages, different pages may be in
+ * different indeterminate states.
+ *
+ * It is difficult to recover from errors such that we can ensure
+ * consistency between the page tables and hypervisor view of the encryption
+ * state. It may not be possible to back out of changes, particularly if the
+ * failure occurs in communicating with the hypervisor. Given this limitation,
+ * further work on the error handling is not likely to meaningfully improve
+ * the reliablity or usability of the system.
+ *
+ * Any errors are likely to soon render the VM inoperable, but we return
+ * an error rather than panic'ing so that the caller can decide how best
+ * to shutdown cleanly.
  */
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
@@ -2203,6 +2221,14 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	return set_memory_p(&addr, numpages);
 }
 
+/*
+ * If set_memory_encrypted()/decrypted() returns an error, the input memory
+ * range is left in an indeterminate state.  The encryption status of pages
+ * may be inconsistent, so the memory is unusable.  The caller should not try
+ * to do further operations on the memory, or return it to the free list.
+ * The memory must be leaked, and the caller should take steps to shutdown
+ * the system as cleanly as possible as something is seriously wrong.
+ */
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
 	return __set_memory_enc_dec(addr, numpages, true);
-- 
2.25.1

