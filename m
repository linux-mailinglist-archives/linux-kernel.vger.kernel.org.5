Return-Path: <linux-kernel+bounces-50389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD20847859
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9468292417
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DE1138481;
	Fri,  2 Feb 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnA7PRVu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE141369AB;
	Fri,  2 Feb 2024 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899251; cv=none; b=Rufmcgj05S8c/K7PFRszTu4m1IuBVDE6Ifu2pImStPVwx78nMZFkq+W2ltAiCTj2EwapGcdfFqM97DogkaxJfbR+1fLvVG5mI4AXHal0CGt3A1gkTEUXO4P57HcEMw/Z5DNguLscFsMUt8KGuOhRakaIo1Wt/dVvNkAXx6RHO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899251; c=relaxed/simple;
	bh=YBoPwJM6qtI/5Knk07kvYlOrcnQuA9SJRJCav45K3Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJSXRYe77DCWgPrmgVN39dHrSlRAfZULU0ARKpOCzvnAQT+/TbD7yeOTvdlTXDR+drAZ94xfkUWunvTQx4WnEhtLd3FEKEVzMvL0AF1Vfvu282es4gpWHsmtax4aApyKFnT/LAU5T2XsNl5kzXWYPoZAGZ5Z5v+RCLDnlDOWz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnA7PRVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60786C433F1;
	Fri,  2 Feb 2024 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899250;
	bh=YBoPwJM6qtI/5Knk07kvYlOrcnQuA9SJRJCav45K3Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnA7PRVuc4gVfJricn9huwZtPMEDhDKAafRaY+y9XYwSXMzNQnizzl9SGy4zcrt6q
	 kOnNN/qS7U9x6+txiovUcWXAOdzu6zEXC67zhc0Z39rr82mQqDOV8ds6DiNKjLzTyX
	 6C+XdGAYnjBYnuB0OuoFtlCWH8h6bAwAUA1bwuzE3XhcsxUxEegdtJsxpWw2bXgP41
	 en+Iudi4OTNOfML8Zm75OEj2QF4MloyH/J3xqotfr/r8QLbrzh165n79aLmMlOir/z
	 I+bN/oC/MM7HGvk0LecG3EzAvh88O+x/SBMlPlVe4UespZ5sJer+qj8GRYVr5BGKcp
	 XciVAWwQDQWJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huang Pei <huangpei@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	rdunlap@infradead.org,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	jiaxun.yang@flygoat.com,
	bhelgaas@google.com,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/21] MIPS: reserve exception vector space ONLY ONCE
Date: Fri,  2 Feb 2024 13:40:07 -0500
Message-ID: <20240202184015.540966-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
Content-Transfer-Encoding: 8bit

From: Huang Pei <huangpei@loongson.cn>

[ Upstream commit abcabb9e30a1f9a69c76776f8abffc31c377b542 ]

"cpu_probe" is called both by BP and APs, but reserving exception vector
(like 0x0-0x1000) called by "cpu_probe" need once and calling on APs is
too late since memblock is unavailable at that time.

So, reserve exception vector ONLY by BP.

Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Huang Pei <huangpei@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/traps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 246c6a6b0261..5b778995d448 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2007,7 +2007,13 @@ unsigned long vi_handlers[64];
 
 void reserve_exception_space(phys_addr_t addr, unsigned long size)
 {
-	memblock_reserve(addr, size);
+	/*
+	 * reserve exception space on CPUs other than CPU0
+	 * is too late, since memblock is unavailable when APs
+	 * up
+	 */
+	if (smp_processor_id() == 0)
+		memblock_reserve(addr, size);
 }
 
 void __init *set_except_vector(int n, void *addr)
-- 
2.43.0


