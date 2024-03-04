Return-Path: <linux-kernel+bounces-91153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B050870A27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB0280DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7F079946;
	Mon,  4 Mar 2024 19:10:58 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB878B7F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579457; cv=none; b=rSV9sRPY8ucchKr3BbKexzosv0jDc4Up7Xqp/8OYz/PRgtbAwQBpxNYv6yF4c8yUwht2h0QNU8xLmvC/Dox2Fj/6qYd9nMoITVLLBu8NT12ojfovfaJNQWsvSoOo0IG6yT1QNuxK38h2K77Mb/G4pCCsTG//PKLeaS5SGECX7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579457; c=relaxed/simple;
	bh=UhA9NzN5AgwziWhnlnveA/LqNjNCJ3iXglsNYWq2dfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L72M96/oIGWWKhmG0iLD5swN1XKo9jh1/PHsAxPXsdWrYtJnZe/JD5P8bRtWZFpPIEfTM1FLgT1i2gO+ZY7rsGgkfelB6BMW5G3P7Bnj4lTYn9/5+7qk7CjZggdEny1qi6qt8RLJ6LicHIdCghPoDFnoVlHVNKXe0xa3htmODWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by albert.telenet-ops.be with bizsmtp
	id ujAr2B00E2qflky06jArfP; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KJv-LE;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCcg-BK;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/7] sh: traps: Make is_dsp_inst() static
Date: Mon,  4 Mar 2024 20:10:44 +0100
Message-Id: <8525fe446e7f24649a83b8cd6ca8b736ab746b80.1709579038.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709579038.git.geert+renesas@glider.be>
References: <cover.1709579038.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If CONFIG_SH_DSP=y (e.g. se7343_defconfig):

    arch/sh/kernel/traps_32.c:572:5: warning: no previous prototype for ‘is_dsp_inst’ [-Wmissing-prototypes]

There are no users outside this file, so make it static.

While at it, convert the dummy for the CONFIG_SH_DSP=n case from a macro
to a static inline function, to increase type-safety.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/traps_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 8cd4b05df75c3e07..1271b839a107ef28 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -569,7 +569,7 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 /*
  *	SH-DSP support gerg@snapgear.com.
  */
-int is_dsp_inst(struct pt_regs *regs)
+static int is_dsp_inst(struct pt_regs *regs)
 {
 	unsigned short inst = 0;
 
@@ -591,7 +591,7 @@ int is_dsp_inst(struct pt_regs *regs)
 	return 0;
 }
 #else
-#define is_dsp_inst(regs)	(0)
+static inline int is_dsp_inst(struct pt_regs *regs) { return 0; }
 #endif /* CONFIG_SH_DSP */
 
 #ifdef CONFIG_CPU_SH2A
-- 
2.34.1


