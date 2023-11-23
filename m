Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D195D7F66C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjKWS60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjKWS6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:58:23 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1A1B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ffef4b2741so157090866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765908; x=1701370708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhz1HO1TFrn+esU2JyrDQXLuWyA0tprcaBHDYdqjcxQ=;
        b=gJ7RVFr3BplZ5mzK9yqnTTzgxxePX12hdwZxTOZVjyvDkAHDNGRB9FOY1tBe9+Tciy
         v7+tjZrsyNjceJy18oL2Z0PyHfCOdBAa15uMgul5YIDOoogvZDnkNBz8RSJS8OeHMjlG
         hAU+224l4M7e5HgXkBk8ZP2krc+RG2WQMkmTJK/UIaU+wYVsssIBc4bQbKWJVqXmxvfD
         hkCm4zbKHfUKLnUOYqSq8HANBiB2FpLtzGTRmi8l6CQcN842fdGCr6pchNq2uSiwvp3J
         cZk79Z716Rz97DCQQXzbpTNlzgAXJFj5vVsv+doYGPWUVaxoW+jdHvP6vIYbyhBjx2sp
         DzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765908; x=1701370708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhz1HO1TFrn+esU2JyrDQXLuWyA0tprcaBHDYdqjcxQ=;
        b=bA+gyZfkXWavd7rFba/Jioej0h+bTZxB27Zg4gKzpNUASKf05KRgylSt181ZFl2H3M
         TFf3oipmUG+SbtxnAOPsFYwrwXfna2GW6IFh2tOcy6nO3kFumNWUFThOqJLLXk+eBIxp
         diT2Zq5pwZfjigaKzgBrjayKEbsNaPf/6PqAPSeXHOqfu0DXwgZKTubWK/b2EbdSBPH3
         v8E47raR7rO7AU6qhrAirR1pC1NXDcMmQLfhxrnqp74y2EBLtCSoPrRGQlBSS5iJ/EFi
         9ZFiRV+rjaIkt2uLsvaorQauU7l40QxxQOyGZmYRrG8GwINlXCPQPugibE/TMOtKJUmj
         oUUg==
X-Gm-Message-State: AOJu0YyyfcXFiKlp8I6b0V1uPIgloRuPhLTmX7HZL3vdGf20U6gzfuGn
        BKIfInWq/8BhCaD1lgaqi7t2HQ==
X-Google-Smtp-Source: AGHT+IHuV5dXf2Er0VwPFonFK4Fp1h+h+XsSB+7tO9pY2bovS/v0cFYLhOuYH9heihq0E1lWqqNMWw==
X-Received: by 2002:a17:906:d4:b0:a01:8ef2:849 with SMTP id 20-20020a17090600d400b00a018ef20849mr177665eji.4.1700765908104;
        Thu, 23 Nov 2023 10:58:28 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:27 -0800 (PST)
From:   Christoph Muellner <christoph.muellner@vrull.eu>
To:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 1/5] tools: selftests: riscv: Fix compile warnings in hwprobe
Date:   Thu, 23 Nov 2023 19:58:17 +0100
Message-ID: <20231123185821.2272504-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Müllner <christoph.muellner@vrull.eu>

GCC prints a couple of format string warnings when compiling
the hwprobe test. Let's follow the recommendation in
Documentation/printk-formats.txt to fix these warnings.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/hwprobe/hwprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/hwprobe.c b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
index c474891df307..abb825811c70 100644
--- a/tools/testing/selftests/riscv/hwprobe/hwprobe.c
+++ b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
@@ -29,7 +29,7 @@ int main(int argc, char **argv)
 		/* Fail if the kernel claims not to recognize a base key. */
 		if ((i < 4) && (pairs[i].key != i))
 			ksft_exit_fail_msg("Failed to recognize base key: key != i, "
-					   "key=%ld, i=%ld\n", pairs[i].key, i);
+					   "key=%lld, i=%ld\n", pairs[i].key, i);
 
 		if (pairs[i].key != RISCV_HWPROBE_KEY_BASE_BEHAVIOR)
 			continue;
@@ -37,7 +37,7 @@ int main(int argc, char **argv)
 		if (pairs[i].value & RISCV_HWPROBE_BASE_BEHAVIOR_IMA)
 			continue;
 
-		ksft_exit_fail_msg("Unexpected pair: (%ld, %ld)\n", pairs[i].key, pairs[i].value);
+		ksft_exit_fail_msg("Unexpected pair: (%lld, %llu)\n", pairs[i].key, pairs[i].value);
 	}
 
 	out = riscv_hwprobe(pairs, 8, 0, 0, 0);
-- 
2.41.0

