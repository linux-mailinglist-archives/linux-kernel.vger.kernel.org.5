Return-Path: <linux-kernel+bounces-112263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A44887799
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6F4282E82
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA0D101EE;
	Sat, 23 Mar 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWQboOv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3DCDF53;
	Sat, 23 Mar 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711183870; cv=none; b=sB/FNPbqgkqojY6wCA1l/YNgfsZo/jzs2YRRAfEja5kJB8twa6SNyCMao4aE9piABxMe9JqZD3xBKIzKr8PLcc8/0mca6+HLJi3A6gFPZZV9U/DT5JSOAqknD6mtsItPbiIDFnybxpBxFLWN6LY2dNuxIhcC8JrWcoAyutUQ4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711183870; c=relaxed/simple;
	bh=hmCc4UcGmIClYKNjSe6c5p0T7m4XM619ijDYneNgaL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDfCT46jXrNaSBnJudbiDa4mS/HvS6+mT3n9Sy4GeCPwXBkHAMphbuv4MMjFWyIUeRQ8dhMTzm4SlZWzKndR6iv345b3lRkuVHhPUsv/wYxSYqKzk6NmiRex2EoDUbVQ3kRiJXwtyp4pb1R9/3CZVyUk8LbuYwtDx7KGOc6FM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWQboOv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB86DC433F1;
	Sat, 23 Mar 2024 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711183870;
	bh=hmCc4UcGmIClYKNjSe6c5p0T7m4XM619ijDYneNgaL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWQboOv2GKWLBXu5r1Owbc50DFNKrS8QujiSM+/Xf2nyN1ekixzKtSTxjF/UdZwBe
	 +srjH4a1W7omI0NcNL73nXVXTnZHxb9shePZyfnwuyAjfoKMMxJsbPhjLDodGlgMea
	 8nVmXL5Ir73TBF/8k+asGeCrylwrc42MZM+yjHGnEMzg3dKzHtt6JpPKE6BNnatrlw
	 c7FdPew7GGJA38fUiSmt+i/dYB0+C31i+W0lgy1qdrRgOdI9pX8XTG48TGZVmC7Kpc
	 tIqQ9lEN95OEDuNzzvRaF5CElJzLkgroAj84LgqIz+zcV84/iA47soTvu3sftpLA8L
	 zN/HU4z4WCSmA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 1/2] MIPS: move unselectable FIT_IMAGE_FDT_EPM5 out of the "System type" choice
Date: Sat, 23 Mar 2024 17:51:00 +0900
Message-Id: <20240323085101.1243814-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240323085101.1243814-1-masahiroy@kernel.org>
References: <20240323085101.1243814-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reason is described in 5033ad566016 ("MIPS: move unselectable
entries out of the "CPU type" choice").

At the same time, commit 101bd58fde10 ("MIPS: Add support for Mobileye
EyeQ5") introduced another instance of the same mistake.

(In fact, 5033ad566016 and 101bd58fde10 have the same commit time.)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 06ef440d16ce..516dc7022bd7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -619,15 +619,6 @@ config MACH_EYEQ5
 
 	bool
 
-config FIT_IMAGE_FDT_EPM5
-	bool "Include FDT for Mobileye EyeQ5 development platforms"
-	depends on MACH_EYEQ5
-	default n
-	help
-	  Enable this to include the FDT for the EyeQ5 development platforms
-	  from Mobileye in the FIT kernel image.
-	  This requires u-boot on the platform.
-
 config MACH_NINTENDO64
 	bool "Nintendo 64 console"
 	select CEVT_R4K
@@ -1011,6 +1002,15 @@ config CAVIUM_OCTEON_SOC
 
 endchoice
 
+config FIT_IMAGE_FDT_EPM5
+	bool "Include FDT for Mobileye EyeQ5 development platforms"
+	depends on MACH_EYEQ5
+	default n
+	help
+	  Enable this to include the FDT for the EyeQ5 development platforms
+	  from Mobileye in the FIT kernel image.
+	  This requires u-boot on the platform.
+
 source "arch/mips/alchemy/Kconfig"
 source "arch/mips/ath25/Kconfig"
 source "arch/mips/ath79/Kconfig"
-- 
2.40.1


