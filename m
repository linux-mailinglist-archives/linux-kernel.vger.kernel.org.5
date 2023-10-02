Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD067B4EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjJBJYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjJBJXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:23:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5694;
        Mon,  2 Oct 2023 02:23:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4066692ad35so16040885e9.1;
        Mon, 02 Oct 2023 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696238628; x=1696843428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eV+VLWmEsyaB+IunROtO6uT7xWMFypNTH9h9QU/Ea1c=;
        b=If5y+nlmGiqkkqGRabBrxpKSmtSrsDpgOqjBIaZw7shWiZHnf0T95I0yY9PHGXGFAN
         F8bc2u6dMG1lxB0WMyKYVbQ04ZaAQtr6+9D77uAQxa2rKHPBLvCS+1MzpkOcZdeFqogh
         DADVwOx4FUn4hW5GV9/yx+P5LlVD4YPpnwrg3DrG5h0bYwULtNxxn1WeF687FK4xlQ1h
         IIP7RexrzkZGMGletdD+OHHzPiUROzqnejcTPhGQD602UfWdajOvdUkVazq7p+6l9Vo8
         3RVjq6zYDdnryOr+TRJN5x/0eVrPoiL0+FhW30W8UgLnxRIdqVqXZsbHXeZ5RwQ/hvYi
         W8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238628; x=1696843428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eV+VLWmEsyaB+IunROtO6uT7xWMFypNTH9h9QU/Ea1c=;
        b=OPUfckOsAeQyEsYLOvtMjscXU/vVvETUh6Wis2rtomekEjigjT9C6g63kh/l2uwq7b
         /6Q8a0sy57utE1qRlQmcZ+/LoE+OTuJs2LVpkk48dqxfCfQl/kgIA29NiwG9moXBZohi
         Ma5oSuFjpXwlaxb82NrEgopZwQ57Rl9spe+fkJ1wO9WQO2F2e+jVR33wmpI8CH4RW85Y
         UOiDlvkgIlUpjtSQWgdBsl4wLjFkNOWv9VMeLXxhA4JMZ2ukLuanL4JcCQorLeq48pld
         jpyuaAOlo844JCETrYBGlfiTi/BP7KjpvZcSdwS5XLQesYxXo/SFpguxIMtRFxPeQaQQ
         0wzw==
X-Gm-Message-State: AOJu0YzZXm5rFe8/+AByLa53Ukq7ckkgbKSIjV4pd42UGoa7wdXlp2A9
        ewfWqnWBaUxnazkD0POwGqWPGDAundY=
X-Google-Smtp-Source: AGHT+IF2O0toKcnLPeXE1jxOs0n80mBAKKNdApkyD/rX1DNEYIT5N4voMKaDDHe4VgnM5u/hmeMwkA==
X-Received: by 2002:a1c:7c11:0:b0:405:4a78:a890 with SMTP id x17-20020a1c7c11000000b004054a78a890mr9186760wmc.8.1696238628428;
        Mon, 02 Oct 2023 02:23:48 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b003fef5e76f2csm6156589wms.0.2023.10.02.02.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 02:23:48 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 02 Oct 2023 11:23:34 +0200
Subject: [PATCH RFC 3/4] clk: introduce req_rate_tmp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-ccf-set-multiple-v1-3-2df5e9eb3738@skidata.com>
References: <20231002-ccf-set-multiple-v1-0-2df5e9eb3738@skidata.com>
In-Reply-To: <20231002-ccf-set-multiple-v1-0-2df5e9eb3738@skidata.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

A clock currently has a req_rate, which is required by the consumer, and
a next_rate, which is the outcoming rate of the ongoing clk_set_rate()
call. This commit introduces req_rate_tmp, which is a temporary required
rate for the ongoing change. This means, the clock is an ancestor of the
change trigger and a descendant of the top-most clock to change. This
helps us to identify if the clock is changed "by accident" (new_rate
set, req_rate_tmp not set).

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5f183cba300c..3e7dd97b71c3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -68,6 +68,7 @@ struct clk_core {
 	u8			new_parent_index;
 	unsigned long		rate;
 	unsigned long		req_rate;
+	unsigned long		req_rate_tmp;
 	unsigned long		new_rate;
 	struct clk_core		*new_parent;
 	struct clk_core		*new_child;
@@ -2168,6 +2169,7 @@ static void clk_reset_temp_rates(struct clk_core *core)
 	struct clk_core *child;
 
 	core->new_rate = CLK_RATE_UNSET;
+	core->req_rate_tmp = CLK_RATE_UNSET;
 
 	hlist_for_each_entry(child, &core->children, child_node) {
 		clk_reset_temp_rates(child);
@@ -2256,8 +2258,17 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 
 out:
 	/* only set new_rates if we found a valid change path */
-	if (top)
+	if (top) {
+		/*
+		 * The current clock is an ancestor of the trigger and therefore
+		 * is a clock which needs to be changed in this run. Clocks
+		 * with new_rate set but req_rate_tmp unset are changed "by
+		 * accident". On these clocks, the new_rate potentially
+		 * conflicts with req_rate.
+		 */
+		core->req_rate_tmp = new_rate;
 		clk_calc_subtree(core, new_rate, parent, p_index);
+	}
 
 	return top;
 }
@@ -3917,7 +3928,7 @@ static int __clk_core_init(struct clk_core *core)
 	else
 		rate = 0;
 	core->rate = rate;
-	core->req_rate = CLK_RATE_UNSET;
+	core->req_rate = core->req_rate_tmp = CLK_RATE_UNSET;
 	core->new_rate = CLK_RATE_UNSET;
 
 	/*

-- 
2.34.1

