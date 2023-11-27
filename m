Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1097C7F9AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjK0HHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjK0HHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:07:25 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D937B1A6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfc3f50504so6123445ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701068848; x=1701673648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9NcydlPjJuZdBvk47SliSWRPXO51iH+ClRWgIXdngI=;
        b=R3bGiBJyq+uYPEskiMD2ig1vN6/rcwG2a45RUwH5v8t+GhKBASiJ2KCfoRAn8QERwB
         Fwjs7IIY/oCs9P1Eafo/z/2qRS1WfEXf7i210aFCLEDdvsIyNEh2DNin+8kvlzQer6OX
         2M31tXupx7SV+Vk4A7EoPk1pd4hi8K8Xz0T6nxvjeGZk/8oV+5tF2GlstIaMZ2RsLMTY
         bDMXAcsqi5GJY8zab1zE4JaC+pdDFrQeYIb274LosuLyjt66+OddRoUGLI4ru4y4mR0k
         tKiamBKph5O4/sifbbYhaIAcjnXWMxdbn726u8JcDt/QzMCnVllmoRHWmiNIYFFGEomz
         MHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068848; x=1701673648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9NcydlPjJuZdBvk47SliSWRPXO51iH+ClRWgIXdngI=;
        b=je29FcBaHiCmdrc8u5zGxbe7OvpyhuL3vKeX6NXVMFkQq9HUsUOec7L40802+jjFSs
         UUTE+/sJyqgrTI71D3mnTc6bSSMYfx5+QON/MN2ejomQ8hJ5qQuxzbNcYr3G3j6Wik8E
         EBJSGq5lmhun/DCWnnAD/L8k08RROHES1HmbxPWCNDdS83+aP/WQEoPkfIVdi7597af+
         ig3AIxGXscZy48KuKA0N1dMZ7y4+sxYzYLuQVwzCXltk2ko3wruOpq8MaAeRdAnP/BFx
         Pr12094Ln1JIbEQspC2BIw/hpftpcn8xmRPlm1mbIy0S5P2oB4s6HZV1Cpkya3So9qV6
         rafw==
X-Gm-Message-State: AOJu0YzBjT1y51K0wK/gpsK/y4FMyCEzJyE6ooGkFHpbkTvvEqOfp8OP
        gTcEhthU+3wfdgkVGkgdwoj6+g==
X-Google-Smtp-Source: AGHT+IELRS3hxE4VCKaoEswdjN2LTSxsJZBADubHAmIAofnrpOYQED6FfVAgy1DMUxcK/odvBEY6yg==
X-Received: by 2002:a17:903:1d1:b0:1cf:d58b:da39 with SMTP id e17-20020a17090301d100b001cfd58bda39mr1135943plh.64.1701068848370;
        Sun, 26 Nov 2023 23:07:28 -0800 (PST)
Received: from localhost.localdomain ([101.10.45.230])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm1340134plb.77.2023.11.26.23.07.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:07:28 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 05/13] crypto: simd - Update `walksize` in simd skcipher
Date:   Mon, 27 Nov 2023 15:06:55 +0800
Message-Id: <20231127070703.1697-6-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231127070703.1697-1-jerry.shih@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `walksize` assignment is missed in simd skcipher.

Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 crypto/cryptd.c | 1 +
 crypto/simd.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index bbcc368b6a55..253d13504ccb 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -405,6 +405,7 @@ static int cryptd_create_skcipher(struct crypto_template *tmpl,
 		(alg->base.cra_flags & CRYPTO_ALG_INTERNAL);
 	inst->alg.ivsize = crypto_skcipher_alg_ivsize(alg);
 	inst->alg.chunksize = crypto_skcipher_alg_chunksize(alg);
+	inst->alg.walksize = crypto_skcipher_alg_walksize(alg);
 	inst->alg.min_keysize = crypto_skcipher_alg_min_keysize(alg);
 	inst->alg.max_keysize = crypto_skcipher_alg_max_keysize(alg);
 
diff --git a/crypto/simd.c b/crypto/simd.c
index edaa479a1ec5..ea0caabf90f1 100644
--- a/crypto/simd.c
+++ b/crypto/simd.c
@@ -181,6 +181,7 @@ struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
 
 	alg->ivsize = ialg->ivsize;
 	alg->chunksize = ialg->chunksize;
+	alg->walksize = ialg->walksize;
 	alg->min_keysize = ialg->min_keysize;
 	alg->max_keysize = ialg->max_keysize;
 
-- 
2.28.0

