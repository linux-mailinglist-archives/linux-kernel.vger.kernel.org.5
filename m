Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E667F9AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjK0HHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0HHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:07:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB464133
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:16 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5bd6ac9833fso2121566a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701068836; x=1701673636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AQWefridDFzEX+S3QZsEdRxceu5Syx5iK5d77pjmdM=;
        b=U0MvI4S/Fs3gjOilMQuu49WHu6Aof9dzgAdbM5Gsk8W2BqwNx80zFGD484TPqf1t1u
         VX6fURDhE6Xyt2X5Wqw4IqvWlNuldcazkBUpcL6P1C+peZcn/qbD+irTxJ3OZ/XbC8Od
         r+Y9F/wjZe+ke/gjwQF3IJ4xclvHIMEc7zIlxVAb53S90NFgYS/+V+eaj37ztdMXvwt0
         pa6NaxRroYqM1FK6Oy0vbX5zt19f1YXjVJ2XP/DbsDN3hhOSRx/mjg2ZkenjuTiFlKRc
         E8LFZV1h8EuWLPOmsY/pgCi14KZ+vAybmubgh4dcIMWehM4v741xreEDFeTA75jy38+3
         SpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068836; x=1701673636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AQWefridDFzEX+S3QZsEdRxceu5Syx5iK5d77pjmdM=;
        b=vS7zfCoW5aFF6jGZaSNswdSROq/TBJg9KHI3J198dKSqODJrnX8R/z6ZTCOJRtROka
         4Pd9N/Kui4PiOwUv08GbdsgRF2rs97Z4f1npCyHgRvLSQZiXypDOdOVQBKHJVWkaOhWa
         u2JMH5RSZYT9DHSb0NmLw45KgoVEsJHQRZ4GMA7dDVnwOrZRqicX70ToC1MZIza4HBoJ
         /lhJLOj5dO9YRAELczhbZtL8X72hAkxnurar5rBi3u2nP9t4PVLJAgBIE8/P8xRKY8/N
         dA060L9NrQWuQk2A0wenPzbN1RCXjjXJkatoSTJ3ZnrOgAunK17T+S64CkVsODX/qEvO
         gZgg==
X-Gm-Message-State: AOJu0YwUW6q59lNN1UIt+hScfmIUNHUBm6yKaXgdBKNibI/aLfAS/FrB
        /C2MTtBm/Zo+BOPRFk84i6W1zA==
X-Google-Smtp-Source: AGHT+IEfgbssJ61TZlq0d2dhxDtdtwhMhkAYzY1cvNJK6+MKTZHhqLX3gJHGHb4gNjKA9hC/r5Pzfg==
X-Received: by 2002:a05:6a20:d48e:b0:187:3b1f:219c with SMTP id im14-20020a056a20d48e00b001873b1f219cmr12639143pzb.10.1701068836407;
        Sun, 26 Nov 2023 23:07:16 -0800 (PST)
Received: from localhost.localdomain ([101.10.45.230])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm1340134plb.77.2023.11.26.23.07.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:07:16 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 01/13] RISC-V: add helper function to read the vector VLEN
Date:   Mon, 27 Nov 2023 15:06:51 +0800
Message-Id: <20231127070703.1697-2-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231127070703.1697-1-jerry.shih@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

