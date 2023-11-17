Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091FA7EF81D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjKQUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQUBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:01:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F017AD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:01:14 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ce618b7919so5934275ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700251274; x=1700856074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PagaqPISiFMUN5ZfGlzy9E8bahGMoCf4MLBDz6dwo3U=;
        b=qrEa9VIkFCMc8UBv7aN8NJGTiooZ3UXuqTzX9IXIH9ecQaAlMXRgmud2bwOJ5autrh
         bGI6CsxP5fGAs62q462ClRCpxepC24dE7VSLqKg8YOO8FdcfTcn2y7AWfyXFlrXbR/Ge
         aCNLa3zRDr/xs03Qhp+AdBZBDo2VF54PzuUVKAaRgkJZK/Up06vcQdLFzVC/4sQv7AKY
         2b58QpujQeY7AaIHJQH8F27596dG1cg7JUFKE7wONJNgJnfcPzYEKke/nPMh4O4t/oVF
         9QyxexuSeulKwx1CfulQplwD/LYICJfeCv2P4JU8UhqvsvAOgY0acEiSzaTuOtrhR8wm
         QP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700251274; x=1700856074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PagaqPISiFMUN5ZfGlzy9E8bahGMoCf4MLBDz6dwo3U=;
        b=PhwrRHmDd6nsCqLncrMDbfG9pTJ3KwgBIhz6dxVipd5JvwpSUQugdtwDeqyKGLiY/p
         Vhp3euMF37SApmXO/0RwPWA5QpGKwovw9kKUskOztFQ9mmNExt0OCKBA5oOGOgZc1YKf
         hQKmwXP0kaCWKRTPCwJMsa6pNGx6CeBaKjWmaC87QKYaiR/bOE+v4OHgI6yTdFqc71xU
         dZl4hA2bZd9dnRz4kG/YCaAe3XK0AVWYmEo1axzTSqRVMaQT63xKUFz+G+EMG7lgD9t4
         294Pq3bsiBrJ94KsqCV/5TdOzHZ2kELXLxfINObiRpqtfQA77glewTVjnPjRpSR6VRly
         ZEbw==
X-Gm-Message-State: AOJu0YxLZj744PdIguIjfFmTpXu8+8iSDqDQlTI9Fall+7xgeZkOHFar
        l5O8MfINvNlo+bpPSCC3xC6U4A==
X-Google-Smtp-Source: AGHT+IHWyullGhPD+gZObx6KM81Mz06irM+FIueUcekK/sxdqjmscsmQoE/71DHzli6umycW8VRUeg==
X-Received: by 2002:a17:902:f684:b0:1c0:afda:7707 with SMTP id l4-20020a170902f68400b001c0afda7707mr127578plg.34.1700251273779;
        Fri, 17 Nov 2023 12:01:13 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bf1-20020a170902b90100b001b53953f306sm1749737plb.178.2023.11.17.12.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:01:13 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 17 Nov 2023 11:56:12 -0800
Subject: [PATCH 2/2] Correct type casting in module loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-module_fixup-v1-2-62bb777f6825@rivosinc.com>
References: <20231117-module_fixup-v1-0-62bb777f6825@rivosinc.com>
In-Reply-To: <20231117-module_fixup-v1-0-62bb777f6825@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make static variables static and use __le16.

Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/module.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 56a8c78e9e21..9f2dc2c0e436 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -45,9 +45,9 @@ void process_accumulated_relocations(struct module *me);
 int add_relocation_to_accumulate(struct module *me, int type, void *location,
 				 unsigned int hashtable_bits, Elf_Addr v);
 
-struct hlist_head *relocation_hashtable;
+static struct hlist_head *relocation_hashtable;
 
-struct list_head used_buckets_list;
+static struct list_head used_buckets_list;
 
 /*
  * The auipc+jalr instruction pair can reach any PC-relative offset
@@ -64,7 +64,7 @@ static bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
 
 static int riscv_insn_rmw(void *location, u32 keep, u32 set)
 {
-	u16 *parcel = location;
+	__le16 *parcel = location;
 	u32 insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
 
 	insn &= keep;
@@ -77,7 +77,7 @@ static int riscv_insn_rmw(void *location, u32 keep, u32 set)
 
 static int riscv_insn_rvc_rmw(void *location, u16 keep, u16 set)
 {
-	u16 *parcel = location;
+	__le16 *parcel = location;
 	u16 insn = le16_to_cpu(*parcel);
 
 	insn &= keep;

-- 
2.34.1

