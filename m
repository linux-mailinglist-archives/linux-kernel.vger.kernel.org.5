Return-Path: <linux-kernel+bounces-84110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7186A239
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D671C235B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66EE1586F8;
	Tue, 27 Feb 2024 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx4adh4P"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB0156985
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071933; cv=none; b=Eqjhus6f4PUid+Q11g3S/iqz2W1xmQC+w+oJPb8JuO+mqBBC92x/QCVSD3rPJhp7J+gkaAcGHsFmz/bzVZ6Zd+1c4+qIwMn4WUmZqMSFUGfc+uGc79TimXbZc433A4WtcEP1L6LNl0vjKE596hOojZE2fCIEMtoUwr2WxWD46g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071933; c=relaxed/simple;
	bh=sD4PGbM5HqA6toI1/CAMqbYx9lSjxRaalfZB/ur59io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXvDmZh2HntlLmTlQ0bTYoEN3e4JFBZBLgbf7cZIMwkAstmOJEvZ2uzIlziN5CZygwncD4I4vEgyjIXMamEoZlJFYW1ADQ8XgvnVUlt3ko7j+gaps8dWo2NnO1ksPmPTw8X9TbvVi5dbFhsdYEN6Pu+tqQ2Y7TcTK5cUDIXCxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx4adh4P; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33de64c91abso1153291f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071931; x=1709676731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieLYzymPNePmb67aE/EpZNATNNR4k3uKBe/0iiseYBc=;
        b=fx4adh4PMuXxZbTp7GOABfUjBc8f1iP0i671dDajCHtEduTgPpxy63uXv+0Uq8O2Uq
         PxU/5gvN64nPDHiX/gRcvlnIByqW7rIh7Ygp9HvG+fMBD5bVezbm4B//+zR7uBBQN2hD
         +SEhFApq4qO06bBoNMiqt+6QTKUmGVaT0lTaHDYQm3yttGkHoUq+UUoheE4MAz2zxgCd
         us+Z//9o6EfIfme+ozAglCmUmpA4wRg5JOhSNhv0VpyN0sNHSshpTbx46+hbrCwr7V3N
         By4I7NKIGZrwT95kkQcS5meC9hQeDIi5S/Ov/woyvtBehfLwyLFM9lPviKW4Rm9Yjyo7
         WUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071931; x=1709676731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieLYzymPNePmb67aE/EpZNATNNR4k3uKBe/0iiseYBc=;
        b=NICwecP8GPZyF6ZAR16HEj+nfy8fyXSEZ8dpzGvHc2WtBM+eLeR/s401gGPiCN2jnN
         3mjqElfiyIKagy4FbVdKtP/sV1LwdCnTmA4UOi/CbihR+gRO6LjByXKwmByR4TtWpRvL
         kL9SEPwIWr8twUz/WJybi3JvDjNp9hwbgca981lP8f0hMlnOibQmcrlTVUD+wznA4QzR
         k3QpyOy/UV8H2lKoKcEUM9Q8Xr31TUDbLsRqKbdhhz301J8xlBHU197ehMOmepKA+3Pc
         BIcU6pRkmhSVsDiy404KNBFsVywvKq8jTj2Jtiq00m9JUY4/NskHYUrBfSt8kSayzF20
         j1tA==
X-Forwarded-Encrypted: i=1; AJvYcCXSy5rg974ZhBDO/3OvzFa0fFjJkxNwiQlcguqtfyyiqNvdl7SZyPL8chWrleo98cDkIyUFy/ci/m4uH0iVpBs/TK5JlfB/GL9KKq8d
X-Gm-Message-State: AOJu0Yw3hjl1sm49RYS8jsgibpp7Y8/PytiNGsAvINxDQ5VOY2nZcYoL
	xkSam1cdeBUybhFBylbhg9qyAGT5oWLT+7/e709CYCiNi2LFFioD
X-Google-Smtp-Source: AGHT+IGEPieExhprrrklXju6UTCtUDpK0Dvkf7ngQAnI0TNhp3s7PZ2YjipnG9rMPGWGhBYZndPeBg==
X-Received: by 2002:a05:6000:1:b0:33d:3099:e67b with SMTP id h1-20020a056000000100b0033d3099e67bmr8504809wrx.63.1709071930805;
        Tue, 27 Feb 2024 14:12:10 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id o8-20020a056000010800b0033d202abf01sm12415560wrx.28.2024.02.27.14.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:12:10 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] staging: pi433: Redefine F_OSC using units.h macro
Date: Wed, 28 Feb 2024 00:12:02 +0200
Message-Id: <20240227221204.534131-4-ikobh7@gmail.com>
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

Use HZ_PER_MHZ for a more robust definition.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index b3b8d1abd3eb..5a1c362badb6 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -8,11 +8,12 @@
 
 #include <linux/types.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #include "rf69.h"
 #include "rf69_registers.h"
 
-#define F_OSC	  32000000 /* in Hz */
+#define F_OSC (32 * HZ_PER_MHZ)
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.34.1


