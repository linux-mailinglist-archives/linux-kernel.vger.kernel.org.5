Return-Path: <linux-kernel+bounces-84102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FCB86A230
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B249C284E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3715698E;
	Tue, 27 Feb 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6GbpXPV"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167D153512
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071852; cv=none; b=lNxq+/Qcf7hOUgMmO/bo80OJPsQKTps0mRGPp7ZX0Q8/ts7XHai42Zu1jMeVneFDUP/R94vNbkvQpWwGhZONDRW9jjq9Gb2BWw0v7yxzLkmwlG7qhkqeM4g/DO9NEooLGjS8m+0NJ5H4CHPxrn34ko0FTaAD8Gwt+T4HBQZarLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071852; c=relaxed/simple;
	bh=fmnSLnIUWlgp5ur85n+HDFL+jupuhUG/KRlYbWXGjS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDLN08ObuFcdt4rkBqO2hx1RNE3x0ygz/2gDpPRapZuCA4Ps02DDpqziZnTgPmvtpLE1FIM8v6dbOx6aKp/ALsJemCKxOCCf78pZo36EEaz0ewS/9Hb55OgBdB9EbwT6vIaadIdecZH8SgNGiHt+9VFb6LkOIJ9XEtF05RCsoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6GbpXPV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33dcd8dec88so1943079f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071849; x=1709676649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByFJ4T1AQt6fR81lqN9Fb0sA+BvqHSN66dpmEs3Guqc=;
        b=Y6GbpXPVfHGaxRV2uWpzEuexOZ3nQCXwO1Sq1eJiCT2Yds14Kls/y3yS9EVU8x6Tbm
         i25ojuFB8jrX9HEd4eeHMnAVmirXSlxw5IJsCdh7t7ZZe64l41H9shF3nsJIiClK26Ld
         8BLhxuDu4lzY3+gzZPkI0QNibkgTyDjP7EKXOdsodoS8i5yq0xgR9pPd32FZiJEXwGRM
         9ad2EaiKeQfODMR1JoSIXWvgzLsKTiUqzZAsZ6Nab8GVJdFiTloWwWEh1TEFNI79L4r+
         xZ1eY1EExQnnZXLKkDIpQxFIPSs/BrWfhUs6E6gMgp4tEJNK27VPSLoIdrGhl16COt+3
         9+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071849; x=1709676649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByFJ4T1AQt6fR81lqN9Fb0sA+BvqHSN66dpmEs3Guqc=;
        b=bYuZ7Nh9NazhAHi0ZT2TlXVnB1aj0LUP5sf2Exr97SeombWFw1rtEtgLBErwTOcpLj
         ztbmccVeTw0fgZDjdirASGt2OdVP+v3mVgYjNH10I2BZJbFkicN2pq2wVXTNuU9Fys/v
         ba3iwsRV0YICH8eQZEYWnWFfJcVtDE9nR6BI5addapyEaY3kbZ6O/VuN4xXYJwZmVKt2
         fA/DE7JXXonTvuoLygCKcaG+eJ/oGw/Ay9/uJ1Z0OuNQFfDJMkKZDG6R+XVN4naVhtTI
         lO+xpbVQu44JqdVBdzi4Clped/+tVimB5MOdbfMyzbn2rG3aqcDi+zxQeRMEGPPzh5u6
         xAGA==
X-Forwarded-Encrypted: i=1; AJvYcCX5Mlr+LKYSiImXUSmu4h5FTYCZLXYmQe/cWosFfB4x8YqixfbwU+COwqrUTRETTG+jfWj/5+AwHZAOkXJlEhEAKIsO7e4QAnVctqS0
X-Gm-Message-State: AOJu0YyR+FvPJegrCHcOG/OdjtDSB7Tb4yYBlM9n30KkuuQnYNNuj9fo
	ER4IniTp6ZxaEa4L3fZluFOw5yBKowTCK/ji4KXt9bLs4x2vfIQ4Mw9HY3LM
X-Google-Smtp-Source: AGHT+IHhgG30hZUhtNXvT7fOr/dUFPR5xQlfvSn7RcabUJUOBunmKVm/n++2BRnYv86YNiIeupq5gg==
X-Received: by 2002:adf:e7c1:0:b0:33d:4c3d:2975 with SMTP id e1-20020adfe7c1000000b0033d4c3d2975mr8642928wrn.32.1709071848925;
        Tue, 27 Feb 2024 14:10:48 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b0033cf5094fcesm12562384wrc.36.2024.02.27.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:10:48 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: pi433: Remove a duplicated F_OSC define
Date: Wed, 28 Feb 2024 00:10:40 +0200
Message-Id: <20240227221043.532938-3-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227221043.532938-1-ikobh7@gmail.com>
References: <20240227221043.532938-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

F_OSC is already defined & only used by rf69.c source file.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 78fa0b8bab8b..52e43a909b03 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -12,7 +12,6 @@
 #include "rf69_registers.h"
 
 /* NOTE: Modifying FREQUENCY value impacts CE certification */
-#define F_OSC		32000000	/* Hz */
 #define FREQUENCY	433920000	/* Hz */
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
-- 
2.34.1


