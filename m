Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECCA76DC84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHCATa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHCAT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:19:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461F5E4D;
        Wed,  2 Aug 2023 17:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8BC061B8E;
        Thu,  3 Aug 2023 00:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93262C433C8;
        Thu,  3 Aug 2023 00:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691021967;
        bh=i9njW3CU3ysA1Et78tlBxgdc/qGyJY9FPTxEpsTmWG8=;
        h=From:Date:Subject:To:Cc:From;
        b=gOq2g+d+9ejMTOZzt81mXK2BHSp/st6eOC25ZVL8ViGAJKxMOnQRjGTVVFkeXHPH0
         mHW/G1MpIEsG/b+1uYo/suVsGKrUb2oJPLdLHNgCs02pj6GdbtS0uiMlpkQlYSch12
         N6xPumaKDJvUnQkROASUWZn9sU9zkiyaXsfr2okI5kz/h54lhN45hXWBWkIxYuiH12
         dCE5w471iYIJHahmjtGL1lWI6TwAF5fgg81DcQ7nCxC7DcaHobiinhbnS4cbD2/wlU
         fLL+mH5LQdKTfwVzmYULP/oFwUOOiFNE3ccWvkpVXH/nyULAzK3oFtviMpXtJ4+UkR
         6uhxIT/80yvfg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 03 Aug 2023 01:19:06 +0100
Subject: [PATCH] arm64/ptrace: Flush FP state when setting ZT0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-arm64-fix-ptrace-zt0-flush-v1-1-72e854eaf96e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHnyymQC/x3MQQqDMBBA0avIrB1IUom2VxEXaTLRAWtlokWU3
 L3B5YPPvyCRMCV4VRcI/TjxdynQdQV+cstIyKEYjDIP1SmDTj62wcgHrps4T3huCuO8pwmDDa1
 +P2PXWA1lsAqV7p73Q85/8JYuIGwAAAA=
To:     Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=broonie@kernel.org;
 h=from:subject:message-id; bh=i9njW3CU3ysA1Et78tlBxgdc/qGyJY9FPTxEpsTmWG8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkyvKM6LEBaAVCoqRA9QISwmgFmsYT68gBlAiT5Dxk
 8jA1SXeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMryjAAKCRAk1otyXVSH0OCmB/
 9oDJr0WeoFr09Y2F5qiVli1uwiYN1YbqiAUwFb/SF8+odcLDXeI6ZFGmv2F17nmGJDUXwGesHkwvOY
 iBMku5e5fgpYudMQ+fvBPPL6reyM1/47yrMwS0bIvfQQCvxCqRNZk4pMm7WzoZi1TbUsD37Pj2Bq8r
 L7k9Uo2EtwfVuK6CYHeBhwR44vHDY0UBgy7FrEhEL/uA5xPg0AXHW1LlgOtoD/7zqBR+qWRA/yViPc
 /4PhoF4Q2K/0L7qmNQQOgyU0ZG8GkQrCdlLqCPGDwD6v5y6rOndBLXXm+xsTXjmvwfdh8JmXrILkaF
 5VEFacWWgVBGYg2NAygyvUZNKsWPez
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting ZT0 via ptrace we do not currently force a reload of the
floating point register state from memory, do that to ensure that the newly
set value gets loaded into the registers on next task execution.

The function was templated off the function for FPSIMD which due to our
providing the option of embedding a FPSIMD regset within the SVE regset
does not directly include the flush.

Fixes: f90b529bcbe5 ("arm64/sme: Implement ZT0 ptrace support")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/ptrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d7f4f0d1ae12..740e81e9db04 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1180,6 +1180,8 @@ static int zt_set(struct task_struct *target,
 	if (ret == 0)
 		target->thread.svcr |= SVCR_ZA_MASK;
 
+	fpsimd_flush_task_state(target);
+
 	return ret;
 }
 

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230802-arm64-fix-ptrace-zt0-flush-d6d71b9f8461

Best regards,
-- 
Mark Brown <broonie@kernel.org>

