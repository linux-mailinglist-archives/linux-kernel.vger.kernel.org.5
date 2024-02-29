Return-Path: <linux-kernel+bounces-86314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B4086C3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64A3B2452A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E142754BF9;
	Thu, 29 Feb 2024 08:38:06 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77C24A19
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195886; cv=none; b=l8+BZ2bcZi3GfXthBWpkklo4otnYmwX0h9Y5ezSkFjaspfaQdHR+MDcrf3G+lIt/nBfYoaYQdnX2ajZFkMH8p2FkzspY2eMHK9fbtp+YpBtEM1JtpvaApRbtL0UDCZCfMuRqpc4ZIu1/v9svdiAjJcypMsi6pj27V41bdr+0O64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195886; c=relaxed/simple;
	bh=jWAacUaeYv+d+/EE4lwYbSgfGQ+fg43sEqeBomEF8Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gquwXbslRmNSEI066Jc7EPYpOaQqNnjWyu7LFSfKgi/k24ztjp+dTc0bXJwah2kplykALK8VfKjJIOy2zNZWOlGqFO05DSIFI/mFxakzNO0Txoqb+TG0Vf8KJje8BCJQcTckwk7z9X48tZOObVB03l4IKboq9gPgifgrhaVx0uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlkjZ4FW1zB0McF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:22:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C8031140496
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:37:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.130.4])
	by APP2 (Coremail) with SMTP id GxC2BwCXgiZOQuBlIOpmAw--.42792S2;
	Thu, 29 Feb 2024 09:37:52 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ENTRY CODE)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH 1/1] x86/entry: Use one cmpq in NMI entry to check RIP for nested NMIs
Date: Thu, 29 Feb 2024 09:37:11 +0100
Message-Id: <20240229083711.721-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCXgiZOQuBlIOpmAw--.42792S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF17JF4UWFykAr4DXFb_yoW8Gw4kpF
	4fCw1kKF4ku34SqFn3K3WIqFW7uFsIgF45WFW2kr4YyayYg3yUKr1Ikr48G34rZr4SkFWr
	tF40qrW8JF1UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRWbyCUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Optimize the check whether a nested NMI occurred between repeat_nmi and
end_repeat_nmi. Although this is not a hot path, this is standard code to
check whether a value is within a given range; it is slightly faster, takes
up less bytes of code and saves one entry in the branch predictor.

This patch also removes the only relocation for end_repeat_nmi, removing
the need for ANNOTATE_NOENDBR.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/x86/entry/entry_64.S | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9bb485977629..cae40076e109 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1251,13 +1251,10 @@ SYM_CODE_START(asm_exc_nmi)
 	 * the outer NMI.
 	 */
 
-	movq	$repeat_nmi, %rdx
-	cmpq	8(%rsp), %rdx
-	ja	1f
-	movq	$end_repeat_nmi, %rdx
-	cmpq	8(%rsp), %rdx
-	ja	nested_nmi_out
-1:
+	movq	8(%rsp), %rdx
+	subq	$repeat_nmi, %rdx
+	cmpq	$(end_repeat_nmi - repeat_nmi), %rdx
+	jb	nested_nmi_out
 
 	/*
 	 * Now check "NMI executing".  If it's set, then we're nested.
@@ -1383,8 +1380,6 @@ repeat_nmi:
 	.endr
 	subq	$(5*8), %rsp
 end_repeat_nmi:
-	ANNOTATE_NOENDBR // this code
-
 	/*
 	 * Everything below this point can be preempted by a nested NMI.
 	 * If this happens, then the inner NMI will change the "iret"
-- 
2.34.1


