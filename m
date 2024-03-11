Return-Path: <linux-kernel+bounces-99392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B548787BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC4287E69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376E5E086;
	Mon, 11 Mar 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwn8o7mM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234345E06B;
	Mon, 11 Mar 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182275; cv=none; b=hsFTIq2VApnv7M21VRH7OMbYw1/0DIhZjOcRQeG7VIBSfODL1c4aZ/IjDbLQjcmXB409bZSy6ijch6upaT8/3gNJ0sbJPo6KFStKnM6RggYwt6nGp4+RnrkNbUzhJA34qmthQnB3ofsW+fbuBnWjdiS8SX3klYRaxaibOJJifuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182275; c=relaxed/simple;
	bh=nhPGpmoDAeeDi2S+ayEK3AhjJxr2UCqdWzDa0/q9ix0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhLhSGqkdDDmamAaXS2eXfls6aow7+xihmQOKfRsl1LmxRpgy0g4XbX/NIr5VZhwiBPqfObbd3GY6Zl//d6iRjDWK2ZuHwfhjA3qv5vZIK3ViW4Iru2bsC0f3DJdAdUuymu1wLnOLiPHyGWtIocuYKFmzTV6hTuGvwbeFeNX3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwn8o7mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47E6C43390;
	Mon, 11 Mar 2024 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182274;
	bh=nhPGpmoDAeeDi2S+ayEK3AhjJxr2UCqdWzDa0/q9ix0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwn8o7mMr1coQuyvFAJlisdB57w3UBRdCj0Wb9HYyTXa8GhKYchalopMLeRSzjInk
	 Iwj3TfZDtwvofh/m+t5Aja2WJFQTprStYmSyzXlyu7drs0ylse8B2YJOPhueg1Bktx
	 rzgshlKQk1qt+aBUjswLMivlxeUNyB2EdbFDrFYDn4TCRGS15Y4mkvduZ/bup8fq6b
	 2pbfVSgUBestSx/SStZt4JA6lC105QU0NCaMPVVrv9CbnnjjGCGSsWwj2Nubu/9jiG
	 dx0Xw8nY+U7ig+CBPMxIwfI4K0r7PJqukIs5HsG+uCmnUfvGzjZCg7eewhYy+o7/fb
	 2QuFjX0sR6zWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	sthemmin@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	devel@linuxdriverproject.org
Subject: [PATCH AUTOSEL 6.6 04/12] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Date: Mon, 11 Mar 2024 14:37:18 -0400
Message-ID: <20240311183727.328187-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183727.328187-1-sashal@kernel.org>
References: <20240311183727.328187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit 0d63e4c0ebc2b5c329babde44fd61d3f08db814d ]

The current method for signaling the compatibility of a Hyper-V host
with MSIs featuring 15-bit APIC IDs relies on a synthetic cpuid leaf.
However, for higher VTLs, this leaf is not reported, due to the absence
of an IO-APIC.

As an alternative, assume that when running at a high VTL, the host
supports 15-bit APIC IDs. This assumption is safe, as Hyper-V does not
employ any architectural MSIs at higher VTLs

This unblocks startup of VTL2 environments with more than 256 CPUs.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1705341460-18394-1-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1705341460-18394-1-git-send-email-ssengar@linux.microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_vtl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 999f5ac82fe90..53b309d41b3b9 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -16,6 +16,11 @@
 extern struct boot_params boot_params;
 static struct real_mode_header hv_vtl_real_mode_header;
 
+static bool __init hv_vtl_msi_ext_dest_id(void)
+{
+	return true;
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
@@ -38,6 +43,8 @@ void __init hv_vtl_init_platform(void)
 	x86_platform.legacy.warm_reset = 0;
 	x86_platform.legacy.reserve_bios_regions = 0;
 	x86_platform.legacy.devices.pnpbios = 0;
+
+	x86_init.hyper.msi_ext_dest_id = hv_vtl_msi_ext_dest_id;
 }
 
 static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
-- 
2.43.0


