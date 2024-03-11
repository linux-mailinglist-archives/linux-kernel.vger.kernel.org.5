Return-Path: <linux-kernel+bounces-99378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D522878786
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC921C2122B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B95732E;
	Mon, 11 Mar 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU5+xj9a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9C54F92;
	Mon, 11 Mar 2024 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182202; cv=none; b=YwTd+zpC8z+G8dTERm66/Pjz63p1tGio84giokVYHI/AcGEgjgvHdSp4q9Q957ww4DXhuFDkA0slk10RUh0g79FO21gTb8tZraEpfGMfh0x8HAvk/bNdMusq0Bof6XTUs3rN2/uC9TEeYyzyRKFiCWYXOkJetOzueQIzJUI4WS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182202; c=relaxed/simple;
	bh=d3YjCGegKBiNlaqnlaRwjobA7R6W5+YKEQ2B++yBx3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lex22auwmzB3CI4+R8OnSjEnyKv/AQHDZrJCvbhJlB3Xfb3BOD85k5bd6QWPR4rzucY+4zIfnnVapXcVI/eOfhB9Vzj10al7MQX4QFpEGGoalWcAYsV6BPuT742BlzS1LV+iQP9JvY61+Et3XsKmOdCakYQ6FqItSdpvHCmo6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU5+xj9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135C2C433B1;
	Mon, 11 Mar 2024 18:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182202;
	bh=d3YjCGegKBiNlaqnlaRwjobA7R6W5+YKEQ2B++yBx3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DU5+xj9a0ciaoyGi6PbqdB/IvKkrzlGFksa8r1LshjvX3P+5OnwnYbxhmDYDd9IpI
	 pqnV82dYwPM+99jCLBsbo4fJ7OsKlExT6yUWc+t5kmhcGqWwzgYSYcKarAITgwE78h
	 9e10cotB/TpexgnzVLoo+SWUpRfKswDDVio6mx99JZl1A0Ziq8/R4n+Cs1ahN0c85P
	 HzIdJQ3HH7MN9Dv0STXcgh0f8l+UO1eI9oWW5vHCLDpTHFage1vaUyt7/KM3xx765T
	 JmMi6ZJVFYhg5JdDtWF1BrnIAHlTUf1ItME7HhjZaHPfprx2zxXyR4RaK2wqZ6AoIM
	 JFPtOA2y/fjnA==
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
Subject: [PATCH AUTOSEL 6.7 04/14] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Date: Mon, 11 Mar 2024 14:36:07 -0400
Message-ID: <20240311183618.327694-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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


