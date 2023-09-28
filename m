Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C647B1376
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjI1HAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjI1HAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:00:19 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E6B7;
        Thu, 28 Sep 2023 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1695884404;
        bh=SiszJ3AInp3rrBHb2XuUaqcNBc77i/EMr6oPxAb1mLQ=;
        h=From:To:Cc:Subject:Date;
        b=m4N4MDux7v8DsHD1TjAz2x+u1B8D/h7p2UR4UnNms63zAd0EcpB381tPXhGpyeOv1
         nyFywJaTL7RhH1Hh4Q2jc2jnMRDlZe3SNbc9sgs8y96mvProP9qmd2B2LPtPro23FT
         Ze71HQa9in2zbVb40Rf6EsEay7gQ9RExYO1rO9bM=
Received: from hygon4.hygon.cn ([175.152.51.41])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id ED2B607C; Thu, 28 Sep 2023 14:59:18 +0800
X-QQ-mid: xmsmtpt1695884358t2s9z7rzc
Message-ID: <tencent_4A14812842F104E93AA722EC939483CEFF05@qq.com>
X-QQ-XMAILINFO: NT+xk6rB66UcYYsfhhQx3EfAgqLG6odk2aekW7AXMue/nhJp6JbDGwd5TY9dkW
         OQ7aLE5CN5/N72w3WZcav6MqKgB4AxXpW4zXfZQQI8PBcfC1Qi4jNjOgmAMHZnr040Tg84Lk5FaA
         YFrfh2PhZPP1yFgyJANO49boZGejJljubERD3lWR5KA2Q3FTf65vO7NmgU5xlszbrZ/jzfp8TTVk
         w0M5EGpHoFB+mnD6N1VMAFWrKpmqcqc8HpqSVD/gy5OS85RXUEQ4lJkhVpzIVOflLgNo5J0bULEK
         MX5wChYnJqq3Ww7pkAk0j9FQudpkbjblKgXL3vlG2DKKC7frulfYxyNDkdf+tL6bG12CoMBGOXQF
         Mouh+1K1qOCxv427F5jkx9Ps1COywEnkKtnUTtygRuiCKx/Ossyg5kNlwEhE1h5eEoL3PPuRCXfz
         krW1a4Orx/MwAq03aqSxobfpHfLjNj7XOUxROayTcd2SR1Ci7HQ8zDCEL4FmCeilja3lWbHgCVMW
         80rClNv1dXCXPEaxHwRA6axUoanwPsG2miW4nKicbpbMrJMrH7xV7lUMss2ZP3CvvEhfLf4Q6MFF
         9w+xfMWmxNScMih2yjZcu1OMeALZbT/I9wJJjlWWOTi1Ys0+PEpjDW/Dji7PY2EtN6N19pvDP6kk
         116d8PRPj+DJv8Cy+4bZC93wnkNu1N6y9G9BZ/hyW9AFQDMTnCSfVI+w1/zbt9BaKePkLjtqp37m
         +CQ3fzkKJX2KSJCiPuh0ZCJIPMgknzj9Sd15ML379J9sI8ZkTYpmcuxGIv8tLG8ULrrTfhbPFqFX
         j+VGl7CPi8p8vTR1UIyedwMwmK6pTbUiT8IvDd1cuiRwbHvxtDfALGsrrA1fyASne5t99+qRZbtX
         csUsjav485D4q/VlNqKIZF62veTI7hM6Wg3cB9NLC3Xzy87FH5reeOOWeIE3N+5K1MrUbZ2qqos+
         9TMGZYQ9m1yXyBdyOk6JjzBApvIoY7Q1yjRFK3Sj+JnqhPWtaXmg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Pu Wen <pu_wen@foxmail.com>
To:     bp@alien8.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        kim.phillips@amd.com
Cc:     linux-kernel@vger.kernel.org, Pu Wen <puwen@hygon.cn>,
        stable@vger.kernel.org
Subject: [PATCH] x86/srso: Add SRSO mitigation for Hygon processors
Date:   Thu, 28 Sep 2023 14:59:16 +0800
X-OQ-MSGID: <20230928065916.133119-1-pu_wen@foxmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pu Wen <puwen@hygon.cn>

Add mitigation for the speculative return stack overflow vulnerability
which exists on Hygon processors.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Cc: <stable@vger.kernel.org>
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382d4e6b848d..4e5ffc8b0e46 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1303,7 +1303,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
 	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB),
+	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
 	VULNBL_AMD(0x19, SRSO),
 	{}
 };
-- 
2.23.0

