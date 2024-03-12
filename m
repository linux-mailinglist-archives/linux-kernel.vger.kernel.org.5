Return-Path: <linux-kernel+bounces-100135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3F0879258
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EE1283972
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960DC77F0A;
	Tue, 12 Mar 2024 10:44:31 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-08.21cn.com [182.42.159.130])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444555E73
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.159.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240271; cv=none; b=GDnPXzXTKztYiNkiIQz3PtqlUy4Z+b031Hg9QZOtbw28blcMml8omGmVWFQMmCLNCiy2YTlUNt1Mil3UxwwGBAXtAEK0AzNTx9uTJYz7SEG+iqsjO1T0cDu1jX+ps+a7Tk8KjMPDH5F+yqwRV6rGydEzoksMIjg/tJZpd1KxETk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240271; c=relaxed/simple;
	bh=MfKDSsCO+k//eJBVuSOO62heQl3fYjZ9fUGxXXuhUXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDKyk3yLv2VrFH0PbJyt5l/LulapauKqQzVTKynsBnFMCiC8eZAtois5Q9mMzzuqUmI51iDw0i2YR9kqpzHzsZNtR9mvedtaXSUMQIne8Y20jI4Vmw+fcz1MZlQtpbf9WmcuJq0lNYy9imdba4U4b4yS7fVgC1zIf3i037umyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.159.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:63786.1870684316
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-124.127.58.150 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id 7579290322CA;
	Tue, 12 Mar 2024 18:35:46 +0800 (CST)
X-189-SAVE-TO-SEND: +sibs@chinatelecom.cn
Received: from  ([124.127.58.150])
	by gateway-ssl-dep-77bc75f6c8-x5lfc with ESMTP id c6fa781bcd40441ca0a54af00e4aa89d for kai.huang@intel.com;
	Tue, 12 Mar 2024 18:35:56 CST
X-Transaction-ID: c6fa781bcd40441ca0a54af00e4aa89d
X-Real-From: sibs@chinatelecom.cn
X-Receive-IP: 124.127.58.150
X-MEDUSA-Status: 0
Sender: sibs@chinatelecom.cn
From: Bingsong Si <sibs@chinatelecom.cn>
To: kai.huang@intel.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	sibs@chinatelecom.cn
Subject: [PATCH v3] x86/cpu: Clear TME feature flag if TME is not enabled by BIOS
Date: Tue, 12 Mar 2024 18:35:34 +0800
Message-Id: <20240312103534.9037-1-sibs@chinatelecom.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b909cb856eb625f00402472d3f3153db2294f259.camel@intel.com>
References: <b909cb856eb625f00402472d3f3153db2294f259.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When TME is disabled by BIOS, dmesg output is "x86/tme: not enabled by
BIOS" but the TME feature is still shown in the output of/proc/cpuinfo.

Signed-off-by: Bingsong Si <sibs@chinatelecom.cn>
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 40dec9b56f87..119ae291573b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -228,6 +228,7 @@ static void detect_tme_early(struct cpuinfo_x86 *c)
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
 		mktme_status = MKTME_DISABLED;
+		clear_cpu_cap(c, X86_FEATURE_TME);
 		return;
 	}
 
-- 
2.34.1


