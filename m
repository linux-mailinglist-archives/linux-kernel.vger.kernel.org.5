Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6277B4EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjJBJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjJBJXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:23:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17FB83;
        Mon,  2 Oct 2023 02:23:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405524e6769so16967185e9.1;
        Mon, 02 Oct 2023 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696238628; x=1696843428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWnc+dy+pgpvwPkAp+YPEAjlQNYnRW3rr6yrN5WtgHM=;
        b=ebkgnddL+rUXra5avqchX5dzdO9VJepU6B/wzyC1s0SmnJDDH4/mkGt1hEuz2h9QXg
         jaQKKpOTO9uoXkpR+rNbp6hTsyVkd2limfbdD49VrYZ9+ZrWvYRZJ+RA1+s9DymVEDaW
         WZiypRs39SAA0svCURfc3UrwtqO+ipGrI1f+rAg6yz0fZOHryXw+JuJDgSrNaFNwcfJr
         8mxlN13S1zZ5cpyaVMVUJYy4gWrUDQll8og46PH4DXUyxjcYrq2KhhZ4pPgzUQEvCQdG
         yy4GlnrBoKKt1BjMtY6y+nw32qNDNW79rJrLKnME9T0QjVdqq7zTr8IvA+k7a0AwMWMO
         grGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238628; x=1696843428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWnc+dy+pgpvwPkAp+YPEAjlQNYnRW3rr6yrN5WtgHM=;
        b=M2O8cTV8G9v7lEh/vBNp2jqxZcmZ5fKWvhi6q+/Ael+6c/+TWIgPYGKoAiXa4uT6Y+
         JZjfkmfrwtP0nF4/c+Nf4kGenkE0d3T4PQR/uoB77qylpmNiQCGQ57KQotmlY9lEnnNQ
         94J2s5ObhB7PZwiKD9gm6O0mt74BkbYRD3fNo1tHpXmwxjinLPHp7d+lk7gQkMAU7g0k
         lzJ1NFoUOlIUrd3FGukV+fpYl6TQ1wIdIFfwufUm1RV6n6JIsQ/cbTvYZDJOIKOrsCHr
         Yf2XcO05EWxawngsNHNZtaoru2BAnng1bFuJZHDb97GBEaYeiA8JNgYN8qtWGpRIywuL
         EFhw==
X-Gm-Message-State: AOJu0YzCqEBk7AZw//hd4bniLmBaEZ54Q+WKYp+WeJnc3C1kd4D8UrPw
        y1M5JFfzpjBlOTOLTdOKIbZOvR7E7Tc=
X-Google-Smtp-Source: AGHT+IEvprV74S3E0t1zQ5YloeRABiVyP75Q8xh4lMPOj/63ZR6M35ItZEnAIgtYfanunqc81pt4FA==
X-Received: by 2002:a05:600c:3d8d:b0:405:d70d:1790 with SMTP id bi13-20020a05600c3d8d00b00405d70d1790mr8993263wmb.13.1696238627736;
        Mon, 02 Oct 2023 02:23:47 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b003fef5e76f2csm6156589wms.0.2023.10.02.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 02:23:47 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 02 Oct 2023 11:23:33 +0200
Subject: [PATCH RFC 2/4] clk: reset new_rates for next run
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-ccf-set-multiple-v1-2-2df5e9eb3738@skidata.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

During clk_set_rate(), new_rates are calculated for all clocks that are
part of the changed clock subtree. These values are temporary and only
valid during the current call. Therefore, reset them to prepare a clean
state for the next call.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 82f954121e4d..5f183cba300c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2163,6 +2163,17 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 	}
 }
 
+static void clk_reset_temp_rates(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	core->new_rate = CLK_RATE_UNSET;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		clk_reset_temp_rates(child);
+	}
+}
+
 /*
  * calculate the new rates returning the topmost clock that has to be
  * changed.
@@ -2244,7 +2255,9 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 		top = clk_calc_new_rates(parent, best_parent_rate);
 
 out:
-	clk_calc_subtree(core, new_rate, parent, p_index);
+	/* only set new_rates if we found a valid change path */
+	if (top)
+		clk_calc_subtree(core, new_rate, parent, p_index);
 
 	return top;
 }
@@ -2347,6 +2360,7 @@ static void clk_change_rate(struct clk_core *core)
 
 	trace_clk_set_rate_complete(core, core->new_rate);
 
+	core->new_rate = CLK_RATE_UNSET;
 	core->rate = clk_recalc(core, best_parent_rate);
 
 	if (core->flags & CLK_SET_RATE_UNGATE) {
@@ -2361,7 +2375,7 @@ static void clk_change_rate(struct clk_core *core)
 		__clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
 
 	if (core->flags & CLK_RECALC_NEW_RATES)
-		(void)clk_calc_new_rates(core, core->new_rate);
+		(void)clk_calc_new_rates(core, core->rate);
 
 	/*
 	 * Use safe iteration, as change_rate can actually swap parents
@@ -2437,8 +2451,10 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 		return -EINVAL;
 
 	ret = clk_pm_runtime_get(core);
-	if (ret)
+	if (ret) {
+		clk_reset_temp_rates(top);
 		return ret;
+	}
 
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
@@ -2454,6 +2470,8 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	clk_change_rate(top);
 
 err:
+	clk_reset_temp_rates(top);
+
 	clk_pm_runtime_put(core);
 
 	return ret;
@@ -3900,6 +3918,7 @@ static int __clk_core_init(struct clk_core *core)
 		rate = 0;
 	core->rate = rate;
 	core->req_rate = CLK_RATE_UNSET;
+	core->new_rate = CLK_RATE_UNSET;
 
 	/*
 	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks

-- 
2.34.1

