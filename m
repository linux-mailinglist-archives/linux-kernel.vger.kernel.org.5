Return-Path: <linux-kernel+bounces-114055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF22888822
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BA51F26A56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C29F2310CA;
	Sun, 24 Mar 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knkLqnCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19731FDB33;
	Sun, 24 Mar 2024 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321336; cv=none; b=VUjnYmie0vTUL1qVvnb2XD3x7vnm7DhMKK2p12nGwx/e0uPNfawwRhgw7pXD6P1EMlvem98xrOQHjDrq69qVfelmvelx3yKIG+9Or+XdzqUe1+KR54TV6hQQ+iQcM63CrC8G2wKuHg2e+VKnuo5egX5BHyVvb6iJKqZoKPbZ3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321336; c=relaxed/simple;
	bh=nhPGpmoDAeeDi2S+ayEK3AhjJxr2UCqdWzDa0/q9ix0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgOplHpLI5nYTMTvEkI0QcdNi+QHxhH6OFnocO6MtCPMVsWH8ffl5WWoo7LeU+lExFLHUeNPwuvnUfo+K4rzsdUqrM3dqu12aRve9BE/qBq3daZ5vl9qy7f8LbXZTQ6kaQDBtDkp+uLagXgEjbOTdrd5akiWViWsNyfMfxqtwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knkLqnCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84B4C433C7;
	Sun, 24 Mar 2024 23:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321335;
	bh=nhPGpmoDAeeDi2S+ayEK3AhjJxr2UCqdWzDa0/q9ix0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knkLqnCrXSfUG1OM7iHBgTcGcyrSLIgyXhy9lYqyKF2dJ8Ef24WhkcJYvodvsId+m
	 fqQvjRtbU3MRyHZXm7036IK5AXKZbG6hCgZfEFwfh6mlju4b2MJmWbA+6a5moN12Pl
	 wmJRGfD1RItPNWEC3WA4JvWsZ6CK9emchC9HgfQCjpFr9H6XxDQCri/ybbQW0LVvfi
	 RPwoT/zJ7W2AK1mjO56HRI4z2AnY9p/514vMR0IHYn5KuOj4BlQQd9aVGMZISbJ5Jl
	 2IllQ4YEbLQbMOyKP1H+HGJHkPrssWyNGXhBfgClnVz0eEt/SSrkUaxHIRGlHJjeG5
	 e+D8S9+2LY9JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 059/638] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Date: Sun, 24 Mar 2024 18:51:36 -0400
Message-ID: <20240324230116.1348576-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


