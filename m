Return-Path: <linux-kernel+bounces-161880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070CE8B52A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755D71F20C73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5710A0B;
	Mon, 29 Apr 2024 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYyPrMq8"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5214A90;
	Mon, 29 Apr 2024 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377111; cv=none; b=pz4iFfAaEnUATbNoxX3jbVA127Eqxetk0hYTsbMms5CIt8e8JEwYOkzFAKZ01XvMMkRitmjj8utNE0z+vRkbkv+Y+71s+ghJpuUuOEpbBpgyrB4icSM4J4uRYjW0LyO224rPRaKzNCYezjiKjSopeY+zbSioLkXXI30jzv4RJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377111; c=relaxed/simple;
	bh=eYP/yKhPTk4xcwsUruZPlGdv8rd/wEe9qbaGyUog6rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Hzp5kR7KcgswYvHqEKaFDmXRr3fGPrf5KWevoPKOVEQRDbnZzZa5ABJg1w3yQ6ZdKPqCrzbYUHr7Rx0lTna9HycCQ/5HxsqHmpOazJ8Bz6iA9rHQt7a85nSQrxKZ7hp77JAqRdIke/7Df4GhoL5h6kC3O/Svw7hQc+Pfv3jKRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYyPrMq8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34d05100927so542818f8f.1;
        Mon, 29 Apr 2024 00:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714377108; x=1714981908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OV1u7iz1PWDb5GaSZ+THHGsU1iE1fOzj0JoX4zD0XiQ=;
        b=mYyPrMq8d/d0O0Fy5PjwKUobAjl5NzGFjQksPsfxBuBgrZbEPEzt/Zl/Fd6cimRIKq
         JVQh8cj1qD0VZ4t38+Z4RHGzmi1viKqQ+9aNiEK43vrSdIrLvMjheIO0FTN7+zkvMLOh
         Qt/QGbcLlQwXSwpl8Zu1bYhz/4ax6yARxRX2iaz4QE3x3iz1d+qVQnd/SfMXgCses728
         ol/k9qv6mOmMZY18bYsvlh6t5fJTYgGCxU5pBwpCMy2G2Xz345ELDy1/YtZt+pHRKqyC
         mZAQJ9OWxrVsaZkkR6Gt7/Bo1liaIAd6fmCKpcOOKlFyP2I+uN5Ty0+IGSIPso9WLPbG
         wazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714377108; x=1714981908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OV1u7iz1PWDb5GaSZ+THHGsU1iE1fOzj0JoX4zD0XiQ=;
        b=iJXvbaKP7NxNUxjnxdltApI5ea0z1fDmU/f9czyvjyEJoAjAN4Wbi+JMqEIcDyXHU3
         m7+4nXZDxLetYUv1dnob/DU5awEcLOc5+6Vu+tymf0mLvIkmi2hNWFT5kryS4GrsYfRb
         9e0GVKrmwCliGTXM+qKNH37RFb8M3FTfdYKDCqLw/QdhTg3bPAJUkN/KPfYtGhxS8f69
         zXTMnq6QBvDxDnSdA6TjeJDg39Itvp8gDQLWMIq5Zvr5KDLwC/LsfzM6df7Gkgm1G5fH
         l/ZDohRJ8Z4ynapSZXQfkX39DRPsxnezolAUfOuEsosh03eKV8soJ+6XA4v+V6eII5So
         7/3w==
X-Forwarded-Encrypted: i=1; AJvYcCWeN3XxnJT8ObtsPugt84fwQ5dnB+6WIP2Nv+lW3izgj1xjLPfPxgRc2xCEHVXEUCjj4XNdUD7OFZvFOZAwGRI5R5Xoi+MEzDdz5PvSkCalPZ6T7TtqbtMXOHhXppwiqw8D/wfpdMKe7bo=
X-Gm-Message-State: AOJu0Yzipt6eeOtgWXowvLYfVDeBcBor0dCv3YyktTy+13NFoavq3opo
	4oBSc/7FOnAB6F3nW2Ai1g+rL7pbxSXnZWfnjPqvKJd0wf7fvJ8w
X-Google-Smtp-Source: AGHT+IH11dIw7Z/1uzLHUqzGAesECRoyaRjhwayeyJXoR2GMh2LzrblIOO3vP8j/BApimDpMRqJTtA==
X-Received: by 2002:a05:6000:1ac9:b0:34c:fa08:7917 with SMTP id i9-20020a0560001ac900b0034cfa087917mr2718925wry.49.1714377107990;
        Mon, 29 Apr 2024 00:51:47 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe2c4000000b0034a3a0a753asm27165212wrj.100.2024.04.29.00.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:51:47 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: atomisp: Fix spelling mistake "pipline" -> "pipeline"
Date: Mon, 29 Apr 2024 08:51:46 +0100
Message-Id: <20240429075146.1073869-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index effc71b5a439..d7e8a9871522 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -894,7 +894,7 @@ int atomisp_start_streaming(struct vb2_queue *vq, unsigned int count)
 	ret = __media_pipeline_start(&asd->video_out.vdev.entity.pads[0], &asd->video_out.pipe);
 	mutex_unlock(&isp->media_dev.graph_mutex);
 	if (ret) {
-		dev_err(isp->dev, "Error starting mc pipline: %d\n", ret);
+		dev_err(isp->dev, "Error starting mc pipeline: %d\n", ret);
 		goto out_unlock;
 	}
 
-- 
2.39.2


