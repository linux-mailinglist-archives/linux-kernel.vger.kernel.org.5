Return-Path: <linux-kernel+bounces-60430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F458504D7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D511F22398
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4385BACF;
	Sat, 10 Feb 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="p6cV09os"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656685381A
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707577784; cv=none; b=J82PMtB4Q+dXiSLS99WNdeCGP0CP0zPjXSYPKgzlxO6pQufsbh6/4uXcLVFtholoB3gURoAN3R7PwC2Yt9n/s66jMEaS026kEh0ZF4uYYGK24TRrCX8cN9+u3gbMCRGJ6SXGC/qXqfkh5VuxdaGgBh9cZUiTka9+asYQaM8Vq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707577784; c=relaxed/simple;
	bh=O3woKGLAIjryni1Jeart9hOwJG1ZEmeJEcbj6CVWNTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AjrYzBlxAukhs2Fbrqnz4i7KiqNtJExqR1qpeBnrcP5PaJexOZ5kVYxp2sxknbWXTl/WVQRUhGcxmr4S31cJ479wB2XnDRQiLcd7wskfwIV+24lflkh8JhpEbpZl9ppbZgXRpCiRbx5Q5lF9IY4nDp7gpRXM4+bgNvkbU7QietI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=p6cV09os; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso1624836a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707577782; x=1708182582;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1QaPWOuXyEob5IK2dCavHwEdoH6YtSk2GJpGvgSELY=;
        b=lJVZP2ohbegBUH7/GaH5t8NlYXZwDx+wXk04KglnPHOJajdOBbtLWD0KCw1iX1CCOL
         +8Rd6prAaBCXzmftV4jWJWkVdEAdf6BCyYbwPvEKe/Ko0XXE69LYM1WIxGndX6d5bid1
         aHWQMsV7/zKZMr3fukmQUfFatMZvtudBbAC5PDLI6okJHOiphL+2SJ53N3J6jDBK3yoe
         NFjF0kuVpgaSZW1l8kRD1+3r+zCDtS5vRbkw8Abph2Fp9CcsPgWAlJN/EiD7eEPwkiYI
         Bnm5yevBTh/uCCL6zPtepm60I3h/OARnchbI1yoEGgXS/8pLUMe8VJxy1osQuN/4KCta
         B78g==
X-Gm-Message-State: AOJu0YwOm3pM7dqhIi1K/RstQgtlloFq8q8zYk0jMsX9rm9Ua7S7khPb
	+ukxw4wQBjqSlz8EbowtcA16htSsFOwDnwEpWjTzv6QD5mUhX36V
X-Google-Smtp-Source: AGHT+IEsyTUHG3qU4Yn7ugUfww2m9F1UsL44fJKKGPdKg/28BPHL4fmIvrgXt7VzyeovZ3AL03D9ww==
X-Received: by 2002:a05:6a21:3189:b0:19e:40d8:7112 with SMTP id za9-20020a056a21318900b0019e40d87112mr1863911pzb.6.1707577781732;
        Sat, 10 Feb 2024 07:09:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVz+eVDf2QrkjRH9PbkRVoZt6Cz33Uy2qYjHWJVl6h3YGdNBHweldCE+2ibA7ZlBw5e2B/4vVw8nbwQS72m8shvtxzjqnX1F8WfOWx7ul/jayv4qXTuMVIHtSaPtFIEUE5DqKjHm//5Wg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id bj18-20020a17090b089200b0029709558393sm3415554pjb.57.2024.02.10.07.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:09:41 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707577779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p1QaPWOuXyEob5IK2dCavHwEdoH6YtSk2GJpGvgSELY=;
	b=p6cV09os2arbl8jiR6woLygay+CZTtYMmja+YCLQgNTSDhk47QnFAlWTV+1EC1tioVWtk7
	g6bu+TnaKJ4wdBpiFSeMt5aLh1rSS2nfo/8DeF3SBsUSMjXwpaRi4xcjYL3FB1TK3MFxoS
	wxooKCB7oIzD+1KS4lOHfvKrnsi6mr53owZtTc01PeL1KwqWIKI+Lpnej97mRXL7JEpxFt
	XPJG6f+boxVuayPq79BvFKNYn/7lSTKwKnw5WeE4vXZCkKMvyVtC1trHRTVSPgre/OA3Y9
	nna465EzfP5pKq1HI5Mi9zHkqHPJ/wpWh57JhIELOaKH4y3lcov1M+64uhDTVw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 10 Feb 2024 12:10:14 -0300
