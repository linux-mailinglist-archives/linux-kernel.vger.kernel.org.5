Return-Path: <linux-kernel+bounces-33191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D2E8365DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFD71F23A75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8AD3D96E;
	Mon, 22 Jan 2024 14:50:52 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587E3D56A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935051; cv=none; b=h72Bxma6i8qD+UFHtmFgpYX/6wBEES7tNn17jKPhLlKRP2zpGoOKbFH0uyVu5vMhsdmJbUZiZSt5OcxxBlya2fJ1s5spwiDXk2v2TaeA0d5SjF/SDyOX5/yVKGqQo4wps++YwD1lhlE0dOaMKXGbt0g72r4wXLWbgdTh0JmjUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935051; c=relaxed/simple;
	bh=1SbxM9qBeJgN6mPKwjnW26SKGE5zOE/i5nXgZr91DWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLhyr/4VINBgZxoeyEs/6zQceu+nVkkj7tVG2XMHcND7Ok5mhaXfauDVuGbD6dZDxXeY7BFmx9nNogwHJmng/e/4Oxj5i/GrR1bMMXC+A24aDV5nIYHa7HbmaY53+ovmevMJskbno96w/pRxVtx94k3PrnnbPlobzQYwFV/Rb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by baptiste.telenet-ops.be with bizsmtp
	id dqqn2B00U0ZxL6o01qqnRw; Mon, 22 Jan 2024 15:50:48 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvcc-00GGyn-Px;
	Mon, 22 Jan 2024 15:50:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvdP-00CFhz-Qm;
	Mon, 22 Jan 2024 15:50:47 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] lib: dhry: use ktime_ms_delta() helper
Date: Mon, 22 Jan 2024 15:50:44 +0100
Message-Id: <bb43c67a7580de6152f5e6eb225071166d33b6e4.1705934853.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705934853.git.geert+renesas@glider.be>
References: <cover.1705934853.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the existing ktime_ms_delta() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/dhry_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dhry_1.c b/lib/dhry_1.c
index 08edbbb19f573ff7..ca6c87232c580954 100644
--- a/lib/dhry_1.c
+++ b/lib/dhry_1.c
@@ -277,7 +277,7 @@ int dhry(int n)
 	dhry_assert_string_eq(Str_1_Loc, "DHRYSTONE PROGRAM, 1'ST STRING");
 	dhry_assert_string_eq(Str_2_Loc, "DHRYSTONE PROGRAM, 2'ND STRING");
 
-	User_Time = ktime_to_ms(ktime_sub(End_Time, Begin_Time));
+	User_Time = ktime_ms_delta(End_Time, Begin_Time);
 
 	kfree(Ptr_Glob);
 	kfree(Next_Ptr_Glob);
-- 
2.34.1


