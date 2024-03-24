Return-Path: <linux-kernel+bounces-114296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EEF8889C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E1EB25347
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3316FF2A;
	Sun, 24 Mar 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1kFLPyn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301161ED0F8;
	Sun, 24 Mar 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321669; cv=none; b=AeIroUw2ID6OzRR9/U5SsvlOgMTMdqywrLk/fUngL0BY0QXlwPKmJScjdPw0euhZCadYkD/mQ6BsCmmb9I7HBIrvsqHkehrnjXjHDI1KTmc0LkMsquLmhwwZmnPYpL5pEbZ+fHLzl5IXi6Av1x6VXGjHNhRxfU+InR87dwJjAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321669; c=relaxed/simple;
	bh=Vql+8js91BRX0rn5qU3meYIvkq3/iZebYzGwS509XTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT7DdeZhSYDZ9yKRBv0Q95ib6gzd92p2kKPe9JJbvEnpSxqfCmc0uMJTB6KRbL4FSGmNdPjRUrN/w+OelqXrKWR0aj3ZQ7NR22tq2MvJzUZaczqScwHju5/o9e2ts4UVF9RssRcC9MYCha5PDB5nLT8HCgSuFxb4TRwo2a/evnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1kFLPyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE43C43399;
	Sun, 24 Mar 2024 23:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321668;
	bh=Vql+8js91BRX0rn5qU3meYIvkq3/iZebYzGwS509XTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1kFLPynROeXaia/neLYNhDoRiejoV8FwURaGegVxq+CWtddmSrfg8rZvGajA0DHb
	 mb0B1wycTdOSGLAFUXKnrVyEsugGi/Eyalcrd4UlUSXcVKtDGi7RtJoWDepbCFD3KJ
	 hKXsAzOW36fM7e+V7p7Bt1lJ3VHWG/pFAbNFdo8q9BuKLjrkE+TK4s6//uoPNyzZus
	 sjGTlZdZ35/9XidkW1JZhiNM4Oon8O3ICEDGTMAqEBub1LXdqFjIicE21tZwb6P117
	 Gncq2cOJzNKAxOMoyGcRiFj1b5dfb6y1j0xbkKj00E+Qk02GV8vYpq16xUp6nS86RE
	 EDUc5uu8ovFlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
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
	dri-devel@lists.freedesktop.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 397/638] drivers/ps3: select VIDEO to provide cmdline functions
Date: Sun, 24 Mar 2024 18:57:14 -0400
Message-ID: <20240324230116.1348576-398-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 7edd06233958d9086a9e3eb723a8768d3c5a9ce1 ]

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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240207161322.8073-1-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/ps3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index a44869e5ea70f..1bd1b0b49bc62 100644
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
-- 
2.43.0


