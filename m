Return-Path: <linux-kernel+bounces-134244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2B89AF6B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992C22820C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DFD17578;
	Sun,  7 Apr 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Yme6dj"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B511711
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477168; cv=none; b=lc+cTfH9+0Bi8LO4Vc5S7U+x6glbIx/GcpUemMOjsCwtb0QtaLdoFSPnpacG2KgVpTcZoHgCVR9vzc6EUZL10LSRx+AKVoYEukiRhVzmui0BMOLPglhtG4aep7V5tIZeEHlM2Q/AtDHzDiKSbfZsIxB8hwjBwsafju09QoYf9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477168; c=relaxed/simple;
	bh=Rgb7nDRXj9MupxIRPzx+m7bzOmhCyq6njAcjkgSTuqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OA4uOs9iFTmCW4Ehvnqw59CAKD6sd2DxY41P3fCWMavbeFi8rV0Oe7Ld63IfhMZYA6IeqdSiQwdUdkCgVF+mwKchk7r5wrean+H/IUesjJPEXiHsjSRvbTDUbRaj6LRwkc6f5pighyi6rAN1Ev1k8meok/ZPCY5lw7QP5dlfc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1Yme6dj; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2a2c9903ef0so2439920a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712477167; x=1713081967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHRwBHxn0oc7UK384XKn6F49yYwWNuwEXuLNUt2jUsA=;
        b=E1Yme6djx2dertv4qoU0riiTlkw0kHhSwdRBDmKYeNuHL7py1DO5zMU6cgCLvfnLEu
         WrzKVfOrQqLDYrQJOpUjzB/kcmrwdEfaDMpuq0TiQLwagLHhuYKJixYIiBBQ0kNnxl+G
         Ht+/2CJIPNXW9iGIrgMFkkTxrwKQYWUCj+iXKoUYJ+H+XIXMZ8/TspJCsfsOEKKSHTub
         AhS+EdI4YYliXHkbBvgWuWvH0C/IgawfCS91jkHGcOwV7fq1KoFSUfUJkJCc42vyTfcK
         crV4MUutGe6Lf4YBbcb+2TISM4W7BkrOckxVDbK+YooaQWB4maF6TV0FRJ1mF5/3TnGv
         V3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477167; x=1713081967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHRwBHxn0oc7UK384XKn6F49yYwWNuwEXuLNUt2jUsA=;
        b=N9iFTv2e8HriiAuCbfhnu5waXqipIdu3QtS3gBeCe6Q/UcJICM8Gnf5PMgYhN6jHOy
         zJ/8svPZkyER/YY/8N7NRqW1cz9Xlk3yl2RpqYxJry52UFED0bR0HtQvdQc4ixdQ9fLN
         JDvSvIa9LxVsm9Llaj9sRe7Z8d6ObEuQsM3anZvEpmNlhnKIqvWUwoZMAOUJ1+CPetZB
         AC+QqFgQ4gmfjFBZDIsElqlSDXez9uwilxJuqQXtBlxTOMnf7XLfGNrUOjO4R7Sa3Ky5
         Sq3310hfcw/JqIruz+DIJ0snoskJOuau1Ym+aoFPsM8bwWRkroOe+YyRnhCfR5+CUOHQ
         b3eg==
X-Gm-Message-State: AOJu0YxuwigMYryHzQdSuLH2xDHt9/Os6RJGR2vvW1NEqEKI7z9O2NIw
	HAYbmNe0J5KFKIYwKDrgf4EjirkeW8JwCuexpJBNJ4vSpQSDhDE+LGm9nvggEsgftUfI5j8=
X-Google-Smtp-Source: AGHT+IFN3cUyK1XcxkTtz7Llt5DIHYe/KljlX635QLCeG1ldOn6n2qJWUpuAqK8X7l6sWIFttlLtmw==
X-Received: by 2002:a05:6a00:1390:b0:6e9:74d7:7092 with SMTP id t16-20020a056a00139000b006e974d77092mr6789288pfg.24.1712477166675;
        Sun, 07 Apr 2024 01:06:06 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id s12-20020a056a00178c00b006e6c856c0f3sm4191297pfg.188.2024.04.07.01.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:06:06 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: sudipm.mukherjee@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH V2] ppdev: Add an error check in register_device
Date: Sun,  7 Apr 2024 16:03:58 +0800
Message-Id: <20240407080358.8635-1-qq810974084@gmail.com>
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
should be dropped, and the value should be recorded, then jump to 'err'.

Fixes: 9a69645dde11 ("ppdev: fix registering same device name")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
V2:
* In patch V2, we found that parport_find_number implicitly calls 
parport_get_port(). So when dealing with abnormal index values, we should
call parport_put_port() to throw away the reference to the port.
---
 drivers/char/ppdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 4c188e9e477c..ac5a93d39fbd 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -300,6 +300,13 @@ static int register_device(int minor, struct pp_struct *pp)
 	}
 
 	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
+	if (index < 0) {
+		pr_warn("%s: failed to get index!\n", name);
+		parport_put_port(port);
+		rc = index;
+		goto err;
+	}
+
 	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
 	ppdev_cb.irq_func = pp_irq;
 	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
-- 
2.34.1


