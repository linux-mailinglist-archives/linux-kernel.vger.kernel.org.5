Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7597B749F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjJCXSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjJCXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:18:17 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A42B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:18:09 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1e12f41e496so971870fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375089; x=1696979889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bih+EsLhqqE18INEKlidrn1Kal2heWWzJ4ETbgTX94I=;
        b=gWbjyVCSoYjNgqXY/1vrUb+LcPUVzLsCYd7NQ/l6818pTUxFjo1kTibUBwZZcAxeDw
         8UTxJ9ujjwDrG807kDYCA41CE8uPjgEI8gGxCHvA+eEFg1T5H4Sbrsi9o0fDo1x7ru7l
         bJ5eE8X2Xm4UMGTLConj6pLRJpH5B/igY3M0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375089; x=1696979889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bih+EsLhqqE18INEKlidrn1Kal2heWWzJ4ETbgTX94I=;
        b=qlzhoDD8CMVWtoPQE1UaSMy7o5TdoIL5dXfUiY0xUg7mWoJbsAzyIz+kQRBHTjPRp0
         /A800lSrwMCMC/bbCjSeJK961T155MbhAtpjpbGnObXqOkAI8dJXsOyZwio35YRMJStn
         QYAdICHeoxe+XxCDqW8zVUrpPrEd4JqCr5uEYZvo4MgbMmuqEb+eWhFrffMXyYUmcG7P
         a3iRyZpXx+lB2m0zx2ZhEwlGdl2dL2qKuBbAYr6NJTLRZsu6XJmkIE8XTRSpcTM75lEA
         UDvPzjqwbgLCuTP4Oiq2GuzpQrpmT3Mu3UpFnHv32jl6RBQvkNlf/jhX4t34RRjoRcFG
         wJZg==
X-Gm-Message-State: AOJu0Yy9QLoz3RN83V4sxfFuG9rFs6zOBib8VikX5Sh9/GykyCiVrEts
        Ny1zOoDEykmv/9J+Nfwj/5gJmQ==
X-Google-Smtp-Source: AGHT+IGMuEXMH0klQynXNGDf9mXvorUx4r7dHi8rq3SeI8WCyENuzvx2RH4KRVoIABsMtoPkloKObQ==
X-Received: by 2002:a05:6870:f708:b0:1d6:567b:7a93 with SMTP id ej8-20020a056870f70800b001d6567b7a93mr1041157oab.11.1696375089114;
        Tue, 03 Oct 2023 16:18:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fm18-20020a056a002f9200b00684ca1b45b9sm1978519pfb.149.2023.10.03.16.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] netfilter: nf_tables: Annotate struct nft_pipapo_match with __counted_by
Date:   Tue,  3 Oct 2023 16:17:51 -0700
Message-Id: <20231003231750.work.190-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Wy0TE8qEtssfM7cN9gcV0HXN7z8A45g0+0RjkMYsJ6Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKEeqBf2tLycKMWuivraE0LzPS9ivsggbdtww
 QfkATjpb1eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhHgAKCRCJcvTf3G3A
 JjOHEACMTVDOfHBHAk8PGKTzvz8VfSLnexla3kFw3JTpU4WFBKxGBGl0Rk5JPIl9QNAC7P8Tv1D
 tc6AdnTmyqE+nwKP/rjvAMfjAYECHpwYOaJAeUK0uSQQ3jiYQ204Rz1XeNmkZtrPMUV84YO3wn+
 z9J6E3OILiVubIm1FpaooFMb2RfqcbXIrOvy17H2o3l5TFI5SlTdOudtqU2Xfw9MA6gCOSPUAD6
 E7/ZbZKh0SUmBJ8g2XXQ1efypS4fTtGGX6vIjdTFNb3mm/pl8u8pUb7HIHIHmx4ajHVULNXKhJS
 FR+2+4KIcgUfZUwkEVfkbHYdrPhSezICZCwT98pN7OaP7oSAmWvM1r4OgWIwd9HZH9//lFyFOwY
 ku9TgykVDQJR1/DogW3OlpuAW3tSz/kdhPLsQzo37jmts3qaiNitpS798OLrieiY/7QCbKO6Hro
 vfM94GieScRafb2hlRygTpf5wAVkl9oWAlzXRrkQ9Op8ErfEGnPtTwp+0/+UEqXWirSg+4H4C1j
 /6joRVoyBrCr3Gf0sujbuMbKM2gE42TMVkCJJU6EUnIi3F4F6rLLbcywyi/unnsiDjd1Lw3uUZl
 tCYdMDgGHXxRMzdhiqbuSLOqg6Zs2i5mheccBCbgvf7k2bPgzQlmsTRrlmWWWwm0+BhcuXWScmO
 cyWMQGk mmrEgDeA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nft_pipapo_match.

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/netfilter/nft_set_pipapo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 25a75591583e..2e164a319945 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -147,7 +147,7 @@ struct nft_pipapo_match {
 	unsigned long * __percpu *scratch;
 	size_t bsize_max;
 	struct rcu_head rcu;
-	struct nft_pipapo_field f[];
+	struct nft_pipapo_field f[] __counted_by(field_count);
 };
 
 /**
-- 
2.34.1

