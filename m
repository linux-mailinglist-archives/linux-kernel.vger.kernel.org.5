Return-Path: <linux-kernel+bounces-76407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE585F6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B477E2826AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8100047A73;
	Thu, 22 Feb 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFxATkeZ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61B45BEF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601272; cv=none; b=fplvxp54hVkL+fWNnZDjDX91o15Uu6QXvWPRt2G3eL/fVEFO2T/s4Ve+Mta4skXF2y7ACAaFz3rYnCwZCLG4zu43IrdvKnyZqHbO41wtTB7plJIiJNVCPqbbL0xV9lba1xNrzumv2LqbHViVjW/SzL86d7BC1e6eOwssbHd/5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601272; c=relaxed/simple;
	bh=ODk9fkgS7BYWU+Gg1SjEmAFub5dXjOyUVZ3wrCXNqm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCGkvnglzICfRZbf9wFuA0tD5oD3CBOiTYxeMNKkTpMFSqavc7o9GB72ODiXTioNoZ0E/wGM5VnBYMQ2Z9+z9oudBeqp42KWoYiuk/Ovx20bdEnaIW0kqbHNVQ9a6LU2HEruDQnfx0O9qGf7j9N/i4RWDyConM8SlsXNzJvARjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFxATkeZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso8257904a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601269; x=1709206069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmUhYWRsoRWZAmukiCSIuLg/ZdC/ToO+ch53EbnA+RQ=;
        b=RFxATkeZFRoRpLTs4v1pDf1EMdRUk1ZURXc9evQLcD8CPv97ZoHZYbXYRTObJNQjsT
         x7v1IRcX77Y5CFi4X1x63WWhSJwYD0y5/6kmTs+fOkYBSWkk59VeIzAs5sikWeI53BR8
         Gflk3aNJn+JeRUkBbZzh30IMhGHRZ2zAaeECRBYGYnQ8S5nn1wRrGubNEbo/5JS/fzyh
         0O8BVa7E691HZmFpCVovpK0pqPJRcskt/oKsCYayRc1tfTRKkC1ov1sJHw4l+VfZlvMe
         5M+XDXIQqiSMmpm3uKFfkiSlgwd1mkKVXclZLuky147mqxThsdnScrCAhXM9PYunzsNb
         iv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601269; x=1709206069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmUhYWRsoRWZAmukiCSIuLg/ZdC/ToO+ch53EbnA+RQ=;
        b=UuFImyZywRkEmFiya1Q7GR6nwFqgi2DhScH8vlQbJfMFFMb1nhvHrakdOjuunHuZOV
         Xu2LwHImmvXnA6UAAf6ImnV0gFfoVWEFHNyN0Cwh29ietrshWHlUB/eRM3ZAbzrmfjJ1
         Up5BY/EI5mFD9Y60LxtwFW66CGM0Ci9bNbYcs/JDIHJrgfW3l1e0DXvCGHj9D4xt6vDS
         OsLeTwes3tGqJJOzeNHfxNB75MUWEJpDUQOo69L8Jev6jSzIXLDJ0KB4XLGTcQBEb8d8
         5jvu1ah62axJWQ3rRX17OfPbdtJxdBuowWzKFbsC8ssX9NVzGiQN9jerNKTzH+Hor5A3
         JQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1T+ui4lGhQjjN7m9dPwfeZkicK27RaXShfhcbhVPNEinzQIZdvu4+2lGUSFzi50e5KZttIyQAbABSq8++dV/CSMMcNC1G26dPz0TF
X-Gm-Message-State: AOJu0YyYxYhicLGnLog8Rv574/1Efqh4IHJUHngkhqB52WgJZ0IIbBbE
	W3jW2mFKlrfmPGUzHGvqXVlmZstEHX1zXRN4cRxSMg7wXvFnSG4q/xtBqi1N
X-Google-Smtp-Source: AGHT+IHtW0GuD91XcYaSU2gDY7bBfM1JJRyLzzy+8Cf5O8JnYufLlLQ+MkUMvOXSphsUGbj5JQLpVA==
X-Received: by 2002:a05:6402:22ef:b0:565:3907:be45 with SMTP id dn15-20020a05640222ef00b005653907be45mr1149547edb.37.1708601269376;
        Thu, 22 Feb 2024 03:27:49 -0800 (PST)
