Return-Path: <linux-kernel+bounces-56757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B0D84CEB2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B4FB2311F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642480BE1;
	Wed,  7 Feb 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RJNTBrNA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B77FBD4;
	Wed,  7 Feb 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322412; cv=none; b=nFiExzDh4VGYufdAbe+SvZ+Qatw35DMrZqSaQZxBsDRUsqUP13GejKQ69NN1rznqeJIJVN435eePsINzHNMLWWkprEiGOdc0sL4ym+99hraB3QaYTC/ZQCmN+564BzrCVdNdGveh/VAmI+N+DAZeSgLHA3wYX3m5v4urFRvW1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322412; c=relaxed/simple;
	bh=gMkb/LVVk95GKIk8bauKpW7UC/dh8L4ylJC+kHTYZqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPdBZ2c3ZX0Q/r47c3tUkyhmf7WVEgew021L3T7KlcjtLQvOZHoYbpXbPdGzj2xfxxpq8xpgJWCYwUs2tguE50Dbz1KlptR+IfP6NU+9iYPizwN5Rzstx62ZrHVO9X9JceAR5pe3AgfMwsvo5RpyL63ddyfXTUf3CunMuHEEhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RJNTBrNA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BzfR02iaC4unUSCO9abKwcFUwiyIjB6j/U2qifVyUjY=; b=RJNTBrNA0gX9tZMdxmaX0a3ewg
	UQNsN0ZI+eUd/5Zhixy5DWyILdoKHPiVbMB3x40NacxvJaR1cZdLWFefS8x7WGy0Mh8x/GpApawEt
	e9F3587MTXO5WU2Bkeu1QKEgyEzoSUZYzIxXT1YLuYvYbv0qED0ZL10TMfAtJT4SHZF4R65bziM7A
	nmIjfG8Slb/SKaR2kjvBiCKEoa1d2hEiLJUmoV6x7KEeRJowHjmHZe04lucfdnO1VpiZ+fyUGOTGU
	Fpm0TGGdwNq7bL7a6epxfUcxyuSOV0l5akAd3OFxd2AxCG5Ee3TRTNNB+WSiPXPkqSDoWoFJOnoXc
	Q4A3mxrg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXkYA-0000000BBCJ-2Wir;
	Wed, 07 Feb 2024 16:13:26 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Geoff Levand <geoff@infradead.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drivers/ps3: select VIDEO to provide cmdline functions
Date: Wed,  7 Feb 2024 08:13:22 -0800
Message-ID: <20240207161322.8073-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When VIDEO is not set, there is a build error. Fix that by selecting
VIDEO for PS3_PS3AV.

ERROR: modpost: ".video_get_options" [drivers/ps3/ps3av_mod.ko] undefined!

Fixes: dae7fbf43fd0 ("driver/ps3: Include <video/cmdline.h> for mode parsing")
Fixes: a3b6792e990d ("video/cmdline: Introduce CONFIG_VIDEO for video= parameter")
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Geoff Levand <geoff@infradead.org>
Acked-by: Geoff Levand <geoff@infradead.org>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: add Geoff's Ack;
    add second Fixes: tag and more Cc:s (Thomas)

 arch/powerpc/platforms/ps3/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -67,6 +67,7 @@ config PS3_VUART
 config PS3_PS3AV
 	depends on PPC_PS3
 	tristate "PS3 AV settings driver" if PS3_ADVANCED
+	select VIDEO
 	select PS3_VUART
 	default y
 	help

