Return-Path: <linux-kernel+bounces-67038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F5856524
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCDC1F26552
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8249813173A;
	Thu, 15 Feb 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzgSeGNJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1D13173C;
	Thu, 15 Feb 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005507; cv=none; b=qBOjT1SMEMTos4A7eLnhNweqrIK0GV2llLGjmn9JOZuTB6WYbIf2mp/++qoO1eVII6LsSOX7OWM7i6Hey86o9w94PYyOojapsiP+R2bAMT5nKh16geXD+G/LeWgbsuiumYnyZ1Sdtfo8Eeka5avQ/olAp8UdwMug7d6EpyGMrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005507; c=relaxed/simple;
	bh=db081udyahOME/RFJvw8RkO4hTyCR745hVkoJE2o4xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Stg10KB34UT1ElZ5/K6muWi/gF4hGHitg7L8n92c3wskQB/CEkCnyLR7A7ZeEjC+s36bAufIoTj98Hx+8kC6wqfGzGHJjDAl/KuVEQyO/Aa6fHegyyjPYTbM/EZIteDF67bRWsRTocfQ/wFLQ2Vt3ecno1e6x4epVk/mc4df1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzgSeGNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35D6C433C7;
	Thu, 15 Feb 2024 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708005507;
	bh=db081udyahOME/RFJvw8RkO4hTyCR745hVkoJE2o4xc=;
	h=From:To:Cc:Subject:Date:From;
	b=EzgSeGNJf9XQHAI3oXqk2wTP7MG8AaQGIaHnyYSrnd4pOSQL01eee9/clvmJs1m4N
	 MpCkvmloLzHTC78ieta9BPreOeKP4jkZfCvBHk6l8iz6+R1Pkt9Yb6jvuxio+ddttY
	 pqHXJSevWCl1R5h0cxOkgBMdKmc2yoQxWJKaNCwGzLFJPmoqg0H9TM1ebgfXZdM2mF
	 6FDDUAh39fwhqpQf4B8UReYYkxWXxAKR8MtbYOGn415/TRryJEZKlg0MXClKep8et/
	 dhLNmdGez5bPx8DJTWV2MZ2MM1UsijYQRF1/AvqQln+B0p+auDpaI4gP4S+icEC5KF
	 aVJU7aufg6rdg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH] sparc: select FRAME_POINTER instead of redefining it
Date: Thu, 15 Feb 2024 22:57:49 +0900
Message-Id: <20240215135749.1909812-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because FRAME_POINTER is defined in lib/Kconfig.debug, the arch Kconfig
should select it.

Add 'select FRAME_POINTER' to MCOUNT. ARCH_WANT_FRAME_POINTERS must
also be selected to avoid the unmet dependency warning.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/Kconfig.debug | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 37e003665de6..d475a056a2e0 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -8,11 +8,8 @@ config MCOUNT
 	bool
 	depends on SPARC64
 	depends on FUNCTION_TRACER
-	default y
-
-config FRAME_POINTER
-	bool
-	depends on MCOUNT
+	select ARCH_WANT_FRAME_POINTERS
+	select FRAME_POINTER
 	default y
 
 config HAVE_HARDLOCKUP_DETECTOR_SPARC64
-- 
2.40.1


