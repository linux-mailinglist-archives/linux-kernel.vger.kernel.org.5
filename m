Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676CC7F4F75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbjKVSZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344399AbjKVSYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:24:44 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C143A2;
        Wed, 22 Nov 2023 10:24:39 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so1013661fa.1;
        Wed, 22 Nov 2023 10:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700677477; x=1701282277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygdtXD6vQmhTkyIIFbEZLW4cEgmK3nTQybwd/aOy/dw=;
        b=DlWSmf+8f7QUpkhL5IcS9u0DvbcRC+XQ2AlTWBtvdwo6I7b9ZyEr4vo3GD+Ogt7xl/
         kEi6YuCS0Na4VtPiUpZVeFdeb+7xr5TtvfLLtveGP+3wfwK3Qj7xbDsq+JijgqcoMvzB
         HJ91BZuP1gXhOCvD1KRu0J4wHtZDb86i46ivcPCc9ZCHkEgGl3mJdYwNWWlcpwRld1lq
         zh/6sXcFw2nQkvz54rJgbI9LMhY5teVDWWXDzQAZTY9Ucrv4TvsPkipmFwUFM8ElctwC
         Iv9lotx5l+Tgp/U0ZHnQs2gnm8c8W5vfjmd7eOCnHbR+XXv2c7MA2W2VngqHqkyl6JzT
         ECVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677477; x=1701282277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygdtXD6vQmhTkyIIFbEZLW4cEgmK3nTQybwd/aOy/dw=;
        b=t9zj5TJn0HAptGgV9zU4uTLn62sTHZX+tEUnUc7Yto2zrrddJBBnImdoe0lb3AF2t5
         vYUzz+b9RoFsy0jFv/FogP1Q5JADKl79wY64j7D7ETFjS2mhP3cvtv+rRLQQXaSC+FOa
         5W8u2zTXs1T0GTxeEifivNT81hWDM0cLlnUqm7qw0phMBT9yfFgytU+OW8jxR5wkxUsM
         YQvCmR+jgjY0wLnyjjYllEINKKGIwR1AJxCbGcF7hLm9VZF7+xecYHN0inqm92p1bDL6
         QACVpt8ayPTHzbAWxc8ZMxXegTpGq3IBx17RLv6aeI+qoedk14K7eTGmtSjOSvm9Dnzj
         X3oQ==
X-Gm-Message-State: AOJu0YycL3Mg0WYFsTTT7WS1l2DtlEJz58aDeaINd87eNlTY7wgTiuLV
        f2phgWK1i6RQEnfrUxMLmvI=
X-Google-Smtp-Source: AGHT+IGOQXheOS+Gt4rJnqKjpbv7GijHFeJguvjzbMNW2BiOOY31AXGILBqTgE/H996cdvS6H0FlrA==
X-Received: by 2002:a2e:9d54:0:b0:2c5:15dc:ba99 with SMTP id y20-20020a2e9d54000000b002c515dcba99mr2236124ljj.51.1700677477316;
        Wed, 22 Nov 2023 10:24:37 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w5-20020a2ea3c5000000b002b9e5fe86dasm11422lje.81.2023.11.22.10.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:24:36 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mips: Set dump-stack arch description
Date:   Wed, 22 Nov 2023 21:24:05 +0300
Message-ID: <20231122182419.30633-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122182419.30633-1-fancer.lancer@gmail.com>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
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

In the framework of the MIPS architecture the mips_set_machine_name()
method is defined to set the machine name. The name currently is only used
in the /proc/cpuinfo file content generation. Let's have it utilized to
mach-personalize the dump-stack data too in a way it's done on ARM, ARM64,
RISC-V, etc.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/prom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index f88ce78e13e3..6062e6fa589a 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -28,6 +28,8 @@ __init void mips_set_machine_name(const char *name)
 
 	strscpy(mips_machine_name, name, sizeof(mips_machine_name));
 	pr_info("MIPS: machine is %s\n", mips_get_machine_name());
+
+	dump_stack_set_arch_desc(name);
 }
 
 char *mips_get_machine_name(void)
-- 
2.42.1

