Return-Path: <linux-kernel+bounces-72506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC885B46B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C87282356
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22645C03D;
	Tue, 20 Feb 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI7I8Lk2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21257313;
	Tue, 20 Feb 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416292; cv=none; b=PL0NT56nWlrKGdFqrLv1UqAkNloK44mkwsd5u+8lyWkK2ihuhlWWsR6NFQSrTKDjcisIoVlaw+zs4ehMXp3MNf20RuX7s920nbOqApm2rTzNFH2fhFTefSQ2LHczXbBaUI8zOs2NDzZ5yCxHhVa+Nu7usZIHn7ngwYbpZw4uObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416292; c=relaxed/simple;
	bh=EU/STwkCla0jaqhFKG2DqIl0BD9+VkpPzOpi0k8lpe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzZMCtIgZCUqryp7+ySh9OTGUMsZ5mXvdJqT3Rmu1/VTVxSL8WMr8p/w1JwUNVx+OZaHRjTI64jGmPc89muUWuDQRnU+breH4cCd3FGIhN9IDPlfo20tcfP3UThIb8LNjRYmzddykCQ3G2xS6KiM3Pmk3uzfoyodzsBlXnygJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI7I8Lk2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e4670921a4so1067399b3a.0;
        Tue, 20 Feb 2024 00:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708416290; x=1709021090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VObNkuiUIEXOfaYY5k7L6fIMBdRV1v/yAwcJqKRM/zg=;
        b=NI7I8Lk2x44MdOhZ7WUp5YRadr2Sdv5k+NBBawGe8qkjlMhS39LSqz0Fjm2yoZl0rB
         BQKhPN1GnDUUlkgWrP+hL0O9GmYqeU/6jzQhIZ+8q+cuPbIVyq4eaK8wxzlpb+Neif4Y
         zWFtg0g1dSvU64+NpEMS6+iuLadjERd50uDD6GyQXr5OqnxMCvaHjRtVT2HC+8x6utPN
         HIEKQijZnWQqwsaLLORNmtfk5SYKQRCkrwyJP2ESCV19CM11iSXJXLDHGHm5GmP0SZdZ
         wTEer9jTfgBsi6HnUGtatZu7waibeEUNaIbmPmXPHGzuErfinBW3EQ2u8+7v7t5bzGDO
         s5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708416290; x=1709021090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VObNkuiUIEXOfaYY5k7L6fIMBdRV1v/yAwcJqKRM/zg=;
        b=Tq5rtZCx9hH3gfghR6t2tH+L7MvL3EDTbby+48OYiXkjOjXsdp4vpJW2BPysxQ8kPh
         v9foyCtWicr3GMk3Mu1tfhhYVSA3mp5ajSRCqSpfUODUq9t3Ybk0sMe9IXrrxJqfJfcq
         ENziQw2sg0GDQMfn6IQE3LPDq9VqzIq0QROgBpVLxUe3MebGgFYfK+wHZ7JwCBIEOH7R
         WfAXWmCZ+XSMYzchbwkKez9A4LfiUIStkhvxepflmkaNggUiBKLe5hHM5rDe0UOhkJae
         eI0qxv5ZwsVqESdf1T6o1xlIdSYaaFDwnEGKCzbVy0KGOhkyxJ6iOmQU7VokGFXfkmdM
         scnA==
X-Forwarded-Encrypted: i=1; AJvYcCUG97ucGe3TqQCk2bllpKx0iFTMVcpYonBVcSwInRTKzksEQ4a7Fh2fOcI3qL3qicxB6vq7JD03Z11al7qyB6H1NCr7cOZ8JUTYwg2ax1c1PTbtoNsvHPgUV4q6GP7djERqacKkCowTtjoihW+JQp8L8Q==
X-Gm-Message-State: AOJu0YxQdVHyKfI0NylMnapeQkdY3lQp0z7CcgKmBs5cSQZNwSWeaInl
	DGtznXrPGvi1tn1BFt80dVF6DNmLx0LoPDchye3vdqesgi+ZWRup
X-Google-Smtp-Source: AGHT+IHo7lfrKaNqjaNnz9v9jwM3hnu2FUBW9Fg5Frzjib/JCeZp93YoYBYQ66s9Eb191Je+349Mjw==
X-Received: by 2002:a05:6a00:987:b0:6e3:79ba:6eed with SMTP id u7-20020a056a00098700b006e379ba6eedmr11038526pfg.13.1708416289774;
        Tue, 20 Feb 2024 00:04:49 -0800 (PST)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id s12-20020aa7828c000000b006e0651ec05csm6165860pfm.43.2024.02.20.00.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 00:04:49 -0800 (PST)
From: SungHwan Jung <onenowy@gmail.com>
To: "Lee, Chun-Yi" <jlee@suse.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: SungHwan Jung <onenowy@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: acer-wmi: Add predator_v4 module parameter
Date: Tue, 20 Feb 2024 17:04:16 +0900
Message-ID: <20240220080416.6395-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This parameter allows predator laptop users to test and use features
(mode button, platform profile, fan speed monitoring) without
adding model names to acer_quirks and compiling kernel.

Signed-off-by: SungHwan Jung <onenowy@gmail.com>
---
 drivers/platform/x86/acer-wmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 88b826e88ebd..bee8c547374f 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -276,6 +276,7 @@ static bool has_type_aa;
 static u16 commun_func_bitmap;
 static u8 commun_fn_key_number;
 static bool cycle_gaming_thermal_profile = true;
+static bool predator_v4;
 
 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
@@ -284,6 +285,7 @@ module_param(force_series, int, 0444);
 module_param(force_caps, int, 0444);
 module_param(ec_raw_mode, bool, 0444);
 module_param(cycle_gaming_thermal_profile, bool, 0644);
+module_param(predator_v4, bool, 0444);
 MODULE_PARM_DESC(mailled, "Set initial state of Mail LED");
 MODULE_PARM_DESC(brightness, "Set initial LCD backlight brightness");
 MODULE_PARM_DESC(threeg, "Set initial state of 3G hardware");
@@ -292,6 +294,8 @@ MODULE_PARM_DESC(force_caps, "Force the capability bitmask to this value");
 MODULE_PARM_DESC(ec_raw_mode, "Enable EC raw mode");
 MODULE_PARM_DESC(cycle_gaming_thermal_profile,
 	"Set thermal mode key in cycle mode. Disabling it sets the mode key in turbo toggle mode");
+MODULE_PARM_DESC(predator_v4,
+	"Enable features for predator laptops that use predator sense v4");
 
 struct acer_data {
 	int mailled;
@@ -725,7 +729,9 @@ enum acer_predator_v4_thermal_profile_wmi {
 /* Find which quirks are needed for a particular vendor/ model pair */
 static void __init find_quirks(void)
 {
-	if (!force_series) {
+	if (predator_v4) {
+		quirks = &quirk_acer_predator_v4;
+	} else if (!force_series) {
 		dmi_check_system(acer_quirks);
 		dmi_check_system(non_acer_quirks);
 	} else if (force_series == 2490) {
-- 
2.43.2


