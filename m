Return-Path: <linux-kernel+bounces-113176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC1A888210
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07F2B2458D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67895130A6A;
	Sun, 24 Mar 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOyzzzjT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE93130A4D;
	Sun, 24 Mar 2024 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319978; cv=none; b=pcdGlJW0ZXo54l5tuWCojNy8vX2A78BnkT1IzzbaAVHOAAyW7Pzy8HWhz5fbl87mX7yI5pOvSxgp5DQBvIhagqpDE/FoS6pIWYC6ulYwiX8vjKUx1ZEHycyLpX3ScJOSRti6PC2xKiHm889PeFkB010G15LQrYPHoNn6R2J8V44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319978; c=relaxed/simple;
	bh=yoUldDTV2NJujGlAxoNcWJ40t+aa06GDaoJ4gRjf/do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn2yFHywUrPWE8zOWxSDkaay3BrNKUD+yqREuRiOTGbez0lHG20qKE7rkNJNaScqeBqfI7G40jRM9hLmswr/UP5kYK/YlQ6R/XX1mIMMACml7gyCXJUSBsCpSVBgBp15O8Vm8CjORvkcB9AcT074p3au50ve6BdWJitgD1xhdTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOyzzzjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BD4C43601;
	Sun, 24 Mar 2024 22:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319978;
	bh=yoUldDTV2NJujGlAxoNcWJ40t+aa06GDaoJ4gRjf/do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOyzzzjTfRlOT/Mfb3OlEfbJcRpv1IdiXE3oA9tJih63muFH2RVgqZGvoab5gAEBr
	 ym7zNi798T9m3hLpyE+zyuycrp+SkWYJFJWxJrgHc5UlIVJrQDVsjA2QEdFLkVm28G
	 K6afLnAFhzclCc0tQZSQs91/9xbWXs4a6YRTR0iT9bWV4U8A39x6AMn///BdfcgBYE
	 YV1COK0iUJLfLxGkY7bIUIlWsUTwekzrIX+jbWnK+HtW5ifiA4cF1oNyV3HFsze5cf
	 +hnJEuhfQZjkFuAFqefZjohmaCSL8fXUCY1fmkiiEF/ndK+GoSIKsyNEitaC1NXX9+
	 pNNxj7jEb4GJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Gino Badouri <badouri.g@gmail.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 285/715] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Sun, 24 Mar 2024 18:27:44 -0400
Message-ID: <20240324223455.1342824-286-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


