Return-Path: <linux-kernel+bounces-123084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FBA8901E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A31C2CF32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D065131E32;
	Thu, 28 Mar 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d48G4MJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431781272CA;
	Thu, 28 Mar 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636344; cv=none; b=dWJDCxqi79oCTy96xHRbXOCmfB7f4J0Oghut52JeFYkzaNzjXJ+Aw41A7uJLny1kPb6s1SdSi+S1VYKcoMIod1Y0YD18owHLzS81BeYKXM2S6+XXxo2rTA+ShGnSsQUoUju8PHp9nEVvxCUIrGJ0NVD1asI+zyccenfaZbSsH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636344; c=relaxed/simple;
	bh=FdkOG4zdDjfUSDCk/3pUequwdZ6ldgpgrBgA4ee4qCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdopvFx1ewITM12SM3O1tiSUG0oLTHfEJoP2e3LSFSVDdkRGWs/oHNWne8t7ZusdyvaKYIgWcYanX5bqO/bgfynkOOm+A5o/VHc5crQVkzXShQEJIbP2e4wdZrZS1kdCKT2A22W6+yhGJGE2xVDpMgu2HAGtfdXDCTbSMt9OW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d48G4MJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BC2C43390;
	Thu, 28 Mar 2024 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636344;
	bh=FdkOG4zdDjfUSDCk/3pUequwdZ6ldgpgrBgA4ee4qCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d48G4MJ2rq1yUfCDNrKx49TagncZz3YBLM9fG5XHBkUnIOTb4XC7MeAMzcsqvkwrO
	 1xlQPYCbLww38b5697nr/jq4Hl1vsgecl1mf8B5psa64ZyNJtRhVDf7OGcbtMmn+k9
	 YgN9X3T98oGYTrQcbz8CKlkJyb+KojNTTexy0bt4PONp0AtvskeOFtzaS3mqGBvTX/
	 m3B1XPzXlSSveOt3PPUHLK0KF+VsBRWjMETAGYkAc4fObGkvAI+J3r2Yk8ASFakNK/
	 2YWagsHEplLZWUgrHCNzyhvam4YWuCAS7nvdC62b+7bib/ot1IgCmNRpJ20KE39ulv
	 ESPzdIf6v1OlQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 9/9] kbuild: enable tautological-constant-out-of-range-compare
Date: Thu, 28 Mar 2024 15:30:47 +0100
Message-Id: <20240328143051.1069575-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All the previously reported warnings from this option have been addressed,
so the option can now be left default-enabled, rather than disabled without
W=1. There are not too many actual bugs found by this, but it can help
detect a silly mistake earlier, and it's usually trivial to work around
the false-positives.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 5a25f133d0e9..24d29e477644 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -120,7 +120,6 @@ KBUILD_CFLAGS += -Wformat-insufficient-args
 endif
 endif
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
-KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
 KBUILD_CFLAGS += -Wno-enum-compare-conditional
 KBUILD_CFLAGS += -Wno-enum-enum-conversion
-- 
2.39.2


