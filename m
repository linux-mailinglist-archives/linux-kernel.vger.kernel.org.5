Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318467B39B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjI2SH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjI2SHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:07:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DD4CC1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-584a761b301so5942887a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010869; x=1696615669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOLSGowyT8bp59dkGdiGtSiQE93Lo/hrKnsFucy41H4=;
        b=gh7W3iVJn11bb5eYM1M1fVlqbLwtiZIuAAOJVZnISy2HvMEB+zfMopBuJ4PGkgtHIM
         l9SCYIZN7MmTnN7vezdltKvpWefWPFnTBaCaUH+/t0TJl1YZyJgcLJXKulS16fdeUsLn
         bsTDJK3OOCdDgmutff8UgfcJXBtyLKHnCE1ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010869; x=1696615669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOLSGowyT8bp59dkGdiGtSiQE93Lo/hrKnsFucy41H4=;
        b=H4cWKAnPlpm4J3ZnYy/SE6G6W1f/p5h6/50oRvy9YoyvldZLsAzNcmaaRtyKOvdGpJ
         2lORCeyGg5+a/RV+2G7V+iU9t2A82yO9Wr0HSXmOgtKtkVck6hJMEASX6sb5dIm9eose
         GYp3U29l49ofZqGxx4M6SS+2y3Hqno56FH8ZWWfo7XeArmr8p0p/kKmL80Je34lHcB1+
         zVlNAURzlZ21FZHjVJEesM/r1OC2mq1rES8ALo4NiuLmpuZ4H0tnQxYMiwAzBUemAOML
         EtnsfsM25zRhqRDvHPCt4Ce5vBcYhqP6rVy0bIG4G3TjT89aftLkIxs60Z5SnfdxlwVX
         sxiw==
X-Gm-Message-State: AOJu0YwYXRPsrkAJly6/0l8mhaDtHEYCOxZsGCTXy73VpsXN6MM2Hc3m
        WYLGSpyBNLbK1SYTJYXg+ZTzRQ==
X-Google-Smtp-Source: AGHT+IHt6XuabPSXjyyEobQ5AIUyk6V8GvupCIuIQkYjXOPloy1zy3GSr04SteVu6zvpk0axqF3tFg==
X-Received: by 2002:a05:6a21:3b46:b0:157:be16:b6bc with SMTP id zy6-20020a056a213b4600b00157be16b6bcmr4419165pzb.59.1696010869260;
        Fri, 29 Sep 2023 11:07:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709027c9800b001c3267ae31bsm17133941pll.301.2023.09.29.11.07.47
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
Subject: [PATCH 2/5] mlxsw: core: Annotate struct mlxsw_env with __counted_by
Date:   Fri, 29 Sep 2023 11:07:41 -0700
Message-Id: <20230929180746.3005922-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180611.work.870-kees@kernel.org>
References: <20230929180611.work.870-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=keescook@chromium.org;
 h=from:subject; bh=L0oxTPzJo9bLm3xCYvLC1IanmGV5YjHUG5FuRGU5Jf8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxJvMgcoNzYyB72yjkUxJlGtHiv6i26l9q3H6
 AWqAtX6Z4qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcSbwAKCRCJcvTf3G3A
 Ju3SD/0aUZX3WDL92XZp5/H8KPI87sDe7TXiou5k61Plb0QhqKrJm0EQvvtFmGQ8yngu0YzXBDM
 /QQNMEOQ2cHyyMTjGimcMw0tFZWAV7NLgHg6msaDMIsrspl5Oev6Z6e8CZODAqAveaOEP6an6Xv
 uPlhAv12ovRr/ARjStdeLWa06Q6buKRjbyekciSkT6E69f3tej6z3CcxbXt5n6KUbj6wzfMy+Ie
 Y6CPL/otBsl0Am4dZG02Cq4efJtZ9y+2rUAI7S/9YTRr8zHPEJEIwB6O1vTsn0wr1y5p1GuMvXg
 cz51ljKx7ftiT/KptN/6KB6m3vInGRUKZSDZsTtBUIkST+MhSL5HbM0OKHNe/fA0+3nrJBDIToR
 awf71Nh8sT8X5NhbYQJmRHRiWgn0cvoyIZ6FoDo6G2u5FYgetEpYI4gJbSFfwzhBl9BYzeSlRYg
 KCpcGhfNGVLxZHppj8PpwtslwJhLb+vPrZrLiqhWSZW209VA+l+fQUBdeGEoANXy4UStmAGhUcN
 oQ2LCzJ8YbW1ORVDuMlnzsaXZoMRhyIrUCbcZBZP5ON/h6tSYSyLH9Z8vphrEIr+7/XuDhHeUP8
 qtvJvfjDXAEVGyjL6s84rvuAHdNLq9TNbMlrrXlb8cq7gOTdf1mtQq7zyud0Da7vFI+AyVBvYeH PkjUGZ7qVyTgCoQ==
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

As found with Coccinelle[1], add __counted_by for struct mlxsw_env.

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
 drivers/net/ethernet/mellanox/mlxsw/core_env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index d637c0348fa1..a129e0df1d07 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -34,7 +34,7 @@ struct mlxsw_env {
 	u8 num_of_slots; /* Including the main board. */
 	u8 max_eeprom_len; /* Maximum module EEPROM transaction length. */
 	struct mutex line_cards_lock; /* Protects line cards. */
-	struct mlxsw_env_line_card *line_cards[];
+	struct mlxsw_env_line_card *line_cards[] __counted_by(num_of_slots);
 };
 
 static bool __mlxsw_env_linecard_is_active(struct mlxsw_env *mlxsw_env,
-- 
2.34.1

