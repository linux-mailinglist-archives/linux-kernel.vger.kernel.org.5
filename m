Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8816B7AB846
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjIVRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIVRwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:52:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A35F10F9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c44c0f9138so20948155ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405084; x=1696009884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXc3WVm2d9wXGVJuKAtiopcDcMVBwoquCz7AlsYwD+o=;
        b=nhRAHBCabqS+f19t4DDPSMSTtrRJlhPkHZrAKOo/KyUq5+5zwQiUNJfUV8V5L8sar1
         ZiB1Vf1cJ6MCQm7WZfN+8Ssm/frqqObMGLM9yKzfuQpqJa72d+E5Lbup4niAcx4ZcDEw
         mICMjFxWchuOC080S+QLbXcsQq1xIEJRoKrhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405084; x=1696009884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXc3WVm2d9wXGVJuKAtiopcDcMVBwoquCz7AlsYwD+o=;
        b=uesvx9MZS2hnq/gXhHvmvbTodwfUrKpv6jB4kHBwpJk9dZD1PlPoOScGduzvRTlSjP
         gZntKp+SOL8ZPQR4uBDv1lDiPkDf76pKgHC9sPKkDASSLSinImoECd9CpwBaNgU7SWFA
         lx5AJ4BmW9JPRcLLGOYZtIsFQzfIwcUTjTE0hu47Apm+69Cso2gHiAvT6K1BlnKmSY9a
         nvscaZxjMNvpTy3bIGIrahPIuMEE1kTAJ3jT+/CKGJqWjmcN3tB0KwIRpD3ESqntdtMD
         R0ByWI8QE9t1IZNS+FaNe/9jB/4Q2D9hfHkqwOXAmFae99LNZlm+tUAWrpKey2Fs2hwW
         zSSg==
X-Gm-Message-State: AOJu0YzEQdHHR9jlfj//5cKFoXl/VxZf7+Q3cdEKpnP3GGaf6Q3GVOes
        AtlrgdxkTNzRz4ojAyfV5Ap88Q==
X-Google-Smtp-Source: AGHT+IH/Kn1OJkUrFMU9jg+TEckOUQCVzn3MG2/uzWrH8DEVzrtRq6GXOgkadVLCZAFxwqsvTYCVvQ==
X-Received: by 2002:a17:902:7798:b0:1c0:aca0:8c44 with SMTP id o24-20020a170902779800b001c0aca08c44mr195510pll.19.1695405083834;
        Fri, 22 Sep 2023 10:51:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001bde12178b4sm3771970pld.33.2023.09.22.10.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:51:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] KVM: Annotate struct kvm_irq_routing_table with __counted_by
Date:   Fri, 22 Sep 2023 10:51:21 -0700
Message-Id: <20230922175121.work.660-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=keescook@chromium.org;
 h=from:subject:message-id; bh=+kioWiTjqV6jdbFZylWekeUu834dva3bEE4RuM/bKRQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQZLetVqJUV8ZSLYv/hoDK79//fc87OG48iZ
 kOU8Wrigv+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UGQAKCRCJcvTf3G3A
 JqBnD/wN4+TtgPpWSDb0l1F32tdGJLNbEHEnVEr8OVv6j14PQUeCh5nUABKY7BTC2yJIGP4VKbX
 ousJT6tKEKoNsuwfJp0Z/Pv2ssKKbABc1busJSGB1V081CNDuOKPy/MN3pCqlTLtxk7yrwMkTWl
 1G+C2YKMD4fKZU1EII3XT6kYdk2j9t487W/CfBBGmWZKuOEeoR0x22SWdrW2QPufcHf9bQLTj/n
 9nygC679juYza9RWkF3u1hGYey8QGjP3SR1pusnTKAHd3oJBBhoLRsbmG9F+PNC3OjXCc5PdK64
 xD+7Inl2rGuMnRumnfsWJ4kBQgBr+Q/EbflYNsf0Aj/e3LVac/HEheuy8BxWasrtWNZ7IF9UgUf
 7IrIqRGQVzygQPskeMPE7NgBtlZdj5C/Mlev/Gh/cuTufDy6RE2lknosD3OI4zzOvD79MZHW8R0
 qV1/TmW7guNS5XqgK1XfYNZcEqCI8PbL8kaClfUCgLYe52QO85Han1E7cH1wZZJBV3/OVQej3RL
 sUUTxwb5vl6n8FNbO+mtp7p2khlg2yyNgo3aaAWsGVmU3pWHubzzRGuIFyQUy6z05n5UEEEXXe2
 kEisjaAvIWB0BwiuIctaz7/4aQuV2TCNVjylB02PM+c77Jzzec7B/M9A+QFaHowdXUCPyiFjaY3
 QET+wYw MOtez24g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct kvm_irq_routing_table.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fb6c6109fdca..4944136efaa2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -664,7 +664,7 @@ struct kvm_irq_routing_table {
 	 * Array indexed by gsi. Each entry contains list of irq chips
 	 * the gsi is connected to.
 	 */
-	struct hlist_head map[];
+	struct hlist_head map[] __counted_by(nr_rt_entries);
 };
 #endif
 
-- 
2.34.1

