Return-Path: <linux-kernel+bounces-161874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD208B528D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3EC282048
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A615AF9;
	Mon, 29 Apr 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfSPIQv7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9F14AA8;
	Mon, 29 Apr 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376968; cv=none; b=RFpOOMsQzftvEzwdxLtBIs9XkZyCcma61DJM8TJDkOVjZmvtcE8LnJN85Qu7CX4vR+VTZ8Ibm+/94gIHlgsUh0ckQpM4xprQkfc2wi1W6Nmi01siSjP8a/G6csUL/dQCpc0dKVP4i6/uMUyFZVxzE1mUC07TT6AuZkgRN4Jt9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376968; c=relaxed/simple;
	bh=eIsAkO2TaiFHfV1YDVy7nO5WUNEWgR9F+gnZBrWDgvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MtSaa1ibKYnOPTU/RMuaoNcwYNNXUzjbunCQNGB+5U30mv5/ioisQw+gWKlodRYpXiqpe47POPvmSWO31BuUTdQk4+nU2Eybc0B49T5+zeQqD9EvPaNL4buFIcqB2zx1weXkhsyJKHebJUEEt6mrsb+BmTmpsiIbxfKExkb8MIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfSPIQv7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51c077cfc09so4788698e87.2;
        Mon, 29 Apr 2024 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714376965; x=1714981765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ8iERLxVujR+lilVZE+rixuOHmFfYyTXZLkb3Z1d30=;
        b=VfSPIQv7RQibwIA2859Wj53dL7CQPtfjVV96r1Lc5fJay8bboYeBYmCPzic79NY24W
         BUkfi8r9CF41KyNwFy9TWcD88frI5W6Zzzi+FDaUcGrtSWef63mgSE8oFeW5htyFk1QY
         O9x5H5kKpXq4VXj6KKf2Uo8AMqbYzeOzSs6UvMQCoBsPHM9l4BT83cP7xsq/teJ1+2rr
         JQyjNG3SlEZIG65RcyduVgKFL/Eipsv/vM29HOd2+K2AEk22WKc7aSDbRcH+NMvIurYF
         V+GW/T3Sj/uteVPBNGk625Ny/1oA4AtoB3tnl2IIm/fPO8lfpxbAocqQ0luxjIFP0CoM
         k7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714376965; x=1714981765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ8iERLxVujR+lilVZE+rixuOHmFfYyTXZLkb3Z1d30=;
        b=LRU9Ddz70Q1atBZGFld/8VFhph29//r966M8ZUxx/sTD6Q5m0gDvKJ/nEcpcJdDT4R
         SX6E2aUTk4KNDU2j1gcUyuraBXtJJB/ThtqrkeYSejtOlJSy+QzX567/2t5AW8Ql8lKB
         fFyz73A5e1eBYMbHDDWOidEZBHvL1M7j2BgUrbKoCGe8G3Pl2aWFLKrc32qvmDlrdtW3
         h8tuGBH6QPbksMWmdP4nqKPenYT+GQgkpLd5xacIU8P1zQscWHUtpwhUzPZtREedSLDC
         wUW2khnaqUfams7swqIczQa8yxVLHiamzl8QVoopA2Zn4Ri8KprTmUNm6WUCYx4bNBzw
         M1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUfRl9gVf8Bbktlrp6TWMtjHmC67Hqxd9WavR+4hJyaI37Qu6LA5VyE7RdDll7xZpldx41f1OnD1Q3IoloB0CC1n+/4lQ39LOgNSrZix0SR2H0++I+OQBcvHqrMZXNVpL5Vm02+pwBopNU=
X-Gm-Message-State: AOJu0Yz846TNkMcbv3y8SXBKkrC2YPiVoV/MoPe5JKp4/qajA8lCRMPf
	0ZoLHXHB53tQ3Jlras9KeNABa61VCIOLu48mJ8VjJFLmpekf9C8raG9t6g==
X-Google-Smtp-Source: AGHT+IEPTPDS0rpVdTT2tVoI5hHxdAvWRCL5Tgcnc6seAdr3EX2dbLgzsV6uEnPdWlaGA0RGcdBEKw==
X-Received: by 2002:ac2:4542:0:b0:51c:66eb:8a66 with SMTP id j2-20020ac24542000000b0051c66eb8a66mr5134593lfm.67.1714376964681;
        Mon, 29 Apr 2024 00:49:24 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id cs7-20020a056000088700b00346cdf48262sm28965784wrb.2.2024.04.29.00.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:49:24 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] hwmon: Fix spelling mistake "accesssible" -> "accessible"
Date: Mon, 29 Apr 2024 08:49:23 +0100
Message-Id: <20240429074923.1073720-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the module description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwmon/lenovo-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lenovo-ec-sensors.c b/drivers/hwmon/lenovo-ec-sensors.c
index 50adeb82468b..143fb79713f7 100644
--- a/drivers/hwmon/lenovo-ec-sensors.c
+++ b/drivers/hwmon/lenovo-ec-sensors.c
@@ -598,5 +598,5 @@ static void __exit lenovo_ec_exit(void)
 module_exit(lenovo_ec_exit);
 
 MODULE_AUTHOR("David Ober <dober@lenovo.com>");
-MODULE_DESCRIPTION("HWMON driver for sensors accesssible via EC in LENOVO motherboards");
+MODULE_DESCRIPTION("HWMON driver for sensors accessible via EC in LENOVO motherboards");
 MODULE_LICENSE("GPL");
-- 
2.39.2


