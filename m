Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915C580E17E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbjLLC2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjLLC17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:27:59 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEA3B5;
        Mon, 11 Dec 2023 18:28:05 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5e1a2253045so6489357b3.2;
        Mon, 11 Dec 2023 18:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348084; x=1702952884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Tx1ZYksYJvVzuOD+JQP20UpTW3NnHVR2BOmbC32l24=;
        b=a8xtZAqnpZmxgaldmGbl8zDfw4wGIe4uHry2UiKo2zru/lOtfdVstM7hB700pxlKYW
         3H9Ia6HB7n2jiNIZ9mB2RKeNktz8q/qFk3RxdklUxh2VVT2y7b/VF1CmOlFPxRncWnPH
         mHJj4OzALSXwXiHojrjyXNZyucPR+I0BTZfzqu+mx6TonaYZy6nryn2P3WA/Qjs6J/Bn
         sYOCyoXCweuD2oVc1tcP6LcK8ixwdpMswad98wl4m/inTvYQBQKV/c5lpqH1sNWcS2HV
         ydziDWwQIP440jviJbloUYBEzZr3WW9bEqIbIjoje1Qgch+n4+MzzHKmFTaQYrupfJns
         tDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348084; x=1702952884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Tx1ZYksYJvVzuOD+JQP20UpTW3NnHVR2BOmbC32l24=;
        b=eaXO6BQrUfnzhHbI9TNw3NjZ9fa+jOcvyvSrcfl7XaoqE5JAvp/ekqPqDf6r7w8akp
         Pm7bTSJ8t2VGmwdaw2+A+T3VnlwMOch23OvaQ2ffMEYjg3B1SbkZTOsVVQ7xib2sGa5Z
         l4eWFsVEUreJYymF5Bb1arUK1uRQytsh8xQYqeOW3zBJJwdBsOu6tX7UOWNmYOEYcdSE
         gb8KG9V9Db3KBnjapl8e9SX/Mz9XodDdFqCRc2eWmbPupsQdPwx6uzcgUndRkETC6tSU
         7vtVY5hs0SicVxxdAXWpxuNH9P2NQaIyLfY2X9K49cWCubkDxyV+CaGnW6Nw3W01NZKh
         g8iA==
X-Gm-Message-State: AOJu0YyPOsDtzqPgeWM/1mbCI60hPoU7rpsff9db+KKFjjtY2XGBRsik
        bqpfyOqDp2yGdn45TgxhqCAY2U8mxLcKaw==
X-Google-Smtp-Source: AGHT+IFbwgCjyr+symSCwmcMVav+/mrWq62DYtu0MzRNEMdwEGE9s7dNj9rtNAhSKnWPycQvxu7lTQ==
X-Received: by 2002:a0d:cc8e:0:b0:5d3:8400:ba9 with SMTP id o136-20020a0dcc8e000000b005d384000ba9mr4160559ywd.48.1702348084007;
        Mon, 11 Dec 2023 18:28:04 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id k7-20020a0dc807000000b0059a34cfa2a5sm3422328ywd.67.2023.12.11.18.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:03 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yury Norov <yury.norov@gmail.com>, linux-mips@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 06/35] mips: sgi-ip30: optimize heart_alloc_int() by using find_and_set_bit()
Date:   Mon, 11 Dec 2023 18:27:20 -0800
Message-Id: <20231212022749.625238-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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

heart_alloc_int() opencodes find_and_set_bit(). Simplify it by using the
dedicated function, and make an nice one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/mips/sgi-ip30/ip30-irq.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
index 423c32cb66ed..3c4d4e947817 100644
--- a/arch/mips/sgi-ip30/ip30-irq.c
+++ b/arch/mips/sgi-ip30/ip30-irq.c
@@ -28,17 +28,9 @@ static DEFINE_PER_CPU(unsigned long, irq_enable_mask);
 
 static inline int heart_alloc_int(void)
 {
-	int bit;
+	int bit = find_and_set_bit(heart_irq_map, HEART_NUM_IRQS);
 
-again:
-	bit = find_first_zero_bit(heart_irq_map, HEART_NUM_IRQS);
-	if (bit >= HEART_NUM_IRQS)
-		return -ENOSPC;
-
-	if (test_and_set_bit(bit, heart_irq_map))
-		goto again;
-
-	return bit;
+	return bit < HEART_NUM_IRQS ? bit : -ENOSPC;
 }
 
 static void ip30_error_irq(struct irq_desc *desc)
-- 
2.40.1

