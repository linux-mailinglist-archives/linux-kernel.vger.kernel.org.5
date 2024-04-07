Return-Path: <linux-kernel+bounces-134426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066E589B159
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CEC283ED3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEC2657C3;
	Sun,  7 Apr 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvfb/Mt+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D9657A8;
	Sun,  7 Apr 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495518; cv=none; b=WopoQCLjWOsVIw3NufD8IPA6FhsD92VRsEx+OStpgN9PWgd0+CP5+jqWKxkNfC/xADShWBfteqnUxPdYtLTC231cioQlGRJchoPklHL4/scdlHcMhtWsN/3R+2fIEUuSsSdB0T2ELaDoV01uj9R2PN/8cF6uujKorrYdy9x+emE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495518; c=relaxed/simple;
	bh=aTWtRfUCjhuH9NSo70GCmFUYOJph1+AAFA4H+EN+RJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiLgbH1JmGJzCpEgcoDp4gp3Tv/Dy0nFfXwCLXjHonb2c3+dMqurnXTMpDyMQFGVK5RFfqgt6/s3UajqcEwV90KybAK3K5Oczer+wdeqn3g9peKidtEU3JDpEC+IQYoTLMYf6vDFeZIqYTcIMkckZ+iwQF8yEqZ9dLhmLftHEh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gvfb/Mt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB04C433A6;
	Sun,  7 Apr 2024 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495518;
	bh=aTWtRfUCjhuH9NSo70GCmFUYOJph1+AAFA4H+EN+RJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gvfb/Mt+tBlEm7D4LzR2J2qnEW6rzlOR1KgIajMrHvMtFgzv9dQPAfIzhEtasUpL/
	 SZzDVKQnFVmR4oma3dk7okZ/uILxQrdpkFfVSB/Fsvu/1kYTWwihuaZkZb4C8daO+m
	 weegH1PXJuA/851dnstIHSD+4NPn1UImXmZ2QGZ7Er8gp+9vb7Y/LadF8d4YwFbEIJ
	 h+GN068rShXPiuge8nVyXjDhYGFUGunmHE1gLtdCb5ORPjsdalsuyl5hwS4nL1zimS
	 CimkVE2+1I7NtjjpfySBQnuFsNx9o2mEP3kj/hflWWxGgPxwCnRc3lYgDhwKJoOPEO
	 drbbgEzTGyoXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 16/25] drm/xe: Fix END redefinition
Date: Sun,  7 Apr 2024 09:11:04 -0400
Message-ID: <20240407131130.1050321-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
Content-Transfer-Encoding: 8bit

From: Lucas De Marchi <lucas.demarchi@intel.com>

[ Upstream commit 0d8cf0c924732a045273c6aca6900a340ac88529 ]

mips declares an END macro in its headers so it can't be used without
namespace in a driver like xe.

Instead of coming up with a longer name, just remove the macro and
replace its use with 0 since it's still clear what that means:
set_offsets() was already using that implicitly when checking the data
variable.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: http://kisskb.ellerman.id.au/kisskb/buildresult/15143996/
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240322145037.196548-1-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 35b22649eb4155ca6bcffcb2c6e2a1d311aaaf72)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_lrc.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index b38319d2801e0..0aa4bcfb90d9d 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -95,7 +95,6 @@ static void set_offsets(u32 *regs,
 #define REG16(x) \
 	(((x) >> 9) | BIT(7) | BUILD_BUG_ON_ZERO(x >= 0x10000)), \
 	(((x) >> 2) & 0x7f)
-#define END 0
 {
 	const u32 base = hwe->mmio_base;
 
@@ -166,7 +165,7 @@ static const u8 gen12_xcs_offsets[] = {
 	REG16(0x274),
 	REG16(0x270),
 
-	END
+	0
 };
 
 static const u8 dg2_xcs_offsets[] = {
@@ -200,7 +199,7 @@ static const u8 dg2_xcs_offsets[] = {
 	REG16(0x274),
 	REG16(0x270),
 
-	END
+	0
 };
 
 static const u8 gen12_rcs_offsets[] = {
@@ -296,7 +295,7 @@ static const u8 gen12_rcs_offsets[] = {
 	REG(0x084),
 	NOP(1),
 
-	END
+	0
 };
 
 static const u8 xehp_rcs_offsets[] = {
@@ -337,7 +336,7 @@ static const u8 xehp_rcs_offsets[] = {
 	LRI(1, 0),
 	REG(0x0c8),
 
-	END
+	0
 };
 
 static const u8 dg2_rcs_offsets[] = {
@@ -380,7 +379,7 @@ static const u8 dg2_rcs_offsets[] = {
 	LRI(1, 0),
 	REG(0x0c8),
 
-	END
+	0
 };
 
 static const u8 mtl_rcs_offsets[] = {
@@ -423,7 +422,7 @@ static const u8 mtl_rcs_offsets[] = {
 	LRI(1, 0),
 	REG(0x0c8),
 
-	END
+	0
 };
 
 #define XE2_CTX_COMMON \
@@ -469,7 +468,7 @@ static const u8 xe2_rcs_offsets[] = {
 	LRI(1, 0),              /* [0x47] */
 	REG(0x0c8),             /* [0x48] R_PWR_CLK_STATE */
 
-	END
+	0
 };
 
 static const u8 xe2_bcs_offsets[] = {
@@ -480,16 +479,15 @@ static const u8 xe2_bcs_offsets[] = {
 	REG16(0x200),           /* [0x42] BCS_SWCTRL */
 	REG16(0x204),           /* [0x44] BLIT_CCTL */
 
-	END
+	0
 };
 
 static const u8 xe2_xcs_offsets[] = {
 	XE2_CTX_COMMON,
 
-	END
+	0
 };
 
-#undef END
 #undef REG16
 #undef REG
 #undef LRI
-- 
2.43.0


