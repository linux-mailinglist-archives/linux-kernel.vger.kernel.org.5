Return-Path: <linux-kernel+bounces-147964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152F8A7BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E91C21563
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0453E08;
	Wed, 17 Apr 2024 05:36:14 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC9535C6;
	Wed, 17 Apr 2024 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713332173; cv=none; b=EDw+G1V4XYiLrPD7XuLbOrk62QzsRwESoLafXOMwpu7m8Xj+3F58Iqv2/tlFkYCLKFIemvVbGfzcXWHvepq08f/hoxcfPd2V/X+x/YaA2kpbKbbZ66td8m1AmAqTW4mrQZmeYT+QrR36X8R5vfgTg+fQevLjufaXv8+oJKhM544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713332173; c=relaxed/simple;
	bh=urrmCvOIPOS0nV0snje91j50tQLPGURC4WfmI7kh3dM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SMYKO/ppFsMfM6jk/jSp+sFEmCgqi/7LN612FlkGJbCJv/9qsli7ExtnyqVzC85eBhq/TP+4IJ6TbtqFGAISSop+VPkDaQ9nOcVqKjMe2ecQbu4OXfurU8ebyAJArEt731qR15VJDh6esoH5JfaRqcYFYZYdrAuu+TUG/qY+9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com; spf=pass smtp.mailfrom=lemote.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemote.com
X-QQ-mid: bizesmtpsz2t1713332137te293nj
X-QQ-Originating-IP: FmxYU+kg4mhECz5/Rzj5B/FHJhz+avSUYkMKMOgcLjI=
Received: from localhost.localdomain ( [222.92.8.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Apr 2024 13:35:35 +0800 (CST)
X-QQ-SSF: 01400000000000F0W000000A0000000
X-QQ-FEAT: Kol1Dm0TdrAEiL1/u6rKAX6Y1AKdxPhCDDTahSVjl13MynbO3JPLQyu+r8ma1
	yTHXtqeqDy0h7xUGMHZY3TLEy7iYNeO0GW2yIkBRElSUGSaXcZ+vme5KADEKxn52Y1T2c1O
	vK4TQvZcV7xaDK3H5K6mhFmsrZFdXztRpFpwAX0RyY6v93CdRWZ/57dxz70Uc+7EmeDzvX+
	ihKq+T8f/QRsXE+IjO00bZrQ514gx/IE5ggLjAGRIUwHfaPnfwIySBlxkacLPvlKakZC6Ha
	ikdFGFZi2+4fwMO/YeExeStTjIZhoU+Cwv4u75LPmiiVq2KK6LoeLHMbGaePv0XcVEOjNEQ
	b+oBA+eSY4h7gGh49dPVR5MBUtUb2VaLeyUUJ1oSJfABrRgZXfn+KYzhx1N3EaA6sGtYdIr
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2947310117825408760
From: wangyao@lemote.com
To: mcgrof@kernel.org,
	masahiroy@kernel.org,
	ainux.wang@gmail.com
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yao <wangyao@lemote.com>
Subject: [PATCH] modules: Drop the .export_symbol section from the final modules
Date: Wed, 17 Apr 2024 13:35:30 +0800
Message-Id: <20240417053530.30995-1-wangyao@lemote.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:lemote.com:qybglogicsvrgz:qybglogicsvrgz5a-2

From: Wang Yao <wangyao@lemote.com>

Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
forget drop the .export_symbol section from the final modules.

Signed-off-by: Wang Yao <wangyao@lemote.com>
---
 scripts/module.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index bf5bcf2836d8..89ff01a22634 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -13,6 +13,7 @@ SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
+		*(.export_symbol)
 	}
 
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
-- 
2.27.0