Received: from localhost.localdomain ([95.90.186.51])
        by smtp.gmail.com with ESMTPSA id ck8-20020a0564021c0800b0056452477a5esm4338524edb.24.2024.02.22.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:27:49 -0800 (PST)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8192e: rename enum members to upper case
Date: Thu, 22 Feb 2024 12:27:23 +0100
Message-ID: <20240222112723.18428-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240222112723.18428-1-straube.linux@gmail.com>
References: <20240222112723.18428-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enum members are usually named all upper case. Rename the members of
the enum fsync_state to improve readability and follow the common kernel
coding style.

Default_Fsync -> DEFAULT_FSYNC
HW_Fsync -> HW_FSYNC
SW_Fsync -> SW_FSYNC

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 26 +++++++++++-----------
 drivers/staging/rtl8192e/rtllib.h          |  6 ++---
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 4b622ad4c534..bf695b61ca8b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1523,7 +1523,7 @@ static void _rtl92e_dm_init_fsync(struct net_device *dev)
 	priv->rtllib->fsync_multiple_timeinterval = 3;
 	priv->rtllib->fsync_firstdiff_ratethreshold = 100;
 	priv->rtllib->fsync_seconddiff_ratethreshold = 200;
-	priv->rtllib->fsync_state = Default_Fsync;
+	priv->rtllib->fsync_state = DEFAULT_FSYNC;
 
 	timer_setup(&priv->fsync_timer, _rtl92e_dm_fsync_timer_callback, 0);
 }
@@ -1716,28 +1716,28 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 	    priv->rtllib->ht_info->iot_peer == HT_IOT_PEER_BROADCOM) {
 		if (priv->rtllib->bfsync_enable == 0) {
 			switch (priv->rtllib->fsync_state) {
-			case Default_Fsync:
+			case DEFAULT_FSYNC:
 				_rtl92e_dm_start_hw_fsync(dev);
-				priv->rtllib->fsync_state = HW_Fsync;
+				priv->rtllib->fsync_state = HW_FSYNC;
 				break;
-			case SW_Fsync:
+			case SW_FSYNC:
 				_rtl92e_dm_end_sw_fsync(dev);
 				_rtl92e_dm_start_hw_fsync(dev);
-				priv->rtllib->fsync_state = HW_Fsync;
+				priv->rtllib->fsync_state = HW_FSYNC;
 				break;
 			default:
 				break;
 			}
 		} else {
 			switch (priv->rtllib->fsync_state) {
-			case Default_Fsync:
+			case DEFAULT_FSYNC:
 				_rtl92e_dm_start_sw_fsync(dev);
-				priv->rtllib->fsync_state = SW_Fsync;
+				priv->rtllib->fsync_state = SW_FSYNC;
 				break;
-			case HW_Fsync:
+			case HW_FSYNC:
 				_rtl92e_dm_end_hw_fsync(dev);
 				_rtl92e_dm_start_sw_fsync(dev);
-				priv->rtllib->fsync_state = SW_Fsync;
+				priv->rtllib->fsync_state = SW_FSYNC;
 				break;
 			default:
 				break;
@@ -1750,13 +1750,13 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 		}
 	} else {
 		switch (priv->rtllib->fsync_state) {
-		case HW_Fsync:
+		case HW_FSYNC:
 			_rtl92e_dm_end_hw_fsync(dev);
-			priv->rtllib->fsync_state = Default_Fsync;
+			priv->rtllib->fsync_state = DEFAULT_FSYNC;
 			break;
-		case SW_Fsync:
+		case SW_FSYNC:
 			_rtl92e_dm_end_sw_fsync(dev);
-			priv->rtllib->fsync_state = Default_Fsync;
+			priv->rtllib->fsync_state = DEFAULT_FSYNC;
 			break;
 		default:
 			break;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c18169725452..ac6c52b58894 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1031,9 +1031,9 @@ struct rx_reorder_entry {
 };
 
 enum fsync_state {
-	Default_Fsync,
-	HW_Fsync,
-	SW_Fsync
+	DEFAULT_FSYNC,
+	HW_FSYNC,
+	SW_FSYNC
 };
 
 enum ips_callback_function {
-- 
2.43.1


