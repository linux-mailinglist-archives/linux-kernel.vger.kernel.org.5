Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E32C7F66CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbjKWS6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKWS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:58:30 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA777D60
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a02d91ab195so164042766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765915; x=1701370715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE4taij5q3MAjmiPUZKHE8qoF6TdBc6iBW1aIWJ4LYw=;
        b=lMrpwtT8QXuTgaqbLHjMRLG+t/59U5KedCK3NhKbEPpJsOdmFxMIlvx20vmYNZmfZ1
         t13Y4JlUqz6slxj+Y1gpzbxy1iVr7T5P2iv44BpGYDowATlcyY54kL/bwWWCJWgUE0+n
         9vl6cs0AL0N3jHUtD0nzAEs7oRP3sm8ss/blYAh150OvKZmTQJRRQq235qcHmienZaNr
         RRABTWM18akM09CCl/NxPIBNcKv1pkFrDN/pnXOunehrWUBmi6lHNdHwWmcWrgjli6mT
         i9bvVEy97zRThVaey22nhFtN2oau0W2qo6YwmpYcYG/rv+mMkfpTDd/xdNbdJfEx0x1J
         katA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765915; x=1701370715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE4taij5q3MAjmiPUZKHE8qoF6TdBc6iBW1aIWJ4LYw=;
        b=bOAKAL1MJVHW89gGGqonDJbbLkxb/RRvjx3D98TrYpug+rhRYyIq958up1YPjwdffO
         31OCYrZPG+P3YgaVjEASd571oVJMYisZzgVdAwj0g+cFae1F2zUMvLQ4jcmkafu6HYMM
         3mZvOB7tXYza486DwFY2FvXYj25OeykXzgJDe1gfzwemi+UB9njFKEF046zQOcqpMzTA
         HC8Kz++eJX5n4IKHf91279S1/4nkPkSGmQw2C1S4m3Orw/AxBbdDHOPWCWNnSVb1hsU4
         TlPXgipap1AJObRxVvnnbkhbBQNvu+byGNMONtwg0xRzApMW2V4D24mcee2/lDemQ11Q
         vY4g==
X-Gm-Message-State: AOJu0Yxg8ZUj3bNXGkHKhpCXDQm8Ludata0aQk9RDJ4CHD/4ucCcOdgu
        yaoeQA2XiIlbuY2N6+zXE/msog==
X-Google-Smtp-Source: AGHT+IGq6dOMJJMtU5Up+yGiMT76gDi7Z83Zw3jt75JpsMbNdpOYO4U2mN9YDUlYYRNjg8nPchbdWA==
X-Received: by 2002:a17:906:1ccd:b0:a00:a591:929 with SMTP id i13-20020a1709061ccd00b00a00a5910929mr195955ejh.24.1700765915300;
        Thu, 23 Nov 2023 10:58:35 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:34 -0800 (PST)
From:   Christoph Muellner <christoph.muellner@vrull.eu>
To:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 5/5] tools: selftests: riscv: Fix compile warnings in mm tests
Date:   Thu, 23 Nov 2023 19:58:21 +0100
Message-ID: <20231123185821.2272504-6-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Müllner <christoph.muellner@vrull.eu>

When building the mm tests with a riscv32 compiler, we see a range
of shift-count-overflow errors from shifting 1UL by more than 32 bits
in do_mmaps(). Since, the relevant code is only called from code that
is gated by `__riscv_xlen == 64`, we can just apply the same gating
to do_mmaps().

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/mm/mmap_test.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 9b8434f62f57..2e0db9c5be6c 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -18,6 +18,8 @@ struct addresses {
 	int *on_56_addr;
 };
 
+// Only works on 64 bit
+#if __riscv_xlen == 64
 static inline void do_mmaps(struct addresses *mmap_addresses)
 {
 	/*
@@ -50,6 +52,7 @@ static inline void do_mmaps(struct addresses *mmap_addresses)
 	mmap_addresses->on_56_addr =
 		mmap(on_56_bits, 5 * sizeof(int), prot, flags, 0, 0);
 }
+#endif /* __riscv_xlen == 64 */
 
 static inline int memory_layout(void)
 {
-- 
2.41.0

