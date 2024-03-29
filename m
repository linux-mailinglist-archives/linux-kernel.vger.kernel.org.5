Return-Path: <linux-kernel+bounces-124700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9D891B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3696DB22E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29712143866;
	Fri, 29 Mar 2024 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuzacE92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA6175C91;
	Fri, 29 Mar 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715734; cv=none; b=pbER57WKuOHk5KUXZY8AVAspYHQr6Q5rCbmNvFD4+nIbI3iiGGpXI0JzX+57Gh68nnJeJWu5TtijqtLpODbCZcyVSSY0mRbT+JO62RX9jx4eiI2JjBdEo9H8VfIHqhn3NQzx9xS5jZDmwVTIbn/1ayB/cnj6qrRC+LgN5vEVTkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715734; c=relaxed/simple;
	bh=e6smQi1YdhW/dUGgauSLAn2658GEXnwU88IsD3J1bTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFQFU60nWOJkoXN6/Tu+5camdz/ePMTdgxqbVQD0USYPl7XQhVNwHv3NUoinMO8e34p0VhR0dkIWbpfBZ6jRJ69NXOG0oCsLv6yLy467jThtY15+SueeaPVETFZ+q6E+Pg/ltdYrs07yFU/mCr5HsObybgMk3I0LIDqYfpPRXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuzacE92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8F7C43394;
	Fri, 29 Mar 2024 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715733;
	bh=e6smQi1YdhW/dUGgauSLAn2658GEXnwU88IsD3J1bTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BuzacE92nKLYwcnW9ZkKLYvpfLltMCWiOz/KXOV4OLKBc4IVxUr+PM4mGbUIdFTBT
	 LnFBGoJMOVDk7TUoiEsCi+4rD8KXYaLhLafcZimZEVkCOV2EiDJywwUpI0inYPVmiJ
	 xbaYYerT4hCriTv+pGP9ce/srr+2C68rRgjmf7Yhfhb/UElmkAJ2rkdzBM2/2/ZGmJ
	 UbZusczMImra//7N07MLlSD6AVlZY1bBPU1K+PPA98O3RT5ePMNWr+pas7L4D0106p
	 29Zr3Fi1Tn6h6hE4ij2NeeSdCHR7YbGLSXqMwpIua/3rrS7P3mrIGxv1+bdRm5q5W9
	 QTh4nQ20ZZ8uA==
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
	deller@gmx.de,
	catalin.marinas@arm.com,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/11] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:35:12 -0400
Message-ID: <20240329123522.3086878-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
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


