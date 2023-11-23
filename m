Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233847F66CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjKWS6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKWS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:58:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0761B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fa2714e828so155763166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765910; x=1701370710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D52mho4bbVBLhO1MqSHLzeH5mafSEJrrR5dOy4gDBr8=;
        b=cSdtf/wVdnMJpBcJIHXBcSzwoCpd9ei0cVYoiTlsuwkgwzmMX2rsXqh7DHqJZb2GR6
         txjD7zh/dpMHGYLNjJ0pjnEAArPzqd9/sGVgLNirIjC65CIDO3vZdyEHLHMZpHudpD+o
         O3Ewgk1y5KE/2OyFRGwBZnCEWW4N1ggOKX6EOvTmUA4+CAfKWATRqeOhx+F89hWYXlP0
         0hDEF4OM/PJK079sHxwfNyiEzAxVX8TIyRVhO5k5CgI9t6VUXViKAVZMaWAaq0Znqe5a
         H/1oPod2UF2tq4WfmSMaY6fBrsEB4q7yXuupPXzwgrjQCBjyWatLxl0NmOE9Gknn7MSm
         5DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765910; x=1701370710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D52mho4bbVBLhO1MqSHLzeH5mafSEJrrR5dOy4gDBr8=;
        b=mMRw7SpeEEeKYzq2slXuCRtIsulEIyyehuYapBqaMqPmlr9uFBSSYsqPUHTaqUyuMV
         rkPnJ/pJJ++Agn6YnGpkdiQnut0khFYGBc9wE0qTVIqI41AVyWsmIK12lGBNm7ljzeD6
         8MKgkwixD5+zPdhq5iBzcIogYjAmcm9HTTt9MGJRYiwpkmdAk9SOA1GzZJT3THZiraT8
         LajyySocJufsEsHS34wefCev2bk/ec8WDm+1tCPg8iszSMcy3acdgLWgBB5uSJ4+rg+m
         A2wz98K1TOTP+3ETByzer5i5BVr8P696WEeAVt5vkvG/8P+nzOx3kdOpnIQrJDOtUHbX
         5B3g==
X-Gm-Message-State: AOJu0YxbWdERFUZEZiPvU4KF79LbdDS1NpToCpZbwQgHTaYG2paWBVhp
        qC/P+vxrXjUmBfhAFOANaBDSCw==
X-Google-Smtp-Source: AGHT+IFVVpG1Z6gxPdaL7IaaTFJinrPmrgoX6cwu9dsiRja9dZsbaJhr6jSoHE3EsEV83YZM2drU6A==
X-Received: by 2002:a17:906:738b:b0:9f8:2f30:d74f with SMTP id f11-20020a170906738b00b009f82f30d74fmr185134ejl.7.1700765909911;
        Thu, 23 Nov 2023 10:58:29 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:29 -0800 (PST)
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
Subject: [PATCH 2/5] tools: selftests: riscv: Fix compile warnings in cbo
Date:   Thu, 23 Nov 2023 19:58:18 +0100
Message-ID: <20231123185821.2272504-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Müllner <christoph.muellner@vrull.eu>

GCC prints a couple of format string warnings when compiling
the cbo test. Let's follow the recommendation in
Documentation/printk-formats.txt to fix these warnings.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index 50a2cc8aef38..c6a83ab11e22 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -97,7 +97,7 @@ static void test_zicboz(void *arg)
 	block_size = pair.value;
 	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE &&
 			 is_power_of_2(block_size), "Zicboz block size\n");
-	ksft_print_msg("Zicboz block size: %ld\n", block_size);
+	ksft_print_msg("Zicboz block size: %llu\n", block_size);
 
 	illegal_insn = false;
 	cbo_zero(&mem[block_size]);
@@ -121,7 +121,7 @@ static void test_zicboz(void *arg)
 		for (j = 0; j < block_size; ++j) {
 			if (mem[i * block_size + j] != expected) {
 				ksft_test_result_fail("cbo.zero check\n");
-				ksft_print_msg("cbo.zero check: mem[%d] != 0x%x\n",
+				ksft_print_msg("cbo.zero check: mem[%llu] != 0x%x\n",
 					       i * block_size + j, expected);
 				return;
 			}
@@ -201,7 +201,7 @@ int main(int argc, char **argv)
 	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
 	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&cpus, 0);
 	if (rc < 0)
-		ksft_exit_fail_msg("hwprobe() failed with %d\n", rc);
+		ksft_exit_fail_msg("hwprobe() failed with %ld\n", rc);
 	assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
 
 	if (pair.value & RISCV_HWPROBE_EXT_ZICBOZ) {
-- 
2.41.0

