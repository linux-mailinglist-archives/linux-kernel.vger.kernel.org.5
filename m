Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A797E82A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbjKJTY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbjKJTYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:24:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8E2141A;
        Fri, 10 Nov 2023 09:52:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f78dcf036so2119170f8f.0;
        Fri, 10 Nov 2023 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699638758; x=1700243558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjLgosbrIATqy9jCIRZQTn6hGbaoZOX0qQ5LZfhUZPU=;
        b=m5LfJeRD02RDsdwKcAMC/XOlKOZVdZkSihxXXU3Jyln05dBXO3csTvR26YU9wgVAcI
         hpBYgqnC7CpJfTfwPIjspcLbGS2HtsAkDAYN6ywTTuppNarTcFjt2SNkbV6ZurF8ptv5
         fR3bMdxNlEQETXXjJzmx+yLrlx6sET5jYPkMGDhr53DcTJuVZcqyNjGXBLtJuCT3KjBA
         O1x5GiEWlA17wYq2KSa9ImmrxINnq/e065UOGrBLB9AiI1xwLzW/rDUVpbDsR/oLJDio
         TuoDNfVnKMj4LE9+q+AiIEPjlrhrCrE+abcYOzYLsO+DONmoBF9n8/7z6Xcsgd4r+zn1
         YBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699638758; x=1700243558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjLgosbrIATqy9jCIRZQTn6hGbaoZOX0qQ5LZfhUZPU=;
        b=qJqkMPxMj50YWDflqOPNyTUIi/JRrfPJQhICLPfIqMQuCxwV/h14BPwdHTV1SlNXVg
         lyTkMTrlag2mK3AgPiscXccxHgMUjcDCCYHlHoVRqHLPJQURgq+wY0XDW/zrUotKVVt0
         XSXAlvnQ4IgUOm4cnN/aJZuBa309SlY6GF0kaFdKm2iS+qIhNS2EPDlBr6he/S/BA6y6
         D6TURSu5DffvkMtWLj3loOAIRYh2rEzcnEigTCMVQU3ro6Nv8Yu0aiZUVQqcArckOGsX
         /4QNigEWW+yBAH+Qw8NxPFZ1wFdgj3L3Ga/CFshgM5JBasX+DJWubPxoHp580H0iaS0N
         yngQ==
X-Gm-Message-State: AOJu0YwgJpjo+tT3NOnrJsIHjA3klAbw/NRLb9W8WCIYmRiuhlhnbKVF
        Sacfun0juLQ6TIZ54Zkrrn4=
X-Google-Smtp-Source: AGHT+IGlrIv+1Zu/VM/CpLeTN7etNZZXa2Hx0vzIylwj8e3jyhc5QYaQ0mrrAQTAHKEwmzAiFiKB2A==
X-Received: by 2002:a05:6000:2ac:b0:32f:64f2:815 with SMTP id l12-20020a05600002ac00b0032f64f20815mr3404438wry.33.1699638758395;
        Fri, 10 Nov 2023 09:52:38 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id e19-20020a5d5953000000b0030647449730sm2362375wri.74.2023.11.10.09.52.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2023 09:52:38 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf] bpf/tests: Remove test for MOVSX32 with offset=32
Date:   Fri, 10 Nov 2023 17:51:50 +0000
Message-Id: <20231110175150.87803-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.39.2
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

MOVSX32 only supports sign extending 8-bit and 16-bit operands into 32
bit operands. The "ALU_MOVSX | BPF_W" test tries to sign extend a 32 bit
operand into a 32 bit operand which is equivalent to a normal BPF_MOV.

Remove this test as it tries to run an invalid instruction.

Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.sang@intel.com
---
 lib/test_bpf.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 7916503e6a6a..c148f8d1e564 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5144,22 +5144,6 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
-	{
-		"ALU_MOVSX | BPF_W",
-		.u.insns_int = {
-			BPF_LD_IMM64(R2, 0x00000000deadbeefLL),
-			BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
-			BPF_MOVSX32_REG(R1, R3, 32),
-			BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
-			BPF_MOV32_IMM(R0, 2),
-			BPF_EXIT_INSN(),
-			BPF_MOV32_IMM(R0, 1),
-			BPF_EXIT_INSN(),
-		},
-		INTERNAL,
-		{ },
-		{ { 0, 0x1 } },
-	},
 	/* MOVSX64 REG */
 	{
 		"ALU64_MOVSX | BPF_B",
-- 
2.39.2

