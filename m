Return-Path: <linux-kernel+bounces-115437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E841889B92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E242A2A4BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C921254E;
	Mon, 25 Mar 2024 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlEF2hYx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07CA1E0E5A;
	Sun, 24 Mar 2024 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320770; cv=none; b=shkPd7YjOI8P/lriutMRz4Av4NYvfyJZAnl8b1SFls5NqaKalqJ3hAmiS/HAEW1q/yOKtxpAypjG3amptdm5RBpV28+oFz9WefW0p9zS0ia3MsFl63I8pqGGIBNvq6oGXfvSe2wTIs8h0Fmy5qIRYxojuMOFRqYWQKemJBJ5O+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320770; c=relaxed/simple;
	bh=yoUldDTV2NJujGlAxoNcWJ40t+aa06GDaoJ4gRjf/do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUakI9hIiRQCtL4QFjBH7Wt7GmTHxysq1M/TscNmw5fpx8sq9EP+DcshtLnfE9ICx427AD7il2zT17zLoQ+P9rYcrw0teX6FMk8+1YzFFcNTTElr6p/7c7VyMUstr//uAuCBRVZAvotAs/EI32fkGwX1mU+JmLdjDZVbcYfK+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlEF2hYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CD7C43394;
	Sun, 24 Mar 2024 22:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320769;
	bh=yoUldDTV2NJujGlAxoNcWJ40t+aa06GDaoJ4gRjf/do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RlEF2hYxcq46dXVVG2Nw5TA9+RV6FC2RCh69ffbPRkBwePA401OrBa9Ig54iE2axk
	 MyK141eyClIgP0a2QaqySBVPOcN4UrUt8LCkDsNlxPlpex+2rGjJqSYA5a/JfA2q0+
	 9mtpwJlJSR+CDGLWs97TjBaWMxGTBuoiWY//xdjyVamgpmeOmd7jyBNNdPPlzpqGB+
	 8uFns0VT+7Iq7b35ICXR8JNGwEhD5Cw/2oDO6Rhn7Iy2kpCtq3JLwcJJwrGA5MpyjY
	 2jrGDdGz2k035nR+po2pat0uQnV9hsp9RpvIDCupCXWIfYPKlVfSiUsgovstj1L7vZ
	 0lNvuCjWDIwrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Gino Badouri <badouri.g@gmail.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 333/713] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Sun, 24 Mar 2024 18:40:59 -0400
Message-ID: <20240324224720.1345309-334-sashal@kernel.org>
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


