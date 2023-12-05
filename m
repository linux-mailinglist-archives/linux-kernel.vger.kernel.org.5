Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934EF804532
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346720AbjLECne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346662AbjLECna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:43:30 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E0A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:43:36 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d855efb920so2943868a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701744215; x=1702349015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0t/9Xz5DiK/wXH2NqGUZGNOtmRM2KXduxsMbe0LSN5g=;
        b=rhY+hiRgeh/1Mf/In9gQYD8QCUPWj5f5fJw3PNkcHgOKcvUSSRsski2xZ28ICISpcx
         tSBr1mmxDtP2iTQ92wjrdaEQw7EYLSroqUbJfeIbPC8U4WX/7rfj7LgBZHuJ2EmAXTfe
         Ioa2oMUtrGS9yF9R8HurzNp7K1GL0LkHEtvscFgS+EZ8GM4f00uN3BEPQL0eJObse9Ch
         GxYlBmWIhUDPSDDhN9M/fgixu5pemWX4hSJ9HNTQ9A6yqO1pZaRhcTWLfHcCX1vkbulc
         OhM8JkU9H5BDp49zqmaTxbFYy/9Q48uwsu+/Fleh7D33rsyC+fBHdiQH7xwBKwS0YM4f
         SvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701744215; x=1702349015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0t/9Xz5DiK/wXH2NqGUZGNOtmRM2KXduxsMbe0LSN5g=;
        b=uh3kNHO8qQL+EiDKGnaR8P03F/jNjwFAch/im7gSelHqdiZfruWtDRQqk0vGi9Oqpw
         iANoAtAN/yO9ocbL9oeaPCQplHK1Ze28qR/063O12kcXO/h3d5C0jdCJEMOqJKm84blh
         S9kgdB+HkPQcujyXindnG3v7o2uj9kfBT+x18cEIYCYpSslfH3DDjoGyrBqF8jahls4X
         LAPCvOgkiFEAY7x7wkAiG3UBygugsP7a5BE6qZ1a4dmvHIF8r6PvKJmTrjDYMcC09D0D
         ed4kd9LDxWKbtnrCTzQJuHYr54yudza+6BEjoxV85lxgCg+ATf/6SQjteqL3YP/to6lK
         Re9w==
X-Gm-Message-State: AOJu0YyZKqZVkTd8w754/FicWKdJf4j50eYGEzztzPItZKzY+l3kHKqO
        nR1GppOsw7W79l4nR/kOqxhkmCOpqEbXZ0/YPAx/qg==
X-Google-Smtp-Source: AGHT+IF/knJEBDAyziZ5bGsFkd0zgoM9yPDKanU8wPN8v+9Xu+OCLihiseLcaJtMfQMkMK0rGT1qkg==
X-Received: by 2002:a05:6830:100f:b0:6d8:a456:d99d with SMTP id a15-20020a056830100f00b006d8a456d99dmr3450114otp.5.1701744215637;
        Mon, 04 Dec 2023 18:43:35 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a9d62d1000000b006b9848f8aa7sm2157655otk.45.2023.12.04.18.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:43:35 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 3/9] RISC-V: Add FIRMWARE_READ_HI definition
Date:   Mon,  4 Dec 2023 18:43:04 -0800
Message-Id: <20231205024310.1593100-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205024310.1593100-1-atishp@rivosinc.com>
References: <20231205024310.1593100-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI v2.0 added another function to SBI PMU extension to read
the upper bits of a counter with width larger than XLEN.

Add the definition for that function.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0892f4421bc4..f3eeca79a02d 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -121,6 +121,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_START,
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
 };
 
 union sbi_pmu_ctr_info {
-- 
2.34.1

