Return-Path: <linux-kernel+bounces-97011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C2876466
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A9C1F22AA9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42E61429E;
	Fri,  8 Mar 2024 12:38:14 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-09.21cn.com [182.42.152.55])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0581F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.152.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901494; cv=none; b=M1QuVYhbfHCfhABrjLZUJTRNzsVLjh4peqgTBuBtMEnTb/ZNJ9Bc2QtT+HjMR9XkKs8PrNRiMsGgdjdd73A4fvwv75sVMi8JJn4DACNLP7G75fTQB+xagWNnBD51+DUnwGNDICenCBAc3F5vLL9XwaPvFhwG79bHSnrHk5I3k6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901494; c=relaxed/simple;
	bh=pvx+gCC6jI5B6hoAV10utHkbSF0byqV7a/fUtmag/aU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZ6pPhCG+uVlmFc7pJeRVl3FWcPvDZ5Yr+383f5xlx6sV0tVpm/d2/qxlZfohd4PtKt7MfmMD8Tu7ajQVp53Ts8SfgPhI1Z8ENJYfN2oXAHXEIg8FCq7gYdb0PGYlvD6iG4YZRt/0aJUYafV3Y4zN6Y5ChejDA6AiXsBvUsSFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.152.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.138.117:1741.1211802803
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-10.133.8.31 (unknown [192.168.138.117])
	by chinatelecom.cn (HERMES) with SMTP id F158E111064AF;
	Fri,  8 Mar 2024 20:27:59 +0800 (CST)
X-189-SAVE-TO-SEND: +sibs@chinatelecom.cn
Received: from  ([10.133.8.31])
	by gateway-ssl-dep-77bc75f6c8-sfvft with ESMTP id 9439230eb9e0458b890b8d3a43501b50 for tglx@linutronix.de;
	Fri, 08 Mar 2024 20:28:11 CST
X-Transaction-ID: 9439230eb9e0458b890b8d3a43501b50
X-Real-From: sibs@chinatelecom.cn
X-Receive-IP: 10.133.8.31
X-MEDUSA-Status: 0
Sender: sibs@chinatelecom.cn
From: Bingsong Si <sibs@chinatelecom.cn>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Bingsong Si <sibs@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Clear TME feature flag if TME is not enabled by BIOS
Date: Fri,  8 Mar 2024 20:27:52 +0800
Message-Id: <20240308122752.3342-1-sibs@chinatelecom.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Bingsong Si <sibs@chinatelecom.cn>
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a927a8fc9624..22f0c829784d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -526,6 +526,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
 		mktme_status = MKTME_DISABLED;
+		clear_cpu_cap(c, X86_FEATURE_TME);
 		return;
 	}
 
-- 
2.34.1


