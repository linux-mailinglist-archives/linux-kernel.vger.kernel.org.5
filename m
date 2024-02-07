Return-Path: <linux-kernel+bounces-55900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB984C32C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CDD1F287DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080610A08;
	Wed,  7 Feb 2024 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3pF+Ll86"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4110949
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277070; cv=none; b=cbE443m1MPRPJiyUzSwsL2GdLTzi30ZNDC1sQC8HYeCGnsV6DssZ/fXBMG7D6lfSPQmUAzwD1WvDwFnCxzrkKwkLSVVidDhGvmS2BpM0gTncxasi7sbqjD0aPZqFpbwGHpb7A2aJHDoFSFH9GudBX048RrsB3bygeYKtsw/gwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277070; c=relaxed/simple;
	bh=SJW0eAfF0ycUGsvIG/nkGrfxSElHHASfpWsfKHgu6Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=st2GLeTQGFtJHm3wUNXowYRnGah0PSua/2clwYwt5jBHOxOceZ7iRxbR2AVYu8ZhEGfBC2tQtzTn0Cg1m/cCRq6W+zPKJEyADubkSa64pBHgbD09jwm0D7jxtD2PDqbtLgbnHj5ft60sB6YoPBf701XBt+92O1e8Nlu06u7mijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3pF+Ll86; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1V+vgE1bWgSihvPKS2sLFdir+8amFigQuNO048cKiKk=; b=3pF+Ll86oxsOYLgGR66uKpNRjm
	3IOt8cHKIsc4d6zt5jQxiZwFWFTTSolfW4tQJ/A9JZlmCyPwi4dhx5vogW33TTOr0Nj26yuN0Xsa1
	OgbiYtCXCFQk//r9uVASMPIPWT53d7WbpjEPUdu96uq2hsyAKJyWnJ7mZDBUJSoQFbjKo/U7P/JJK
	HWvYX7kxDS3yES4kEx+1Pkx5ddInlaVww46RSmmpgW4MSN5Oa9vDbrAkFzJqdj+K1hcya7BxQFrKv
	iFnD6821Xoja+aXeTMLAe0EvDz3s5L60GdJgaMXvddgABdqZz4d/AmP0nMXOVAgEOcNpBgfSIT6NJ
	Y9WMEFkw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXYkt-00000009Zqt-0IUX;
	Wed, 07 Feb 2024 03:37:47 +0000
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
	Geoff Levand <geoff@infradead.org>
Subject: [PATCH] drivers/ps3: select VIDEO to provide cmdline functions
Date: Tue,  6 Feb 2024 19:37:44 -0800
Message-ID: <20240207033744.13028-1-rdunlap@infradead.org>
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
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Geoff Levand <geoff@infradead.org>
---
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

