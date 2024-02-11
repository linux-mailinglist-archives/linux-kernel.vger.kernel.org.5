Return-Path: <linux-kernel+bounces-60727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41818508F2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693811F21451
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B4B5A7A1;
	Sun, 11 Feb 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="h3rFLLTL"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB705A7A3
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654543; cv=none; b=eK4GROKQ9FqSVdiZbj7Gvgw28StgtkUY6BkmRhdAuY2cpHO/z23cO/M/H9FKSBhhKvtekSNcM7w2uLHQmrcHuB1yPh7+sn2cU2yirRALYUbQmEcyJhSywgq5gG03xiNPDbDYYdZZfUFSkndmT+HgBrqQgY/u7YHKv5f+oCuBOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654543; c=relaxed/simple;
	bh=VDd0p4EgHd0V78fptXuQVp76nhioQUVgvT6c7xK6XB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCfHFpX/v4l8XvPx5HUStVURE13PYgjudvx5ENiFOvl2RrmaS8l25gse02VPrOrizb5pgQF7Abo5t1oxqKsOF3UJk6oIQ6t/FJl2BQGcrJamEwz9Zr4jAriJzNpIIcZ2mh9pC9Wp2EzeyksyLqd7SmWo5UIFwnb2rpCRcgjXx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=h3rFLLTL; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Z8w2rS5yOymFYZ8w2rQ4zQ; Sun, 11 Feb 2024 13:27:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1707654470;
	bh=yjTdCUQsFTSNm5Ev7xNn7axY7MBZ0FtXX9CI5fLO26M=;
	h=From:To:Cc:Subject:Date;
	b=h3rFLLTLkMZjqWbUjtTisjdWyfYwJt1jHDbPkmO9jBbTFmmyaeFXdFUWb20lag9vH
	 xu/FEycccHE+QoLhTHVsj9hX2XySe2SnitNm5vpnpLspP+WIHx3PrwY7VVHYyp90WT
	 hIn8gbrZC3WiPGFvDHj8tw5IWIgjQbTSRW5HqlljriNKdv6M+yBPDXtDnpS7Yb4ahU
	 /xj7tWW/QQHQm66zAIEEPiZfqN3d3frQv3xDsuwutuiYokfWYDxOJT2Ro3T/HBVNwF
	 /fVwANHFr7Vybw9gnJ0tkEt+9iN3K9WONO+r95egNghqhFwPUJICCQRXp1b64N3pK3
	 ph1JfsJ3MSTmQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Feb 2024 13:27:50 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-staging@lists.linux.dev
Subject: [PATCH] staging: axis-fifo: Use sysfs_emit()
Date: Sun, 11 Feb 2024 13:27:10 +0100
Message-ID: <588327734f374b5f5cb5c4d5725d884fdc83663e.1707654406.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_read() is anly called from _show() functions declared by
DEVICE_ATTR_RW().

Using sysfs_emit() is the preferred style and here, it saves a useless
copy and a temporary buffer in the stack.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/axis-fifo/axis-fifo.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 727b956aa231..c51818c56dd2 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -165,14 +165,9 @@ static ssize_t sysfs_read(struct device *dev, char *buf,
 {
 	struct axis_fifo *fifo = dev_get_drvdata(dev);
 	unsigned int read_val;
-	unsigned int len;
-	char tmp[32];
 
 	read_val = ioread32(fifo->base_addr + addr_offset);
-	len =  snprintf(tmp, sizeof(tmp), "0x%x\n", read_val);
-	memcpy(buf, tmp, len);
-
-	return len;
+	return sysfs_emit(buf, "0x%x\n", read_val);
 }
 
 static ssize_t isr_store(struct device *dev, struct device_attribute *attr,
-- 
2.43.0


