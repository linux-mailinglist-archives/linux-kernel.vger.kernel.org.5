Return-Path: <linux-kernel+bounces-125036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86245891F05
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F0E28E004
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B02D1BEDD7;
	Fri, 29 Mar 2024 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkzUiljP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B1D1BEDC7;
	Fri, 29 Mar 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716682; cv=none; b=hji5iBd45K29jptmc8eJzG+JdsfNy6Jdzeul5EhPrCgzrrsYUqu3A2ynRC7EzpeshssvWMn04Ng4Orm3klhZ9QZA2W+ofikGJvNv4ucnPhC7fdwLogtoGPQoue548wpRVIFSeP7PrtMyEZbY174ecssBxf/oAQlW7C33zzXBRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716682; c=relaxed/simple;
	bh=e6smQi1YdhW/dUGgauSLAn2658GEXnwU88IsD3J1bTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLpY5760Gyng0QTGfoWKfWw9+L9VBSa18y1vebKOHp6KeJrWW5nYyz0l6P/hQAGLH4A7X1dCa6jwfLx/pjM8JZlQv7FtnunYaCg0LyNg5tvVsQXYoxo4zEo+0tBKkhxQIdo0JRbjVdbKXRBNkQJS7MtzCxnseFH14i+zwf+oDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkzUiljP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B25CC433B1;
	Fri, 29 Mar 2024 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716682;
	bh=e6smQi1YdhW/dUGgauSLAn2658GEXnwU88IsD3J1bTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkzUiljP701AG0j4iOLPTj0k/GF4iZuQuBJrNM3t1+JXHUxCW+8EgyRxOs/XQduGI
	 3chlX+mjMF5t+ts+uIJsrh3ZIwkSMlx1/PaVHF4oBOsRFEA6TWMCj3fuUvphT1hyuY
	 gsRYli0bHsVdwMpkaQaAhrPw4KfKF2Jy3HaPpMrNrO7vKhgXz1Udvz/g++hhu1Nppq
	 suh9hwj6ZOBF3WShnUCuNUZZjR/ca8yPtSkSQ41Aez1LA2XuiTiWGiRugNS0ZiVTbL
	 xpfDUKgm/cwEz5giG2qhZwodHM3UvQ8IfAsk5rCKL8tq6zCn6SMYQJwMw78gLC0M5j
	 1aFu+JDNWFpdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	andreas@gaisler.com,
	masahiroy@kernel.org,
	deller@gmx.de,
	guoren@kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/19] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:50:43 -0400
Message-ID: <20240329125100.3094358-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit d4be85d068b4418c341f79b654399f7f0891069a ]

The UBSAN instrumentation cannot work in the vDSO since it is executing
in userspace, so disable it in the Makefile. Fixes the build failures
such as:

arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/all/20240224073617.GA2959352@ravnborg.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index dc85570d88395..4fa1cb1a67fca 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -1,6 +1,7 @@
 #
 # Building vDSO images for sparc.
 #
+UBSAN_SANITIZE := n
 
 KBUILD_CFLAGS += $(DISABLE_LTO)
 
-- 
2.43.0


