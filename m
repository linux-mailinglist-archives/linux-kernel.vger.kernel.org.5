Return-Path: <linux-kernel+bounces-84111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E60086A23A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF33928828E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CD155307;
	Tue, 27 Feb 2024 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a23d3tvX"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C911586C5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071935; cv=none; b=qjsDdvGMUp4iVzRbWVmdxV8vX0OHhuvXv4iSte9iOBimbngoY7DD1I6REPYKUNqJOaK7IT7xaNbS4QZeZ2AQmkX2aj0In5MMe1kIPyVAP76aO+oZLp29RHnwB6gK979ZVtjzrTanTIWejdeRFgmVFmYCy9Wfth44m+wHb8Lq0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071935; c=relaxed/simple;
	bh=ZLpd/FTiTFzHnfpWMzTXSPkcqYPvkCAzdFD9LpcTNSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFmRRH9x4T19TYq5mv2IU0/B4Im5pEQY0SKhLDV8/O7jQmz0v4UkVGQwH2MtWJV/E3To1k5Y3b4KVK9TBfMf762sSF/ZesEcnCl+tbV+HrSDirK3rqtqkhuQNbwb2MvmmrnCLaA+nDAJh5s6ZJzdKJm0GUB/mb8Y129PJE9md/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a23d3tvX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412a9ea61adso12487925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071932; x=1709676732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56OYpxv+7Sg0fmYSpVc7Gnw4S4WJ/wpnYoYBTxSpZBc=;
        b=a23d3tvX+WXugkF0gXPrw5DisvbKlwUzb/eh2xOI5gYizgy6O3a2hy1DixPQBehT38
         nwVhxfy4wGE6JQlj5G13DHli0c3RN7+WthL3OIdH3J/2DXw4eRjb2Kp90g/P5Rm9cT5C
         ym1mJRfNuBZ4cnLjqSutWyMDRnuBZPmJYLJa2H5IbjrtWMddDND0Z2AQrVekzlI5cKWP
         bDZwp2XFvtWgApI2EPP3QBgU3tSOT/m00ZwkE3vpDon5aQEuMwE9xObVlU4BaLU6xcer
         gaRpmk3oW54++AFzVvPdDkJGwLMzfGxuX8ZO+X+RulNBxxFCYGjbqgRwjVfrX6yLkKPC
         t5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071932; x=1709676732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56OYpxv+7Sg0fmYSpVc7Gnw4S4WJ/wpnYoYBTxSpZBc=;
        b=YgZEme4GH0mS7nOKVB4KQ9fbthu13hMKM37vVpFFGkx1RHoirCt4YO1R33WHfgmLXN
         lyKD4r5g3sfZ/mgJdb9bf2zHsSygvTYDTWBBlPiophRIAHBSUBDKz8HuhXhuyoEYteV+
         S8LQ2vSBaqiS7964YCq07yRU6jxJ9OIp7pnk0HMG8UZ81B04pZtOKty0QAHF5sEDg4Vr
         KCfFXFrYyxtwD1eSBqtR6W1fT9fJ/BO6h0N1Ac8X6AS8WiT0lcltt9BpYFxrVfn6KS4F
         W/kiXmbWluqwj6f3jfjrTeO6UcntCFasiShSzif5UMQuQANM9/xsYmYe/p1KKij3xUPR
         5eeA==
X-Forwarded-Encrypted: i=1; AJvYcCU4nNfsWDysGTfu9ziTx7OLroNT+T5UnQtwZzjJeBBegn+stiyUib8DvcrHzsDas5SzlucxGp+qeC/C4ipaK0tSYvMNQuk8iigPmEbq
X-Gm-Message-State: AOJu0YwW6/X/yKTMCUvflK1no5/zxX9m2NoYn18Y2d5Ztt4rYvyuWXie
	2tOgRg3hXDTtF9gJbrYwXrUhVeib1Q8XyiLNacDIM6dsWxqvkyuE
X-Google-Smtp-Source: AGHT+IEj8tptFBYZE9yIKo1btwZirTUVTC0IDKeHJmBh0DqpHi/ZZQQD/glicH/eZ/xctGMYD9cGzg==
X-Received: by 2002:a05:600c:4e91:b0:412:a04f:7f5 with SMTP id f17-20020a05600c4e9100b00412a04f07f5mr6186950wmq.16.1709071932249;
        Tue, 27 Feb 2024 14:12:12 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id o8-20020a056000010800b0033d202abf01sm12415560wrx.28.2024.02.27.14.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:12:11 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] staging: pi433: Remove the unused FREQUENCY define
Date: Wed, 28 Feb 2024 00:12:03 +0200
Message-Id: <20240227221204.534131-5-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227221204.534131-1-ikobh7@gmail.com>
References: <20240227221204.534131-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FREQUENCY is not being used, delete its comment.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 52e43a909b03..e63e87fd6cce 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -11,8 +11,6 @@
 #include "rf69_enum.h"
 #include "rf69_registers.h"
 
-/* NOTE: Modifying FREQUENCY value impacts CE certification */
-#define FREQUENCY	433920000	/* Hz */
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
 
-- 
2.34.1


