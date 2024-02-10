Return-Path: <linux-kernel+bounces-60287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0BA8502AB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB281F2504D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED951173C;
	Sat, 10 Feb 2024 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RzTE3mmK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D79538B;
	Sat, 10 Feb 2024 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707543584; cv=none; b=CzCs5JQGLYAb7uieGJO7zw4S8A2wZ156bTrK6fJrArlBjCmSaPzApnhW7b+jwgIaUYT1viX/h1akUFFfNYvtSK0IBZFr2CgLQhUNOdIwTis8hJNmQlnpec5piFUhAtKQDOBNeCRmt123D9RD+lHk8pgkV/lkBDklCQxfclisDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707543584; c=relaxed/simple;
	bh=ymS3THZPo/dGfmpHzhuCPt9BRs7X7mcRRvh0DplpSuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLC1HxC1bWjuOgrZISdULSa0rYmxPjW+QjV+zJzbF9CVDz0nVNkezL7gH5x2Ei2QaWndkpwK/ZStspV6VrDEb8BKn9HBCgTk3AYFI6vjwdoVYvZsK8cyqRrfn+u35wpntEpm5htFlEeKDqFa6PyuQ+O4cmkEmiTT6OhGr2zDU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RzTE3mmK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=E+99tlygCzTff7/Lep6ynyrCUPd965OcPCGgKVbHlJI=; b=RzTE3mmKu17bVfIXNvYCTuq4CM
	r/AZx+vIkZXY6ETgwEYbvgUYlmtv/Z25NkvtzyJY+HC0dJJLk7bsJPfNzbrt2ZqfBotLgBDzcCZAW
	yhvXX5uo4a8lXsEfsaq8IJ15b9N0XdOF8M3BOnfU9VjL97DolXZvp6ngjbmoF7OvK6X3UWu6l2Z3z
	t0DsWsRKwZ8leaZXaZbpz7j5GTeOsf6ktz4D2dl5FVcCRDv9jpiMYHcaZHm0oto/wBB0Fafk2rVkj
	mJEOJmDOukQIJgHSScTODhlQugZ+DxjlzmPzg0W+Bpy6BhcPDjskjOtfNlpFpXv27SUg7lymVCo2H
	BiB1CZyQ==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYg5T-00000001Fdo-1cm8;
	Sat, 10 Feb 2024 05:39:39 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev/sh7760fb: allow modular build
Date: Fri,  9 Feb 2024 21:39:38 -0800
Message-ID: <20240210053938.30558-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason to prohibit sh7760fb from being built as a
loadable module as suggested by Geert, so change the config symbol
from bool to tristate to allow that and change the FB dependency as
needed.

Fixes: f75f71b2c418 ("fbdev/sh7760fb: Depend on FB=y")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1645,8 +1645,8 @@ config FB_COBALT
 	select FB_IOMEM_HELPERS
 
 config FB_SH7760
-	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	tristate "SH7760/SH7763/SH7720/SH7721 LCDC support"
+	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_IOMEM_HELPERS
 	help