Subject: [PATCH] peci: Make peci_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-bus_cleanup-peci-v1-1-1e64bef6efc0@marliere.net>
X-B4-Tracking: v=1; b=H4sIANWRx2UC/x3MQQqAIBBA0avIrBNMK6qrRITaVANhohhBePek5
 Vv8/0LEQBhhZC8EvCnS5QrqioE9tNuR01oMUshGyFpwk+JiT9Quee7REheDUraTw9r2BkrmA27
 0/MtpzvkDNxWhc2IAAAA=
To: Iwona Winiarska <iwona.winiarska@intel.com>
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1653; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=O3woKGLAIjryni1Jeart9hOwJG1ZEmeJEcbj6CVWNTo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlx5HWXzeWYjUWC3gyPmxiPeBYUjpkdgMwR4KjY
 kwmqhCagn2JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZceR1gAKCRDJC4p8Y4ZY
 ptqkEACYh760FzcDVXtJDOPHGR2/2HxArqNC24eB5cpwNwQBObCSz45PVXmsUMAP7n7HUYOGkwp
 cOtsjL6cfUywVIw5x/FhShGiToozgdzBCDXmnS5GeNskcD8O4C69RXRzJPF6k21SkHVk+X1n5KA
 rdammB6VVxv9vb25p++4QxR9QuZIlo+wwAE/GOZKRDtcbNba7Sy/Q4gNOzyqDoXmKPGWAsBMvtk
 ATAHvWBFfLUDqNxEpbUNItC5ypgLCl8izX+vjE5fxuIA+3cTq2h9Aa8dSnL1umJW6XjeIrVeHEx
 3SZsKHfwqRmgZEiyUwdeHDepFChtKYDlGCOEXflP8ppK/ecFXniwNXikSZRD6TdfRtTjqlNzKVL
 ATEFUUAtTFLpKZYk7MOUrK35N9P7fwip3tluVNghHyyUTJvTJ6tShXe4BOZHZKnQn3nbhRhM2te
 YwlViQY1Ne9ITmY0toOXQpIvHTQh+f/7H5ZCoxzseHbuL2nm4WKOj7iR/hf6I4I93mz7+gsljLI
 xRZ1Z5MJrgbf3MgkqxZ+wBiDk/1KKDWPZ04U9IhxUY7lVd/RmEu0hGUb8ezQQQ3hfJpYeveX3JK
 jpgMuaQ3TCF48WRR1xbLxTGyiIvJlBwgeW1G+O1gFm3ta113Fu2x37NHtl6r9Ewel5EY7EhyFCG
 KlLs/0oG+XOF55A==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the peci_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/peci/core.c     | 2 +-
 drivers/peci/internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index 0f83a9c6093b..b2f8db967e9b 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -201,7 +201,7 @@ static void peci_bus_device_remove(struct device *dev)
 		driver->remove(device);
 }
 
-struct bus_type peci_bus_type = {
+const struct bus_type peci_bus_type = {
 	.name		= "peci",
 	.match		= peci_bus_device_match,
 	.probe		= peci_bus_device_probe,
diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
index 9d75ea54504c..8a896c256c5f 100644
--- a/drivers/peci/internal.h
+++ b/drivers/peci/internal.h
@@ -81,7 +81,7 @@ extern const struct attribute_group *peci_device_groups[];
 int peci_device_create(struct peci_controller *controller, u8 addr);
 void peci_device_destroy(struct peci_device *device);
 
-extern struct bus_type peci_bus_type;
+extern const struct bus_type peci_bus_type;
 extern const struct attribute_group *peci_bus_groups[];
 
 /**

---
base-commit: 047371968ffc470769f541d6933e262dc7085456
change-id: 20240210-bus_cleanup-peci-0933c629d58b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


