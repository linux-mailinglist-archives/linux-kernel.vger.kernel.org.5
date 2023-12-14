Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51879812D16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443702AbjLNKfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443641AbjLNKfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:35:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA4F139;
        Thu, 14 Dec 2023 02:35:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3332efd75c9so6822434f8f.2;
        Thu, 14 Dec 2023 02:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702550120; x=1703154920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SZpEgDuZF0Kd57Q/v4Kq9sCIukMURy5kzt0ohYZmr8=;
        b=QO/qw4f7RbtkpgM4FmK4C53/KNN7XywM/8TA9B0sanPqUs3mwxBF0FI1r85Q+E/E+5
         zKKR17B35HPsa1Z3vJFP4+7Qfs095QnBwCD1tUsiA61tg5FZfIT8jS1S4y7KZmOYUQSt
         Pph8Q4Qbz9AXxzQQ8oF2y8c9jsrCbRwheNjhWB0lLZ6KPo9QjNG/EzpfjA2bYjRhJxz8
         INmPcqxuOFA7Cc2UzZIkDnmsFOFBfVdbc4Np5Kpv6jpi4iQa+OkUk5xIXeWVTZwlMh93
         VaYuikZhYU1DvO+ekOpW7Q4SJs/y9efBeXcOHUxYVlGD9MtSECIIJpTlMLUJENuAJg2b
         eCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550120; x=1703154920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SZpEgDuZF0Kd57Q/v4Kq9sCIukMURy5kzt0ohYZmr8=;
        b=jWaD8rR+a/fShMzjaGdmloifn+bUeYLNhTHoAcY5/vCmQv0n80QXPnARk9yBPm7v4Y
         IuxHib/SnWy3jz3PMgn/Tn3dID9gsUbs0ehi3Kyg4up3VXLRWC/ChNRy2SWtfk5Jul/1
         wo3o8XcSU79u3XXPUQ00CX86rfZ47eze2iKdFEM/FsgMuCmtWzX0zmuEGBA+LhkXkkDN
         L42spu7hrBoRZMpnXj36nv1c7nGHV18e1HwuGtjAoWOyWgYxVbkGtEq2gp/YM3tE/CWl
         Vyp6EwAJ3eHQBPp1F2ADaGkHcgtc2xW0BKgDwNhs0rwTbBwsx0r+IJpViP1lWsdZUnZi
         3HIQ==
X-Gm-Message-State: AOJu0Yzjl0UjsplzorOCTv9Niz1d7aTQQ3SoWEOuR+D4NGpdkE6SallW
        mPM4Y/BeXMLteRgCqW8RP0c=
X-Google-Smtp-Source: AGHT+IHYPY97jc9qd+t5is/0cCaszwyL2E4cFGf6c7JTug0/K/MlULH3FTa3Xttj5loEfnYxN8qi2g==
X-Received: by 2002:a05:6000:235:b0:336:4a69:aa98 with SMTP id l21-20020a056000023500b003364a69aa98mr115808wrz.122.1702550119975;
        Thu, 14 Dec 2023 02:35:19 -0800 (PST)
Received: from localhost.localdomain ([129.0.226.240])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003333ed23356sm15849623wrw.4.2023.12.14.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:35:19 -0800 (PST)
From:   Brandon Cheo Fusi <fusibrandon13@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH 3/5] cpufreq: dt-platdev: Blocklist allwinner,sun20i-d1 SoC
Date:   Thu, 14 Dec 2023 11:33:40 +0100
Message-Id: <20231214103342.30775-4-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214103342.30775-1-fusibrandon13@gmail.com>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner D1 uses H6 cpufreq driver. Add it to blocklist
so the "cpufreq-dt" device is not created twice.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bd1e1357c..2febcfc2c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -104,6 +104,7 @@ static const struct of_device_id allowlist[] __initconst = {
  */
 static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h6", },
+	{ .compatible = "allwinner,sun20i-d1", },
 
 	{ .compatible = "apple,arm-platform", },
 
-- 
2.30.2

