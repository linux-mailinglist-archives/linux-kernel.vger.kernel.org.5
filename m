Return-Path: <linux-kernel+bounces-114220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F21E88892A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2283B24E16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79416A1C1;
	Sun, 24 Mar 2024 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYl0NBsx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0518F2092FF;
	Sun, 24 Mar 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321561; cv=none; b=PnKDEmZSaMkWv8Y0q31G0+3SJdgGlY3XI+UXFRi90GoJuli55gc3JTNvSJKa3Twuse9DhgAJUm2xfrAZpRGCgysi82BYukU8XRn0qnvZKw4G5faS1NUIUse0N6Z33K0/T2Ykt8kyAqIh9e/3q5eAZ+ynZe6HSZG2FHDej8aQfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321561; c=relaxed/simple;
	bh=yoUldDTV2NJujGlAxoNcWJ40t+aa06GDaoJ4gRjf/do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTfTQBfvlG6eL8MZMPY87IqI+Y97rEkZSOQ2uO0zX06OdbkXyvpmuvOCS14R9kwXDXNzjCfWBmVgDJcp6jIhZ0USqaGkI14YvfhB5KRtd0eVt32Z7YInkueAD6BiQtezEXB2oNrsPlFtapxiJeWr5D64nvTkHSNIYNvvsMHzCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYl0NBsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2019C433F1;
	Sun, 24 Mar 2024 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321559;
	bh=yoUldDTV2NJujGlAxoNcWJ40t+aa06GDaoJ4gRjf/do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYl0NBsxAyoyww8j2/A5E8h955apwZkACoVDrwEHe4B5bKYPtA+u2mKJRBlSPDhsb
	 RS91ADAHl8xXC9VNL9S34u8EQpjtoQuoRIIyxkpW+OIEzPsNCeka2Otejjjs4LF4QW
	 n07wcE2kQWhA2RglT+uGCr6EYOqDf8ywPEcOVR7pT/J7tLrApDicVdgh2pnKheaqYU
	 EkJTOucYpgxi+RLy4F+V/zwv0NWD37vncK4Vo3AU0M6h2RTOSHNJn2QqD9lT46+r4i
	 kXyns2gfPe+6pNY/sYagcuZlPl14Qw1e5V8lTNVf2BOgXa83Yfwic7GVxstERIFVIp
	 kQb5PL6cSoZKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Gino Badouri <badouri.g@gmail.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 288/638] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Sun, 24 Mar 2024 18:55:25 -0400
Message-ID: <20240324230116.1348576-289-sashal@kernel.org>
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

From: Perry Yuan <perry.yuan@amd.com>

[ Upstream commit a51ab63b297ce9e26e3ffb9be896018a42d5f32f ]

As there are some AMD processors which only support CPPC V2 firmware and
BIOS implementation, the amd_pstate driver will be failed to load when
system booting with below kernel warning message:

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

To make the amd_pstate driver can be loaded on those TR40 processors, it
needs to match x86_model from 0x30 to 0x7F for family 17H.
With the change, the system can load amd_pstate driver as expected.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reported-by: Gino Badouri <badouri.g@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218171
Fixes: fbd74d1689 ("ACPI: CPPC: Fix enabling CPPC on AMD systems with shared memory")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/acpi/cppc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 8d8752b44f113..ff8f25faca3dd 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -20,7 +20,7 @@ bool cpc_supported_by_cpu(void)
 		    (boot_cpu_data.x86_model >= 0x20 && boot_cpu_data.x86_model <= 0x2f)))
 			return true;
 		else if (boot_cpu_data.x86 == 0x17 &&
-			 boot_cpu_data.x86_model >= 0x70 && boot_cpu_data.x86_model <= 0x7f)
+			 boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x7f)
 			return true;
 		return boot_cpu_has(X86_FEATURE_CPPC);
 	}
-- 
2.43.0


