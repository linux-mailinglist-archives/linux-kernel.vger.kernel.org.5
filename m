Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041EA7B39C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjI2SL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjI2SLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:11:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E001A5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:11:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-692c02adeefso9144428b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011111; x=1696615911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OH0PiR0WI/UE2sZjCTyFU1iLE9Onm3jTTwerBkotyuo=;
        b=M6H97+PWjTqOpphNFmzrKJiS8uUoVdZ/atl4aDIURSnYWgxqvCjtOqLmhOrKjlfZtH
         2x5gg8ZM4LtE14rl5dbuLnCCYn6qyGEW35F/jPX7MxKg3EUisYQlEDna2xhTqQO2o6N/
         NEB5IX+TqMQapc++UTQ/y80qz8YBaIljJ0RR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011111; x=1696615911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OH0PiR0WI/UE2sZjCTyFU1iLE9Onm3jTTwerBkotyuo=;
        b=vytUT/kO0v7X3aTISawB4ssqWCwZaWhrkhljStl/eYFPLVS8t4iktQdMWR5RO2TpCW
         A/i2rFT2pe9hLWkJcZ6umNzH9FLMwQnsNPkocvF6JhcNGwKipbdnZ4AwL0yApyXlwxRE
         LNuADcrNXyaiDY2XWgqAnAp44LSH066btcJW3VfxPgBOf0snKUZ6ug+SjIDFhKlVuUqW
         3apbalAMfFqvhJnPOqp6k6rR6jibuj893GnDwWAib76I+trInVmANQ9dzqEBPAeDsNOT
         VoHn2m1y3HbxQfjfwkUdtlAdk5sgx0XQ2fXzJ4cb7QiIFS2ssFMbo3SImSauUGBS3ToJ
         PoFA==
X-Gm-Message-State: AOJu0Yzmg1+lCDWW3aoFRUVlWpgA097QA8w7DVXpSbCw4So2R4IkvQvu
        twpU2ANEy5TxgBEd2hUe+twXMg==
X-Google-Smtp-Source: AGHT+IHAY4rhk60X1mRZO3KkP8CVqHVHv0bnb2oq8VCNZiw3pzIiWNqw+uVNR3TmEftzfyciqOQl3Q==
X-Received: by 2002:a05:6a20:442a:b0:12f:c0c1:d70 with SMTP id ce42-20020a056a20442a00b0012fc0c10d70mr5673020pzb.40.1696011111199;
        Fri, 29 Sep 2023 11:11:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090282c200b001c5fe217fb9sm13142608plz.267.2023.09.29.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:11:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Raju Rangoju <rajur@chelsio.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/5] chelsio/l2t: Annotate struct l2t_data with __counted_by
Date:   Fri, 29 Sep 2023 11:11:45 -0700
Message-Id: <20230929181149.3006432-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
References: <20230929181042.work.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=keescook@chromium.org;
 h=from:subject; bh=A70ndgAnsB63r0Ibz6C+3NACmZt0aUvaCrb1LtGUWWA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxNkvS86dHwSxy8ppyZ4ezGlY0dySlfyX5m8D
 KpLi1xEZTeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcTZAAKCRCJcvTf3G3A
 JnXDEACBpLVSApm8BNpQD0pC+7W9QFQ72d157scW1CwY8mp7MuBY9cbc42hxF04FiiP0uxr0uGw
 XLnttDJr1KtImVLWmFl0uTUJ2xvOvLqJgAcPgUHpRHHu4p6f3W4JigMcvvGsLfUiWnHrd2E70bp
 EXieKubhNH+KdSuW1X6a5GdsevlmO37r3NEQ/nOm2IYzC0HZTjokvwhXWWKVx7PdVa1cQrq0fDz
 quZ7/aSDzhr6+fC04zQC3bu3IKGusBFOz/tN8NVAhXu45U5wB41EVV+fRKcODPdVPU2b1dI0RpL
 RtwvZQbS4kgZN4bu3pjCR32LHbyD8Y1N01Thzl3TlndTZo1u+6F5MIgL7EyQErTsPKBc3LXQk2H
 xjyT65i/n3qp12l8Ja1892vv5FIXxnfo6mfq4aXqZtEamwm9FmJAypVESnfvoodbydB/Enrzg99
 uk6ya1qT3/vKaXJ8N3tsc4MOhcwS82XDxjADntekAFtoVjfy9vhxoYUKT+hWXd+41p6BGl2hgKH
 2wYFDc6IR6RWodoZd7pwH1GFZt/Z+anl5r8+FqFUO8RSQxzUiclCweDbghMn1pLP9Ga9SS1r8O7
 kM5qmK82FMBYrUe+3Zsdv7TlwH2LRPNEXsX+HH3vqdQgn+8ZzHuUBmb16fmcZi3/PVPhM0+TBlf BTl+VEbGPVimvcw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct l2t_data.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb3/l2t.h | 2 +-
 drivers/net/ethernet/chelsio/cxgb4/l2t.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/l2t.h b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
index ea75f275023f..646ca0bc25bd 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/l2t.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
@@ -76,7 +76,7 @@ struct l2t_data {
 	atomic_t nfree;		/* number of free entries */
 	rwlock_t lock;
 	struct rcu_head rcu_head;	/* to handle rcu cleanup */
-	struct l2t_entry l2tab[];
+	struct l2t_entry l2tab[] __counted_by(nentries);
 };
 
 typedef void (*arp_failure_handler_func)(struct t3cdev * dev,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/l2t.c b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
index a10a6862a9a4..1e5f5b1a22a6 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/l2t.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
@@ -59,7 +59,7 @@ struct l2t_data {
 	rwlock_t lock;
 	atomic_t nfree;             /* number of free entries */
 	struct l2t_entry *rover;    /* starting point for next allocation */
-	struct l2t_entry l2tab[];  /* MUST BE LAST */
+	struct l2t_entry l2tab[] __counted_by(l2t_size);  /* MUST BE LAST */
 };
 
 static inline unsigned int vlan_prio(const struct l2t_entry *e)
-- 
2.34.1

