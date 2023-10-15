Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ED07C9760
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 02:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjJOATy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 20:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJOATy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 20:19:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F54CC;
        Sat, 14 Oct 2023 17:19:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5ac87af634aso955473a12.2;
        Sat, 14 Oct 2023 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697329192; x=1697933992; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DYEp35qic1kAb3LmlymDoS6bjtxg7Oyn8w01vjbBN0=;
        b=ELJDb99tMgN0ApjHP7BMtZrntVnM26SwfSv/HQ1oMrQCVKTM3yiB8n92qbPzbYmvfC
         nXnbIhqDr7FWaZpz5G7cVDgDgJcMtzCDzZJa+BV2uTr2HfvZsrmm50eUXVyXacQQ5NgC
         1EJrZeTXi6WR6kl3xRqAYlIQaNoHqkGE4YuxF38YbkGfnNWeQdlG0dBiNQS802Xx+GZl
         oIp/dMM7tHweSkRUWkLiVyDSAUv7WBPQ788bY7gNtrAwSIgjtxNrrkb3FY/CQhLuT+uQ
         6sit1IuT69AxTdI7G2l06G+zQGFi4uHpVArwSBrIW6XeXO8l1tbANESqLil43XKo/sOw
         rXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697329192; x=1697933992;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DYEp35qic1kAb3LmlymDoS6bjtxg7Oyn8w01vjbBN0=;
        b=faNyT77KIPUnMaFwZinsSNqk6NBx+q119zqiCL7i3luDxbZwnqYgirNp1emJybY6cE
         Z5jhOwjR6397TB4hyLNmEYHP/SV2SUk8g2Ud3MOBSpr/GHL+nkjKo9TY+h7RgaVAPv1Q
         yLAfIx3sDEJ1jLMVLDj29zScSbo95Kc2hfkfDZBWUoOUCsBNxwC/+nyhIh7VkgyqBdSN
         pKWcN8R3TXIvVXtcD94BPKj/aFwab8AkO9mvGv2rdsNfE1XMKeheDJ4WQ4u7kcLyZ05a
         km25+9bNyD6TgUxpvgKl8D9h6CTdbSUIx6VGX2T16jLjuqL3vuacgaZEwzK4f12ZzvAa
         fLeA==
X-Gm-Message-State: AOJu0YwksTnRvcgfFcMqHMFkAtyecOuLJ2um4rB9ZcvAVkXFucD6zmXh
        bNs59sJSI/RX2kuDs9/h8rsHDQ+ytG+x6RYx
X-Google-Smtp-Source: AGHT+IH3+9qB9tQfEMwULFJwZFYHCZFV657ZMANCg9S81xDJCZW2dlV2hePQNq2UJNwzGIfP3AYO3A==
X-Received: by 2002:a17:902:ecc5:b0:1c6:e8d:29ea with SMTP id a5-20020a170902ecc500b001c60e8d29eamr33123528plh.60.1697329192135;
        Sat, 14 Oct 2023 17:19:52 -0700 (PDT)
Received: from fpga ([2405:4802:1d8b:d300:e43c:5ed2:5abb:2c02])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001c5076ae6absm6001685plb.126.2023.10.14.17.19.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Oct 2023 17:19:51 -0700 (PDT)
Date:   Sat, 14 Oct 2023 20:19:46 -0400
From:   "Duc-Long, Le" <duclong.linux@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: tc358746: fix the pll calculating function
Message-ID: <20231015001946.GA10485@fpga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following formula of Pll_clk in 5.2 section, 50th page of
TC358746AXBG/748XBG/748IXBG Functional Specification Rev 1.1 document.
The formula of fout is as below:
	fout = refclk * mul / (prediv * postdiv)

Remove "p" to avoid using 2 times of prediv in pll calculating function.

Signed-off-by: Duc-Long, Le <duclong.linux@gmail.com>
---
 drivers/media/i2c/tc358746.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/tc358746.c b/drivers/media/i2c/tc358746.c
index 566f5eaddd57..4f54773886cc 100644
--- a/drivers/media/i2c/tc358746.c
+++ b/drivers/media/i2c/tc358746.c
@@ -839,14 +839,14 @@ static unsigned long tc358746_find_pll_settings(struct tc358746 *tc358746,
 		if (fin < 4 * HZ_PER_MHZ || fin > 40 * HZ_PER_MHZ)
 			continue;
 
-		tmp = fout * p * postdiv;
+		tmp = fout * postdiv;
 		do_div(tmp, fin);
 		mul = tmp;
 		if (mul > 511)
 			continue;
 
 		tmp = mul * fin;
-		do_div(tmp, p * postdiv);
+		do_div(tmp, postdiv);
 
 		delta = abs(fout - tmp);
 		if (delta < min_delta) {
-- 
2.17.1

