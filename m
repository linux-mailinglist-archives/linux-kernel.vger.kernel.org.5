Return-Path: <linux-kernel+bounces-41750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A3F83F74E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30A7285E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316266B22;
	Sun, 28 Jan 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O64EN5E0"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC9664AA
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458446; cv=none; b=BznbUERlmnMlgsDE1FcZwmpSnE8aWaf1y0x1D4RWye0JMD1klfMLf8Q2CB+HiXbCw99zhMu/JAtLxHCfU7eXoI35C8S7xPo3M3ODg+VkovR6hOzjBjg7jIbnYqhNm4vlKen9CAPyMu+wwWZo2G9ayeYCwVszWDH/qLUZV9jibSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458446; c=relaxed/simple;
	bh=SvazET5cvoizwnCav2UmC+F26NoJafLS2DPv3VLtt5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VfMTHjaWsyrCsLHganEhun9RNNtYvE4A3XCb4KUJ1YdtSj8BJpIWGKVuzF3difoOkwTJOeM/3L26QkKNxt+IIxxJiAOGhbvmhOMy6YOt+jx7z/qTZbV+12S5u34fMlrwimJgvGbLpjCc5x3nM3OoeZIOeWd3iqbpOZCvaqnEzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O64EN5E0; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6860ff3951aso15906136d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 08:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706458443; x=1707063243; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bSToxy5CAGcJZTlMmZs/1RykWirU/TWtFNPtD7p0tY=;
        b=O64EN5E0rBu5u4XKgHNHHAbLjI0PydCqWCdlY+Ny7MjoSSNRA9M4mwWWTNgtUABPe0
         eUNOmuXrxg/Lkk2WCkI9KnV8kPS8YlaY4seik0pRlu2ejGEj++T8DKKWP7rl5bGBE6e7
         QulReKcKmtGSBgMG7fCMGvrIxfLo2VVXxsrDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706458443; x=1707063243;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bSToxy5CAGcJZTlMmZs/1RykWirU/TWtFNPtD7p0tY=;
        b=samOPZBPuZiPzw9PVhTNRE9P6aB2Xug7Gdb+o/qLBqDoYmO2HomorxhwUDxPv+GaxO
         eI567uW17qv808XuSTtHrnAUHo2/6acRwh9v2M894GNmePOG6U9XpuFA1vETImMPNu81
         0WFtRTQxxJmMa5JOFrhWAB6GN2v6pDDj/eUv+eSVqik+KVCmZxdZn9G3VA2em/+mid42
         JaeHXvC6pN9zsnDYFsnxh8Z8joIir88s+K2NJBcP0W3Rki87tN5/KxfFeiUwfNyxI8NR
         EdVvJ0foVgR/iKmULAnw3KOgW0igquR5awWyc3KoMywcWwhFAB2h+N0abdAOYVPMoUTK
         HPbQ==
X-Gm-Message-State: AOJu0YwFYZqbHrDFfZnk+UhgCjBFPY97OofM+DbCcgyKgfbwFid8CIJ7
	pXQfQXrdgpxtNKH/V97YXD8OQjL2cbdLMkcYSxNhFGSDFvXmWdjY8NXtxZ0zyA==
X-Google-Smtp-Source: AGHT+IGPj/bWw10peow8+ThqZ4AksGoB8+fhu6FGjZno0b2aG69izlBUsWRzjFmhWV39AxgNwh/u1Q==
X-Received: by 2002:a05:6214:301e:b0:685:f795:dfc2 with SMTP id ke30-20020a056214301e00b00685f795dfc2mr4607832qvb.86.1706458442616;
        Sun, 28 Jan 2024 08:14:02 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id dz11-20020ad4588b000000b0068c493426edsm566640qvb.104.2024.01.28.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 08:14:02 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/2] media: Fix build warnings with gcc-11
Date: Sun, 28 Jan 2024 16:13:55 +0000
Message-Id: <20240128-gcc-11-warnings-v1-0-52bbdf492049@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEN9tmUC/x3MQQqAIBBA0avErBtwJMG6SrQQHW02FgoVhHdPW
 r7F/y9ULsIVluGFwpdUOXIHjQP43eXEKKEbtNKTIm0xeY9EeLuSJaeKZIIzUc/Wmgi9OgtHef7
 jurX2AWVPfVxhAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

gcc-11 throws some warnings, most of them are false positive... but with
a simple refactor the code looks nicer and the warnings are gone.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (2):
      media: nxp: imx8-isi: Factor out a variable
      media: usb: s2255: Refactor s2255_get_fx2fw

 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c | 8 +++-----
 drivers/media/usb/s2255/s2255drv.c                | 7 ++++---
 2 files changed, 7 insertions(+), 8 deletions(-)
---
base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
change-id: 20240128-gcc-11-warnings-15da5f29885f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


