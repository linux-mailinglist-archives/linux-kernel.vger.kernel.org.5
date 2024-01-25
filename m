Return-Path: <linux-kernel+bounces-39389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58683CFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F161F249AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5B1D6B6;
	Thu, 25 Jan 2024 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm9XhisI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F51B81E;
	Thu, 25 Jan 2024 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223368; cv=none; b=skBISUudfRQXoftObNAqEfF4MQijM1APV6dykFOPU+RAoX49wlGnO7tWOTznNQY6RGMZSXxBOqs+zA21GGhYwmPWva+2DOpr9uWwgjoIHFG9Z0Al6ty+3xmN61lUZQbN3XN/zumWMuCkVu08FTSpVncuYBFhuC/IMU9fuqFAEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223368; c=relaxed/simple;
	bh=bT1Kw/x60kOitlZMWNafPmdLsoWMItemWBhie7YD9XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VG4nyuMnox7IpZvoXmLJaGLAzrctrpDwrcDPfJ7zIn4xQEz7rRkHmMZM37xk355PhGrHsTf6d4rMPN9fW8i/7jleHIBGtUSvWiFHGvit071WEo8R02+4NRumVfU2k0kxJwDilzPXE6sfib1O7j4LsN3ixwb5Zx6/baXwPBgyk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm9XhisI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10818C43399;
	Thu, 25 Jan 2024 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223367;
	bh=bT1Kw/x60kOitlZMWNafPmdLsoWMItemWBhie7YD9XI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vm9XhisI0+r01AtDM7hT6Qlf+/72BmdUJfjk7HzpkQqfo+6q6UAUrGk2wEX1mnGq+
	 AifZ6OrufCEJmyH1mVG6+NuPL+yN3bn3pNYRWmm8HAhlgkL+tqL4ceufEZOm0OyrY3
	 lnjhEEfCUYl8RoJ7UVoOpMW/JsNby6WAAkC/64kRL1Nm9m0i8OwKZZRTc2YSfuLayd
	 /96/mE/alkmHGuux4DqHH5rS50bMzj0+9DgRxAyGRdoS2KSFIXPoG5WtIMUiZAX8oX
	 he7GgenQWajMSh+FbcMbNwL86iz3lHCcMyusNj2PoNlqRUtNbVx0uyzr9EsrMjneUW
	 +VPWnodIzPPoQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:15 -0700
Subject: [PATCH 09/11] fortify: Drop Clang version check for 12.0.1 or
 newer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-9-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, keescook@chromium.org, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=nathan@kernel.org;
 h=from:subject:message-id; bh=bT1Kw/x60kOitlZMWNafPmdLsoWMItemWBhie7YD9XI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv27eWPvnV7twFfRCac5NVSbV+yKyDO4WymklMN+1
 NaUwdC5o5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEyEayMjw9ZnpT/ionb+e3hY
 VUjldLWuGJNh5JL9089X7Dgxr8uJ9SYjQ9eP2Tqnnmccu3yrMU3w9v+eWaoWztvr+MJVb3woyVr
 xgQEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that the minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1, this condition is always true, as the build
will fail during the configuration stage for older LLVM versions. Remove
it.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: keescook@chromium.org
Cc: linux-hardening@vger.kernel.org
---
 security/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 606a87c29a01..412e76f1575d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -142,8 +142,6 @@ config HARDENED_USERCOPY
 config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
-	# https://llvm.org/pr41459
-	depends on !CC_IS_CLANG || CLANG_VERSION >= 120001
 	# https://github.com/llvm/llvm-project/issues/53645
 	depends on !CC_IS_CLANG || !X86_32
 	help

-- 
2.43.0


