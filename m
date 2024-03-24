Return-Path: <linux-kernel+bounces-115294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E713889A86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70151F33EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E346C1D4C40;
	Mon, 25 Mar 2024 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a63LtQ44"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007A80055;
	Sun, 24 Mar 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320511; cv=none; b=Mlkfun4GE42+PGB/7Ao2BaZyZMcaEqm1Ec/lb3bkei66KEAMUnM0bJlZqJX+l6eWmDo1GoO16wFg14aPITWjf+/90+Zd06mISmdlHSNSY09yQoVLcVgByvBTECl1Knsg/bmTNWvFt48MWkGoPqc8LcUXHCB6zwIkOyb9l8e4l7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320511; c=relaxed/simple;
	bh=d3YjCGegKBiNlaqnlaRwjobA7R6W5+YKEQ2B++yBx3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFfk2MsR2R0AGSrPV9ppBhde5cdAvvq44W4+jGoXn7T4Ho0+f0WHlI9l+uUWRwzGwSJDD9ukZotR91XOeoT/MBUhI3UnVn26SDT16+n8pFwxUY7ACkT6Z2bfdTPfhEstQ0xn4epOj2ho+rRoWYhQJK1zdRHN5ROZlaCDMhLyC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a63LtQ44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A1BC433C7;
	Sun, 24 Mar 2024 22:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320511;
	bh=d3YjCGegKBiNlaqnlaRwjobA7R6W5+YKEQ2B++yBx3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a63LtQ44XNG1WBdCJadl0NmlZG0y9zcmAlUtVbAly1Ba4VOpN5S3CqpDGRaZdOnuV
	 DMWNcrGh9gLYL79v2ft54s22xynCF8zAIE10JjHUBczIrFUUYmuUYngGDhHWL+MMKH
	 zUZtv4eAxpf/mgP9jtPP7J1w2hkFHVUJfuOLRVnK2LR8Tok+/s4GO1keMCIhYMuiZu
	 T2PkwIYF90cmGMuZMMSgXQFw7AsaTZZxXXUSrIAfaObcbgMBdpz72iCG/nFK+sc37j
	 wF/UzsUXxKwQVoXg5znBQ5Ig2XQK+yg7D+oCCaiCFrEhH1OTRYZXfcMsBi3X/pyjdW
	 +ULDwC2idf/xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 071/713] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Date: Sun, 24 Mar 2024 18:36:37 -0400
Message-ID: <20240324224720.1345309-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 96e6c51515f50..cf1b78cb2d043 100644
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


