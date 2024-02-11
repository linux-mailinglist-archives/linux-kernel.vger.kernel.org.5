Return-Path: <linux-kernel+bounces-60826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3A8509F1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02241F21099
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989145D475;
	Sun, 11 Feb 2024 15:09:47 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F75D46D
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664187; cv=none; b=lhIjVEVh+ZGBWof9WadLZu7v7AqN6AYxW+v9t963EMQmdgFP0nWAxZKjjJlI3kbowygHGBc60HAFSIPbQtBiUbkTV8Y2b2RQZsOYu/o8EgjSyneE3XTqIF8JD7BPmnjXah2HEFyCCqbpxdQof8K5lJqsr7MNM7QkkMdLLhLfp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664187; c=relaxed/simple;
	bh=oM+ZoyIjXDNRxwrDc/pX5Se6omq6E/r+S5nA28fWjWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Goon192eMW4T7kuPCZ3nlBOSiTXo/aWqbOx2JsGqooB9KWe04DYiX+u8wBXfcCrRYZfbmLbGeECkwi0xN8M3fLEP8I3wJyhBNg/Bq/QYA09DXT4NIyBb4e646QVZkjvlpmOV/4XtUSBY2Vkqn007qBH+LmprJ0iqCZj+ozlP02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Vinod Koul <vkoul@kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] soundwire: fix double free of pointer
Date: Sun, 11 Feb 2024 07:09:37 -0800
Message-ID: <20240211150937.4058-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

If sdw_ml_sync_bank_switch() returns error not on the first iteration,
it leads to freeing prevously freed memory. So, set the pointer to NULL
after each successful bank switch.

Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/soundwire/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 304ff2ee7d75..d650e6f0f8e7 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -833,6 +833,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 				"multi link bank switch failed: %d\n", ret);
 			goto error;
 		}
+		bus->defer_msg.msg = NULL;
 
 		if (multi_link)
 			mutex_unlock(&bus->msg_lock);
-- 
2.25.1


