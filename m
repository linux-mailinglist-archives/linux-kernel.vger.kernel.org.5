Return-Path: <linux-kernel+bounces-38042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F2683BA28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46F828CCFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894C18039;
	Thu, 25 Jan 2024 06:33:19 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3A2FD17BB3;
	Thu, 25 Jan 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164398; cv=none; b=DbX52M6tRUjYXpWOZX3D/3Q0ApDJ0GQXyeHyd3+2qDvJfrIaPewbDSxzY75N8V7dsyJyeUy83VIIRlLu2ottPI7TYh/G+uenNVvw3fuFXPRgFb/lrXBdKRx2cwNWqRK53RP4e9twlw92Wf40QXeGUYxyvtuBU1dk6DCAQnDxm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164398; c=relaxed/simple;
	bh=O3xIRxDbYOxVI2Z7tBOKEYs1HYeab7mX97qcSE25kmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eg20hW0S2VrcO13ZgPDc/BwUX6be5LG6nneRv55709CKm4pp5B41A4seLvoZM5wn7+xgyrenpNk7GVk1W6gE7NBeXxC8K7qDeLPAR+UgDQIzq4kaPimmNkuyjXIsGkImUo7l0qznIRnR9XEeGpH4+jaEBBL+ZzHC881u4IBDsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id A13DF6082FC27;
	Thu, 25 Jan 2024 14:32:40 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	mail@karthek.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] HID: hidraw: fix a problem of memory leak in hidraw_release()
Date: Thu, 25 Jan 2024 14:32:26 +0800
Message-Id: <20240125063225.2796234-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct hidraw_list' is a circular queue whose head can be smaller than
tail. Using 'list->tail != list->head' to release all memory that should
be released.

Fixes: a5623a203cff ("HID: hidraw: fix memory leak in hidraw_release()")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/hid/hidraw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 13c8dd8cd350..2bc762d31ac7 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -357,8 +357,11 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	down_write(&minors_rwsem);
 
 	spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
-	for (int i = list->tail; i < list->head; i++)
-		kfree(list->buffer[i].value);
+	while (list->tail != list->head) {
+		kfree(list->buffer[list->tail].value);
+		list->buffer[list->tail].value = NULL;
+		list->tail = (list->tail + 1) & (HIDRAW_BUFFER_SIZE - 1);
+	}
 	list_del(&list->node);
 	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
 	kfree(list);
-- 
2.30.2


