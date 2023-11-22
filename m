Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC637F3C98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbjKVDsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVDsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:48:51 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C457181
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:48:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28120aa1c24so4403361a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700624926; x=1701229726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dli5291sgoxdBf0M7ZcZCemBOpnn4oJYx/LL1st4SQ=;
        b=E1yqsT3YLm8x6TGPOSPxSmSnLdYJ0cXCSHSJ1SFo7IGo56sXCEFJe5xLQeRW7PmyEF
         kjHLfTOfPXLNitFeyxZlTgHJG2p75BbV5fs96A1K+0b38p46ddPJ/NXy9winayYilZjd
         vr52kJGLIK2MCb9Dgz2xnI+brWfx8MboR80Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700624926; x=1701229726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dli5291sgoxdBf0M7ZcZCemBOpnn4oJYx/LL1st4SQ=;
        b=mGYKIhRt8Hm9B+m131zQdhPtibItueLoeJFh+rq0enNPWJlE9zKp9UND1hmkZ7JFpp
         ya/bhR1xxbPxzP5XH5z1JDMImRMjHvHuXxEUS9TaDe70pKJxEGVUMo/Rf83tjgqD4Khn
         vnETQaKpFRMX9ep4RvUEZZyI0VUe79VK+2JvI/5q46z2hGPJRNsS7J7+PNL4NyYi0V14
         +aUdmQde0TjIYImTa8buiP64DiLeX++h5mDNU8ae0hheagx0yJldOitFQPQGbBqdge1e
         yp1973uOAfD4vUCEsnOuWYrJcjmIO3X1/jq1qktsxCEoERpA+6K26vGK1Rll2RvAiChc
         6mdA==
X-Gm-Message-State: AOJu0Yx64pwiGnUTg1ZuHfSb1b6M0CikBcIk1XQJcl4exrN6JMD0Lw2H
        EAA3mtRgta781aJOgajM1ZPOew==
X-Google-Smtp-Source: AGHT+IFVjXM1ZR3Y2Vn54mvt9XyjmYWMc0GfXoY/IyKyfKoyP3+LBBRYkTtIcayEk07Hmy7kFJKAnQ==
X-Received: by 2002:a17:90b:1d8f:b0:27d:2109:6279 with SMTP id pf15-20020a17090b1d8f00b0027d21096279mr1340292pjb.12.1700624926197;
        Tue, 21 Nov 2023 19:48:46 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:1aba:fb75:807e:7620])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090adc1000b00280215e7aebsm300191pjv.15.2023.11.21.19.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:48:45 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Patrick Georgi <pgeorgi@google.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stefan Reinauer <reinauer@google.com>
Subject: [PATCH] kconfig: WERROR unmet symbol dependency
Date:   Wed, 22 Nov 2023 12:47:45 +0900
Message-ID: <20231122034753.1446513-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KCONFIG_WERROR env variable is set treat unmet direct
symbol dependency as a terminal condition (error).

Suggested-by: Stefan Reinauer <reinauer@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 scripts/kconfig/symbol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index a76925b46ce6..34fc66e075b7 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -37,6 +37,7 @@ static struct symbol symbol_empty = {
 
 struct symbol *modules_sym;
 static tristate modules_val;
+static int sym_warnings;
 
 enum symbol_type sym_get_type(struct symbol *sym)
 {
@@ -317,12 +318,14 @@ static void sym_warn_unmet_dep(struct symbol *sym)
 			       "  Selected by [m]:\n");
 
 	fputs(str_get(&gs), stderr);
+	sym_warnings++;
 }
 
 void sym_calc_value(struct symbol *sym)
 {
 	struct symbol_value newval, oldval;
 	struct property *prop;
+	const char *werror;
 	struct expr *e;
 
 	if (!sym)
@@ -338,8 +341,9 @@ void sym_calc_value(struct symbol *sym)
 		sym_calc_value(prop_get_symbol(prop));
 	}
 
+	werror = getenv("KCONFIG_WERROR");
+	sym_warnings = 0;
 	sym->flags |= SYMBOL_VALID;
-
 	oldval = sym->curr;
 
 	switch (sym->type) {
@@ -430,6 +434,9 @@ void sym_calc_value(struct symbol *sym)
 		;
 	}
 
+	if (sym_warnings && werror)
+		exit(1);
+
 	sym->curr = newval;
 	if (sym_is_choice(sym) && newval.tri == yes)
 		sym->curr.val = sym_calc_choice(sym);
-- 
2.43.0.rc1.413.gea7ed67945-goog

