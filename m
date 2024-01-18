Return-Path: <linux-kernel+bounces-30016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E883178B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBADF1F22310
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D323760;
	Thu, 18 Jan 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MpFTAmnL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA381774B;
	Thu, 18 Jan 2024 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575502; cv=none; b=Fq6FpT2MaCj68eAMri+DweoPJLdHK4o08UC+PnYB28lrFyZbalfFBhfzTGO7XjvaD3JziZ1y11wdlR2qi69CrFGrC9cQMbEC/kJpLrdlQ0O7faK6g01aG1ol4FPnSlecCg0pilbDbEOBTpO3Y9y+GivFGvhZ4J+BGknwAwY4sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575502; c=relaxed/simple;
	bh=Rqt9d8H9b7ON2dY22pUE5JwX1GzNwB3+PYGDm4bKB/E=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=KiUKZS35UA3nPOAVkzoyfObq9YON7qDkU8OCpCghqJ9bh2g7br3+Q+z/eqMIXfNuiv2jg+OlspWrNbUAVzQHNAbVHfgmpUZKH7ehxtlVCRZ89dc28C9EW93Kca8lHRlOtQr2et6fV7UW4XD8wTnRtCbu089XC6Mf0mGjFkw1EmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MpFTAmnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18ECC433F1;
	Thu, 18 Jan 2024 10:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575502;
	bh=Rqt9d8H9b7ON2dY22pUE5JwX1GzNwB3+PYGDm4bKB/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MpFTAmnLYx+DzpKxhXO/jxzN+fklmEPLz8kgGOvq1f4y5DoLx2B+7aCJQuhBTQF0R
	 aN3U9OiC/sCdVmPchK65S8ea/VGPpM6pOwRSPUPvmOvzEMWwjzHQNyBXS0KYeNWHVv
	 jEdM3qSWbaJj2oDAXPkqgHLPgrwjfPDe0Dg3ktRU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCH 6.6 129/150] x86/microcode: do not cache microcode if it will not be used
Date: Thu, 18 Jan 2024 11:49:11 +0100
Message-ID: <20240118104326.023345747@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
References: <20240118104320.029537060@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

No relevant upstream kernel due to refactoring in 6.7

Builtin/initrd microcode will not be used the ucode loader is disabled.
But currently, save_microcode_in_initrd is always performed and it
accesses MSR_IA32_UCODE_REV even if dis_ucode_ldr is true, and in
particular even if X86_FEATURE_HYPERVISOR is set; the TDX module does not
implement the MSR and the result is a call trace at boot for TDX guests.

Mainline Linux fixed this as part of a more complex rework of microcode
caching that went into 6.7 (see in particular commits dd5e3e3ca6,
"x86/microcode/intel: Simplify early loading"; and a7939f0167203,
"x86/microcode/amd: Cache builtin/initrd microcode early").  Do the bare
minimum in stable kernels, setting initrd_gone just like mainline Linux
does in mark_initrd_gone().

Note that save_microcode_in_initrd() is not in the microcode application
path, which runs with paging disabled on 32-bit systems, so it can (and
has to) use dis_ucode_ldr instead of check_loader_disabled_ap().

Cc: stable@vger.kernel.org # v6.6+
Cc: x86@kernel.org # v6.6+
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -208,6 +208,11 @@ static int __init save_microcode_in_init
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int ret = -EINVAL;
 
+	if (dis_ucode_ldr) {
+		ret = 0;
+		goto out;
+	}
+
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		if (c->x86 >= 6)
@@ -221,6 +226,7 @@ static int __init save_microcode_in_init
 		break;
 	}
 
+out:
 	initrd_gone = true;
 
 	return ret;



