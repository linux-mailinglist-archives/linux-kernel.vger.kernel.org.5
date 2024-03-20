Return-Path: <linux-kernel+bounces-109114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE788814CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15C91F21F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C152F78;
	Wed, 20 Mar 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1bwb+0R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9191364;
	Wed, 20 Mar 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949420; cv=none; b=glTemy0GxLK8ZBb1ONl0ZCrd+QMa5WaDKeFE7ujMuiinrQ2+F6c78WtG2KfjOFF8zAtIyAfnDgUDAemcMQOVzcyQ0uauiaxHy692F9S74EEyBeXlEdpiY/ZTTXkKcbT7eHlFK15kDNccQbokEUAuUCLmKgsSc3wvwnp78KOBnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949420; c=relaxed/simple;
	bh=1hvlb+dBq1uqMaMG6m7WOPZeFA1zoDxT5KLD5wMVj78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a6WwSJWRMgc8BAGOdPT502tM7/Ojb1XjKoOUB4JtRN9awLs7oWnb2xwH2BPEYONaSIL6NoBgh+F0u0rNMV1mvyhqid4MKl409QlK557IbM0HiLYR2m1nG2vrNeglYZN+kUuG4/4QHiQmWvtMrv2PnZZ9V2YgWZEcWQqjZjUbbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1bwb+0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07B2C433F1;
	Wed, 20 Mar 2024 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710949420;
	bh=1hvlb+dBq1uqMaMG6m7WOPZeFA1zoDxT5KLD5wMVj78=;
	h=From:To:Cc:Subject:Date:From;
	b=B1bwb+0R3MFIKhh9B/6DLhVFYStUBi0lMDkeqcA1X81AYfUVkRVMDfPOgMHiva5EA
	 Pe+F6T4HGo1DFkaRXVp2KhCjHrWWdbQQovnxs8zXohXrZPjpUPL+G7iSIK0fYVDq3j
	 9plSGoyqcsbZ58I54D7zo5svC/RWSRHFS7PhI46acb5KPveLmf0tADJoaFArqSv+/z
	 LfvgClpvX0wvi9Y2fycwnF72KouOWmyh5bI48MpZ6pnJaaw6TCcumKo/UNzk5hJGbG
	 zmJjIW+5vkdt0Jk11qQiJL2HIUV6yn9zgBGm3Xy1ZHhHtqO71S4fuWIlT5UrB9lL6E
	 wR4lyG3EVpunw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] x86: tinyconfig: fix warning for 'make ARCH=x86_64 tinyconfig'
Date: Thu, 21 Mar 2024 00:43:12 +0900
Message-Id: <20240320154313.612342-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kconfig emits a warning for the following command:

  $ make ARCH=x86_64 tinyconfig
    [ snip ]
  .config:1380:warning: override: UNWINDER_GUESS changes choice state

When X86_64=y, the unwinder is exclusively selected from the following
three options:

 - UNWINDER_ORC
 - UNWINDER_FRAME_POINTER
 - UNWINDER_GUESS

However, arch/x86/configs/tiny.config only specifies the values of the
last two. UNWINDER_ORC must be explicitly disabled.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/configs/tiny.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/configs/tiny.config b/arch/x86/configs/tiny.config
index 66c9e2aab16c..be3ee4294903 100644
--- a/arch/x86/configs/tiny.config
+++ b/arch/x86/configs/tiny.config
@@ -1,5 +1,6 @@
 CONFIG_NOHIGHMEM=y
 # CONFIG_HIGHMEM4G is not set
 # CONFIG_HIGHMEM64G is not set
+# CONFIG_UNWINDER_ORC is not set
 CONFIG_UNWINDER_GUESS=y
 # CONFIG_UNWINDER_FRAME_POINTER is not set
-- 
2.40.1


