Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87E280B198
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574957AbjLIBwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjLIBwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:52:10 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156D6172B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:52:16 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d08a924fcfso24838025ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 17:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702086735; x=1702691535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=K1h100B6rjxyBFhxrdSH5Ur+K5ujhSlU9cdOG0Eg1zw=;
        b=f8zEuyxSOLLLwFoajahMGRTvF/B5r80n+uP7gCQ6XpWa9F3RMXE1GWmgagTchOC3Ig
         wsvpIiVEqE/h4wD6al3VFxE4OM08sLaCN10ubkw/SVsJYo226F1cKSxzglEI/Sp5NfFz
         Rn4wF283H0a7UGISO0g5fWn/5LM5SvOFgWLXAd45xgjryOTsLtBfY32JVa38FgzgtHKb
         /e0NNteJAtj0h/OGJFq1XGROxfP80kdCnayeu1fh46N6yAJEVt5OeYW7moidaiTnQbXu
         t5LwiXY9ie8Jm7P2h7+ygyGnPMrtQVrp7wCeHm0EHQ6cCehI27CQ7wm2xf686MGkNRId
         Ggjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702086735; x=1702691535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1h100B6rjxyBFhxrdSH5Ur+K5ujhSlU9cdOG0Eg1zw=;
        b=EidObgrieJ3VrCpTjxAAZUMPtq7sWB3bfQ6MMvAIovZ5Z0alQg9cgxs3IfAOI5MQtK
         q4OZaXpc2EGb6gAWN0MU56oX/0A6VsS9zBZqpvlX6TIOkSRqC/LkUR5Td1BuTxoP8PUB
         ZKbsZayonc08bIffVA1Jqe9bz67q3KjYEUDYS4dDoMwvmkARqnIgVlzexNAdzEfEKW9+
         Kb3BWfi6qyPRkS7v+tlpjCb9O0TPcQI4BUFoqkap1CuX3MZn7W1+62rGzUZ6bLvtqold
         gkcMvfTq8dkPg1BHtJ4k7E1FYFelA9uf3wqtE7uPwgs1tKafienh4fbqumUj2olqu5Mp
         MT0w==
X-Gm-Message-State: AOJu0YwG528utgUY80UHjt51njdmYLqTJsv8cfT6JOnZxxVcqkxr9hID
        EcC/Vz4vXbgJUz+gUJdKq7ZyGyIA3NcAlg==
X-Google-Smtp-Source: AGHT+IHSp1UWhkp1RZkMgC5fh8wg1F0fMcJCJefjtVs2a8zJaGbmy/bnfWcus6mP69lpWNulTfSCAQ==
X-Received: by 2002:a17:902:9f87:b0:1cc:5a74:b1df with SMTP id g7-20020a1709029f8700b001cc5a74b1dfmr1034535plq.2.1702086735356;
        Fri, 08 Dec 2023 17:52:15 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7a1f:1c3b:5ad2:1af2])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001cc8cf4ad16sm2370142plg.246.2023.12.08.17.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 17:52:13 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Guilherme Amadio <amadio@gentoo.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH] x86/nmi: Rate limit unknown NMI messages
Date:   Fri,  8 Dec 2023 17:52:11 -0800
Message-ID: <20231209015211.357983-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some AMD machines, unknown NMI messages were printed on the console
continuously when using perf command with IBS.  It was reported that it
can slow down the kernel.  Let's ratelimit the unknown NMI messages.

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Guilherme Amadio <amadio@gentoo.org>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/kernel/nmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 17e955ab69fe..d23867901186 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -303,13 +303,13 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 
 	__this_cpu_add(nmi_stats.unknown, 1);
 
-	pr_emerg("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
-		 reason, smp_processor_id());
+	pr_emerg_ratelimited("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
+			     reason, smp_processor_id());
 
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
 		nmi_panic(regs, "NMI: Not continuing");
 
-	pr_emerg("Dazed and confused, but trying to continue\n");
+	pr_emerg_ratelimited("Dazed and confused, but trying to continue\n");
 }
 NOKPROBE_SYMBOL(unknown_nmi_error);
 
-- 
2.43.0.472.g3155946c3a-goog

