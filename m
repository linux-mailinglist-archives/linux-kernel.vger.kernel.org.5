Return-Path: <linux-kernel+bounces-50347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DFE8477CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE9E1F2316D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0531153BFF;
	Fri,  2 Feb 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfunN7eV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320F152DF4;
	Fri,  2 Feb 2024 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899175; cv=none; b=Ih/yB/6rURG9uMD8ji6oaSaZ/YH6LZyXHWgrhi4sUufYH3J7kKtjmsvHIiwaDnNx5sjIlNVlAfFP1al1kZYM/ZI4hrroSUkfSbcUuPQUcrk9y3ZdvkbKlLGjtBqmow8UA+VHyPym8dqaRBAk2plJojeuXxpGukaagMUwV2uUtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899175; c=relaxed/simple;
	bh=94HCRGsnQQo8/820OUGWhKe+XapvGFDqMm0ejMc7aoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WN3apilRj8HuCoAK8EQB3SwODcT/YXE8iHSoArMPDt4qcmwGL0Y/gP/+7CJS3GGoXhnkPds2mEdfds59QmPV69hVvwqPixDED4Qlx1IuNoG2hnMq3Qs/laliNhUrFUanpkPf/O1RmQ470oQi5D+VlRQe6QuNbKhgf2XIL9VovHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfunN7eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE57C43394;
	Fri,  2 Feb 2024 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899174;
	bh=94HCRGsnQQo8/820OUGWhKe+XapvGFDqMm0ejMc7aoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfunN7eV6jTw1ekJnV7FWnm8Us1v6bjjr0SACuzMw1hC2LHLfcRZREMOKBXCYVge0
	 uFAmyd7f2C0ZlaIfdrtJXYnqE9s7OnE9e/fJKC3cAEn2KX+skd2Do79ARBpx0Bp3oR
	 ci62WGwpMztjs6/RxXJispjt2Y5ujTCIeoca0XEoPU7gqdab0MQX2U4GKLRN3aPF0v
	 Xlwd0tg5xsJNmDLxPv6YPvtw7nJ32Ba0lgj3AxesR4s6U6jZDLetP1zwcE6qXWYt5F
	 pks7kxkJl5RUsnT8aEwnhXrRqqczTilqafVtxgcJapjqiACX1fIDhn7doS7yU6Mh2R
	 IWiKs8WHhqpHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fullway Wang <fullwaywang@outlook.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	tzimmermann@suse.de,
	sam@ravnborg.org,
	javierm@redhat.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 04/23] fbdev: sis: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:39:00 -0500
Message-ID: <20240202183926.540467-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Fullway Wang <fullwaywang@outlook.com>

[ Upstream commit e421946be7d9bf545147bea8419ef8239cb7ca52 ]

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of pixclock,
it may cause divide-by-zero error.

In sisfb_check_var(), var->pixclock is used as a divisor to caculate
drate before it is checked against zero. Fix this by checking it
at the beginning.

This is similar to CVE-2022-3061 in i740fb which was fixed by
commit 15cf0b8.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sis/sis_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 6ad47b6b6004..431b1a138c11 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1475,6 +1475,8 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	vtotal = var->upper_margin + var->lower_margin + var->vsync_len;
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = var->pixclock;
 
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
-- 
2.43.0


