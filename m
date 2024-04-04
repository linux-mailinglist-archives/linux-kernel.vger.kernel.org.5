Return-Path: <linux-kernel+bounces-130775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40093897CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD851B295CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864D1CABB;
	Thu,  4 Apr 2024 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moeryeMB"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401151CAB5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189871; cv=none; b=tOZTeY17ZNZX5i95t8M0+BdNA8TAhGKp+IeYpFxcenEOmTVS4NXA8o0vfJoxuDW2p57xx71wkcKFXRU7yYCTRJs4TKQXhA3BuwQlqT9CvL8TGyxXgWMjJor9QjNE5qfMzVRwN7NUsfiou4DbEh98W39xPOkfTLTb+9NLTVxAPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189871; c=relaxed/simple;
	bh=B7R3hnTJRgCRWl5nF3InAG07B70C9XWTY07YjD3CY9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/0jqccmCOi447MA9XupYqeiymDERYA6TM98zQDI9jQo1CD6A2x6aMm2M++VI+AZpIkrLBBhS4vYJ19zPRKktK8OAQFeS3XwLF1MR+1NLIky+HDMcO6RUg/pI6TQuW5luEu0MaPwmZoiWtPeCZtwrqCJfSJj0fWpkt/+NS5xuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moeryeMB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a226f8e44aso272060a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 17:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712189869; x=1712794669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEhL3R0CV+V3IuuciSTia1iTNDXKvNOyBjkJ1bb1xuA=;
        b=moeryeMBg1rF1de14LZ/J6WEZLTGhm4Opitd/OsogBSskMhZ4ezInwXDi8cIdkQgwY
         bjxh3Dq1gJtSM06a4Qiy5wuBq70tOTQzUSAfRISBICJ9ZYRExvFCqHcBD7HKsnKXnWqN
         zP0i07ErOw+Mq4HK73p0lHDQh5IHz6q2eS/KPuuwLRHltZb3LpmTasf/vN5PvVFvBDdd
         oK5uwnNU0aBDhW36BNulQc0wr05G+Jd8cooXpebonquvphyndPHtpkWjZjiLyGDGk8bo
         1w5Tb6fpcM75svULCi4zxAJ74NZV4UwukrX4zeUY34wJBTtrDkbw52rRbivNb8Pv2jrX
         Hn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712189869; x=1712794669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEhL3R0CV+V3IuuciSTia1iTNDXKvNOyBjkJ1bb1xuA=;
        b=CfW+zmzzOBBDh3P6gm7P8PLZBl+8cN7ipyLF4MITc/BmfpJJM2nG8szZ9soaySwOyV
         eV41f3b12oVK6R2m0CSjCWFR/A8UqMM+naG+0KKhPSmMUZ+IEX/ZOkXrFJZVePpG2Vrb
         IjJ8AiTlXNxKbn6dozNpn+blonEAWNPc3ppGflRxYntfS+jNXJVdbZCRE+2sRWshlwcp
         +aNoT6/NMMRVMhfskR9x9kQZPGuMLThPme1vmN4W6lGpmhDqT2ReHRSNsnxkhtrF9H7/
         VugmrnY+Td4vBY01kZ68StiBusN0tVMN4eZ9Zkv3Egu5EtsVFLdIUo9L0F8/+30nY02P
         y9dA==
X-Forwarded-Encrypted: i=1; AJvYcCWXe/r78lDh38y4OEJO5B52WGyx9V9bEUVWmVGnJfvZnj780LXACtajnYUyGRwCaE3/GTyYfWu5GNiuG7bDSeJ2O/8ovuWEW4fLQ1Jq
X-Gm-Message-State: AOJu0Yy17BWJcuV09JPCsdUPylYFdbb+2Y8MTFJLHgGnezqp3yV3KIFG
	popzhKAN/Tg9/vyWWB4mnRI97F+a6e4IXFhk60+mNzgO6gLROBu705226CwkYFjjvw==
X-Google-Smtp-Source: AGHT+IFvRGBLmr18Nxk1BlgrtjmU4Hpm+bSbf901S7+dDxgwigEa/yJT6NNfNLt7go4I4DJzMOm6Rw==
X-Received: by 2002:a17:90a:c587:b0:2a2:775:9830 with SMTP id l7-20020a17090ac58700b002a207759830mr1144439pjt.11.1712189869444;
        Wed, 03 Apr 2024 17:17:49 -0700 (PDT)
Received: from jc-ubuntu-dev-korn-1 (c-98-210-1-68.hsd1.ca.comcast.net. [98.210.1.68])
        by smtp.gmail.com with ESMTPSA id q94-20020a17090a17e700b0029facfb3f25sm338726pja.45.2024.04.03.17.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 17:17:49 -0700 (PDT)
From: Jackson Chui <jacksonchui.qwerty@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jackson Chui <jacksonchui.qwerty@gmail.com>
Subject: [PATCH] staging: greybus: Clear up precedence for gcam logging macros
Date: Wed,  3 Apr 2024 17:16:28 -0700
Message-Id: <20240404001627.94858-1-jacksonchui.qwerty@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by checkpatch:

CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid
precedence issues

Disambiguates '&' (address-of) operator and '->' operator precedence,
accounting for how '(gcam)->bundle->dev' is a 'struct device' and not a
'struct device*', which is required by the dev_{dbg,info,err} driver
model diagnostic macros. Issue found by checkpatch.

Signed-off-by: Jackson Chui <jacksonchui.qwerty@gmail.com>
---
 drivers/staging/greybus/camera.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index a8173aa3a995..d82a2d2abdca 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -180,9 +180,9 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
 
 #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
 
-#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
-#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
-#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
+#define gcam_dbg(gcam, format...)	dev_dbg(&((gcam)->bundle->dev), format)
+#define gcam_info(gcam, format...)	dev_info(&((gcam)->bundle->dev), format)
+#define gcam_err(gcam, format...)	dev_err(&((gcam)->bundle->dev), format)
 
 static int gb_camera_operation_sync_flags(struct gb_connection *connection,
 					  int type, unsigned int flags,
-- 
2.34.1


