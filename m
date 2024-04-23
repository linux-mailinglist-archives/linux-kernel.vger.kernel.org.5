Return-Path: <linux-kernel+bounces-155387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5672C8AE9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880121C235AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2F684E02;
	Tue, 23 Apr 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhJMRiDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F845C0C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883275; cv=none; b=r5Ts9tL4NaT2BcBDMLq4To4zxCkXDzjpvVrkbT7Sn3PyoWWwLz4gS1nSnHq4mWJ4AM3y1BI76WQzylbpX6nwCSkF8iruPfCQBXzFVSzW7o3LAp+jNieoP+kzDghpTgWbKpL/XFOhbPu/Zgg52BceDx7qLjV+DCbZYTsv48PvlCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883275; c=relaxed/simple;
	bh=f3l1B1ROT5WgMnyYTGNqcQT1a+Nd3onAdjpdJ5GT0Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5vJeULURn7wxyjwxoNCOrX3kWW2djUlV/roxmxLrIFC9I6UePKwzCcoTBkVHRoy8OcQ7VqNUfkeFZitf1XrC38RvECDM7kE/Y3blP0YOh/jYirj6jX5cb5sJha1E0LNQIF2skYO0eumQWXMijRYkb4GDnXkNWnTaNg56i1qgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhJMRiDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077FBC116B1;
	Tue, 23 Apr 2024 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713883274;
	bh=f3l1B1ROT5WgMnyYTGNqcQT1a+Nd3onAdjpdJ5GT0Ng=;
	h=From:To:Cc:Subject:Date:From;
	b=LhJMRiDuh+sbo9IavZcA+cpSO3Fgra4A8UZX5RLvj/IlmhhvkfE2hwRYZ5Xqoaky7
	 iGEF9qnjhELIK3tKyexC/v9O057zFuKyKzbC3cTmjGVnHpxlfcyAnElp0levQ3vegk
	 pR1f8tbDmhRbWY2CbuqD5EUxHNiiZGSDXfaplVGM3VScSaVOxM3Om7ZLq6qf3FsM5a
	 p+TU7FG2pZHt+eNHWj+CJtQVyMOjEgGYdhxGXcLmBcNFxQ1+pQucMPzFSYQSBO47yf
	 QwU1WLm1MLZveDDOO8qBsvomzWzpPlCFzKuF7tLXnCQA7jPuSirGW6WYiahdK047/k
	 37a4ZWDnja37g==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Wenkuan Wang <Wenkuan.Wang@amd.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/CPU/AMD: Add models 0x10-0x1f to the Zen5 range
Date: Tue, 23 Apr 2024 16:41:11 +0200
Message-ID: <20240423144111.1362-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenkuan Wang <Wenkuan.Wang@amd.com>

Add some more Zen5 models.

Fixes: 3e4147f33f8b ("x86/CPU/AMD: Add X86_FEATURE_ZEN5")
Signed-off-by: Wenkuan Wang <Wenkuan.Wang@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index cb9eece55904..307302af0aee 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -459,8 +459,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 
 	case 0x1a:
 		switch (c->x86_model) {
-		case 0x00 ... 0x0f:
-		case 0x20 ... 0x2f:
+		case 0x00 ... 0x2f:
 		case 0x40 ... 0x4f:
 		case 0x70 ... 0x7f:
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
-- 
2.43.0


