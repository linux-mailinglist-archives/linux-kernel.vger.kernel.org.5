Return-Path: <linux-kernel+bounces-109141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA807881533
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EEC28517D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B5854736;
	Wed, 20 Mar 2024 16:05:46 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABE54744;
	Wed, 20 Mar 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950745; cv=none; b=nGiGsVOiqAIf/Z+KDJ5Q/JDbR8as+zpR8oajtaFI8zPSl97ZXGVa0GiPL//UMC3dEYaxn2nAbVkhrjyFmxJVEbVXO+PB0jV/LU9ICG13CVqbe/7OkbdCxqzAG4kDnL805ptlKJYiRZLKUxDtLkE8r+vcRiBF5h/kxBHbeOVfR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950745; c=relaxed/simple;
	bh=/IfiUa26qG6YiQu8AKOCfYA2x46Rjq20kX1gZ1TFB8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHaofabC8q3N7D7OP+ZRkWuKL6Wy5y5TbWuV8M1nmO2Sx01k2MkoUO73VAcWkZURya4r38jr6Ljbi/TqV5x1vo9dda1Q0HqSx3dxJe7+Oui6dVVokID/fnYv5Zwoe5eVjEqQCzXCrxUhO0I2VzjRxIFCr7xxHcacD0Lt7OYH1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V0D1W2jdvz1vxBr;
	Thu, 21 Mar 2024 00:04:31 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id B91A41A0172;
	Thu, 21 Mar 2024 00:05:17 +0800 (CST)
Received: from huawei.com (10.67.189.167) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 21 Mar
 2024 00:05:17 +0800
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To: <linux@armlinux.org.uk>, <linus.walleij@linaro.org>, <arnd@arndb.de>,
	<keescook@chromium.org>, <rmk+kernel@armlinux.org.uk>,
	<haibo.li@mediatek.com>, <angelogioacchino.delregno@collabora.com>,
	<amergnat@baylibre.com>, <xiaojiangfeng@huawei.com>
CC: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<douzhaolei@huawei.com>, <gustavoars@kernel.org>, <jpoimboe@kernel.org>,
	<kepler.chenxin@huawei.com>, <kirill.shutemov@linux.intel.com>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
	<nixiaoming@huawei.com>, <peterz@infradead.org>, <wangbing6@huawei.com>,
	<wangfangpeng1@huawei.com>, <jannh@google.com>, <willy@infradead.org>,
	<David.Laight@ACULAB.COM>
Subject: [PATCH v3] ARM: unwind: improve unwinders for noreturn case
Date: Wed, 20 Mar 2024 23:41:34 +0800
Message-ID: <1710949294-29287-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)

This is an off-by-one bug which is common in unwinders,
due to the fact that the address on the stack points
to the return address rather than the call address.

So, for example, when the last instruction of a function
is a function call (e.g., to a noreturn function), it can
cause the unwinder to incorrectly try to unwind from
the function after the callee.

foo:
..
    bl      bar
.. end of function and thus next function ...

which results in LR pointing into the next function.

Fixed this by subtracting 1 from frmae->pc in the call frame
like ORC on x86 does.

Refer to the unwind_next_frame function in the unwind_orc.c

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lkml.kernel.org/lkml/20240305175846.qnyiru7uaa7itqba@treble/
Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Link: https://lkml.kernel.org/lkml/Zeg8wRYFemMjcCxG@shell.armlinux.org.uk/
Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
ChangeLog v1->v2
- stay printk("%s...", loglvl, ...)
ChangeLog v2->v3
- Redundant code is deleted to simplify the code
---
 arch/arm/kernel/unwind.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 9d21921..abfa8e9 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -514,6 +514,14 @@ int unwind_frame(struct stackframe *frame)
 	frame->sp = ctrl.vrs[SP];
 	frame->lr = ctrl.vrs[LR];
 	frame->pc = ctrl.vrs[PC];
+	/*
+	 * When the last instruction of a function is a function call
+	 * (e.g., to a noreturn function), it can cause the unwinder
+	 * incorrectly try to unwind from the function after the callee,
+	 * fixed this by subtracting 1 from frame->pc in the call frame
+	 * like ORC on x86 does.
+	 */
+	frame->pc = frame->pc - 1;
 	frame->lr_addr = ctrl.lr_addr;
 
 	return URC_OK;
-- 
1.8.5.6


