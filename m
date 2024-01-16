Return-Path: <linux-kernel+bounces-26817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1B382E684
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55927287C11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605F9134DA;
	Tue, 16 Jan 2024 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsnxLcBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8089134CC;
	Tue, 16 Jan 2024 01:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0058BC433C7;
	Tue, 16 Jan 2024 01:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367092;
	bh=DXgIWm1bgazqnDNb1QVVSQlUq3TFQjUEod9kNlqTCeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsnxLcBYJ05qq/Bc3XhhfBh2imthuq0OPT4Tig9rcfe//5YbvMKQLHhttTNEAWLpD
	 JdpJLOZcqt2EGF/LPqMEhZkDjjibnShp9kqLMZSylr+OlqYFsaoFUstLeeypUFNcJW
	 Xhp5yHW1q0xQkXu9GUc3rwgmDQVEKPDNIi4xHYm0+jTowkJSB9NGTlqzbzExBxP2UK
	 JT4ay1BwSIz1OqfsgPjcB+LNX5qfonZ0EeBXzIUuDgVhXD1TBzXtBZnNN6pzLG8ofW
	 d5W/Jar5hme+BP4xQuoEnf9+BcSvNe+N6+mF3h9LH82LZck9lH8+NCv/KmyQX2VFn0
	 J4d6eKxK3FRJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	ardb@kernel.org,
	mark.rutland@arm.com,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 08/21] arm64: Fix circular header dependency
Date: Mon, 15 Jan 2024 20:03:45 -0500
Message-ID: <20240116010422.217925-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010422.217925-1-sashal@kernel.org>
References: <20240116010422.217925-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Kent Overstreet <kent.overstreet@linux.dev>

[ Upstream commit 04bc786d663543512d08f1b86c7bcefb5144afe3 ]

Replace linux/percpu.h include with asm/percpu.h to avoid circular
dependency.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/spectre.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 06c357d83b13..0c4d9045c31f 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -13,8 +13,8 @@
 #define __BP_HARDEN_HYP_VECS_SZ	((BP_HARDEN_EL2_SLOTS - 1) * SZ_2K)
 
 #ifndef __ASSEMBLY__
-
-#include <linux/percpu.h>
+#include <linux/smp.h>
+#include <asm/percpu.h>
 
 #include <asm/cpufeature.h>
 #include <asm/virt.h>
-- 
2.43.0


