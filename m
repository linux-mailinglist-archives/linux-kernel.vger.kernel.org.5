Return-Path: <linux-kernel+bounces-111474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5D1886CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDAA1C219CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9594D47793;
	Fri, 22 Mar 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6njRtQ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9147772
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113791; cv=none; b=RhDSgznyJmYToLHzGPD2MdC1z6IVJi8kUsGcdlwm/MmsSFgvej3kaLcBNa5o8oCXSLvM3Z7tdPWGOwZx2enf+qoRz7GqQiCF6ZwR9GFgQ/uBxk6kscJsuP69MBYzpONtsOpz5jNVxLyh/5mIM9pJoNEjjb0WptDWkuKLrL+Tetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113791; c=relaxed/simple;
	bh=AiSrh+YA/lxHjLdvMVR5E4drVrl44FmWI2qerSd1BDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUt22j75UdFVQi53+wHQbZzhAIHLHe72qW4UYQ31h3KO1lVFQMyriOyLbqj/IEg6dxJtqz4K6nrZb8EgG7I6GBezGI1w2wnvGVY76IQ9KIBClws6cgu9UPQMBChHPAGuiL2gSHspGlzF+J4f41iJ/95ju+dTWMPQ3vP1dJ1yjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6njRtQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BAFC433F1;
	Fri, 22 Mar 2024 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113791;
	bh=AiSrh+YA/lxHjLdvMVR5E4drVrl44FmWI2qerSd1BDg=;
	h=From:To:Cc:Subject:Date:From;
	b=c6njRtQ/X9HmhIIsxJBIGPKC6YiCRTEMieus4KuwrAbK5j2tKqXXFUARAiaH1vgDN
	 JWXzTICc+ugEMJVg2/q+Y+H0XLZ3ozT6EeyWc0ZMzvPoms43ed8Y4HH9eX41Nb/GXL
	 GIZ+gyoPIMABMzGRTMfTI+TqwRNTKZpRGNlP/B9iWBeaqYv3IfyUhFR5OTzh+fe/4B
	 pDQgRz9kI++sp5b2iKGf1vXMM1IcwaWNEGVmyzNeyrqfIrAH4GAYB0tHeb4InQRCc2
	 oiYsUlAKaXZQK4hgHyPYdLW4q0owTmToo98tpXUR2x+BpVh9r7hrV0vW1WxNhGNMvB
	 ffLkP0iqD4c+Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Matthew Garrett <mjg59@google.com>,
	Bartosz Szczepanek <bsz@semihalf.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: aovid -Wunused-but-set-variable
Date: Fri, 22 Mar 2024 14:22:48 +0100
Message-Id: <20240322132307.907203-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Outside of the EFI tpm code, the TPM_MEMREMAP()/TPM_MEMUNMAP functions are
defined as trivial macros, leading to the mapping_size variable ending
up unused:

In file included from drivers/char/tpm/tpm-sysfs.c:16:
In file included from drivers/char/tpm/tpm.h:28:
include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
  167 |         int mapping_size;

Turn the stubs into inline functions to avoid this warning.

Fixes: c46f3405692d ("tpm: Reserve the TPM final events table")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/tpm_eventlog.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 7d68a5cc5881..6e5be15029fb 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -131,11 +131,16 @@ struct tcg_algorithm_info {
 };
 
 #ifndef TPM_MEMREMAP
-#define TPM_MEMREMAP(start, size) NULL
+static inline void *TPM_MEMREMAP(unsigned long start, size_t size)
+{
+	return NULL;
+}
 #endif
 
 #ifndef TPM_MEMUNMAP
-#define TPM_MEMUNMAP(start, size) do{} while(0)
+static inline void TPM_MEMUNMAP(void *mapping, size_t size)
+{
+}
 #endif
 
 /**
-- 
2.39.2


