Return-Path: <linux-kernel+bounces-26856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE282E6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2DD1F2372E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B824215;
	Tue, 16 Jan 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM7bJ4v+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97772420C;
	Tue, 16 Jan 2024 01:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366C6C433F1;
	Tue, 16 Jan 2024 01:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367217;
	bh=G7KKNtunMq/+ZIMrUvnMm3p3/u15EMWrNrCPsESRQko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aM7bJ4v+JqjihoQO5il4xbqkT1+nJjR1bi4rSqpuwysTHuOoigIFG+J8NNEvKwues
	 Fe65PSZU/IxDnm5SCtRttVn5C/aE0o0twXEivhTY2QVr5FbhhkUmXLVbeH+FNT8qEg
	 /sDFmDigwjOcGw60M8f0oBuXSAkpo6OwvJKC7kTtHi/QjEFSDokN9lcXcRNvKEulOb
	 uE9wc8cSZgELSkLfjl7SE1rf4CSXtkRTzoxxGb8KKIXHLcrx4wthcpFsxkc1RGd9Nc
	 xWSAIkp2BddzU8KS72bOEV5ZkBQVjt3j7zG9As0Jg7m6yUfXG6taZAPyLxUqikhb+/
	 +5AyTMkHdW1Yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 06/14] arm64: Fix circular header dependency
Date: Mon, 15 Jan 2024 20:06:08 -0500
Message-ID: <20240116010642.218876-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010642.218876-1-sashal@kernel.org>
References: <20240116010642.218876-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index aa3d3607d5c8..f7a204a9352c 100644
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


