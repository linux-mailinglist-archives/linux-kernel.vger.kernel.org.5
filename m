Return-Path: <linux-kernel+bounces-117484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3018088AFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B3FC632BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30B13B5B1;
	Mon, 25 Mar 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYBBbfxQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC912B157;
	Mon, 25 Mar 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384732; cv=none; b=Jc3uCTatEhPtcIYwMLTovvBvJUw1Wln+iHdPabmGGzdjPoa/yYoSpBEk99WkEMLvAZseJjnbpbptqjSRKMax+mWqSzCxjmDC9kJ0jgIdSwNIL6nH2rue0U1piCnmk60AatG+hiXq+ceQ9jwvK+e9wYADcYnxP1oAu7Vh8uQHknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384732; c=relaxed/simple;
	bh=CJxKR8UNymWiAkoGTQUmm74DhnvBaZZP9hB+tXHxzbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OXRyVovq7jDnJIDBkD5IoTv/h+zJNrpVFFC+uOB/kGOHFVk35IWn/aKVLkEjEC6wNrlDQvNVbQxM9STwSfRVchT74SlRjhy0ip82OVsRG7FA8npVc7iZdaD0CIfVHN4W087oV9Js3e1sgtNPuT4i4nU6xIAF4PeA0ta8QM+OrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYBBbfxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC35C433C7;
	Mon, 25 Mar 2024 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711384732;
	bh=CJxKR8UNymWiAkoGTQUmm74DhnvBaZZP9hB+tXHxzbc=;
	h=From:Date:Subject:To:Cc:From;
	b=DYBBbfxQjeyNps22kMv0rulCkXFHojXbH9GUt6jbDb3ClU+ZmcJxc3phHFvCHUH0h
	 hsH+HcaIOJbLjKlZtB5n4mCupg4Yp4s7SDj0CzD8+zYNeuYK0Bmtn/dsvC2E/KDrqb
	 5B2fvf+8Xfe17H+QwKq/UQ7f4riUdVIBhgsF8Q0czq+N0lHKl5tkKChyOLqwjBeP3G
	 NxXQ8cDV2i8Arp+dRoiqH2jR/3sk67UUuoLyT7WPnhqqafYHNKjUbG2LMnWRVadi+2
	 wYotyyEqJG9vfkVS/ChHHXrz1fdtFoHYqvrRJpfM7DJ2kVenS2Eo7Xd4WOHtxOwI1J
	 3//If3AyujgtA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 25 Mar 2024 16:35:21 +0000
Subject: [PATCH] arm64/ptrace: Use saved floating point state type to
 determine SVE layout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-arm64-ptrace-fp-type-v1-1-8dc846caf11f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMinAWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNL3cSiXDMT3YKSosTkVN20At2SyoJU3RTj5FQTizQLCwvjVCWg1oK
 i1LTMCrCx0bG1tQCrOV2MZgAAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CJxKR8UNymWiAkoGTQUmm74DhnvBaZZP9hB+tXHxzbc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmAaiZtvwmf4UFALoOXmuGK0ixd/tNCvVGCopl8RQD
 qUB6X46JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgGomQAKCRAk1otyXVSH0KN8B/
 9r7e1IHguFKU+kRZM5X5JfT/i3nfrnQ86DPw3GiS81xr2njfX5ae53taWoc+vtFBkN0sfmkxtPp5op
 T1Fd5Fd/bNoiyCA0jtaOR7ZU7Oj19tl1tufFgxgRxbIBlflpOgkTHpDQ2qJzC4q0JaJFSoq/E+xDGB
 4ObNZNaf2i1V5i9bgDLNkhqRmC5iwuk+GAM+hXzy9bzprAs/ENWuGKbQ17OZq7n96C3wdSmxd1k9Vh
 S1mHMHbZEBj6oNUtOezs5rEDAuMK06tDl6meLbwzH+PtzMqGdKQoInlzPPmQeYH6YfWe1JLk+mg26b
 yXXs8mltU+rLX6+2RIGaigALtzXIBZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The SVE register sets have two different formats, one of which is a wrapped
version of the standard FPSIMD register set and another with actual SVE
register data. At present we check TIF_SVE to see if full SVE register
state should be provided when reading the SVE regset but if we were in a
syscall we may have saved only floating point registers even though that is
set.

Fix this and simplify the logic by checking and using the format which we
recorded when deciding if we should use FPSIMD or SVE format.

Fixes: 8c845e273104 ("arm64/sve: Leave SVE enabled on syscall if we don't context switch")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/ptrace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 162b030ab9da..0d022599eb61 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -761,7 +761,6 @@ static void sve_init_header_from_task(struct user_sve_header *header,
 {
 	unsigned int vq;
 	bool active;
-	bool fpsimd_only;
 	enum vec_type task_type;
 
 	memset(header, 0, sizeof(*header));
@@ -777,12 +776,10 @@ static void sve_init_header_from_task(struct user_sve_header *header,
 	case ARM64_VEC_SVE:
 		if (test_tsk_thread_flag(target, TIF_SVE_VL_INHERIT))
 			header->flags |= SVE_PT_VL_INHERIT;
-		fpsimd_only = !test_tsk_thread_flag(target, TIF_SVE);
 		break;
 	case ARM64_VEC_SME:
 		if (test_tsk_thread_flag(target, TIF_SME_VL_INHERIT))
 			header->flags |= SVE_PT_VL_INHERIT;
-		fpsimd_only = false;
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -790,7 +787,7 @@ static void sve_init_header_from_task(struct user_sve_header *header,
 	}
 
 	if (active) {
-		if (fpsimd_only) {
+		if (target->thread.fp_type == FP_STATE_FPSIMD) {
 			header->flags |= SVE_PT_REGS_FPSIMD;
 		} else {
 			header->flags |= SVE_PT_REGS_SVE;

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240129-arm64-ptrace-fp-type-d3ce48f8883e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


