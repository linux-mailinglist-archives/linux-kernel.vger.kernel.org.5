Return-Path: <linux-kernel+bounces-114593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFF888B39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8C21C28E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597529E1A6;
	Sun, 24 Mar 2024 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnAN5v8d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52714C5A6;
	Sun, 24 Mar 2024 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322244; cv=none; b=TQMwr7hFqLS1biIAKrBjMH8gtkQn0NBCM+KwERp6y5yw0pMj18RCbrmFfE6wTNUXx42wuyxuHd3m6O/syjkcXDbACDSiyaFJTJL3WYp5T7pl+miPd0KOWetQz6RmYIzr5FGiQPMLbf3TthfrVsElpW5cIUqAV8v6eMk/FWFJJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322244; c=relaxed/simple;
	bh=zIzrS9FnuADVM5W+mS2X8Ece0Bn7nG81SCezXMUw+EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GklhXPoCHo7o1A2XSPvUrz3YjPnHeD0GNi//WOrjwfjnNHZ6n1BbuM+4ot7B40auASSJM8tRtDdEg2Pc/MQEnw0X1c24+TWML2zKDn7BVBI+628UUCk4clGzq0qdfdTjpXnC9Z4uC4mYH/dvRjs8EpRqcqJ7CXItMVKbGCuU2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnAN5v8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F17AC43394;
	Sun, 24 Mar 2024 23:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322242;
	bh=zIzrS9FnuADVM5W+mS2X8Ece0Bn7nG81SCezXMUw+EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnAN5v8ddCCs+7tYKjGK6/NDTPdt36jaRKAUGkWrdwlkgMeUh8JipiyRflaK3gjUH
	 dFsP7wSuDBCXwaFoP4xW07K9e3C3kaBCS2NggfKBDrNtUkoC1JolQTQGEuarVOc4LO
	 0hGz5RObEH7WKHRzw6NHCvGq208qOgkhmg1mHM2/gLEAL6iGwTMDcaCIQkCooIVY47
	 XwYQXishJrq5AtaQ7ABMKg/yfDPgXPx8MPRCUTIxdowUxvQMGBpjb/GSB/4jC/eDK2
	 w45hC4REFumgrehwCK+wozRm5uhAqLDoxKDotrNMWvyVyvHPM70ZPpTdmhfo/Mzuqb
	 9AeANEI5FpzZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+ce750e124675d4599449@syzkaller.appspotmail.com,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 324/451] media: pvrusb2: fix uaf in pvr2_context_set_notify
Date: Sun, 24 Mar 2024 19:10:00 -0400
Message-ID: <20240324231207.1351418-325-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 0a0b79ea55de8514e1750884e5fec77f9fdd01ee ]

[Syzbot reported]
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
Read of size 4 at addr ffff888113aeb0d8 by task kworker/1:1/26

CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.8.0-rc1-syzkaller-00046-gf1a27f081c1f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
 pvr2_context_notify drivers/media/usb/pvrusb2/pvrusb2-context.c:95 [inline]
 pvr2_context_disconnect+0x94/0xb0 drivers/media/usb/pvrusb2/pvrusb2-context.c:272

Freed by task 906:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
kasan_save_track+0x14/0x30 mm/kasan/common.c:68
kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
poison_slab_object mm/kasan/common.c:241 [inline]
__kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
kasan_slab_free include/linux/kasan.h:184 [inline]
slab_free_hook mm/slub.c:2121 [inline]
slab_free mm/slub.c:4299 [inline]
kfree+0x105/0x340 mm/slub.c:4409
pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
pvr2_context_thread_func+0x69d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:158

[Analyze]
Task A set disconnect_flag = !0, which resulted in Task B's condition being met
and releasing mp, leading to this issue.

[Fix]
Place the disconnect_flag assignment operation after all code in pvr2_context_disconnect()
to avoid this issue.

Reported-and-tested-by: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com
Fixes: e5be15c63804 ("V4L/DVB (7711): pvrusb2: Fix race on module unload")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 58f2f3ff10ee2..73c95ba2328a4 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -267,9 +267,9 @@ static void pvr2_context_exit(struct pvr2_context *mp)
 void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
-	mp->disconnect_flag = !0;
 	if (!pvr2_context_shutok())
 		pvr2_context_notify(mp);
+	mp->disconnect_flag = !0;
 }
 
 
-- 
2.43.0


