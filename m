Return-Path: <linux-kernel+bounces-95995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 379698755CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDEDFB223B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90813175C;
	Thu,  7 Mar 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="g5UATij/"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE73612A15C;
	Thu,  7 Mar 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834891; cv=none; b=A2mAa7tzDPN5XETGXo2Lpe1AWOlQge9zzd3+dNd84VSzcTAgKSMOUrJfwyCxxqH+rbttiJVcxBJXJhXkzb9pPShb5XS2+ybVAuKTbrQuWFFOw77SdcoQxuZ1egAUEFSjQdFdxI0XpuEj3MpnK0NPe1h0Z5oGxX9mTIZPrrbl+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834891; c=relaxed/simple;
	bh=d1LqTxtfR2Y90CoQGt9aHXtXMhcXtM4r5fGeKndr/Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d5B/bihb+e8o/fNQIPc3ce1mcdg+QYqPhB7q5q0DpRIZSEexuxIdpZJNpCWuOiT4Z237sM8TRchk4LlTCAZHOyE6cshYti9vxRkf4M2BofEpd8WPHMs+BfCJSnrfXPrLXy/Jjcl3CVuvCJ9O4XPtrB8vrsk56yMqQdGfpxrmoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=g5UATij/; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TrHMx4CLYz687C;
	Thu,  7 Mar 2024 19:07:57 +0100 (CET)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4TrHMp2C7yz686Q;
	Thu,  7 Mar 2024 19:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709834877;
	bh=hf+Dkq4gendnDFhQL2nsuHPuMRlOr7oIlpwqpMC5s6o=;
	h=From:To:Cc:Subject:Date;
	b=g5UATij/BDx1CIuzLzDq2RrfiizCrNNT311KY+fBDxK7k1xUwCpSd1AT8ey0Tc8BG
	 KuEnNe48tkual/NYHnIZe5JsPqoaJRXZICeoTOkN2VvwHLv6I34VJlYJlGHP0iQ/T9
	 3Bi58FJ4QPFPvGYcrAvVK2LqHsxkRNC1jQuWiNMk=
From: Andreas Larsson <andreas@gaisler.com>
To: sparclinux@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sam Ravnborg <sam@ravnborg.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] lib/fonts: Allow Sparc console 8x16 font for sparc64 early boot text console
Date: Thu,  7 Mar 2024 19:07:42 +0100
Message-Id: <20240307180742.900068-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow FONT_SUN8x16 when EARLYFB is enabled for sparc64, even when
FRAMEBUFFER_CONSOLE is not to avoid the following warning for this case

   WARNING: unmet direct dependencies detected for FONT_SUN8x16
     Depends on [n]: FONT_SUPPORT [=y] && (FRAMEBUFFER_CONSOLE [=n] && (FONTS [=n] || SPARC [=y]) || BOOTX_TEXT)
     Selected by [y]:
     - EARLYFB [=y] && SPARC64 [=y]

by allowing it in the same manner as is done for powerpc in commit
0ebc7feae79a ("powerpc: Use shared font data").

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Fixes: 0f1991949d9b ("sparc: Use shared font data")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402241539.epQT43nI-lkp@intel.com/
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
---
The commit this fixes can be found on my for-next branch from
https://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git/
---
 lib/fonts/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
index 7ee468ef21ec6..7e945fdcbf115 100644
--- a/lib/fonts/Kconfig
+++ b/lib/fonts/Kconfig
@@ -98,7 +98,8 @@ config FONT_10x18
 
 config FONT_SUN8x16
 	bool "Sparc console 8x16 font"
-	depends on (FRAMEBUFFER_CONSOLE && (FONTS || SPARC)) || BOOTX_TEXT
+	depends on (FRAMEBUFFER_CONSOLE && (FONTS || SPARC)) || \
+		   BOOTX_TEXT || EARLYFB
 	help
 	  This is the high resolution console font for Sun machines. Say Y.
 

base-commit: 626db6ee8ee1edac206610db407114aa83b53fd3
-- 
2.34.1


