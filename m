Return-Path: <linux-kernel+bounces-73714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D96785C79C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFDC1C21F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520BA151CEC;
	Tue, 20 Feb 2024 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOexJ3/A"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8876C9C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463676; cv=none; b=Eawudm5Ta+LV97N0daA4xP+MvGmyVFF+tyMPTmteA2kzL7AMuNYj7+CLcmmyjLPg+a+g4xk/1LK0Es37AoFTJk0imPe90/PGzTnaD7Ka3a6q3hEr8NYkPK6slLB5vtOGnnf2PCk0xExyqc+olI22zRTi7UPPZ8C1YpuUKADGy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463676; c=relaxed/simple;
	bh=uG1gfpoRfXRgKuEHJKltjR7JrRYIjqvRvSia55JVwcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FRRf/V+TXaczHSAwPRtn6VTl035qR9Kex0VKtfmHbss3c7IGwRfIi6q6IZraRKijbvMI4tTb/YozvFJ45+zy6JahEQ9CYTuu6ZrgOKeHHuS6YDC45NkNjUIzpUEt3I+2CCWAiliCDLcGtK+Kydx/iYHXaj1diZM2RQKnxMGu58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOexJ3/A; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dbd32cff0bso24638165ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708463674; x=1709068474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A93PgWbW04e3vN6J7sWJkkLxGXflBHffLu+zmG4+tnw=;
        b=iOexJ3/AcbWSsRyM4/wpeKprHMDp8PMEmas7s1l3Jy5hwRa8fa3wcpH/FMQnZCmfEh
         W7xPxPFjrHKji0Hnirr2hlvAkllz8VzSGnhLpRsMqphBQ+05cv/nxoiXor7MFOEsUotW
         5Vtcj2wc7GDnk/ReoHrXrau3g4pC1RiOoF/32XF4TEICk49/0aXAMpnoxn/irI7mYjkK
         wCqrGzgdih4NK/5VxdS+Mu3gNASeINRkIXrJHlDFwv4NQJPzvK2a8+ro3GWDSOY7I8j7
         +CJH5hhS8T+I3XyfPF5R2lETltgrWHsm+fCYPdudv1U8S86elcIeYqHpdEKCVqtsPAxr
         iMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463674; x=1709068474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A93PgWbW04e3vN6J7sWJkkLxGXflBHffLu+zmG4+tnw=;
        b=FzDXR4NcUWm74KOlbv7A7un8Zglk5PX5Kw8ls8ttS0xtKs0KI9SrvwPRh22T9JeOLo
         DymMSLyuZ94eQ1xIDiQe7K8xHfhZOLbmJVaDLWQAP3T5CHZ6H8fvHyTzM2ybVdQdnI07
         psccrwTmMn4YgmNxqdWMqW+r/AY4YNcdM/LE/xVmjbtsyUs71gzeQwF/2+8tJ2e8UFxq
         oDqLA1saZJ5jqTBrMVEmJLbB5oEXARY4HouTRHb6ido8oRGMWC+5Me2Ar8hVBP+E0RnA
         GC6IC5LSfPeoB7IGDu1x2f8NnzT8AZh8I8Pnlr5dMhfjn3ery2S9lcl0ypNn8FPrzAS+
         LxTg==
X-Gm-Message-State: AOJu0YybNzxlir7bbv9nJmeCqJIl2R4ETnYzT7LJfkzIXG6nLRD0MmV6
	VJZxMJnTfqAPg+qDijud0SbAVnrzoU26VqtHtVJSv2zdNarSakIG
X-Google-Smtp-Source: AGHT+IE6ebYcpcwYiCnw5UjZZZdDHNYjoNj1345Sq6+8t74K/RzBNOqe0SBDuOW/qJb9WGGzGdBVnw==
X-Received: by 2002:a17:903:8ce:b0:1db:cca9:f751 with SMTP id lk14-20020a17090308ce00b001dbcca9f751mr10541302plb.59.1708463674378;
        Tue, 20 Feb 2024 13:14:34 -0800 (PST)
Received: from localhost.localdomain ([116.73.143.161])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170903048c00b001dba50577ddsm6733481plb.121.2024.02.20.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:14:33 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH] Spelling correction patch
Date: Wed, 21 Feb 2024 02:44:24 +0530
Message-Id: <20240220211424.6005-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc | 2 +-
 Documentation/ABI/testing/sysfs-bus-cxl                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 96aafa66b4a5..339cec3b2f1a 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -97,7 +97,7 @@ Date:		August 2023
 KernelVersion:	6.7
 Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
 Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
-		for the users to configure explicitly. This file is avaialble only
+		for the users to configure explicitly. This file is available only
 		for TMC ETR devices.
 
 What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred
diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index fff2581b8033..bbf6de5a4ca1 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -224,7 +224,7 @@ Description:
 		decoding a Host Physical Address range. Note that this number
 		may be elevated without any regionX objects active or even
 		enumerated, as this may be due to decoders established by
-		platform firwmare or a previous kernel (kexec).
+		platform firmware or a previous kernel (kexec).
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y
-- 
2.34.1


