Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2540D810779
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378159AbjLMBSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378152AbjLMBSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:18:37 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A45A5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:18:43 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d9e9b72ecfso3568859a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702430323; x=1703035123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjqGV1Kb/P5zbkrU4HZj42U242Y4ucdb6cKzFhJu16E=;
        b=TKw0O7f0+RjFtPX/EoJru2ueXfI3wGXJuk/UFASokbPUubJk+TWmZvm1U9PCvCjGFK
         rnXvaC+HPaLKdtFAdNyXL7jUWmob6gpbHef+9uZk2UmExJNwnuDxeITV/my6qedL/Y3Z
         vocryzYjOFH/UF4wLsou6Dw0QParbESABM42BdQwgcqGqO3mweeKdZTBb7R+Enrb+KQ4
         pFY7S0guRKiN4ao0TfMrdrKuk7yapYIsVOOWIt4TjHrGXhosrZif5+/OLZ2y20OMzjYg
         UPv4pFjWuHpJzbilxw6loAolYVnw7d8GVTqZCTTUjj1tjBnTDufrp0k9XzD7l+07t/vK
         EATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702430323; x=1703035123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjqGV1Kb/P5zbkrU4HZj42U242Y4ucdb6cKzFhJu16E=;
        b=UBmzEjWUrNrgXHZpxAsHSdrlIydMPnvACz7JlfFkRE04LENt+QX1Jp2cLiKoXBvIJA
         q3uxB9IJT/wTCTegWH35cPzeQD9qXNyVM7Pf/fq5ivkZp8j3proBiN2pwo8NeEHfe7bS
         uSfEvp6fFLopprPPEkjXYB9YhQHkmgAcNnCzHTmlHNQtOoTOM9YuWbOs3ADVnDW4fTnk
         9iBjOyENTz5YSOffTcwjOTuatiO7XMKP10WrXnb2vFHuqi4Yinh9TtyEyZ0G+j5xhVZF
         gCSKEPR8o0TiTost0CUtYyUFmxASRBbmoeyZGKbo3OR1tI68/AF1yb1apfsx8Otg50Ma
         F2+Q==
X-Gm-Message-State: AOJu0YzKhylNGbrvbY+tXYWNE3FloXnKI/nkq9jwsUfkMzBGIKiDbJh9
        ydPXQA9MgRGrzpj969zKB91UQg==
X-Google-Smtp-Source: AGHT+IGcpXKQDzSepggo4DA6an7sZ49nxOLPtoiybj/deuVMJvtLgMtNqZQ5vl9noZsHlO7zvyyAAA==
X-Received: by 2002:a05:6870:7f03:b0:1fa:1f04:e5f1 with SMTP id xa3-20020a0568707f0300b001fa1f04e5f1mr8946584oab.34.1702430322830;
        Tue, 12 Dec 2023 17:18:42 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id cy26-20020a056830699a00b006d9a339773csm172548otb.27.2023.12.12.17.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:18:42 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 12 Dec 2023 17:18:38 -0800
Subject: [PATCH v12 1/5] asm-generic: Improve csum_fold
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-optimize_checksum-v12-1-419a4ba6d666@rivosinc.com>
References: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
In-Reply-To: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <david.laight@aculab.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702430319; l=1517;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FtbING0Tg9V1myoJvDDTr8ph0mEbsa+4mbxe/ijBRBI=;
 b=dJ5wOJMjymK/YpMtfR6jvWWktdU7txotFEvdWb2yuqaSvy9+MkF/Rz3ht0deRKm8zz0sRZ+ph
 Cz3UO09uQmsCFOG5spy3fV0k06pu9P/54kSRkrQ0X38OTK6yYmeYPna
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This csum_fold implementation introduced into arch/arc by Vineet Gupta
is better than the default implementation on at least arc, x86, and
riscv. Using GCC trunk and compiling non-inlined version, this
implementation has 41.6667%, 25% fewer instructions on riscv64, x86-64
respectively with -O3 optimization. Most implmentations override this
default in asm, but this should be more performant than all of those
other implementations except for arm which has barrel shifting and
sparc32 which has a carry flag.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: David Laight <david.laight@aculab.com>
---
 include/asm-generic/checksum.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 43e18db89c14..ad928cce268b 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_GENERIC_CHECKSUM_H
 #define __ASM_GENERIC_CHECKSUM_H
 
+#include <linux/bitops.h>
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
@@ -31,9 +33,7 @@ extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 static inline __sum16 csum_fold(__wsum csum)
 {
 	u32 sum = (__force u32)csum;
-	sum = (sum & 0xffff) + (sum >> 16);
-	sum = (sum & 0xffff) + (sum >> 16);
-	return (__force __sum16)~sum;
+	return (__force __sum16)((~sum - ror32(sum, 16)) >> 16);
 }
 #endif
 

-- 
2.43.0

