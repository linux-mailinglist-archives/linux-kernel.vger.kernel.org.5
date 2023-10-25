Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3664D7D735C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjJYShI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjJYShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:37:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1981F111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-577e62e2adfso75257a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698259019; x=1698863819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AQWefridDFzEX+S3QZsEdRxceu5Syx5iK5d77pjmdM=;
        b=BEk/TZiyK9j8wTcqs7wcZdkD0N+ykp+xXIBbXRNUL9uCTlc9wcGaIJhk3jJ4wlWBmN
         4CyoPG5wg8UnGZLqnLHvjRnfggn3SP7l+ThtNAMXeUWbhmIrZSeuwhJG2/sJlxvi/2Vz
         e9/YTTyBokdGQFJhPDNCXMqnGrQPJYkd7IcIx0WgErwVX623U8vgo5ipUY91SDucXeBt
         7fpqvk2JchFvE2BVh9YQR3VanCGzZ6G1OP+MdDqS7+YtxnX3TZIsz01NBqHYWUEv3ZV6
         9+XPxx1eSBiVkdfyclPoQbAVgIPKKbuiEoYHzi8DmI1oLvQ9uyTIKCVAs2YYfHgddsYE
         b8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259019; x=1698863819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AQWefridDFzEX+S3QZsEdRxceu5Syx5iK5d77pjmdM=;
        b=CsGx8M47fyGaf97pVa+/bUniFmiCscPo2Na8Q0E1bV4OMo9etQLRGEfWu4S2b5h1Zi
         71Wum/hOE4t2PmOqZ3iVlSqN5khL437Bej5QUshLRwWN2LbZ4/Yfb8IlC6ffP+R02NLF
         HJ2/FFe3vSFP4DNlEP0jM0Q4fVpQvxcixILPzts9QlHmd8+jssXk58rP7vTkx1YvmD5q
         j53O5lo0AGrCURtpPIsGx9f9xypPDD8hfUtUbtw8nqE4aWQDwHzcm1tqwQiMRZb5qqV4
         0oB7Ey7tBaJZMujqUrD3plYF5v16caqja3KbWxe6Q/sxggHZOOG8W7FPm8mE5pBa/aGq
         YfxA==
X-Gm-Message-State: AOJu0YwQGXYd75RXaWlDBAYCPKsTnq1oUp4HBHSTBR5U/aH3IDpsERIo
        SVbF/4EBjVBw17Gg2cw4kfP4gA==
X-Google-Smtp-Source: AGHT+IFi/NboaaxSjvkdMStkpkrWMbnIqk4WWFJWYRx8koDO2Zab0WQxKwEoeYJQcTe6ecrly6nnFw==
X-Received: by 2002:a17:90a:17c5:b0:27d:2100:b57c with SMTP id q63-20020a17090a17c500b0027d2100b57cmr14411038pja.37.1698259019481;
        Wed, 25 Oct 2023 11:36:59 -0700 (PDT)
Received: from localhost.localdomain ([49.216.222.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adb0300b00278f1512dd9sm212367pjv.32.2023.10.25.11.36.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:36:59 -0700 (PDT)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ebiggers@kernel.org, ardb@kernel.org,
        phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 01/12] RISC-V: add helper function to read the vector VLEN
Date:   Thu, 26 Oct 2023 02:36:33 +0800
Message-Id: <20231025183644.8735-2-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231025183644.8735-1-jerry.shih@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

VLEN describes the length of each vector register and some instructions
need specific minimal VLENs to work correctly.

The vector code already includes a variable riscv_v_vsize that contains
the value of "32 vector registers with vlenb length" that gets filled
during boot. vlenb is the value contained in the CSR_VLENB register and
the value represents "VLEN / 8".

So add riscv_vector_vlen() to return the actual VLEN value for in-kernel
users when they need to check the available VLEN.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 arch/riscv/include/asm/vector.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 9fb2dea66abd..1fd3e5510b64 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -244,4 +244,15 @@ void kernel_vector_allow_preemption(void);
 #define kernel_vector_allow_preemption()	do {} while (0)
 #endif
 
+/*
+ * Return the implementation's vlen value.
+ *
+ * riscv_v_vsize contains the value of "32 vector registers with vlenb length"
+ * so rebuild the vlen value in bits from it.
+ */
+static inline int riscv_vector_vlen(void)
+{
+	return riscv_v_vsize / 32 * 8;
+}
+
 #endif /* ! __ASM_RISCV_VECTOR_H */
-- 
2.28.0

