Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA64804DD1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjLEJ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbjLEJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:28:25 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891E1138
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:28:29 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b9b8522d91so1023903b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701768508; x=1702373308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9NcydlPjJuZdBvk47SliSWRPXO51iH+ClRWgIXdngI=;
        b=PPBdSIMsiEiHJtO9YF1DSrwoPWPWwDY0lsXcg4j+Y51g526eF34dm5awrHZ23cMmZf
         OpRi+1KVrTZp3F+UsdMKOHsRsfxIzegbcoODaiDj6vbg0Yd+UqhOTOIeVYD6MfHEZH/p
         G59V4KhcWb2H4Zf5DLhHzcRc84wIgXFwJ+rAwJ4LzRw42gDkV1fzbbKNqXIS4jNZqtxe
         +cB33zA05jv1vvEAjtKFaPl/MzDy6bShulOXkmaPyEDG6mXkerKAdW6lECPueppU+blh
         vxf/vuecRsGO6qiMVMFaUMLT9t9nMHuw/P1FoFwfafAfx532BBB/CCWqQr5ujiwDbjTk
         Vqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768508; x=1702373308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9NcydlPjJuZdBvk47SliSWRPXO51iH+ClRWgIXdngI=;
        b=ce6rQuqy/kwjTwBFTVEqIEuUoPxA8m9/XWjZx4DEi6+GtDD2uGf3uKdbn2DESfCQrp
         cE3ZLBEbMsmCMdyqc0ZPLxWk28qILecu2SduMZW7+wvlq8wiNM8VVFa4+YbyPN/+Ag0a
         1BcXE7fRHj/TvYLNQz4Lhl8TjrGEFLZyo7OpzyHvQSGKfxOCfdjPFoN1Ep43Z53pvN6S
         v9tj0vFnMMQVD+iQpXvj4Xk2hHm2gH8mSWNRW1Iu6R7pS/M2yJjp7y9FGPGLTs4g6PTl
         4zHNVeEPf1ePSTlgZmpZUa+bendqzvrOQbCdwhlGDwteji4Ih+CVCZCZ9MM/VP3d8QyZ
         wsEA==
X-Gm-Message-State: AOJu0YxlvrQY82EWTVrDRU+78ksuBWIib6Z7KDKG9ei5LEhow9F0+VNF
        W7XiMJO8DkGmLYwn4iYOImEhjw==
X-Google-Smtp-Source: AGHT+IHZ3EK+AWz07LHe5BsDXoplI+8JX1FVHrlgMUB8wBmoWXqufxaT2Ka9FS50Dim4x8aDAfAYQQ==
X-Received: by 2002:a05:6808:16a7:b0:3b8:44dc:7ce0 with SMTP id bb39-20020a05680816a700b003b844dc7ce0mr7330943oib.2.1701768508622;
        Tue, 05 Dec 2023 01:28:28 -0800 (PST)
Received: from localhost.localdomain ([101.10.93.135])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006cdd723bb6fsm8858788pfu.115.2023.12.05.01.28.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:28:28 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org, conor@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 05/12] crypto: simd - Update `walksize` in simd skcipher
Date:   Tue,  5 Dec 2023 17:27:54 +0800
Message-Id: <20231205092801.1335-6-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231205092801.1335-1-jerry.shih@sifive.com>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
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

