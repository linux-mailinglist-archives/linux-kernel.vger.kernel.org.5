Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793A08028F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 00:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjLCXUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 18:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjLCXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 18:20:36 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586CFD9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 15:20:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c08af319cso9684455e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701645641; x=1702250441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl45wvWcP4iiFsyKLXsZFij0FbjKyVAo4CJ25+GOTjE=;
        b=Vw+cIUHFphIuGolOq/WjcyMdohXYFmMDnOwx+bjwMIwg0mh47gehGK271JPmQhuQuz
         4Tw12YGtyYd8z9kmpGnN8XjxH5UhNZ+Tx/DZUAxMXHhxFsdyq5g13RJGrK//IkELPcEj
         QoaXQYxMx+9co82ysMC3cIJW2EZImZDK2oGYFgEytSR9Wt1k7S7M4X42570VQBp7LhVd
         KuNQ3pHGjnwe+xjZIzxlmBE5v0XoFqGZ5+6naszr90gR/RHnkWpFKEulB+Let10VUvC1
         Wf+KRpI94Qn1ZYYQHhvPZrEG2FlH4het168PZNRUHu6A9FdlR/cNtJuAMS0Smro7d9A0
         q6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701645641; x=1702250441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jl45wvWcP4iiFsyKLXsZFij0FbjKyVAo4CJ25+GOTjE=;
        b=CAE1kG9eK2xr4ZrcfNjx9M/F+Mb/Wt3wTBmL25pIebnsiWG91n4HOtaMtM6nXSSCsJ
         iSiTZ6iZByqLiosFtOHi1VOgLvGIhBmgxfcfydvZXYuOUuGn6OQFe+rUGkIKBdpKy5eM
         vxSoQpww7cYIr+Nyl7I/TM3fBj6gSgfN70J7KakagYwzdx4CYUz/3LNDGMrwzPi9pp1I
         HEtiXbFXslAkp0ja7Yt/kJC11wPL4VXmOqiDsKCrDsR35eSfseV84bh2Xqkhjo1MykXl
         B10T0waveREoUkA5EsQfi7+b6Pn+eRAVL5Xgl+jSIU16qfeJnLNl9+8xVHGUYwi49fs2
         k2Fw==
X-Gm-Message-State: AOJu0YxrHzaJVDoU7SD69gq/Arrg0UFE1LGgvwGpzP5C9mXgnzSQulxH
        QpOuJOO+spAXPiCFX3FbMLn40J+ZA5defQ==
X-Google-Smtp-Source: AGHT+IH/kIgKYu8li0ZGcECa/mT7UIUaI7PiEXF0n4u5t7B1OjUBocBX5J2yipih5lbb95unE69t0A==
X-Received: by 2002:a05:600c:4713:b0:40b:5e1c:5c26 with SMTP id v19-20020a05600c471300b0040b5e1c5c26mr1947287wmo.59.1701645640562;
        Sun, 03 Dec 2023 15:20:40 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b004064cd71aa8sm11566222wms.34.2023.12.03.15.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 15:20:39 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip v2 2/3] x86/traps: Use current_top_of_stack() helper in traps.c
Date:   Mon,  4 Dec 2023 00:19:39 +0100
Message-ID: <20231203232017.994963-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231203232017.994963-1-ubizjak@gmail.com>
References: <20231203232017.994963-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use current_top_of_stack() helper in sync_regs() and vc_switch_off_ist()
instead of reading top_of_stack percpu variable explicitly.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81..78b1d1a6ed2c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -772,7 +772,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(pcpu_hot.top_of_stack) - 1;
+	struct pt_regs *regs = (struct pt_regs *)current_top_of_stack() - 1;
 	if (regs != eregs)
 		*regs = *eregs;
 	return regs;
@@ -790,7 +790,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 * trust it and switch to the current kernel stack
 	 */
 	if (ip_within_syscall_gap(regs)) {
-		sp = this_cpu_read(pcpu_hot.top_of_stack);
+		sp = current_top_of_stack();
 		goto sync;
 	}
 
-- 
2.42.0

