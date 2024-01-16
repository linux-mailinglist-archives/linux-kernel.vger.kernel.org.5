Return-Path: <linux-kernel+bounces-26837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1000482E6C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27641F23092
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8A21DA46;
	Tue, 16 Jan 2024 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+YZbVN8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6301DA3D;
	Tue, 16 Jan 2024 01:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCE5C433C7;
	Tue, 16 Jan 2024 01:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367156;
	bh=F6xSX1T32k1EJPxeHc6Sl9oNxcMOzIIN6E8rE6ra3E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+YZbVN85JUiZjVdCWD+4u4qC2guirZeaHOnbqh9x9i5rdelY6jN7qvmyrI5qdPxn
	 y6N98sBNd5OURtcZEG27jCyYw6OfOMY9D0gQ/A7NxByRa2aI0jclB/26AkkLx+st5p
	 vuqchyng9xdtL38vjrZnclAXssi5fEEH0E6mil5r6eUvzn4VKlU/+p0MAoviTOJvAJ
	 IZkDIN62yAYK8S1dYYxMfn6JCH8T2eJ2Ymr+Tkfs16wsnOaRhw5RGMWJMYQZuu0mMP
	 KN1MrVvRP8XP0BV9JhLl9CGrBfvd/XBNpobpbpV0tXVbZ5jrOAmzOQvYFm6R/xQ4f2
	 2BQHfTuXLJ3vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	ardb@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 07/19] arm64: Fix circular header dependency
Date: Mon, 15 Jan 2024 20:05:02 -0500
Message-ID: <20240116010532.218428-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010532.218428-1-sashal@kernel.org>
References: <20240116010532.218428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 9cc501450486..75e837753772 100644
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


