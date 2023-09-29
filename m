Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75737B39B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjI2SH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjI2SHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:07:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D871A4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c60cec8041so77448825ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010869; x=1696615669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1fCnyMESIUDw106GjvVeHm07JaGiyNbi4ApDENYnlM=;
        b=i7xHrXvm+x+CXquDtwP3n/6SITwyQLaNnPs/iDit5wVSn9kPZ8ni8jT0KLjaFj1bCn
         Ol2D23xwnqUrGXkm0hdDWcquaq4LlQ6Z3+qZb8YvupZjLed4EqP4vMcKAl4Sce/U57Ne
         VNoIs2qPpRmdcN2+VHjE2NTdqJB+HGG2DulUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010869; x=1696615669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1fCnyMESIUDw106GjvVeHm07JaGiyNbi4ApDENYnlM=;
        b=XIVY07gaDxDfVCal+1tXFntr9oeObWvMC0bTqJY4M17eZSiN9xGNlittn8MjSzdUHB
         VZcjd8wYYhcYj4ELlGlihKYLAVJX/2akpRI64qvD0fDNC5xJ0phCeR4hJ7XaPLMbHDbP
         O7/9yGCK7Q1r6TjxFOSZlatgFypA/3YHQOc3u8ROvEZnfL4jTQTN39MKd589cLeJNQUs
         JxypIXmacAh4cQ9bPp5qLsyLVKH5X1YcwRWgJa2nwtiSoXs9gID/+slwdRQSDFLieUrC
         /tnEclqKwyYWH+x+48XsFs/Cmwrj1TltY9e2u6P1IgQRvqz/sSw7CXlBvbQdKwqsinOt
         qmSA==
X-Gm-Message-State: AOJu0Yz+HQ+zn2s61fgLr6fE5OFdveSOKWGbVaOaeH4XYrQhtdKncJXk
        JCmPojTmfRV/8SjZ/yoeLIlLIQ==
X-Google-Smtp-Source: AGHT+IEYP50F7nEfHcXuhCVPvSqHJT+dGY9l357PrVksSC4o53t+1o2XfasILPny5/J4Mg6J6IWTvw==
X-Received: by 2002:a17:902:c408:b0:1c4:5c05:c3c9 with SMTP id k8-20020a170902c40800b001c45c05c3c9mr5808758plk.56.1696010869523;
        Fri, 29 Sep 2023 11:07:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902d18100b001b8b1f6619asm17332300plb.75.2023.09.29.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:07:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 3/5] mlxsw: spectrum: Annotate struct mlxsw_sp_counter_pool with __counted_by
Date:   Fri, 29 Sep 2023 11:07:42 -0700
Message-Id: <20230929180746.3005922-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180611.work.870-kees@kernel.org>
References: <20230929180611.work.870-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=keescook@chromium.org;
 h=from:subject; bh=+RWfw0GyGwLXMxH+fSx74341Dume6vULCGctkWzJyII=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxJvQ2MJX5MIYubHbp+JLru78XV8PSD9HfCip
 MzkMrfhDwOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcSbwAKCRCJcvTf3G3A
 JnRLD/9EGd9KZ/Tj7Icy70EINkAG/rdfxW+EXWV6I9tI7aqUVeByxYSzHqj8FOidkSGNCh4jARc
 +uXnybahYfPpBWVV41kZfAhAIpxzSoq6s8NuNmkX6T8LHkps1oWxj6pDoKaoFfCMdsAhNUK1xcK
 UiU2qHZHzc1qKNWo1sAcHnPjme+swZST7xHSQ8SF2E13eDaQvKKEpdPeGtSNgPEV8yLj58EN7a0
 iP8n1qZPDs7IoEuCGekv4cGmTTaSzUDc0R7Za2m+3bdHl4DcF9E+nOig6tbTybEZi1aNNjPdNL+
 s+j9/MzDWmw9GMUxIetw7H9laEtIav7YYaf6G8aRv+wTndvPDcfVqBcvfdYnZNx0/rgJSm4e1K+
 QhoQGun8o9/gzP/Y0vAq9j6Fqo2XYbAy9jfvjwol3QlvCJMu54iuM/U5nr6GkAWJ4k7d9jZiVFx
 W2aBOpvnHsbXQd8exwGC8sDd5XFNezCGfQ+qK0pWvD3xzZtJ8mgiQFrhnx7KZDh2+fYU33Hzy8K
 6beObhLWjwE4DYbXYUH8YXOE31yPMSY5K6435NP9Zhlwr4oB1bNxjmDgCqJC73O+PFfJuj6UzKl
 fpEuOHPJVmLtuWUTjz2a/oXMxNT4xkygpO3lIq/qJUoDhiJqrHWI4WM1E4GV4EiRdSAkrIFp856 Z9rPTNG+P+HSMvw==
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
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_counter_pool.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
index ee59c79156e4..50e591420bd9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
@@ -24,7 +24,7 @@ struct mlxsw_sp_counter_pool {
 	spinlock_t counter_pool_lock; /* Protects counter pool allocations */
 	atomic_t active_entries_count;
 	unsigned int sub_pools_count;
-	struct mlxsw_sp_counter_sub_pool sub_pools[];
+	struct mlxsw_sp_counter_sub_pool sub_pools[] __counted_by(sub_pools_count);
 };
 
 static const struct mlxsw_sp_counter_sub_pool mlxsw_sp_counter_sub_pools[] = {
-- 
2.34.1

