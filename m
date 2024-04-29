Return-Path: <linux-kernel+bounces-162822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AF68B6102
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7537B214F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D205B12881E;
	Mon, 29 Apr 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kuu472My"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14B8614C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414875; cv=none; b=fSgXoERADpjiuJnHW0b7QqOLrcut+XFWtfen6g8n65mfteBHC/t/nw/S+1eYj0XyhIdL2WX2YT5soKw5yJ0PNh8PRCH21Efd2qkhpxsDSaog6/vKtmyeTPB1iKYA9v3fP1aQ/Jljh2VJzW1TZWRWJHg6HaajxnWfyWluebKqJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414875; c=relaxed/simple;
	bh=uz91hq17CnQ8Sh5zJn2MbtAhwZLCaoUgLNJ2BANazg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hhsw8An4hG4GaPoh6v5t7wf+76izqkDDXKFOeN8E5tMSVCo8+M+JxShqrQyJ5Fzo9Kiq+6S7O7vVZDny0QbF53X/CxPbhGL19Cz2QYXiqS9wQPY1fJd9kCSy7enRPEDny6gl1UVFU5+aJKXHTli9ur3n/K/y65A1+/o1Koc0C9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kuu472My; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so3437453eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714414873; x=1715019673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBVxCic88av72rysgf6bYhkMGfNNdbGnMRLbJ+ADBuk=;
        b=kuu472My1bvUXd76YNoHXd1+CIKzivEkuNBRzsT647zVTN8EmJgdi22cTcRfg24fQH
         FnOnELVEDv89AgVDW7vucSSDtqTUI7+oeKpEbf4dhio85MeEcp/AsO5HhcAW9vci39X6
         0npu+sia4RpU6spWIgAgdC4GQ3UP88W7SLFPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414873; x=1715019673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBVxCic88av72rysgf6bYhkMGfNNdbGnMRLbJ+ADBuk=;
        b=NcV11wZYn4KvvuSf9EsNUJc4jpSyL9VcbUwUw2rOwA1+kEKFNAuXkiPrJ8jqF5ZsoP
         4QGEQVog7y3TTXabkgCdTDDcOoBlfCFrNy59eLCoqM7IyzahAf2TQHE1PRBi34M2WX9j
         gJJstw5Tj62qzoPTLwuSufdkPfBBt6jY6UshMN+aD75ZDIAob+5MeCAe7LPtNKsqgUe5
         yIrnSfZlPvFGUxBOI+gmeGZSmicEt38sr/hgNN/LpEBCPzffPheJuuKxXc2tMxKcl10z
         NEYLYl0+YnXvr07yVTBsoU1GvzJzZCdNNCY2EE3AliEv/yiSAsIH3YM2wvsZ6i4NtIpV
         eRYg==
X-Forwarded-Encrypted: i=1; AJvYcCW+l9j6J1F+zz2srKoQu0WpppkitT8pqamFks8LuiSzm1593vV71f5z0lvJtkz9jfaxc7/LxdwntZKkp6e5i0GwaQ0nVVQ/QwuydzIX
X-Gm-Message-State: AOJu0YwT8nhprRyMV5mnq7YwvAANpcPFelUGG+YLeVVmIpk2eJzjpZXP
	bHyjxXcShLXHunz0wvmJe1J3In1cQZBw2vUusUK9aGJZHXFn968iesnA2epUDw==
X-Google-Smtp-Source: AGHT+IGW1AClZt7yrZUX7DvN75b1Hy5u+Q/VGfw3SwSFCG6ZNRcO0lB67xbIFtPI1JNDURyCCGkxEA==
X-Received: by 2002:a05:6358:102:b0:18e:b6a9:6412 with SMTP id f2-20020a056358010200b0018eb6a96412mr5292990rwa.18.1714414872815;
        Mon, 29 Apr 2024 11:21:12 -0700 (PDT)
Received: from seobrien.c.googlers.com.com (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id y12-20020a0ceacc000000b006a0d04827e9sm1021160qvp.57.2024.04.29.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:21:12 -0700 (PDT)
From: Sean O'Brien <seobrien@chromium.org>
To: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Sean O'Brien <seobrien@chromium.org>,
	Jiri Kosina <jikos@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: Add quirk for Logitech Casa touchpad
Date: Mon, 29 Apr 2024 18:20:36 +0000
Message-ID: <20240429182036.1.Ie7e8d0ba595f9e39f71cbe4ab3468f79c00b4581@changeid>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This device sometimes doesn't send touch release signals when moving
from >=4 fingers to <4 fingers. Using MT_QUIRK_NOT_SEEN_MEANS_UP instead
of MT_QUIRK_ALWAYS_VALID makes sure that no touches become stuck.

MT_QUIRK_FORCE_MULTI_INPUT is not necessary for this device, but does no
harm.

Signed-off-by: Sean O'Brien <seobrien@chromium.org>
---

 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8376fb5e2d0b4..68b0f39deaa9a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -823,6 +823,7 @@
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
 #define USB_DEVICE_ID_LOGITECH_T651	0xb00c
 #define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD	0xb309
+#define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD	0xbb00
 #define USB_DEVICE_ID_LOGITECH_C007	0xc007
 #define USB_DEVICE_ID_LOGITECH_C077	0xc077
 #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 04a014cd2a2f6..3df9e90693e3a 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2081,6 +2081,12 @@ static const struct hid_device_id mt_devices[] = {
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X12_TAB) },
 
+	/* Logitech devices */
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
+		HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_LOGITECH,
+			USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD) },
+
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
-- 
2.45.0.rc0.197.gbae5840b3b-goog


