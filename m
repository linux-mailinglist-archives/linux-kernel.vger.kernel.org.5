Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DC80E4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjLLHFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjLLHFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:05:45 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B62D5;
        Mon, 11 Dec 2023 23:05:51 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-20307e91258so11220fac.0;
        Mon, 11 Dec 2023 23:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702364751; x=1702969551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxQYxpYcrWIqvC1cKCSYLMPQZtsdrNIv93BxHbphWrs=;
        b=JgTJApR5diAcVXCoDKGxz4igZ2fxk6devxE9l9aWilUpCLVEt5hmDACOGpCpuA1Kd7
         O1AutN5f6LoIcQFujNmEGDXvHpMkonwiovwiEdVLC/aYmMnjMJe0FQr7K6pC1qGd79Dp
         lgx03+MTLgyMI+Q2o8SztL+H4dkKuAIKcFkfZintzgqeMyVYmvqyRwE3p1E8Paljh+w3
         GhWb9iaUapjrdswi7RROufbt6WRZoNd2DXNPZwKEMNNM+ZAKmGEqgRJJ1tJ2bGd/xr9+
         rV2ocCQslbnjJHJo9hJYXHQg4Xt1grGXJempUkLbUKzIL1ddH+MfPRKRGIvYTj8No8yC
         uUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702364751; x=1702969551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IxQYxpYcrWIqvC1cKCSYLMPQZtsdrNIv93BxHbphWrs=;
        b=m3WwWqyjKreV11kngzPWAvuacOz1oV23+/FcPX09YyBoQCOIuQ6r6eN4Bg360UdPPz
         sqMMtF7bvM/l6drLA4njJiW/7R+/s7pKD+LsN9kjZ9PUvcrNTw2aGQFoMzr8tN7hf43J
         pQ/gPIco3ctMAceGJDQbvMfeWmc95Cih/aD6jeD0hY+zuoa/jShRjuIistByJdrUHrFS
         Pn61a23Bmgo1Tj1wW8Yz31lB/koACLMW4vXPOjdkB0b5LoJXczBA8hbULGA6HTF07Rq2
         KXomk/ud3POQahm8PITo/iwzNVSnG1wWoJc08MQT83kziQgPnbTEHCYnPMyZmYOkPWQ/
         ofaQ==
X-Gm-Message-State: AOJu0YwcRzHYMDojk45mIoQkkjeqa3pgUwcCmQvZkbLQ1VvHreNPFMME
        QTz6TOyckD9KbcAJ6Q2p5+k=
X-Google-Smtp-Source: AGHT+IFIPRwDp5aw1X9LTPnHC7HkFiMRiZ3w/V+YsEOXcNFTStkOgj3TcG3rVDdRoxEiytIyYRjrBg==
X-Received: by 2002:a05:6870:61d4:b0:1fb:75a:77c1 with SMTP id b20-20020a05687061d400b001fb075a77c1mr5353980oah.114.1702364750851;
        Mon, 11 Dec 2023 23:05:50 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7da0:5ec4:de63:3cf4])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a0023d100b006cb6e83bf7fsm7397491pfc.192.2023.12.11.23.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:05:50 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Pablo Galindo <pablogsal@gmail.com>,
        Fangrui Song <maskray@google.com>
Subject: [PATCH 1/3] perf genelf: Set ELF program header addresses properly
Date:   Mon, 11 Dec 2023 23:05:44 -0800
Message-ID: <20231212070547.612536-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212070547.612536-1-namhyung@kernel.org>
References: <20231212070547.612536-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The text section starts after the ELF headers so PHDR.p_vaddr and
others should have the correct addresses.

Fixes: babd04386b1d ("perf jit: Include program header in ELF files")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/genelf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index fefc72066c4e..ac17a3cb59dc 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -293,9 +293,9 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	 */
 	phdr = elf_newphdr(e, 1);
 	phdr[0].p_type = PT_LOAD;
-	phdr[0].p_offset = 0;
-	phdr[0].p_vaddr = 0;
-	phdr[0].p_paddr = 0;
+	phdr[0].p_offset = GEN_ELF_TEXT_OFFSET;
+	phdr[0].p_vaddr = GEN_ELF_TEXT_OFFSET;
+	phdr[0].p_paddr = GEN_ELF_TEXT_OFFSET;
 	phdr[0].p_filesz = csize;
 	phdr[0].p_memsz = csize;
 	phdr[0].p_flags = PF_X | PF_R;
-- 
2.43.0.472.g3155946c3a-goog

