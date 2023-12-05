Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE341805C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbjLEQwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjLEQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:51:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584AB1AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:51:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A91C433C9;
        Tue,  5 Dec 2023 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795103;
        bh=+jSB6ryQw/tAoaW0f6Dn8f5r/j3Y5hYXa/dEZzeKHsY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hOEE6jkMfBUEtmzmA1a20oPe1c2o7yUFkOp3Soydq20VtoqeV10lZHXQxQw3NJ6p1
         mcvf+CiN214KhEBoLcwbRtiKYBguX7jap49c859W398E0hXSgm/jUIUMH6Q+qVFzOn
         KtG8RFvhr1LwgmBNfKeAxRaGLfB6HY+TOnmTADBzaQfMqd/JgGgRoxbyi5b64Da9KD
         Ch6uNqSr2G36ujJPwYSxpiqlBe/K29leQ5Qs3lQOBEg0lC2yl/TTN5UchYOmzk3n96
         7pqwn1GNdrWxsti1Iq7SFdFrLQb5TlfxVb4MMPiMNEvdYcwT5UT5AzANTw0M0JdKnp
         yzbxilEmRdBXA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:08 +0000
Subject: [PATCH v3 10/21] arm64/fpsimd: Enable host kernel access to FPMR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-10-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+jSB6ryQw/tAoaW0f6Dn8f5r/j3Y5hYXa/dEZzeKHsY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1Twi1WtlQKKaA5nkPHlUe3V53qwJKTbWM22bF4r
 r3HvagmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U8AAKCRAk1otyXVSH0JiEB/
 9XRJ2vuPLH6rhHC2Qunzpjix2wygMNt0T1tUgLYOD0GoobfEhVwybTH5ELOpKpZVcm0nQBB3xNGgWg
 5MQWDMHDxejQpv0QOviokbMj+oOWuUQEEvTOPs8Tpe/ssY+k3YM4atL8a9ITybuuOv3gnvSX2pfAls
 MHcW4FTIlOukWiGyYs+PDgvBanU8KETC6LiA9eAa/zAe+3pIFYdYa+6kg+TggcotOuRTJfPz7+ryGY
 kUOK4r6FI80TFQn8IUK4i3/toQ8/FL9eztBf0SE2wydjH4wGNGGMyqEzx8jlq6/fqyjUtnTRNk6pwX
 chgJQUTMrr/hJkNvG8ydGY3SfPgOkJ
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

FEAT_FPMR provides a new generally accessible architectural register FPMR.
This is only accessible to EL0 and EL1 when HCRX_EL2.EnFPM is set to 1,
do this when the host is running. The guest part will be done along with
context switching the new register and exposing it via guest management.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index b85f46a73e21..9f9239d86900 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -105,7 +105,7 @@
 #define HCRX_GUEST_FLAGS \
 	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
 	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2) : 0))
-#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En)
+#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_RES1		((1U << 31) | (1 << 23))

-- 
2.30.2

