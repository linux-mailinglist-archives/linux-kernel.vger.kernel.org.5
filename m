Return-Path: <linux-kernel+bounces-98515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFD877B51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F301F213F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C310796;
	Mon, 11 Mar 2024 07:27:43 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-01.21cn.com [182.42.159.233])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDF810FA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.159.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710142062; cv=none; b=lg4BD/iFiuUCLBvXOwv4MmW1hXyw1HKZlPFLKI8QD2NwG5JhHY9WMolr9Dn3jVF9per7xpLjgb5MZ2UdkX6/4sF1XyQirXimLx/Asavr6MgzODDdEsNo81TeLGbZyOpQeZjXYSzo89ojIkduoGe8i3MRlY5wTUfouRcfsIReTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710142062; c=relaxed/simple;
	bh=J6HmO0J6s+zLrlibuEwc/AwNYn0n0tulm6hqS9PockI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEjpzJVdczEkKNN0VaQPL0r9Z2/ZdfQdzRfUmtK3E04b91zsInw9ZF/fzBPWjCA3XZGGG7hhYjU+FhcZoRdxlsHoz20vFSst8hK9HiUhe6maSKnfcabxZ+n5kov4Et+v+Vg6nK2Y+cmMgwIHcmd6Cn7v88+pjKjejN1R2Y7+CSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.159.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:29798.1556610506
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-124.127.58.150 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id E743B100112C5;
	Mon, 11 Mar 2024 15:20:15 +0800 (CST)
X-189-SAVE-TO-SEND: +sibs@chinatelecom.cn
Received: from  ([124.127.58.150])
	by gateway-ssl-dep-77bc75f6c8-x5lfc with ESMTP id b8ee26f0b9ed4be19d3822e012ad2032 for tglx@linutronix.de;
	Mon, 11 Mar 2024 15:20:21 CST
X-Transaction-ID: b8ee26f0b9ed4be19d3822e012ad2032
X-Real-From: sibs@chinatelecom.cn
X-Receive-IP: 124.127.58.150
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
Subject: [PATCH v2] x86/cpu: Clear TME feature flag if TME is not enabled by BIOS
Date: Mon, 11 Mar 2024 15:19:37 +0800
Message-Id: <20240311071938.13247-1-sibs@chinatelecom.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308122752.3342-1-sibs@chinatelecom.cn>
References: <20240308122752.3342-1-sibs@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When TME is disabled by BIOS, dmesg output is "x86/mktme: enabled by
BIOS" but the TME feature is still shown in the output of/proc/cpuinfo.

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


