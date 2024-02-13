Return-Path: <linux-kernel+bounces-62667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9FA85242E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C600D1F23C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A46312C;
	Tue, 13 Feb 2024 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+255kJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4F63117;
	Tue, 13 Feb 2024 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783708; cv=none; b=pDoJAdIYD/k1xh2rAjLEECWdZnNxL/FU5YzOaxRiuZKCrCeCVFw94FrkWeS8F6gY1iWwBQBS+j7lQb1oIfO6HE5Zn2a5PN4QZAd6M6QNLIHXZiIK51rRNz8uZQ7oLzbaGog+OpOG7TplhVloC2U/GBCEQdNSZPX4SH4aGEorfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783708; c=relaxed/simple;
	bh=w1jwcGRF9vZAy4gnFzNIyEL76DACT7ggXyEpj6J6IwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nd5hUJldVWVW/Fdx4dXjSbGVzWTKIxe0wkaIOpcwPAloi8Pu8r64hlexkzKgyZxh85HiVg2lhdzYnMCjdE1WsUKR6YeJOMj50Dse7LKx7M48ajTBuuZ69V0CwAyUfDMjnukNFFcCTii2PPQx5Ta0ytRexocwnY/fqJM/vvHZIRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+255kJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65715C43399;
	Tue, 13 Feb 2024 00:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783708;
	bh=w1jwcGRF9vZAy4gnFzNIyEL76DACT7ggXyEpj6J6IwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+255kJYWRhDAHbVL6RseVSV2MjSybKMNwBMBEH77W53kxSIlroyi1Z3vymXQ9f7V
	 JxZDpgqErYpN5wRyAHShASLYG469YlwtYewCfd5PQtsf0kCVuh3zzgFIxtTIqpNQGu
	 cUhBhMri+5729tQ/U9GplMSX3coAfLzOM0+E5AawBKOXR7sBU8E00+NSbWF47vpn/1
	 CV99VqYY1DxTnGjvJ95t7W2P7r4y+H0poKc/dtHc/76Z/4fQrDZrOdUJOKmjzKajNP
	 40+J1gQFUNkP6BAiKCyEktuWPT7ooyOqd8MM5APSM9qDvL1p7/+73g2+7mUDJcOc4t
	 pH2rHPR5gc4rA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Fangrui Song <maskray@google.com>,
	loongarch@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	git@xen0n.name,
	guoren@kernel.org,
	rmk+kernel@armlinux.org.uk,
	chenfeiyang@loongson.cn,
	zhangqing@loongson.cn
Subject: [PATCH AUTOSEL 6.6 36/51] LoongArch: vDSO: Disable UBSAN instrumentation
Date: Mon, 12 Feb 2024 19:20:13 -0500
Message-ID: <20240213002052.670571-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit cca5efe77a6a2d02b3da4960f799fa233e460ab1 ]

The vDSO executes in userspace, so the kernel's UBSAN should not
instrument it. Solves these kind of build errors:

  loongarch64-linux-ld: arch/loongarch/vdso/vgettimeofday.o: in function `vdso_shift_ns':
  lib/vdso/gettimeofday.c:23:(.text+0x3f8): undefined reference to `__ubsan_handle_shift_out_of_bounds'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401310530.lZHCj1Zl-lkp@intel.com/
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Fangrui Song <maskray@google.com>
Cc: loongarch@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 5c97d1463328..4305d99b3313 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -2,6 +2,7 @@
 # Objects to go into the VDSO.
 
 KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
 # Include the generic Makefile to check the built vdso.
-- 
2.43.0


