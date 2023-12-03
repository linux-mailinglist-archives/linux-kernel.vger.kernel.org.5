Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF24B80284F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjLCWME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjLCWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:11:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B1D5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 14:12:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c0a03eb87so6160455e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 14:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701641524; x=1702246324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIsCrkxdL3+P74omPdT684tv0k/I5V1A9sE1nd9EGUY=;
        b=cxQB0EMBcScTJ6+qad4ZPyrEbXWTVSE34X64H68hHkuTFibL2c89FwAfA9l7li6v/Z
         QSZ6b5e6L7yvGDJ7ZcAYLW1yvE/aQsk9LHqhhWg5xzyd7++XMlBUbeD0I1sIDW4ccrk0
         x7Sj9yK003j6F/bnZhWZ75UiBB6kxnn6hQ95iq9fnwukIw/iyFAKV2F7+IPqj+1Kdh6z
         vvPqaWPcg4cZ4S0Ptj//0Hayi/Arg50R7wfogiNFTwrtV0JSSy/T7J0hpcCW3Q1SzCfo
         sTMvntbLff/xSlo9N3VYNrNNMQODOocB9AvAAiZwxy6YsabwX03R9VMuBxD4VfVx8Yr4
         jsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701641524; x=1702246324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIsCrkxdL3+P74omPdT684tv0k/I5V1A9sE1nd9EGUY=;
        b=uymJj9+llHjODyxmH7974hEhuX4aMMQVd+SgEh8JfFKiBsUyQeeNeGUXAv7AXoDmJe
         zrw49hln75GZJk8AMw475H/oGSZbglExk3GOB6bymc/orraRKM+fACkhS723c9pUnLZi
         cbU6N7vL3hEBXLuXPcDCRqsK2v5IzlvW7syqy90pLbqcArxBucULQUlGE/GgFE8gybsO
         PZY17NGqZELRIRCABweksQmrsvrtmXHQB5nj4nO2Njfj4pkZ0dUTC7XBxmU+KtU33Jl2
         Rv8FPGJ78w01DuLiHpGwJvdGhXdNkTlM3t7OQhwTwuVC+C1AXbfTHDymyykDILZza51f
         P/Tg==
X-Gm-Message-State: AOJu0YxcIdE84H3D9H1+mkzFPxHkkjH0k81zWfCU1KyQy6diwwBc5UxS
        LY66/x1zbkOdLlGeVLEMvVg=
X-Google-Smtp-Source: AGHT+IFNOQfipqO6R9CgGxonCq6Hk37UjxpbaasEIFcin3RUO4wj4xzTs3ZmVl4E4+EMrhj7OOJlJA==
X-Received: by 2002:a05:600c:4f87:b0:40b:5f03:b3b1 with SMTP id n7-20020a05600c4f8700b0040b5f03b3b1mr978076wmq.211.1701641524194;
        Sun, 03 Dec 2023 14:12:04 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b0040b397787d3sm16589181wmb.24.2023.12.03.14.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 14:12:04 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 3/3] x86/percpu: Avoid sparse warning with cast to named address space
Date:   Sun,  3 Dec 2023 23:10:54 +0100
Message-ID: <20231203221151.794615-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231203221151.794615-1-ubizjak@gmail.com>
References: <20231203221151.794615-1-ubizjak@gmail.com>
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

Currently sparse does not know about __seg_fs and __seg_fs named
address space qualifiers. Avoid thousands of warnings about unexpected
keyword at the end of cast operator by removing named address space
qualifier from __my_cpu_type() when __CHECKER__ is defined.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310080853.UhMe5iWa-lkp@intel.com/
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 7f6e978e21b1..07ee2aedb1f6 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -96,6 +96,15 @@
 
 #endif /* CONFIG_SMP */
 
+/*
+ * FIXME: Drop this hack once sparse learns how to ignore
+ * __seg_fs and __seg_gs named address space qualifiers.
+ */
+#ifdef __CHECKER__
+#undef __percpu_seg_override
+#define __percpu_seg_override
+#endif
+
 #define __my_cpu_type(var)	typeof(var) __percpu_seg_override
 #define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
 #define __my_cpu_var(var)	(*__my_cpu_ptr(&var))
-- 
2.42.0

