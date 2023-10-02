Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57627B4F00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjJBJYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjJBJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:23:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297179E;
        Mon,  2 Oct 2023 02:23:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50307acd445so24788970e87.0;
        Mon, 02 Oct 2023 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696238629; x=1696843429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WxI5UNOh/sMglL2XmJQroF7LkfgIlgVWztDdlKZGLc=;
        b=Ty7Gd6qcKHE9K/CCHgTbxFD7iuklgDrsqZ6NnZpvYGaeyYxmZzLcWwS2Y+aIwhLgt4
         uAe+CjVFI4u4lS52Mw4y9+E1eJO/br9fMHzKFq064155hJeoIWtqYbjQ+BOLpKLFXyNs
         1fLiXt8R6Zpr7KZussJaHLn8bj/Co+1qvdeJYkCdnHU8JKT4k0JjRuUsm4KIjJcs59Dz
         xAbzq76HuAuxuDfDaFr7N4irF4QB/3Yap5n21lOTuSOLrBeU9b0taNDtcvsmYfpAdrcc
         hxbmir8mYXWSlzMIvLxzl9Nz2tlcWz9Ua3DFzfMUiX8TYV+4izhHhIkLYNwGIL698Vk5
         jbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238629; x=1696843429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WxI5UNOh/sMglL2XmJQroF7LkfgIlgVWztDdlKZGLc=;
        b=OmDbJvToDNkavsHj0THFyEH/B6lFnqprsmewDoDqYe+aRJSm2al7qpThVEEQpQcIAD
         77YYlqqylAyzE1VfTNLoUutPKe3+l92QICJmYoAeh4/gyPopgU2H0ivlL3aTZArYvVN5
         ioVskTosF7/Gys/7o3Te0CAh9pYm04MCqmDUMtm9wuvVc1F9SSgHOKOMuVieKUjONb+i
         h7n3HLTQcBL9Gq7RXG3aj1F5oO1jpC5I1i4exrDlsiB7FNKGbn40L2gmeppboVKPgMi+
         Taf2Qx7932OaVjN/viN5JXMo9jmOjUYZ/adxKE8ftwzGmPIctJzRsjnE7ClW/hs/AbV4
         kPWQ==
X-Gm-Message-State: AOJu0YwewG4VxhbKvG515cnrPU4qSjpmwF+FAm1MuWlfl7cW2uCwYW7U
        pUbAy6q4fNeIYn5wON93nnUY6UbXJok=
X-Google-Smtp-Source: AGHT+IE7TNaedcvmDzAjGdIITBA+OGMR+LGyhUSgwsbuDpFIgKXquyj34ELFm8dLaLHrZCmqoZ9LJQ==
X-Received: by 2002:ac2:57c6:0:b0:505:70dd:d594 with SMTP id k6-20020ac257c6000000b0050570ddd594mr5124538lfo.49.1696238629036;
        Mon, 02 Oct 2023 02:23:49 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b003fef5e76f2csm6156589wms.0.2023.10.02.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 02:23:48 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 02 Oct 2023 11:23:35 +0200
Subject: [PATCH RFC 4/4] clk: consider rates when calculating subtree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-ccf-set-multiple-v1-4-2df5e9eb3738@skidata.com>
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

With req_rate_tmp and new_rate, we can identify if a clock is changed by
accident. Additionally, with req_rate, we are able to find out if a
clock consumer requires a certain rate. This enables us to find
"unwanted clock changes", meaning a clock is changed although its
consumer is expecting its current rate. On such a finding, the
"calculate new rates" process is started again, but this time for the
affected clock. During every execution of this process, we identify the
clocks which are required to be changed to get the requested rate. If a
clock needs to be changed a second time, we found a conflict. There are
various options to resolve the conflict, but for now we just error out.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3e7dd97b71c3..296d0fa510de 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2145,7 +2145,10 @@ static int __clk_speculate_rates(struct clk_core *core,
 	return ret;
 }
 
-static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
+static struct clk_core *clk_calc_new_rates(struct clk_core *core,
+					   unsigned long rate);
+
+static int clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 			     struct clk_core *new_parent, u8 p_index)
 {
 	struct clk_core *child;
@@ -2160,8 +2163,28 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 
 	hlist_for_each_entry(child, &core->children, child_node) {
 		child->new_rate = clk_recalc(child, new_rate);
-		clk_calc_subtree(child, child->new_rate, NULL, 0);
+
+		/*
+		 * A new rate of a shared parent clock might clash with a
+		 * required rate of a sibling. Ensure that the new rates are as
+		 * close as possible to the required ones. During this process,
+		 * the shared parent clock is not allowed to be changed again,
+		 * meaning it should have found the optimal rate already in the
+		 * initial clk_core_determine_round_nolock().
+		 */
+		if (child->req_rate != CLK_RATE_UNSET &&
+		    child->req_rate != child->new_rate) {
+			pr_debug("%s: set back to req=%lu\n", child->name,
+				 child->req_rate);
+			if (!clk_calc_new_rates(child, child->req_rate))
+				return -EINVAL;
+		}
+
+		if (clk_calc_subtree(child, child->new_rate, NULL, 0))
+			return -EINVAL;
 	}
+
+	return 0;
 }
 
 static void clk_reset_temp_rates(struct clk_core *core)
@@ -2259,6 +2282,22 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 out:
 	/* only set new_rates if we found a valid change path */
 	if (top) {
+		/*
+		 * If req_rate_tmp is set, the current clock is already required
+		 * to be changed in this run. However, if the new rate is not
+		 * the same as the temporary required one, the driver did not
+		 * consider its active rate (which is required by at least one
+		 * of its descendants from a previous run).
+		 */
+		if (core->req_rate_tmp != CLK_RATE_UNSET &&
+		    core->req_rate_tmp != new_rate) {
+			pr_warn("%s: %s: conflict: req=%lu new=%lu\n", __func__,
+				core->name, core->req_rate_tmp, new_rate);
+			pr_err(".{determine,round}_rate() of %s requires fix\n",
+			       core->name);
+			return NULL;
+		}
+
 		/*
 		 * The current clock is an ancestor of the trigger and therefore
 		 * is a clock which needs to be changed in this run. Clocks
@@ -2267,7 +2306,16 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 		 * conflicts with req_rate.
 		 */
 		core->req_rate_tmp = new_rate;
-		clk_calc_subtree(core, new_rate, parent, p_index);
+
+		/*
+		 * Calculating the subtree potentially leads to a re-entrance
+		 * into clk_calc_new_rates(). This is required to set accidently
+		 * changed consumer-required clocks, back to their required
+		 * rate. This can fail in case of a conflict (shared parent
+		 * needs to be changed again).
+		 */
+		if (clk_calc_subtree(core, new_rate, parent, p_index))
+			return NULL;
 	}
 
 	return top;

-- 
2.34.1

