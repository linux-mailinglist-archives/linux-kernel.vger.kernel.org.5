Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68980EF99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376464AbjLLPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjLLPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:05:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE8DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:05:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2866fe08b32so3992231a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702393554; x=1702998354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3txP48XMkWU7VdifF1r+KohcEJ8EmE42oAUbDKnZrMo=;
        b=i2itJ4T5uborrMbjtJtD+rnhEgZm1WNVg6vpVm0c6VzlAU/sdxcW5kVX5yx+5x3Gp8
         VffOaMu/lsak4A4KSjtFjwsNfTTzqv8kGRtYsOkj5sKo2uA7PjqNq/xM36fZSMjdK4rg
         GN5AjkzVIE+j5gElLUgpp2U+fNh6cHQeOiHdkAec4+X8oI/uLG0IybpQ257F3/lKKBan
         Bfxr8lFA0CXH+CVu/GI6b88ofCd9uJkA8XSVuHHwneRKAKZylacYxAE8/cOF5Ftc782d
         KZJnpsqQ8n/USs9C/Po20xNyPwCMRkommD2+FvEymqKmM57xUu/uq4O7Yb5mxKjO2xrt
         ZYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393554; x=1702998354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3txP48XMkWU7VdifF1r+KohcEJ8EmE42oAUbDKnZrMo=;
        b=wIrSI7giNtsK5uttk5drRs7JiII/8DiW8dtPRXuaMCRcZbYS0rAGglywk+VeCjh8m4
         zUOpAiZ7WxZLf45WLrGLKKa++0W6l4gDU+k4iDQ+HUSXzMGjaRiXa6V3nihkrWEh3QOi
         DonWkgkjgMai3jR1efLBAQOBRZqWJ23YPfoBfjGKFtg18I0/i9BwE6CsxjUHlLkKtERW
         TgNZR6MUxEDW6mNcx59mL+f4A45pjZli0L5+bhKwz4OcD6ZqA06kvHJzzxZsPUHAMDvq
         F1DqiNwrjXHp1SQsKemZsIbT/xhBtL/p/gL1EL5cC272cE1kOQK9ov2+hQErM5gaYfXD
         63jA==
X-Gm-Message-State: AOJu0Ywczf2hXt4g2gEmdnQat6zGfwOOEKsfs6zzEbNc+RLlaj4ufX7H
        KGaM0wzntJ0fFvfsltw2Do2ERLhpwcY=
X-Google-Smtp-Source: AGHT+IHjKEVwynFnXlWyt+MOonfSE3qN4EzOLY/c2A9E5u3wQ8BJIgpVa9Tu0Coe6hXPSAjohfrC8g==
X-Received: by 2002:a17:90a:c58d:b0:28a:b5e0:b569 with SMTP id l13-20020a17090ac58d00b0028ab5e0b569mr827977pjt.37.1702393554470;
        Tue, 12 Dec 2023 07:05:54 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id pb17-20020a17090b3c1100b00286ed94466dsm9188599pjb.32.2023.12.12.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:05:54 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/kexec: Simplify the logic of mem_region_callback()
Date:   Tue, 12 Dec 2023 23:05:06 +0800
Message-ID: <20231212150506.31711-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The expression `mstart + resource_size(res) - 1` is actually equivalent to
`res->end`, simplify the logic of this function to improve readability.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/machine_kexec_64.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..6f8df998890e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -42,12 +42,9 @@ struct init_pgtable_data {
 static int mem_region_callback(struct resource *res, void *arg)
 {
 	struct init_pgtable_data *data = arg;
-	unsigned long mstart, mend;
-
-	mstart = res->start;
-	mend = mstart + resource_size(res) - 1;
 
-	return kernel_ident_mapping_init(data->info, data->level4p, mstart, mend);
+	return kernel_ident_mapping_init(data->info, data->level4p,
+					 res->start, res->end);
 }
 
 static int
-- 
2.43.0

