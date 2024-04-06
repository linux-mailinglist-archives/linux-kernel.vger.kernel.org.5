Return-Path: <linux-kernel+bounces-133960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FEE89AB76
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10176B21CC8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679953839C;
	Sat,  6 Apr 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtiQpuZn"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C111E87C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712415389; cv=none; b=UHlNmm9P4lwH387SYsKGQD5FHrb1soF/cWTynRZ/On9xlHyOZ/2BARhAAPYflAOy1F0Toths/vEMcCjzk7FKCs8mVUoztTWKiE5V3FaxJ4TlV82taa+JIKehhcvrFAN+uEFBiwdOlEZa0pPh8n1eXZfzVe/ePxYMHQ3+oENSGk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712415389; c=relaxed/simple;
	bh=q8m8OVpGFIgYTKXIELbCybDzJMbWjuqURTJUH55dwEs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SvPWyJRn4DQaQ/Een8KrXSbOhAL8qiuXHWGTc1/s5VqvUsYk54DKe0e6oi0rFaOli9qprcvPsr7dTPzFcLUf8qCXNrs2zMhH9XcHltyKxA5REIOAy5Mz0GVnTeegYQUKnyDl1WUsohOlhqrhfpoaaqo82LDO4K23c3WGejPcviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtiQpuZn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516e62a2b05so105468e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712415386; x=1713020186; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aWtJxxCLxr91qNR9cPEfSgYsfFWHGlJqEcVp12GrLIs=;
        b=DtiQpuZn5tB5V92ydxA8SIr14Hgb7Qt3Czgm70bsqhFZkzSKzXm54ToJAU1U6z1E1/
         PZVMpCZaHadQ9LPAFVaSr2xapONIOEBsqPI5hh6PxjAEYxzElV9nzaZ7pRKqWkT05dDN
         3psxHJzx2SpepFmtklxjLf/Fxo8UjUxs8iL57LJf68nXiYDrfU9ihViL5D4NHwAlKJso
         2gvHgJB60GfWoPou0fQrktu+HmWi9S43Rc5kuUGccgMEAZatdVqOtUWS1JUGSmKLogki
         BbaJcwRLLtZqmA04YD5PwIcCYjORkag0RhSSpNYLDWNwVHgs54PaawjoRgTihwPVbinG
         t40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712415386; x=1713020186;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWtJxxCLxr91qNR9cPEfSgYsfFWHGlJqEcVp12GrLIs=;
        b=DciWzm5GVFbUBBnfFP39j993KGsJ1H3wtqMHu6vMz4TW7fQNNuGrlfslaFScTb8rGv
         x7APWLUJ15BoUNVjyUONFdA4AT2s7YV9pExS3vxpbXL64PWLQQxg6ov9Ap7HX9fgtI8k
         m4c6jXcWHU36OyMSK17ojeMyo0cJDweciI+GFWQOesLNdIZdHx96j2wh7iNT5m2/zksD
         7yiEW2yV/Pg5lXyr6/EvWqBzk7woRB2z3JqsJCKNyVlxaLvyffAvrJGGrMNh4Xlf7qCQ
         jdugX9wwxxPztP0nMird3csvAZI+fW0RDH5HiV8Hn8xrB/DHfZAtddMgD1hd1BD++VfC
         rTxw==
X-Gm-Message-State: AOJu0Yydbp2ebiROnYsJ2dUmU/dI0VLQKeeR/L6haSc8AMkYFMv5bo4u
	FaB1tGyEh//MGdBhE68z8y5zXrfxPHYBIVKghbwwCh1lIxnaDP5G2bE+kp4ocrXiYwrBL0Gu/oG
	V66TuqTUKIeNs0pA/NoqAxE+a/9n4YyuGwW+LTQ==
X-Google-Smtp-Source: AGHT+IEyZwQkRe+ImVy6v89+Xgx4SKA3aCXwXqK0MT8N7us1Vx2jD6XbGiA5t6mZPlYV36Cbw2fJ1SPK65ezhS51DLQ=
X-Received: by 2002:a19:2d0e:0:b0:516:d4c2:5412 with SMTP id
 k14-20020a192d0e000000b00516d4c25412mr2829877lfj.32.1712415385522; Sat, 06
 Apr 2024 07:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jarlath <jarla7h@gmail.com>
Date: Sat, 6 Apr 2024 16:55:49 +0200
Message-ID: <CAJ2n2MSOg8q1oFYi49oxaBkJPmufXf5GWnUoZXkOcE-N7_Nj5g@mail.gmail.com>
Subject: [PATCH] Add new PSU: Corsair HX1200i (2023) to corsair-psu.c
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It looks like Corsair has updated its power supply portfolio. The
owned HX1200i is not supported by default. After adding the
[idProduct] configuration, you can get a correct reading from the
device. The HX1200i as of 2024-04-04 on the site is marked as a new
model.

Signed-off-by: Tomasz Gwozdz <jarla7h@gmail.com>


--- drivers/hwmon/corsair-psu.c.orig    2024-04-06 15:49:20.922744536 +0200
+++ drivers/hwmon/corsair-psu.c 2024-04-06 16:03:27.793762525 +0200
@@ -883,6 +883,7 @@ static const struct hid_device_id corsai
       { HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
       { HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
       { HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i Series 2023 */
+       { HID_USB_DEVICE(0x1b1c, 0x1c23) }, /* Corsair HX1200i Series 2023 */
       { HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i Series
2022 and 2023 */
       { },
};

