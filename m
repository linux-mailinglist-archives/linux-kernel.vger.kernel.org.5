Return-Path: <linux-kernel+bounces-51513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091B848C10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D153283F53
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E501510A2B;
	Sun,  4 Feb 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7vEqYW4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D310A09
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707034214; cv=none; b=WmWJjCAFiaT6MAz/18AP+qrTf4eNSm81khpV7K4k74/w+YddFB4Df2uIeM/RWyebiQWnB+1iVM9VG1wj5Z+cTAg4iNpnzwftXYArMghBCV6hJT4jZplmDAuuwt54xweA4NN9+A3u81EOXZEPTAM+EWH23D3e7CeMlPCdlOM6hBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707034214; c=relaxed/simple;
	bh=ETBf1FO+9nmgKQPZs8HdwPMyJlT1LQh/VW2kdPjj5ug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YkJ14qwhQRm/jBqqiRoU9mTCEofa7jmQl9Ljht+AefTg4ldIgckg6iGhyvEFNlrNvZfIGJdZFnI9nntnUgtcXeqQs8i6E/+FFy322MrkBN/x98g5ghkrFYVfByvD1h/LesgJshoWILK6H+AoqwLBWepwYuouIjSYRHsgAuUVAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7vEqYW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DE2C433C7;
	Sun,  4 Feb 2024 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707034213;
	bh=ETBf1FO+9nmgKQPZs8HdwPMyJlT1LQh/VW2kdPjj5ug=;
	h=From:To:Cc:Subject:Date:From;
	b=q7vEqYW4MpSQte4JFhgfQ4DF6zyFO/T8rMaCa/8PRlIuy6ReGDKRr+Vv5iGFbMBEu
	 LrUthmt//6M5m1s+TOzT4nOZAe5ANbqubJA0+HtyYmGrNGNV8++IVH9WLVVn9VYZRE
	 PrSQA8YBx9STdhHXbLrluKk06SB1WU+XXdrg3HlZonzHH/Gupc5Ng8qQOOwjkKFDGh
	 vAj6CUcUcvL1ALzW53nuiFfVhpqwXOYLAvST2v/rXk6VTOD0mv0HoMQf0epE7Y+2cS
	 /x6os5UP8yown/e26xArgGGYmvMd2xUcWThYjwjxmigVhRhFBokiDZzEFk5c9OEwWK
	 4+YB0ReqAdvqw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Greg Hackmann <ghackmann@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH] platform: goldfish: move the separate 'default' propery for CONFIG_GOLDFISH
Date: Sun,  4 Feb 2024 17:10:04 +0900
Message-Id: <20240204081004.33871-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there are two entries for CONFIG_GOLDFISH.

In arch/x86/Kconfig:

  config GOLDFISH
          def_bool y
          depends on X86_GOLDFISH

In drivers/platform/goldfish/Kconfig:

  menuconfig GOLDFISH
          bool "Platform support for Goldfish virtual devices"
          depends on HAS_IOMEM && HAS_DMA

While Kconfig allows multiple entries, it generally leads to tricky
code.

Prior to commit bd2f348db503 ("goldfish: refactor goldfish platform
configs"), CONFIG_GOLDFISH was an alias of CONFIG_X86_GOLDFISH.

After the mentioned commit added the second entry with a user prompt,
the former provides the 'default' property that is effective only when
X86_GOLDFISH=y.

Merge them tegether to clarify how it has worked in the past 8 years.

Cc: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Kconfig                  | 4 ----
 drivers/platform/goldfish/Kconfig | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec175b9bf..eb6c9f5b3be7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -471,10 +471,6 @@ config X86_MPPARSE
 	  For old smp systems that do not have proper acpi support. Newer systems
 	  (esp with 64bit cpus) with acpi support, MADT and DSDT will override it
 
-config GOLDFISH
-	def_bool y
-	depends on X86_GOLDFISH
-
 config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
index f3d09b1631e3..03ca5bf19f98 100644
--- a/drivers/platform/goldfish/Kconfig
+++ b/drivers/platform/goldfish/Kconfig
@@ -2,6 +2,7 @@
 menuconfig GOLDFISH
 	bool "Platform support for Goldfish virtual devices"
 	depends on HAS_IOMEM && HAS_DMA
+	default X86_GOLDFISH
 	help
 	  Say Y here to get to see options for the Goldfish virtual platform.
 	  This option alone does not add any kernel code.
-- 
2.40.1


