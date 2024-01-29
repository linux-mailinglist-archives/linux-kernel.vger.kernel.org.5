Return-Path: <linux-kernel+bounces-42871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5158407FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52D6288E04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B5D65BAF;
	Mon, 29 Jan 2024 14:16:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07565BA7;
	Mon, 29 Jan 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537775; cv=none; b=szYmyWjnoX6mnH66i78LPa270Z6hho4t2nHRDyyJAQvqUBwwhJTqfrfVhZ5Ux794HmuYQKdwsOWxbGPyskgUKmsaDROCxGMjms3NrnjQS6lT8xlNwEO2yXLweK3w/+wN8NByeZuaEkDM+fpK+GoVvM+pYkXem+vrvCIBucsC53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537775; c=relaxed/simple;
	bh=GrmuLwJa+BiBDhS1HgVuwxQ+fKStrHIgXIe12Tm1gcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IGUz6Yzcx117YTMmdGY/zDTUkqhjqPzkuKE6eYJ0phg6x1Om/EXdc8MMy2FEg7WF/wyMYalOZ5Fv0ShC8Qdvn9R2Qypo01DWsNY0odWPfJ8wSkUAEO2axwBtVwF0c+85skKE/6TfjI4haiWsTSzDQi9IOIt9xCseL3MJBruYbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42891C433C7;
	Mon, 29 Jan 2024 14:16:11 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Cc: loongarch@lists.linux.dev,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Qing Zhang <diasyzhang@tencent.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix earlycon parameter if KASAN enabled
Date: Mon, 29 Jan 2024 22:15:50 +0800
Message-Id: <20240129141550.3284498-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The earlycon parameter is based on fixmap, and fixmap addresses are not
supposed to be shadowed by KASAN. So return the kasan_early_shadow_page
in kasan_mem_to_shadow() if the input address is above FIXADDR_START.
Otherwise earlycon cannot work after kasan_init().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/kasan_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index cc3e81fe0186..c608adc99845 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -44,6 +44,9 @@ void *kasan_mem_to_shadow(const void *addr)
 		unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
 		unsigned long offset = 0;
 
+		if (maddr >= FIXADDR_START)
+			return (void *)(kasan_early_shadow_page);
+
 		maddr &= XRANGE_SHADOW_MASK;
 		switch (xrange) {
 		case XKPRANGE_CC_SEG:
-- 
2.39.3


