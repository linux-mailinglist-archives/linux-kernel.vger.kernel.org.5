Return-Path: <linux-kernel+bounces-146777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77AA8A6ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CE71C208EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931F12AAC5;
	Tue, 16 Apr 2024 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1GAN6hM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0612D1EF;
	Tue, 16 Apr 2024 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269960; cv=none; b=aEDdX51Ls8VT46n1Qw3ZOq1B3JF63oUG/O1LlFjTFMo9zYZxPrkI5xYtQGVIIxKD9UoZZ1JMk1XVmPIFMN1OCrH6XdGQ1z5lWMQhZQwfDZUIEKj/NidE63+aTz/USdaLYmkQ9oC9pFW7/EcbFvG+rG9f2Uxnjk032Em6G5tGzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269960; c=relaxed/simple;
	bh=MrxCcrNkQQraaKDvGJ3l7Z0HfhQ1ri7vp/0R8pBVwGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEKQjaepLAwoXLuZ8yDQ3mfrhHFoYl3sKA9ZIg9S7alrmlJ9hri02qqEO1qDziav08M7uwQX35W/ThDicdjxK4xIJEMQmxgeVFgjXLvn+T/co4bK7dpsY4ikWbJ0GApBng1JnLQjHXAabioGJnBlU5G+YjQa1AVzOe9xcJIMn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1GAN6hM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFA4C113CE;
	Tue, 16 Apr 2024 12:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269959;
	bh=MrxCcrNkQQraaKDvGJ3l7Z0HfhQ1ri7vp/0R8pBVwGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1GAN6hMu5jV6MoUkKJ+TwwKMWFsbyOHH77Qv1CAR0n3xQArLzeN/sAnYQNaqYhs/
	 YXkgyVIl2or2DcVGZjEVoLuFlUgzSR+zFJldTdHO6wGaDA2uOeCOCV1FexH0MA+Kyk
	 QPzPxVyi3ZX7gzkfNJWTpFN/qlmkMEoajrgV21Hhf7xZepHZdv+K7C2MK6pb3o+ihZ
	 EkFyQkDC8YtQI7xZ2PdgY4VxnVO3moem3Al8GUZoao4Ulp0mhyC0AyD9QaeHmhqkBf
	 Bpp0ePawCXIS8/cLnGg9fWZ1sIdQ4wG5kIwmu81KhX/tsDBmONexZpw/g5hZUDs5k0
	 T1mq8D2f+6jMw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/4] Makefile: remove some unnecessary header include paths
Date: Tue, 16 Apr 2024 21:18:36 +0900
Message-Id: <20240416121838.95427-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416121838.95427-1-masahiroy@kernel.org>
References: <20240416121838.95427-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include directive with the double-quote form, #include "...",
first searches for the specified header in the directory containing
the source file.

If all local headers are included using the double-quote form instead
of the angle bracket form, there is no need to add the local directory
to the header search path.

drivers/gpu/drm/imagination and drivers/net/ethernet/aquantia/atlantic
use only the double-quote form for including the local headers, and
there are no generated sources or headers in their directories. Hence,
the local header search path is unneeded.

The same applies to arch/loongarch/kvm/ because TRACE_INCLUDE_PATH is
relative to include/trace/.

I guess there exist more Makefiles with unnecessary header inclusion
paths (and more cases where it is possible to delete the header search
path by replacing #include <...> with #include "..."), but I do not have
an easy way to detect it.

These are unneeded inclusion paths that I happened to find.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/loongarch/kvm/Makefile                     | 2 --
 drivers/gpu/drm/imagination/Makefile            | 2 --
 drivers/net/ethernet/aquantia/atlantic/Makefile | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
index 244467d7792a..7a0108a721c1 100644
--- a/arch/loongarch/kvm/Makefile
+++ b/arch/loongarch/kvm/Makefile
@@ -3,8 +3,6 @@
 # Makefile for LoongArch KVM support
 #
 
-ccflags-y += -I $(srctree)/$(src)
-
 include $(srctree)/virt/kvm/Makefile.kvm
 
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/drivers/gpu/drm/imagination/Makefile b/drivers/gpu/drm/imagination/Makefile
index ec6db8e9b403..3d9d4d40fb80 100644
--- a/drivers/gpu/drm/imagination/Makefile
+++ b/drivers/gpu/drm/imagination/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only OR MIT
 # Copyright (c) 2023 Imagination Technologies Ltd.
 
-subdir-ccflags-y := -I$(srctree)/$(src)
-
 powervr-y := \
 	pvr_ccb.o \
 	pvr_cccb.o \
diff --git a/drivers/net/ethernet/aquantia/atlantic/Makefile b/drivers/net/ethernet/aquantia/atlantic/Makefile
index 8ebcc68e807f..268a055086c4 100644
--- a/drivers/net/ethernet/aquantia/atlantic/Makefile
+++ b/drivers/net/ethernet/aquantia/atlantic/Makefile
@@ -8,8 +8,6 @@
 
 obj-$(CONFIG_AQTION) += atlantic.o
 
-ccflags-y += -I$(srctree)/$(src)
-
 atlantic-objs := aq_main.o \
 	aq_nic.o \
 	aq_pci_func.o \
-- 
2.40.1


