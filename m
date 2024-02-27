Return-Path: <linux-kernel+bounces-83564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B9869B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0B1C24914
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5B1487C8;
	Tue, 27 Feb 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjltX1F3"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6E14831E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049707; cv=none; b=Go18bqZzxNOBOZu5Z0lmRGLf2vudjXGEbwVB1boDYLKVApJDkWH3eiNayj3T+If+fZ/HsqZ+Oda3We62AoGcK6JQnoHCuvDFMhSXWy13LHo+0BluOI9btPAoiIJz960dAHET3Tv+wojNXMKwYvGtnl8JPcQMGUFGXCNXOkMClGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049707; c=relaxed/simple;
	bh=rj5M9NTOw+mlLPuNBzddxSdKcQk7qpqzonx/WQhvBg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvZCoOVxuhRAqgZCL85TW5Lye67tbyEGfArhKrrL5lvyx56i5ZsfNvzErzHgHZ53xA27ja6WG9MiGapWWLBCR9ph1ASnzC/+arikeKj/FYgveqX50k7nIDvXAUVy0/e/xFtDdi0cjWyyxRAGxsRbBg0EejDvDfU6EP+Imr14wcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjltX1F3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d23d301452so61646541fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709049703; x=1709654503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw+xXvSI28q5RO1dOygG9JjocsqAHut9oZzvrKjoGSM=;
        b=kjltX1F3ZjTf5cqd9xy6JeNw5OzwHRMjIT9BTV7xrhLoudnYYIKQ9SWZ2E0e+vjzPB
         GJE65nq86X+ogoN1jrxY0yflcUzmJoI+WXOlaRV9kRhjvD/EBB4VGi0Y0TYpSUgvGh81
         5/u3YjMgFzEwigf3NZA2aoxM7uMQM/ZTMDl0qzLD/IW7dRG4MaaTjZa6Aw716cWQTCDV
         mnWQV38cRabB8grdieQcP2OeuXBWw8EbJIcEY5xllNJiD/tqiQz8TSVklDcSKESOBOJF
         LtdOmIdJexLH+2eesJsUf6LN8YF3583UfOGF6tLGBt65bffhbo2KB7BXM8GzQQzDicfB
         CFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049703; x=1709654503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bw+xXvSI28q5RO1dOygG9JjocsqAHut9oZzvrKjoGSM=;
        b=HY45z53qgVpP/xVtkqOnc7bDtsI4EU1OGsWWUd5fpSP2otqBHSS+7lyj5NMekXZgPB
         Wh+QgBL0Ra+deWehyFA62KVT9YVxdJwd6Ho7Ir4CMaNtytG7tKM7OjS5smyVNcVNaT4Y
         I+WVBTO4XQ67Jj4lM4xeWImXeedHuOM5ks8WyqgtjEnkQ5U5EdVLahHHbUEKURZfuctF
         9cu4+g3+jFwUoxlHCF1nfhavNzWrPQ42O/u84gIqXBzeznJ2Vx2ZZ5zTBdd4feHDefna
         Udx2NAR0AQBFPOizuRVF729XZLoFDs63T5oJcDep6SUt5ihy7NSqgb+oJ0TCfia+Y3GQ
         MJZg==
X-Forwarded-Encrypted: i=1; AJvYcCVHXEdeU8CI66UuCOFaLuAqcuwhpA6u7cI6eyensrlcu1xSBB0aPAGSSS+alAHVJVz1QoCTdfh4p817hOLvvdm/og6sDhsca9pe0QiO
X-Gm-Message-State: AOJu0YwRIeixGT4LYfEIGIMhuK7zWLphks8eN1b/tdHGgnjKRDxk+SX1
	f9LOGsVCxAxP9drYMy6WimaetsRMUuad2bhs5wBJmqFsybVHl4H5
X-Google-Smtp-Source: AGHT+IEjjiHreFIpagJZhsvqT3vXcRrneODTErc9AB6tq16rbUuhBf8n8mhbKupYMkbTwMrDBvOdJw==
X-Received: by 2002:a05:6512:2216:b0:513:16cd:1377 with SMTP id h22-20020a056512221600b0051316cd1377mr378703lfu.1.1709049703230;
        Tue, 27 Feb 2024 08:01:43 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id x18-20020ac24892000000b005128d0e2a07sm1228190lfc.308.2024.02.27.08.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:01:42 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: vireshk@kernel.org
Cc: johan@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/2] staging: greybus: Replaces directive __attribute__((packed)) by __packed as suggested by checkpatch
Date: Tue, 27 Feb 2024 17:01:13 +0100
Message-Id: <20240227160113.111264-2-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240227160113.111264-1-bergh.jonathan@gmail.com>
References: <20240227160113.111264-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following changes:
 * Replaces '__attribute__((packed))' by '__packed' to remove warning as
   flagged by checkpatch

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/greybus/greybus_firmware.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/greybus_firmware.h b/drivers/staging/greybus/greybus_firmware.h
index f68fd5e25321..b6042a82ada4 100644
--- a/drivers/staging/greybus/greybus_firmware.h
+++ b/drivers/staging/greybus/greybus_firmware.h
@@ -41,14 +41,14 @@ struct fw_mgmt_ioc_get_intf_version {
 	__u8 firmware_tag[GB_FIRMWARE_U_TAG_MAX_SIZE];
 	__u16 major;
 	__u16 minor;
-} __attribute__ ((__packed__));
+} __packed;
 
 struct fw_mgmt_ioc_get_backend_version {
 	__u8 firmware_tag[GB_FIRMWARE_U_TAG_MAX_SIZE];
 	__u16 major;
 	__u16 minor;
 	__u8 status;
-} __attribute__ ((__packed__));
+} __packed;
 
 struct fw_mgmt_ioc_intf_load_and_validate {
 	__u8 firmware_tag[GB_FIRMWARE_U_TAG_MAX_SIZE];
@@ -56,12 +56,12 @@ struct fw_mgmt_ioc_intf_load_and_validate {
 	__u8 status;
 	__u16 major;
 	__u16 minor;
-} __attribute__ ((__packed__));
+} __packed;
 
 struct fw_mgmt_ioc_backend_fw_update {
 	__u8 firmware_tag[GB_FIRMWARE_U_TAG_MAX_SIZE];
 	__u8 status;
-} __attribute__ ((__packed__));
+} __packed;
 
 #define FW_MGMT_IOCTL_BASE			'F'
 #define FW_MGMT_IOC_GET_INTF_FW			_IOR(FW_MGMT_IOCTL_BASE, 0, struct fw_mgmt_ioc_get_intf_version)
-- 
2.40.1


