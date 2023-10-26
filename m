Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225387D84C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbjJZObf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345180AbjJZObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:31:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC711AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:31:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50819c4ad6fso316698e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698330688; x=1698935488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1dcX0dIRRrObAnF5frYkpK4OuCll9+8enWqXlC/Z8E=;
        b=r+ITtGKyJwdQ5ptBp+iLE3dx2El3nF1hbe+sdjh4Nnnq1tVNdbpjVXVC7TKVltHUwC
         Nl2gtYIjIPMu2uzhSA9525B5tgW3FszuD9J6VrQ3SC14OHOPaFqkc53rlYm4q8v1JRhP
         MZLWp80kcU+Bp9Re3rJA9NuGAlzVyuqb4/C45WBkCEwiHidNfJYkkG0yTcEwQyGKcEYQ
         GU6hOLa/xOF/PL8A4AzNik+beSfbIZIR8k79usrs3AGhiKCpEdoSHUB23S5S0aqpSbbL
         th+T3TdptY7FoZlxOxlJYpufgOJDAkRMLa22aLkVJgXs3QKNOG3t8wP9Brdt/D8xVamN
         T91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330688; x=1698935488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1dcX0dIRRrObAnF5frYkpK4OuCll9+8enWqXlC/Z8E=;
        b=lPmfPcCl4aaw5hZk1klp5Us8gR4sGI5Yv3i5+vi8zu1zk7xEfVibvbCICJEOiRzE0j
         ajG11nU/pEoq9/OZw460UE+pJ9Mni44Tji0M7siXc3jYF7ZdkHkMP1FzSf96VKfo27c2
         IPXLsigNWVsZnguPxcsToRSfIsZtVFg6zicu1MUvKwfA/nZfGq3HAUBhLhp41/rofAKB
         fK9z9AAawtksodP8GIIZhzomaKs3QQ0ChhCvnvaTWvA0lyYt81ig8frsV3kpetovzzkO
         VWMaoMIi6mIPkoG0styuako18rjUPb1T5KWQwi9KtttXzPlFXdTwzgIFHY89O6zRJXGo
         qk5w==
X-Gm-Message-State: AOJu0YzKZ0Q1DOWrWWpukxR9v1KmGbFzSKAoKq1GE1JIO5et51uoEw3g
        zkhmiB7NuoFrcv/baDUyqvgJ/w==
X-Google-Smtp-Source: AGHT+IFmVffviYe4SnJWF87coMF05M74cu5j7URH/064z6PBGryKofvqvntRSm7MdXJtr+wPs+ZT7Q==
X-Received: by 2002:a05:6512:3c8f:b0:507:94be:adcf with SMTP id h15-20020a0565123c8f00b0050794beadcfmr13384462lfv.2.1698330687613;
        Thu, 26 Oct 2023 07:31:27 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:b380:32be:257:5381])
        by smtp.gmail.com with ESMTPSA id r9-20020a056000014900b003232f167df5sm14316589wrx.108.2023.10.26.07.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:31:27 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Himanshu Chauhan <hchauhan@ventanamicro.com>,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH 1/3] riscv: add SBI SSE extension definitions
Date:   Thu, 26 Oct 2023 16:31:20 +0200
Message-ID: <20231026143122.279437-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026143122.279437-1-cleger@rivosinc.com>
References: <20231026143122.279437-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add needed definitions for SBI Supervisor Software Events extension [1].
This extension enables the SBI to inject events into supervisor software
much like ARM SDEI.

[1] https://lists.riscv.org/g/tech-prs/message/515

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 38 ++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c      |  4 ++++
 2 files changed, 42 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5b4a1bf5f439..2e99cafe7fed 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -30,6 +30,7 @@ enum sbi_ext_id {
 	SBI_EXT_HSM = 0x48534D,
 	SBI_EXT_SRST = 0x53525354,
 	SBI_EXT_PMU = 0x504D55,
+	SBI_EXT_SSE = 0x535345,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -236,6 +237,40 @@ enum sbi_pmu_ctr_type {
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
 
+enum sbi_ext_sse_fid {
+	SBI_SSE_EVENT_ATTR_GET = 0,
+	SBI_SSE_EVENT_ATTR_SET,
+	SBI_SSE_EVENT_REGISTER,
+	SBI_SSE_EVENT_UNREGISTER,
+	SBI_SSE_EVENT_ENABLE,
+	SBI_SSE_EVENT_DISABLE,
+	SBI_SSE_EVENT_COMPLETE,
+	SBI_SSE_EVENT_SIGNAL,
+};
+
+#define SBI_SSE_EVENT_LOCAL_RAS		0x00000000
+#define SBI_SSE_EVENT_GLOBAL_RAS	0x00008000
+#define SBI_SSE_EVENT_LOCAL_ASYNC_PF	0x00010000
+#define SBI_SSE_EVENT_LOCAL_PMU		0x00010001
+#define SBI_SSE_EVENT_LOCAL_DEBUG	0xffff3fff
+#define SBI_SSE_EVENT_GLOBAL_DEBUG	0xffffbfff
+
+#define SBI_SSE_EVENT_GLOBAL		(1 << 15)
+#define SBI_SSE_EVENT_PLATFORM		(1 << 14)
+
+enum sbi_sse_event_attr {
+	SBI_SSE_EVENT_ATTR_STATE = 0,
+	SBI_SSE_EVENT_ATTR_PRIORITY,
+	SBI_SSE_EVENT_ATTR_INJECTION,
+	SBI_SSE_EVENT_ATTR_HART_ID,
+	SBI_SSE_EVENT_ATTR_RAW_PENDING_STATUS,
+};
+
+enum sbi_sse_event_handler_sts {
+	SBI_SSE_HANDLER_SUCCESS	= 0,
+	SBI_SSE_HANDLER_FAILED,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
@@ -251,6 +286,9 @@ enum sbi_pmu_ctr_type {
 #define SBI_ERR_ALREADY_AVAILABLE -6
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
+#define SBI_ERR_INVALID_STATE	-10
+#define SBI_ERR_BAD_RANGE	-11
+#define SBI_ERR_BUSY		-12
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index c672c8ba9a2a..13b63b383d4e 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -56,9 +56,13 @@ int sbi_err_map_linux_errno(int err)
 	case SBI_ERR_DENIED:
 		return -EPERM;
 	case SBI_ERR_INVALID_PARAM:
+	case SBI_ERR_BAD_RANGE:
+	case SBI_ERR_INVALID_STATE:
 		return -EINVAL;
 	case SBI_ERR_INVALID_ADDRESS:
 		return -EFAULT;
+	case SBI_ERR_BUSY:
+		return -EBUSY;
 	case SBI_ERR_NOT_SUPPORTED:
 	case SBI_ERR_FAILURE:
 	default:
-- 
2.42.0

