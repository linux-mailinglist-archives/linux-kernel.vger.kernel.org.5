Return-Path: <linux-kernel+bounces-157570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A452D8B130D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90AAB2555E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8001CD24;
	Wed, 24 Apr 2024 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUuSVMo6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC51CA9C;
	Wed, 24 Apr 2024 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985186; cv=none; b=oSistbIwwy1GIRjojr5QyAHhrJY368ihnaQAN107tY2fW6F0Aam8bQguf1ipWbjqaGCvHXVToC3DUoqKSgh5C/8MfFHKt4vuQlSrB2EExRx+ogJJaoF9ES2JylQGf8sCRjRWuo+L/U1PmsfKQqrzrWLevEMCRrKsuuNwoxgjhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985186; c=relaxed/simple;
	bh=KWqSv/2vCgFV7m0dVXGDUGjrPJ+c2I7IUQFN3z0Zgus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CFj13d6M1jy+a2/0nHi34UDVDbuRwe7HsT68LmA9ecUz77YR2CMWNVBPJdBMM/qBUxmPVkkwuo0i4e4oM2fRmQHJqqFjlPob9qR3k0wl/O0ITgeqMQox8bNXX2wecLcgx4GhVps12aDCdvLBaFbF1nVQ4kOOmB0+q7mTRZ1Sr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUuSVMo6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ac4cd7a1cso1496675e9.1;
        Wed, 24 Apr 2024 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713985183; x=1714589983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnKdVsW3GNjrjEclR8/GG7vSTtR89KCyBOPnFq0O3VE=;
        b=VUuSVMo6kk3iNiRS7UejeNnf4x1QY1SzR5VqKMbGOeNnGpSEy6+N4hUOzlmpfxZcPF
         RpBqA10zNtvwKGDPHQnn0pEQDukwpJhgSiFAJcpMWbbb8B01n0f/QdMLd35aLZAyhow8
         JCR23u2KJoqEMAfunQJTMtJqYDyycwzdmaZSBDvXNH0W9J2TU6/8k8j5XKRghg/nWXj9
         BLCckdXGqGDyGklU20IRQFMpbOy6vNlMlfRTDsbPQeGzcyYpykATFP6vT3zKZNeOOe/n
         eXdkorMxXByMLg6+OGsK0Hxo8O0peXwhCDkBSJNMkLfbUugPqtSjjQZUd2rIfQjbXRze
         p4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713985183; x=1714589983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnKdVsW3GNjrjEclR8/GG7vSTtR89KCyBOPnFq0O3VE=;
        b=iCSXUvY2APd+hHES7hYTPzIyJBwEaBiKT4pie+4hzEx2q4zReA5uxJ8gUaUdWvh+0E
         E6xgMGviElJ9ctcNI1LlmckLZ5n8VP39mIu4PcfuJSZo0ql4bRlR7RzVJwn/0aG4dwlK
         4oZgc3pgflYA1noieUYVRjL2vLZXQ72Ukg6H7WgqGdaTrGS78nLB9jYnegXgJi8t9rrz
         CxWrl67C7rQC1DPa7a7vAZduug0dAZiuo3sbj2D9y4qe0vrtaU0ipqLRoYzm4Y5KUMGq
         8d2B3fdTSKh3ZLst0sBdOygAXL0PODAOzXywzb3z5UzINiS/A94BRZJ7811ru3WZpGCn
         eHBw==
X-Forwarded-Encrypted: i=1; AJvYcCVSZrsrlNgxh43AztmZIiGl6zEydmA1Y1SwXzmO5Kg/1iJqxoSmxlmiN9Rau7c6Mv3OtSsxya+NJtbnLMG2ubLvTZUXVKK5uuaHZLippPeyO204grmO423Sb4j4h6MYcYAbA6P5rC5Z
X-Gm-Message-State: AOJu0Yz0NpRdRdWyJ/eM1KyU3pXZ96vGadWjgCQlyZaprglQVJvvnQDl
	/fo8340X6tPa+pDhH1Hmixx3yqM0nlbJmqLg2ibK4wxWBxBaAnNL
X-Google-Smtp-Source: AGHT+IGT8zaAQwwZaEgs9XcONv9Zm8MHgUDOW+5ujWQNFb/3a72Geo4VUvVluRmNYRyjdFv7zV0GjQ==
X-Received: by 2002:a05:600c:190d:b0:418:e304:4a13 with SMTP id j13-20020a05600c190d00b00418e3044a13mr2556516wmq.19.1713985182714;
        Wed, 24 Apr 2024 11:59:42 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b00349d8717feasm17861731wrc.56.2024.04.24.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:59:42 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: temperature: mcp9600: Fix temperature reading for negative values
Date: Wed, 24 Apr 2024 20:59:10 +0200
Message-Id: <20240424185913.1177127-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Temperature is stored as 16bit value in two's complement format. Current
implementation ignores the sign bit. Make it aware of the sign bit by
using sign_extend32.

Fixes: 3f6b9598b6df ("iio: temperature: Add MCP9600 thermocouple EMF converter")
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/temperature/mcp9600.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 46845804292b..7a3eef5d5e75 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -52,7 +52,8 @@ static int mcp9600_read(struct mcp9600_data *data,
 
 	if (ret < 0)
 		return ret;
-	*val = ret;
+
+	*val = sign_extend32(ret, 15);
 
 	return 0;
 }
-- 
2.39.2


