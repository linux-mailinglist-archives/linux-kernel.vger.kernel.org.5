Return-Path: <linux-kernel+bounces-22600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E794082A03F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024291C223C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C91B4D588;
	Wed, 10 Jan 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNDUzxFh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC54D581
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wab.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ecfd153ccfso78582107b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704911339; x=1705516139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YkL9+IaZL1qRobXKY78NwRR56bxY1pr5+2dRgzIbPA4=;
        b=jNDUzxFhZWTk/jcp6T+IAmwoMV+1SO2xjdp49QMgmlMZSBtwvJMDqPargS2a1EhLIa
         NX1QvVZC7C+BQg9XNjfgc7nB4Rv7y6vBrHeTeyTtapf+bxzFIMu5FYkRrPBQkrFcDujT
         178Q3wlxy81ZKkSv/MQBC75aTu0nNoy8QlTRlwbp35KwvK5CSfXptJLndaMYNomINnJV
         sv4RsEyTDW8vSFeahat6rd7c00JOzF9yW5t8zHd5dD79uH8XD/xtNiymkekpL19dlVg0
         UHOVyyFzm3/8XwBM4pHXCml3tPT+pZJrRFPUVQ9Spk3JPq/yiPIRUr7jYJXf8y5vYEmz
         wbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911339; x=1705516139;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkL9+IaZL1qRobXKY78NwRR56bxY1pr5+2dRgzIbPA4=;
        b=mh0UQAQkUDO4bNhBJhC+tJ9TnFEN/WivJdTQ0jJO5sKs04x8wTRQJKymScQj9ZyCpQ
         yBK5cAvKfU+dxUAYR9ivhfc1SNeQ3C5idw+PGoMwoZwDW6bYIsbhCl/NFwIy22zUdoUs
         JAxfK+/2BOmzr6uzPhm87tKWq7TuICQu5ouwnB5xiTVg+//CHlcVYll/ko5uKd583ZYu
         7pE8jhagAV2SHW34yzeT1eimt7sKyHbdAq5SO6o3JxH7lQ7HuXJEFdffBNImSlEfRA2O
         ZPHpFynA+jY8vq3RwrjXEnP853X3MCemavsB4WdDKUBmZZq4I+7OkEbcu7s/9qHBtD0/
         ig6g==
X-Gm-Message-State: AOJu0YzFPB70biDVB8TMCJoo1hxv360Ge2THfRJR5mVlVU+lC9DzaS/s
	dxaNvCXasIjMMe26h3JzFRBlDGLvhEK3Cg==
X-Google-Smtp-Source: AGHT+IH7cJZ/Hw+qJqoWaeA9yPVQRmrmWDFe1fyYKiD6ai5Gl7Cxo52TcYX6lpZB4QluW9Rx00HI6z8=
X-Received: from willb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:491])
 (user=wab job=sendgmr) by 2002:a0d:e4c5:0:b0:5f8:b9b8:aa0a with SMTP id
 n188-20020a0de4c5000000b005f8b9b8aa0amr23354ywe.2.1704911339353; Wed, 10 Jan
 2024 10:28:59 -0800 (PST)
Date: Wed, 10 Jan 2024 18:28:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110182855.1833512-1-wab@google.com>
Subject: [PATCH] nvme: Inform controller of doorbell config before unquiescing
 IO queues
From: William Butler <wab@google.com>
To: Keith Busch <kbusch@kernel.org>, Pavel Emelyanov <xemul@openvz.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, William Butler <wab@google.com>
Content-Type: text/plain; charset="UTF-8"

During resets, if queues are unquiesced first, then the host can submit
IOs to the controller using shadow doorbell logic but the controller
won't be aware. This can lead to necessary MMIO doorbells from being
not issued, causing requests to be delayed and timed-out.

Signed-off-by: William Butler <wab@google.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 61af7ff1a9d6..f87c51a946b3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2743,10 +2743,10 @@ static void nvme_reset_work(struct work_struct *work)
 	 * controller around but remove all namespaces.
 	 */
 	if (dev->online_queues > 1) {
+		nvme_dbbuf_set(dev);
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
 		nvme_pci_update_nr_queues(dev);
-		nvme_dbbuf_set(dev);
 		nvme_unfreeze(&dev->ctrl);
 	} else {
 		dev_warn(dev->ctrl.device, "IO queues lost\n");
-- 
2.43.0.275.g3460e3d667-goog


