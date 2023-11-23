Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14E7F66CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345840AbjKWS6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjKWS63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:58:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B2D47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso1614715a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765913; x=1701370713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r701pvo9PbgE9h16+HzDZMKOHNQtZ1R5aBMPWWKprHM=;
        b=cQMI8JJmM8qjaLeMVk4RNlEsMuL127P+aY4k8iy/iz8h0VwIqjg0Qihxdk99fZNmxL
         Hz8KX4+zHEUEgjPLGnVccBEMSwprXl1g+Wy2X9BtTwsIXXL/WI3D1WxCxHnwEwqbHC12
         zoLilQGEH+gfogv7ZzS4MqET4mzHT4Nw38xvqIl8jaycFnsVCVqixr6bGi5jENyzqCPS
         mVO6VuOE8QmSNgbqsp0J1wl9z9PDAqlzX4vJtrhduJFmL6ElRHQbNMPkpunXJMQFLILe
         KzRmKazci7LYxbgKyg/FhlFJnOH/NgQH0U2ch9v9WtJ1dHq09Rt4EpArQzZUIjfDVYr/
         fvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765913; x=1701370713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r701pvo9PbgE9h16+HzDZMKOHNQtZ1R5aBMPWWKprHM=;
        b=OcpCYYRE9TsyEXqVLPSBBsXjy37aWZXOpcF/PX8BI7SkLE/k1bCur2z27AybuGudxo
         9KI3TzRpiMuPZBnSSVWPukEr+klJgX9kXl2XvqpyhakQNbqP1ySKZ4VhOwrTNjwyUV78
         xzvTMb/MCLUW+7H02uU9CjXcpFKMtuTILd+1vO2gBpH0gCa4oQy2NPFJVLiEzurUULoD
         Wti4Wn+5BEg5gfHdb7iMnP0GBXgU9vE6fUlas3rUucKjtDh92Zxthsjufh+bES6fFJgz
         q/3+fOfqC9qjZZrCrFTMrv9nINvvYV3cOIX0JHPgPq8r8DKZDBTOVHdPXMV9KqkHS4ij
         A75A==
X-Gm-Message-State: AOJu0YxE1XGpNxC1x0nc2fEb2nLzkRsXANKALOnTtTSFDNrJ/kV9vQeS
        cgFusWtyJgaBHBOGx5Z+hdAggw==
X-Google-Smtp-Source: AGHT+IGo/4pGiY2CzvH24z/qYlIQMvNju8tGcNRKHAO+YNqcSuXvNbr1QJbcmN9PcnnekmGYewrQBw==
X-Received: by 2002:a17:906:b188:b0:9e6:f7c6:792f with SMTP id w8-20020a170906b18800b009e6f7c6792fmr159047ejy.17.1700765913533;
        Thu, 23 Nov 2023 10:58:33 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:32 -0800 (PST)
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
Subject: [PATCH 4/5] tools: selftests: riscv: Fix compile warnings in vector tests
Date:   Thu, 23 Nov 2023 19:58:20 +0100
Message-ID: <20231123185821.2272504-5-christoph.muellner@vrull.eu>
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
the vector tests. Let's follow the recommendation in
Documentation/printk-formats.txt to fix these warnings.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 2 +-
 tools/testing/selftests/riscv/vector/vstate_prctl.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
index 66764edb0d52..1dd94197da30 100644
--- a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
@@ -27,7 +27,7 @@ int main(void)
 
 	datap = malloc(MAX_VSIZE);
 	if (!datap) {
-		ksft_test_result_fail("fail to allocate memory for size = %lu\n", MAX_VSIZE);
+		ksft_test_result_fail("fail to allocate memory for size = %d\n", MAX_VSIZE);
 		exit(-1);
 	}
 
diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index b348b475be57..8ad94e08ff4d 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -68,7 +68,7 @@ int test_and_compare_child(long provided, long expected, int inherit)
 	}
 	rc = launch_test(inherit);
 	if (rc != expected) {
-		ksft_test_result_fail("Test failed, check %d != %d\n", rc,
+		ksft_test_result_fail("Test failed, check %d != %ld\n", rc,
 				      expected);
 		return -2;
 	}
@@ -87,7 +87,7 @@ int main(void)
 	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
 	rc = riscv_hwprobe(&pair, 1, 0, NULL, 0);
 	if (rc < 0) {
-		ksft_test_result_fail("hwprobe() failed with %d\n", rc);
+		ksft_test_result_fail("hwprobe() failed with %ld\n", rc);
 		return -1;
 	}
 
-- 
2.41.0

