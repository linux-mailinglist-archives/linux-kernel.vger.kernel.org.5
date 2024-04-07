Return-Path: <linux-kernel+bounces-134502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0BB89B246
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B331F21162
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30103AC10;
	Sun,  7 Apr 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLRTQknE"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9453838F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712496185; cv=none; b=RNqpg1EQaDaNpeYWAS5tCJsPyg8lVuSqSks7lq2bJVEeVier+7XFW4MgPT2//rf7N6AavQy9upB/Fjma0LdrxUUf2ze7GTlbBzyh5uew9L4lR1PRA9tX1aCuCknzDN5rUgze5EQiS0PWFqQx+MymwLOkpS0ZOusrRqXJlh3k2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712496185; c=relaxed/simple;
	bh=T6OMxDGBj6shnRpK6I/E3tiSw+Kcv040bGQQxvrkfCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LEgG+z+kFEsvK5YjTKgVv6tjSGGlt/5b3LnZaZv69wiPsMwuLme2Lzdj4g9W5z+9fxKlC5oEce0fArEsq5NVmH1h5bO5ot27yKv3ocxms4IezVlV+yESo53DMvVUZkTeF2MvYx/UeFy5jo2iW8yrGhD1x+ceAlUvpjzgzeRd/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLRTQknE; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1e411e339b8so1639405ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712496183; x=1713100983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1eplB7rHSkoFmDqIIBpZQgckLsHN14+8+C+N4HT8iAs=;
        b=TLRTQknEI/2ed/IFVHxbkrVvkrLRFVb//sjEjJY6olffIkXIYKvAT6K47kQVN0qLoi
         N1bEgioqP171wJLx+qtScoIuy9VgfidtqTlbmDMhdp69WXuqXZB58GeDmze357eanQT5
         /tPhFK8IHFoepOgWEh9A17T7vjVda5rarOnUaOpeG3UzPqUI0G4hDRh4byhCCKI7DJYC
         cHNCpXrT+JuGRHQeaKfLDAcg6kDmCrS1o5WfJrzARcZKjm+xiP2n70+C5PUV57tS21xT
         XIRABGoiQFJrc++UfKqneanevsNIEIm42QXLAAQ+bSfqnTxgouEUCS3a3W6PBSI7sFie
         JL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712496183; x=1713100983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eplB7rHSkoFmDqIIBpZQgckLsHN14+8+C+N4HT8iAs=;
        b=uXqUU9nw1Rqf8kYWk5b4albBs7/PGnHaEx2MfyGe6B4NPrucP0TAhWVbh3X0m4vkX1
         o9g4AJZt9fKsxFxlpFOtjjwfF2mXMUtNXqr3MfYaJM3FZo5aNFyeTDhkD7gp9ThRXaq0
         2kjjWbmtJWzcURm6k6gGdcXuVTcK1OkN/Jlhy9MIl5cCEr0SDRjeAAnK2J4VKQ7VNLm5
         ABl83llsbPj2IlMUOeS+0th84HKGNJW8MM/cuxUMOuk9FIfO2UIISLluWHmwPvI78agH
         e9BpzpVcIBQcpMtkOFDt09BQ2Uza0SHo1kJfFajmZscN9SfT6Y2lFqgjAXkmIz8kABwn
         ysCQ==
X-Gm-Message-State: AOJu0YwCbyobzWSTM5aQwNr6dPyva9k55ikxJprSb5amP3x1qgt0HQL1
	B1Jwy1wB6jUxflYNKBBMuNPFVEvd7NCEpdRdwSMHsAFM0A8tSJXfVcwR59LlSPBJxl8DCS4=
X-Google-Smtp-Source: AGHT+IFiFUIKFEV1iLUI4zN9y+ozWRnYz39yb/lPw+ucjje20sSfUcWseJfaJNNVFfPnmn0OZ/82Bw==
X-Received: by 2002:a17:903:22c1:b0:1e3:df09:e1dd with SMTP id y1-20020a17090322c100b001e3df09e1ddmr4393050plg.53.1712496182936;
        Sun, 07 Apr 2024 06:23:02 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001e2670c3406sm4910892plq.306.2024.04.07.06.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 06:23:02 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: sudipm.mukherjee@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH V3] ppdev: Add an error check in register_device
Date: Sun,  7 Apr 2024 21:20:54 +0800
Message-Id: <20240407132054.12170-1-qq810974084@gmail.com>
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
the index value is abnormal, a warning message should be printed, the port
should be dropped, and the value should be recorded.

Fixes: 9a69645dde11 ("ppdev: fix registering same device name")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
V2:
* In patch V2, we found that parport_find_number implicitly calls
parport_get_port(). So when dealing with abnormal index values, we should
call parport_put_port() to throw away the reference to the port.
V3:
* In patch V3, we made some additional adjustments to the jump labels,
making the code more concise and readable.
  Thanks to Christophe JAILLET for helpful suggestion.
---
 drivers/char/ppdev.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 4c188e9e477c..276db589b901 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -296,28 +296,36 @@ static int register_device(int minor, struct pp_struct *pp)
 	if (!port) {
 		pr_warn("%s: no associated port!\n", name);
 		rc = -ENXIO;
-		goto err;
+		goto err_free_name;
 	}
 
 	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
+	if (index < 0) {
+		pr_warn("%s: failed to get index!\n", name);
+		rc = index;
+		goto err_put_port;
+	}
+
 	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
 	ppdev_cb.irq_func = pp_irq;
 	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
 	ppdev_cb.private = pp;
 	pdev = parport_register_dev_model(port, name, &ppdev_cb, index);
-	parport_put_port(port);
 
 	if (!pdev) {
 		pr_warn("%s: failed to register device!\n", name);
 		rc = -ENXIO;
 		ida_simple_remove(&ida_index, index);
-		goto err;
+		goto err_put_port;
 	}
 
 	pp->pdev = pdev;
 	pp->index = index;
 	dev_dbg(&pdev->dev, "registered pardevice\n");
-err:
+
+err_put_port:
+	parport_put_port(port);
+err_free_name:
 	kfree(name);
 	return rc;
 }
-- 
2.34.1


