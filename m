Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D520C7AB847
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjIVRwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjIVRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:52:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2E19A7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d2e13074so2263971b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405089; x=1696009889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWy2cKV4GFEr9xRf73jZAqGJISBwaUBznOL/cu2BqBw=;
        b=i+fY+MMf047XGpXu1WzoN1S4aNRG5oCjTysS+96xXYCwoX4KaDmbppfcByit0UmifV
         A+7nl3bF/6K/fzBoJMuXdULWoTtka57Cc8NX5bld2dTfo84kOJwtQoBAUNeDqyaR1aXP
         EDoEaKKJccG8gnwm+KA7SVZ8EOiB4X9wsip7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405089; x=1696009889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWy2cKV4GFEr9xRf73jZAqGJISBwaUBznOL/cu2BqBw=;
        b=FRcnfyFmR4/oNG5z5Pv3r8dInXfdGUUeYqhSMwQe/fFje0IEs6OZGLg1UGAmFJMcrn
         VWexpZxDucFIY6ngpHot0w/g5pcvME2BxcJsseVNhiLNLURyYDCd57AxNR2rSjwKfaM7
         ge0zTqloER6Wfnt8/GENBfxEBqp/TqtDwtL2dwI6PV4ARndiJgSQE7TAwEq2Htt3+4mx
         IugsrjjjUTd6sr2QsPxwm3zU+DniarsaokDqQOApCtZhoBjcjeSKprXfO4znstXtiklS
         haX8LhnGDCg3FEFlapjEZcu+044W+sgRkdZ1pqgBznTphsSAJpscNJ7CkYl50DGpnQOr
         jA0A==
X-Gm-Message-State: AOJu0Yw57N34ZbDWSuUd2B8Ri+XqJWf+fIsAXI06qack7nUt0Ers0UUC
        bh63P3XzjTwtBv8MSBlMbWiUmw==
X-Google-Smtp-Source: AGHT+IFxuzaCV7r8DjCeSYSf/GN6tB4Ibj1JEyclXxd13O3+GZ+mnIbjiCq0jprg5ZLn/K1NZk6hBw==
X-Received: by 2002:a05:6a00:10c6:b0:692:7527:c2d0 with SMTP id d6-20020a056a0010c600b006927527c2d0mr121528pfu.32.1695405089536;
        Fri, 22 Sep 2023 10:51:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c3-20020a637243000000b005742092c211sm3377312pgn.64.2023.09.22.10.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:51:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] irqdomain: Annotate struct irq_domain with __counted_by
Date:   Fri, 22 Sep 2023 10:51:27 -0700
Message-Id: <20230922175127.work.214-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=keescook@chromium.org;
 h=from:subject:message-id; bh=BQgw8EF2sQN7M4ibs+QlF6QlmGe5nOy0wKdHVYuPEVY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQfbeoxDR4zaH3uOGAmbHCAxmdV/x0Uu57ck
 umTWwWqzXaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UHwAKCRCJcvTf3G3A
 JghaD/4pcL2sXBv0TjsRrV0JegGCtCISLELqwjPXi9SkAxJNkulj3xTCySEPOwpLlQXHM7SxQwr
 F0EPSgQBnwy8EAg3ioFdXQBOAxIhxVqp8jtgieOLcP8kj0/OVK/kCf3D2xOkvXpmSe/CGBQm27a
 ozR6mTj7DTFHYXDQcYBBjX3lrYjX63xd9Sk/Yz6rMpYqL1GxW0LMeomXNII//d0rtJD15oDP+Fh
 vQCWAqLroY1LYo3JHHzjp7caDPUb5KPqr0coODKFf2Uieux7YJSeeWD9bi97tqFYXE0DQ6+PqIT
 LND+y+hEX6Psxf4oEOTEzekyAJb/DDGbImYoB92mpkNMzEsmwF1hwlO5Yhu4g17g0Rnsq5J4X74
 r5mI20ib6cKbNVQjJJ0cBfrRIvwHCUpzWVmMNeNsKUweLfOOqcEOw9Rgar/ErLx6AqLspvWjwa3
 dfbQt+uY4pKOVFOV0L/ylQiPyQFOKcEm1hBKEp3iQZM2qfJWHoIkOSs0WtRZkrA46yXj0rlpfRX
 ImzSaV4bdrg6X6/DJKUDmCwKX0gJ4X2dd9NZAwnnGqqRL07VZmoHTSDDdfvdBEnK2UnFxcrrvH7
 BQq1GTf7uFssvkCPkCSORG26ATobdZGprPkXeGlAsXhd0Szfa+nZ4EyVlUnVshv88fcCi79uZAW
 mbuiuGn YoIj4oWw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct irq_domain.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/irqdomain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 51c254b7fec2..ee0a82c60508 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -174,7 +174,7 @@ struct irq_domain {
 	irq_hw_number_t			hwirq_max;
 	unsigned int			revmap_size;
 	struct radix_tree_root		revmap_tree;
-	struct irq_data __rcu		*revmap[];
+	struct irq_data __rcu		*revmap[] __counted_by(revmap_size);
 };
 
 /* Irq domain flags */
-- 
2.34.1

