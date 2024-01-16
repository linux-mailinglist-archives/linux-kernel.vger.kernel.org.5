Return-Path: <linux-kernel+bounces-26869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5602C82E727
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E2EB209D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4942A1D7;
	Tue, 16 Jan 2024 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGKVq+BS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71928E38;
	Tue, 16 Jan 2024 01:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8A2C433C7;
	Tue, 16 Jan 2024 01:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367262;
	bh=gbvGgTDEjv3h6cJ8jC0L0xUeG38FiPqcSYJiJolFY4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGKVq+BSDlgNvj0wmsm9KTpYgPlE4YeL1oOmz74RIklxyMzwjsubXyOv6V1Zsg+lF
	 jLfiYGBBwJleF2Xnne7y/9u1eR0aa6EnUyNW/G1kFzoC4TVY97MI9WDMToPrJdk1gr
	 euvCtMvh49QpcLjsmi8WxKv0rJQ4SP4+siMLLbLAT0BuXbZ5EL0EirtHAskUppnHE3
	 sL+Sw0PqR3QuFM+w6METfhvYJLe5ZsmgVQP+HJ8RwzAxVEsifAiaIv9gvCTq9tRGSA
	 26cCDybFS/x/IOG3VKGHcX2iou6cD2+UEm89rdhrXjEPdOEZhIx2+i1jdhGmvxJju5
	 DAoHmv0B9T84w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	keescook@chromium.org,
	arnd@arndb.de,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 05/11] arm64: Fix circular header dependency
Date: Mon, 15 Jan 2024 20:07:05 -0500
Message-ID: <20240116010729.219219-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010729.219219-1-sashal@kernel.org>
References: <20240116010729.219219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index db7b371b367c..31823d9715ab 100644
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


