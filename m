Return-Path: <linux-kernel+bounces-115919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF848894D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C694C1F2EE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE0C148FE1;
	Mon, 25 Mar 2024 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiqloPFl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFD1487EF;
	Sun, 24 Mar 2024 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322114; cv=none; b=NU33hgBdbE+WTn/4MPwwbXpyRTwfAs9mRfGJyGQd2RjKuf2rOSQJAC59C350CD5CC5OS7RU8H/NAE9rJ3dorrWlf/mVA9vb9KjJKg0NVY5r5CO0F5QON2+mpjJWP+lzFXlo0F5AcNFpgW6hd3NjnEwEiO6IBIqCr5t54xDdQAEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322114; c=relaxed/simple;
	bh=yoUldDTV2NJujGlAxoNcWJ40t+aa06GDaoJ4gRjf/do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L20il62SPZSBhuYzSEiNp63900xqV3kZHVghAFH1T9rqxaPRB9UIvcU43JivLuXEWGo8/D1c+09akLWrCN4CxCgUxVtRcymOgo4vwGdwmq5Was+N/inkLyMXSyixb6Ld5qHtS26geoHdy+zG+4DKA2wO88Ll5BOGrIWUzh1Yphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiqloPFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DBDC43399;
	Sun, 24 Mar 2024 23:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322113;
	bh=yoUldDTV2NJujGlAxoNcWJ40t+aa06GDaoJ4gRjf/do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FiqloPFljlNqUd6Au4Tn5P/+vrWHtmPON867c+uTQTHyU5RuvPKdzF6QGO2X2bjh8
	 prctoDkrVjuIMLAtgIr7fhHf9b1vq7IrxB83b1hfXph5FufBrZ3q0evDijZJoTI12K
	 1q4HRJ9Ns4EfWS+5mNku7fazBz+sx6KGYjNV/NQCIlYmJbYP4YwRcgH8fhGF4GccmW
	 vY1D3rM/DDjjv0+Y3zNlg/GoUQul/N+9Zdht9QOJ0r/z2qM5UP24jMhY6iqat5oDEa
	 47u/CuVV+shqG7/lUIGEloTzlY1Fgj1azsWng/KqIrxg4PrNvd+liyXtqvK1th5sta
	 F6yu1QpWiDHhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Gino Badouri <badouri.g@gmail.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 188/451] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Sun, 24 Mar 2024 19:07:44 -0400
Message-ID: <20240324231207.1351418-189-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


