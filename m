Return-Path: <linux-kernel+bounces-85767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A608786BA76
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81042861E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F9C1361B6;
	Wed, 28 Feb 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKQoa0a+"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE71361A0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157790; cv=none; b=r9J5NK+kXBwS8Z9fCh62PTPh2iXmZztGaPXlufjBGjYpRmkRvYMDF4x8MP/MGU666oa0GMfs+50Zl4d8dwlPaBXkXp9iH1Dy6pl4h8zXs2zoonwIc7yG30WbEf8gSXnj1vgfOBxi/lXkVQqsaw/IWTg1F/v8bkj9cWv4MPrHYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157790; c=relaxed/simple;
	bh=Ybd/HW3xor3RSSR0F37+S3Wo7Gc0r4PsvTMb4I8HHCI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z2cUuFSoiHateAClnH0XJdC13DhERcx1YoRsLhhqBgileIdwqyETLw/CL9h2WvNwQe+MmgBK4UsbYNgRo5lr1hVeSdVpi/ins1LHNRMUtib8CuJYaWWTxm8NTrxTKmEDPNfBFSlozLUlEVuH2MIzkMrcBQNwKF3wog4aL635DgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKQoa0a+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso445980276.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709157787; x=1709762587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOALInjeSh3HTsFKo9WeEXTAmZVBSHgGCLq/ONkSsHE=;
        b=vKQoa0a+MuYFP7qu+/L7cVNB6QPL2QiKG6k0ejUKLLGASeEjtHXTizcOx4mHfzvHB4
         9VUNIUoBKkJjiLQEse12DknNAVLyLps8yN030mrxeoqt/9cY4caXfiDHrubjIZX1v1gc
         jRz12nVBlxe3s8WMMf9ZIjDmV1omJegZNDbRMyjBTc3CRjx8OhYMsLBlyELliakCjFQA
         K8piN8tcsJlLeus+fFhTCupKF+cJdnvCd+wKy7pjAptu8Jvyt8RlFW9sOlHj/Qkmtk0n
         7qiWTDOVs7XYRcHxKugbATK1Pq3aaKYSxM77L1x42P0NWTpDUIqQTyD0xoe8qqhq4tab
         Ytew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709157787; x=1709762587;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOALInjeSh3HTsFKo9WeEXTAmZVBSHgGCLq/ONkSsHE=;
        b=B/kTCZMai2yAE98Jvt0FbZSFDrCMe5NLDsmAfFNicLkNjz4Pw5QrhxS12B2SfNFrgO
         0Um1uxpBmnDO6xZwLs9xuC0yziRuw0dSBCfv/VowOaNfNAUK1kVArb156uqnSeeJZIY8
         T3CN7ugi1auAxFHg3lr7yQ0q7pmyYPHkACgxhqlEiWPa/cjGRWeIG+HFFl2dMelwOToj
         rq+3g3k0Dy4Qyr5wKhRefmWBGsOdyoTtVgUBia9FEIcJ91cliyaNse2plctAtdoqek8x
         2OncOkJ2P7pJN16VORyWifcjaJD1Oikb4olj0XH1oP03kfVlKveEcRengW6IpWn7jswt
         iOPg==
X-Forwarded-Encrypted: i=1; AJvYcCV2mscUOxAEKlhx/YVhyqs1v9NFj3j5THPGoM5Xbz9c65/dKgsDiZlH0hMsuyitomdJl59qRTw6Q0s2anBmYqWPaCPAJ6saO+WYuYVU
X-Gm-Message-State: AOJu0Yza4vb4QTYo2+sdhTU8OW41WT+j49b5dtv6GgmNBmtxKqvvghkV
	3LmkyvfkCziAxVDn4o0WBkdvNCwqPzNZmd+5+XkqFJRDBILY2uTDBXg1yfDedMlDmm4bURF4Su2
	tvQ==
X-Google-Smtp-Source: AGHT+IGMJv0UhUZ/qmZRP7/6yeugTC9G/Lx9cGOcVKv1FCV+MmpktOD6lzu7jHBhZw5mSTxD3Jq60w0kvRg=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:1142:b0:dce:5218:c89b with SMTP id
 p2-20020a056902114200b00dce5218c89bmr31900ybu.5.1709157787604; Wed, 28 Feb
 2024 14:03:07 -0800 (PST)
Date: Wed, 28 Feb 2024 22:02:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228220251.3613424-1-jthies@google.com>
Subject: [PATCH v2 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
plug type and updating the modal support macro for consistent naming.

Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in v2:
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

 drivers/usb/typec/ucsi/ucsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 7e35ffbe0a6f2..469a2baf472e4 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -259,12 +259,12 @@ struct ucsi_cable_property {
 #define UCSI_CABLE_PROP_FLAG_VBUS_IN_CABLE	BIT(0)
 #define UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE	BIT(1)
 #define UCSI_CABLE_PROP_FLAG_DIRECTIONALITY	BIT(2)
-#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	((_f_) & GENMASK(3, 0))
+#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	(((_f_) & GENMASK(4, 3)) >> 3)
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_A	0
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_B	1
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
 #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
-#define UCSI_CABLE_PROP_MODE_SUPPORT		BIT(5)
+#define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
 	u8 latency;
 } __packed;
 
-- 
2.44.0.rc1.240.g4c46232300-goog


