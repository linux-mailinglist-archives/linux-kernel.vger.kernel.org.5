Return-Path: <linux-kernel+bounces-128946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32517896225
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3371F263B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B9168DA;
	Wed,  3 Apr 2024 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXBiZEVr"
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A512B77
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108461; cv=none; b=shgFXDphp4/xPwrFylFuF50aUldCxD0gmOI3X+lAMwKd9FSfnx2/JUIkv/WglBF37jaonic683uxzyqxyzNtkgsDUZ+fhvES7Q17oCki9IQ/4DcJxhTAxkpQo5vbmDodbRRzeuIZe0Ro602cCOCZAE8oIApkSoqQc7CuatBq4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108461; c=relaxed/simple;
	bh=DlqBVWt3lP12rhuKBJ1TmaVN0gaUo8h2eVmdTwB7+F4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hitw1xEk4pODdgynk0+RnefaURkX15g1Go7e5ys86TZAnTkNaAcMbhQzSPPNVk2yNThfLWHj5f/aiezlDflgKwX1S9o3J+i97m8iGkZDqf+XIsqAoSB5wP46FDVQmE8CQm2rz6ja9loBwiQQg2MRTzmoIepnINWEP9PfxQ+Tm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXBiZEVr; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-22e78e78ccdso569789fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 18:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712108459; x=1712713259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmNCu6e/IBdkkRsftu1sagLOcJIjx7WFA2lOLADZPiI=;
        b=LXBiZEVravKJcHN1dhKMVmCBOWmhlQjQqY02DpWTqK/fEkawMmZiWYF1y+hba5ESv/
         r+aIa6TQKfzgpqXaENV1tNuOMi94M6o/LL+uaDsr6MHMNnneSF/KcqywYa5ZFz9aJfD0
         8VyP6cgULb5YUaeMNRUSGGvWwDxXIfctE14Vx+x1pmPps7uciu/jg7aiCEZZPofpVBfc
         aTYkY7okXu6ouu2RTCI6P5+kUFsShW4zk4tygPIdiskV+LqvfJMJs5VmW5NkQfGWVSSI
         akTs0PWxFuRIZG6b5yVJy6NXRRe010tGFYjKcvetEi6v8u8TZsn117KGLmKZP9FGv1bU
         EHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712108459; x=1712713259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmNCu6e/IBdkkRsftu1sagLOcJIjx7WFA2lOLADZPiI=;
        b=n/rE7gs7oJegv1VReLMWEJp8HraRxLfynAklN7myV/JlG4iK1DIX5fru4jBrwqJslW
         S1BKB1PiIZN2FiGA9M4NDry+U0nzYi9TUZcOLe8U2npiN8n+GNy+3iHDoa2efneuoVfT
         NvwTf85yEs/lDkyT5wQjaHTIo0p9g7LBDuAy0afPZVniVsWM+rWcbKLLS/jSkBO1YR7J
         j6ugUEoFnNmp2mVo3y5Lj/fe+aOrtuSz8HpiHlJkxIllhK5b/VFB3Aa8r+ENs8m3/vN9
         DVyJJEXIB/xhoSXDbUYaDYzUUSZBrnnav+O3xlSlZ9FAaMzQ5HYWSSYNbt9oisElB6uQ
         QY2g==
X-Gm-Message-State: AOJu0Yy9TJ4GZrHrjzkBhjkjqgX1CWPkieeTAR6So0ADvAIIpwtFn5Sk
	iW9KGum6NCX0AYteNWZCHUQnyYNcBE7RTDo5l4PTWy9JX8mv8cCx4qXolEZZPShF3WsrGsI=
X-Google-Smtp-Source: AGHT+IE9IRCE1miKUNBiAKoQarUEuPd6UJXkyu3lV4uHJcwPKjuN9yWZC5+G5liwphZLtFq6OUBIDA==
X-Received: by 2002:a05:6870:2317:b0:222:b434:d388 with SMTP id w23-20020a056870231700b00222b434d388mr16208128oao.39.1712108458783;
        Tue, 02 Apr 2024 18:40:58 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id j3-20020a62b603000000b006e56bf07483sm10546993pff.77.2024.04.02.18.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:40:58 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: sudipm.mukherjee@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH] ppdev: Add an error check in register_device
Date: Wed,  3 Apr 2024 09:40:51 +0800
Message-Id: <20240403014051.969619-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In register_device, the return value of ida_simple_get is unchecked, 
in witch ida_simple_get will use an invalid index value.

To address this issue, index should be checked after ida_simple_get. When
the index value is abnormal, a warning message should be printed and the
value should be recorded, then jump to 'err'.

Fixes: 9a69645dde11 ("ppdev: fix registering same device name")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
 drivers/char/ppdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 4c188e9e477c..5d688059884d 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -300,6 +300,12 @@ static int register_device(int minor, struct pp_struct *pp)
 	}
 
 	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
+	if (index < 0) {
+		pr_warn("%s: failed to get index!\n", name);
+		rc = index;
+		goto err;
+	}
+
 	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
 	ppdev_cb.irq_func = pp_irq;
 	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
-- 
2.34.1


