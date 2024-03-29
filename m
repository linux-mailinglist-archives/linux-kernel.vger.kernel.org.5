Return-Path: <linux-kernel+bounces-125017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D189C891ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9841C20B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33C1B85BF;
	Fri, 29 Mar 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED0Sgjzb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279411B858F;
	Fri, 29 Mar 2024 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716639; cv=none; b=hSZQawZYy4es8Zgdm7JXG16bcnvlkpHIyK5Rl0AXQ7NkQ9y4z2YIS+O52HupicYlv0Cf4V1i20ZPkP0nEM9vPzIl4DL5ZqGphEFAfIvZ3dKbFDJY79/DEgbO7zl+o1eLuSRomG4Revk8jS8kqo8vwn9HFcQfs4/5eu+tmd3V9Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716639; c=relaxed/simple;
	bh=lRVkrFF93OgjKTOJxfW5xcxxpMm4wx7SGwA+QNECwS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNdzZOf9WBdqf2ZSm+7WYmsJtyXhWSXotgdfPikdHJTRYP17akTC8AFGHHAMTQk2z/TNWf009cmfkP2ZBrxUgCz+A6i+yY38w+H6FsciZew3bKmmZHRxV0d8TQBVTjZNhe0c/ZPgbp9VCjzORyGandwoCz+xmqaKuM4MnK52Wow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED0Sgjzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCFFC433A6;
	Fri, 29 Mar 2024 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716638;
	bh=lRVkrFF93OgjKTOJxfW5xcxxpMm4wx7SGwA+QNECwS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ED0SgjzbCj38MdHLsbHmewZih/sLYNA5W9YC+HUHiJw74it1SV7DykEfzEnt4/33U
	 T6kun6Lu2nx2DGW21DJI+PPpBGb6CPsLVwf3rstR5T15sxoPEk4VbBAh1l8zSU4oi7
	 eSXc9CR/OzSjKh+qPZN+Xy8t/uwyfFVyAjl2lm9n9AsPpX07zi0ywNzEU3M0FXnVIN
	 wGDWXbzAStkuR2jOdPZDRSAQ/vnac3xoDrcF/hzNA+cVTqUTAPdOyP5aRiUupdjR/y
	 zxzHA7QhGfBRaM04q7L4BsoENj5i7Z8OKmdZma2Ic9GVUvQ+YJ+kn+nwKAfg8k1TOL
	 7jWn+r86AhYmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	andreas@gaisler.com,
	masahiroy@kernel.org,
	rmk+kernel@armlinux.org.uk,
	svens@linux.ibm.com,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/23] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:49:48 -0400
Message-ID: <20240329125009.3093845-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 997ffe46e953a..5b869c2c84363 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -2,6 +2,7 @@
 #
 # Building vDSO images for sparc.
 #
+UBSAN_SANITIZE := n
 
 KBUILD_CFLAGS += $(DISABLE_LTO)
 
-- 
2.43.0


