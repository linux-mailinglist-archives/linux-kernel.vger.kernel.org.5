Return-Path: <linux-kernel+bounces-145060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1E8A4EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C38F1F22690
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70571723;
	Mon, 15 Apr 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQpdE6Gu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7670CAD;
	Mon, 15 Apr 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183659; cv=none; b=Q+N9J3nwy4fJ/sokrJU4GpcSeZtHylc2dYmPDu20/WsFHFOhgOG21bn5uilHUcI/fx/mET17IChxzpKYBDYKt92aXYciD0Wwp0GpUjwVw4bYEIWqGG7pwfN+B9WWX6a664zfIT+2VCxKS2PmvPAEeLIPpuHvIZelU5nAzfA5VOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183659; c=relaxed/simple;
	bh=rFheM71yjeyhsdNNlmFP4+aGuyKqpUtHIcDrzZ28OAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4ADMjHrM/gI0pNg7MOJdGlmaBMx18CBY0mRUonpuL0uIw89PhkI+v1sDjhB4xvqGQ+mV82Wr7sfCS+22HWVd9H2zdr4+7T1UTXD4z824UkMCrDiXk0x6voM+ZpGJJZDJ8fRXEncZabZvRJB+umV1P3ER2XEEo301f3fX4AsJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQpdE6Gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A4FC4AF07;
	Mon, 15 Apr 2024 12:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183659;
	bh=rFheM71yjeyhsdNNlmFP4+aGuyKqpUtHIcDrzZ28OAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQpdE6GuxbEQNfuOyFt+EkGaz36CTj5VFlsD3OgUJGhuFsy9ntPntCbL7Gte3FBcY
	 1kc8TnF7C28DHfBAPorUAdaOyRfq1pPxA5KrV59hyC/aMWMVSiIQRTf6mzdI2HIOIq
	 oIci99l9WdfM/aSfPq+iF+58mVD1nEoKEyOFk+F1bX1rKCBzUuq7caFE5RGr0qkxwn
	 JtKr7+oTM/eODyORqhiBBMkti4HoLHteI+MT6kjf5Lnm6xdW+LxaZ96BHzHQs5PdbC
	 grhTAqAjwaJa31mr13JqPu1+HClA74HitSBcQJN5vC+7FpB68Kj8Ty2KyCfQUJJ9be
	 X4n2O1ZkQ92sQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Kees Cook <keescook@chromium.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] [v3] kbuild: enable -Wstringop-truncation globally
Date: Mon, 15 Apr 2024 14:20:37 +0200
Message-Id: <20240415122037.1983124-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415122037.1983124-1-arnd@kernel.org>
References: <20240415122037.1983124-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The remaining warnings of this type have been addressed, so it can
now be enabled by default, rather than only for W=1.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: no changes
v2: no changes
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 1d13cecc7cc7..17c511ddf48a 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -108,7 +108,6 @@ else
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow-non-kprintf)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation-non-kprintf)
 endif
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 KBUILD_CFLAGS += -Wno-override-init # alias for -Wno-initializer-overrides in clang
 
-- 
2.39.2


