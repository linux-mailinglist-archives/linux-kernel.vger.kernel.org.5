Return-Path: <linux-kernel+bounces-20846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C3682861D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C028BB23D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F55381BB;
	Tue,  9 Jan 2024 12:37:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7B26AF7;
	Tue,  9 Jan 2024 12:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150A1C433F1;
	Tue,  9 Jan 2024 12:37:40 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add a missing call to efi_esrt_init()
Date: Tue,  9 Jan 2024 20:37:31 +0800
Message-Id: <20240109123731.3964440-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ESRT (EFI System Resource Table) is needed for UEFI's "Capsule Update"
feature. But ESRT initialization is missing on LoongArch now, so add a
call to efi_esrt_init() at the end of efi_init().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index acb5d3385675..000825406c1f 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -140,4 +140,6 @@ void __init efi_init(void)
 
 		early_memunmap(tbl, sizeof(*tbl));
 	}
+
+	efi_esrt_init();
 }
-- 
2.39.3


