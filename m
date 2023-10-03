Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F397B74AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjJCXTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjJCXTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:19:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBB811F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:18:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso1179636b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375133; x=1696979933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWNIdeN2XwgWHo5X2YYBIvg85yUsaTggFd2yH1rpeNo=;
        b=FUNXClypEDIPztwRcBTngVP9vRWTx93FHRHaondl5dE8i10zMxU7OUsF1NznK1ZMZD
         mWVFInGRdpMUqq49AJjcmIRsziaNWsjioN44l5SSk2JHOBtC+0+3M8/aAwpJNF8kPtqk
         fmC9Nm/jMRK8ylLmVzTiWfN/4aU3qld/roQGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375133; x=1696979933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWNIdeN2XwgWHo5X2YYBIvg85yUsaTggFd2yH1rpeNo=;
        b=h3IAVpCxV7fBXwjvotCJYCPyvfUbbSX8AI8SszAickm8nYBxiQbpjz4XusJyb1JczQ
         1YqXxWEox5lMTNCsgeGCG7SVhsBLyl5RLfVVXJPmGF1NzsnZv5d+JaseB5S+Q97tMRsF
         LBeqTrZJ81deoIBlq5hLEPbd7PzarxYrP9SKH0qe0vhpniMFdxNRX+Ya/SD1adArD9jm
         BiJBeepXeQBLlCmwEsxXZU4/bRcL5wD97CxCm9ZLAL+HZkyjMvUxg4vdaUphFDufcTae
         U3ZQLlFY5kJ7qONh6bYtmswGEc6xUQGHGkGeHBy5qFaPy6Dpg6f/Kjl5Y51qeqPkt7y7
         nNSQ==
X-Gm-Message-State: AOJu0YzCLMUJ2rhEWn22asAJfoB7oDqCtCxZ279Am2vMyfEqW9CRLJjn
        jsmYqR6lf7YDhbqe2EILoOLgmg==
X-Google-Smtp-Source: AGHT+IE2ezD7VkJBj90UTSYYCyLaSdWwrTpUvpxo1uGqb0HyKbaxHn5PneqQ/44FkdSbOE1AfbArPQ==
X-Received: by 2002:a05:6a00:1511:b0:690:cb8f:3320 with SMTP id q17-20020a056a00151100b00690cb8f3320mr1061401pfu.24.1696375133553;
        Tue, 03 Oct 2023 16:18:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f30-20020a63755e000000b005777a50c14csm1948843pgn.0.2023.10.03.16.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yu Xiao <yu.xiao@corigine.com>,
        Sixiang Chen <sixiang.chen@corigine.com>,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        Louis Peens <louis.peens@corigine.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] nfp: nsp: Annotate struct nfp_eth_table with __counted_by
Date:   Tue,  3 Oct 2023 16:18:51 -0700
Message-Id: <20231003231850.work.335-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=keescook@chromium.org;
 h=from:subject:message-id; bh=kyIpUckdxhoPI7wg/1i7aDtbMCbDJmvf94yOHZ/LMos=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKFaqeDk2zRE3th7z8cYZ1dn2zrPeWsHfJfCM
 Cuy93rmm6WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhWgAKCRCJcvTf3G3A
 JtivD/921uPevWfkg8Iip9YGwRkTHQCT/UJ598wTfO+mlFZfgD8SEx3AvBWVtFAqDbrflleiDp7
 R58oBrQcmRqVIpJKsm718xxHUhMOtY3JGgUQYiv6bAN4lISc2z5Ju2QzD1IrXquWHev+ayiwS7n
 7KZVM+Gd+Sr/EQvetaHmNqzDWdIBpT5mdQLxQmX4+hCsrGzMAXlei3f84qoOw9V2e9u+n43W93H
 Z7rbuFzJIXu4IKLlngEXXY/RFZVr88AIIkpwz8/OLLEnYTJ7SkChFnM3/yMejx9Xsp9zCyfF/5w
 b+riLsgZTZzyAUN4l7+Pgl9Kqq1+xXc6+mV5O0MJ8pdzoA3aiUcTiMZqhJds8Ti0POEk+7pauBr
 d/n6Dnx+fZtx58xQUgpRvrVLtZkQ8pFgcNr3b3KNXXy3c2zxAv15kOKKK5jHD4/FpOINsE3FVfx
 SUZS2QHF0QVAWCxGH9+5QJn5SOVWKlzi0AFHyV6bRb0yyRkkp8+8Gj9xDDJMarG0yDVlaW6lPTT
 oYsKlppQ44FxNQ9UEDX3nZpTULabRuehfovG2KPpb4amory077swEoE6JUbBUf8rm9K09YA8FDk
 wyXGduO9eqahqe3FfT3xbGGSFV+k4JvfrMZrTP0+Eu5N659fq3paOBy8VsG3ts4pnnXNddDgEGP
 okULyFU CI3chMuA==
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

As found with Coccinelle[1], add __counted_by for struct nfp_eth_table.

Cc: Simon Horman <simon.horman@corigine.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Yinjun Zhang <yinjun.zhang@corigine.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Yu Xiao <yu.xiao@corigine.com>
Cc: Sixiang Chen <sixiang.chen@corigine.com>
Cc: oss-drivers@corigine.com
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
index 6e044ac04917..00264af13b49 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
@@ -241,7 +241,7 @@ struct nfp_eth_table {
 
 		u64 link_modes_supp[2];
 		u64 link_modes_ad[2];
-	} ports[];
+	} ports[] __counted_by(count);
 };
 
 struct nfp_eth_table *nfp_eth_read_ports(struct nfp_cpp *cpp);
-- 
2.34.1

