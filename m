Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AB17A1494
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjIODtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjIODtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:49:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4304A196
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:49:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26fc9e49859so1404619a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694749782; x=1695354582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYrxQXlYsxlbzxTi4wO/BXPj8sXNJd30qJO9BW1+NbI=;
        b=w9pW4kwXoRnN24mTCa23KvD2uArcbmnnkwJJTIat4sFVVPLEZIV/0ZERLBTnDX73TN
         The3+O0bJUyLDiTkDVtNBBetlV4Wq3zIytFOV2U1QceS79u1NR2GbkzfgahSlGFvjcNU
         5WfcH60q8TveMDa1fJz8vVwGQqhtyasICgByFp8K/Wo7yV5uvQh3Kla36zEUdWc6+sGs
         CCnY3ivoFtoqmwK64GazD0rsPwgmwg3P4zrGDGl4vM8Ve5z+iCC2nXvbfHLbmoKjykX5
         TaSrYUK4Aj448x36gQ4HWpqeuA6a7ELouuSyomDADJUx5H3Mbkqz/vYZ7BUxt2p4Ffgx
         ESbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749782; x=1695354582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYrxQXlYsxlbzxTi4wO/BXPj8sXNJd30qJO9BW1+NbI=;
        b=lzkX0BIeiiBNmoW7kAcZmXqrcXJfVTjs+WMvbItMNgciB+mfF+A0I06U1Y6rssEDCX
         bB0OvnsUN5tDc4UijeGMXuCWM/mGWKBSzE8R71+TyqUk1msHNynd/WsOCwEcPkfksfFy
         ZlabSwCybAHiqh2D8vajPNfwH0i2DGtg9pCeMxiB2Z1qj+H3eIZQILTSF+t8KBpyGR/A
         N5+7CwDcejfBJzhHCTq8ha6npkoumTm45YvjSlCfDMq7+qHYWECeTh/MEAWvXltDMIuC
         AMTKTtIQi6wPs91xDVNMWJ8TZtMHFpczD1HCuPuhIEQdVcmVvAZPjenfYOYBxVwQEH0y
         No6A==
X-Gm-Message-State: AOJu0YwmafJR2S+cs17t7L7gBPCixwlfLbLLbWTAtViulnnEY6Kedkd3
        OAY6eJhq8scXQHLOckD70nUZpvIar8nGCjb04xg=
X-Google-Smtp-Source: AGHT+IE5tKvO4SXpAoimXWGch4a0PPCgswsOZ5z1Ogsr/mm4ho/Z0k9TYcBVqTcs69mbhoBJ0bgVSQ==
X-Received: by 2002:a17:90a:c245:b0:268:3f6d:9751 with SMTP id d5-20020a17090ac24500b002683f6d9751mr416214pjx.23.1694749782539;
        Thu, 14 Sep 2023 20:49:42 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090adac500b002739282db53sm3881409pjx.32.2023.09.14.20.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:49:42 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 14 Sep 2023 20:49:37 -0700
Subject: [PATCH v5 1/4] asm-generic: Improve csum_fold
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-optimize_checksum-v5-1-c95b82a2757e@rivosinc.com>
References: <20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com>
In-Reply-To: <20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This csum_fold implementation introduced into arch/arc by Vineet Gupta
is better than the default implementation on at least arc, x86, arm, and
riscv. Using GCC trunk and compiling non-inlined version, this
implementation has 41.6667%, 25%, 16.6667% fewer instructions on
riscv64, x86-64, and arm64 respectively with -O3 optimization.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 include/asm-generic/checksum.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 43e18db89c14..adab9ac4312c 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -30,10 +30,7 @@ extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
  */
 static inline __sum16 csum_fold(__wsum csum)
 {
-	u32 sum = (__force u32)csum;
-	sum = (sum & 0xffff) + (sum >> 16);
-	sum = (sum & 0xffff) + (sum >> 16);
-	return (__force __sum16)~sum;
+	return (__force __sum16)((~csum - ror32(csum, 16)) >> 16);
 }
 #endif
 

-- 
2.42.0

