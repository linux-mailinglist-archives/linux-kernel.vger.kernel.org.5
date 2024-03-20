Return-Path: <linux-kernel+bounces-109486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E53881A24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1591C20EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4778613F;
	Wed, 20 Mar 2024 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uopcagLU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490086122
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710976925; cv=none; b=pbrhE7+T4Of2YIUjlA71jK3KnSp6ENzGk2YaJFUAUQBslhZMwFdb1wZBaWUcqVpi2BH9CcqzwXZmkJ2VRR7pL++zKAN8oPkqe5onvjvDt3e6p/zfKxi3u6+327/4nwr/iOZ2nHZFUQD1pxhhlQUEqphUqV+vhNc344bjZc3TgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710976925; c=relaxed/simple;
	bh=LstULD3SZgSv3OfqQEREHb9PlnHVDFzksy2daTuKq/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uIekWKvXw4E1EwmYrDZYe6aO6hyS+hHt/vQS+2RQ52geAOkN9wXlhatNQs2G7rC+yjUOyE36cOg+9ITi9rLiUYN9a2T5TDn1OxCx3BEs4EvJcpDMQ9qUwhMg9ucMfeGo5Vp/Q1K0qu/Ow3eEeIrgpS7QHqwHMXrQ43HtyuHZMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uopcagLU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so1853420276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710976922; x=1711581722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=31u9h4pRsIoYT5xL2+2Sx/Q3BDCy9WQzGQxSt0T02WU=;
        b=uopcagLUe9FUu5r+Uju/IIdjmlZvPd8g8tPAHZeY1L74ucLYao2lqvpJWWEkGKRz78
         xrkjAjMclpsRi8qc1hy5NIbfcaioJnTkBNbugXLKVpGzvzo5IHVDHbIBJjgeT5HQkXzB
         iqcD1xaTHex0kL7fWJ7049ZAhs8Nbx+Bvg/GU1Q/XA1+racvK/Df+zYoY48PRta1V1lK
         5tyflTyWUhpq+pC+ZE6YyXwvLY3wZcSYObhcLy7nukRavgR2B/U4VJeLX08y+trMRrQl
         8kcqT9YdLMjujjOp/aQQFG/vMjfNIHJrIJcmQ1LdRl8mKopXzHwjDQO9LLFSL+Ap3Jt7
         k0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710976922; x=1711581722;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31u9h4pRsIoYT5xL2+2Sx/Q3BDCy9WQzGQxSt0T02WU=;
        b=cjEbWK3CG2wVj01yKItV+G21/dNmtF1mcD3oRRa6YeFv4FlNPnSn2wBKtkPIOHfXkJ
         oSltiYhONsGQsSBzAJS5hMT+fXAeIrMafiaNjI/V5YdEI9rohal0njAFgEyyaxVoxqOb
         wKeGWfradDzxoFYUSytO+mv4qHyGokXLp/7ou8eEzjhVH6YV395pw/IdphCgQbim5KCc
         6Uy9POcc5qN4C7fFmLIMu6E1TS+69F5eDmePnQKI2sLw2/vVJ5cbqMIQS7Vc0W/fFCPV
         yTAIEHbhhkcMbwO+1Ynx1NTEyk+93EKw51/ZHQAB9Ehgb/t7e/bO9SRk6jZOLjNTs0gE
         fdtg==
X-Forwarded-Encrypted: i=1; AJvYcCXbCiLau6XY7A5Nsr3cLX8lz2tYVm4KyFFV/C4P9hQiKUW451ou6khBvPfXdH3nVXBA4Wm+ENmxRNwmVSdwLndAXorj+ZW7cOz7R4uM
X-Gm-Message-State: AOJu0YxzsN8o0NREN6o/49IQTSiMeiNoV5rvZeYpX7KmFprjhT3E7VXJ
	gOeuOSplML1+4MZWdSLCAirBeJ/QJJKs+c9FGROZyqpdQZG+XCHi8tBWqjNdKmPTTSSNvID60oK
	95KzGp2C5UJvUXwgO9lN+pg==
X-Google-Smtp-Source: AGHT+IEbxaoDxR39hoPNgni/Vs4CVRqb2djIgFXCSM9OsEXWBDwH4FweLj7pnfzYDXD3ipk1F2Hy16EUjCN+ESro/Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4b84:0:b0:dcc:2267:796e with SMTP
 id y126-20020a254b84000000b00dcc2267796emr201630yba.2.1710976922546; Wed, 20
 Mar 2024 16:22:02 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:22:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJlv+2UC/x3MwQqDMAwA0F+RnBdoqzL1V8YOs4maw6okUjbEf
 7d4fJd3gLEKGwzVAcpZTNZU4B8VxOWTZkahYgguNK4ODm3XFLc/kkpmNcxCvOJCX8GIY/QdtV3 bP/0EpdiUJ/nd/et9nhdMvlXFbgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710976921; l=1895;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=LstULD3SZgSv3OfqQEREHb9PlnHVDFzksy2daTuKq/I=; b=asHNy0GS4ziNs7+teZK7JmBwmWLU7eI7UJYX/Jv9UFQa5idrd1r/icfuQF/NfP0K1Tp7LHyZY
 MGpRYh9EuvuDYbE8MrciB/WCTNc+XdNdU97Xs+IFqzbG81WPC/L/6PW
X-Mailer: b4 0.12.3
Message-ID: <20240320-strncpy-drivers-video-hdmi-c-v1-1-f9a08168cdaf@google.com>
Subject: [PATCH] video/hdmi: prefer length specifier in format over string copying
From: Justin Stitt <justinstitt@google.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

It looks like the main use of strncpy() here is to limit the amount of
bytes printed from hdmi_log() by using a tmp buffer and limiting the
number of bytes copied. Really, we should use the %.<len>s format
qualifier to achieve this.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/video/hdmi.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 03c7f27dde49..ba301f3f4951 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -1310,17 +1310,11 @@ static void hdmi_spd_infoframe_log(const char *level,
 				   struct device *dev,
 				   const struct hdmi_spd_infoframe *frame)
 {
-	u8 buf[17];
-
 	hdmi_infoframe_log_header(level, dev,
 				  (const struct hdmi_any_infoframe *)frame);
 
-	memset(buf, 0, sizeof(buf));
-
-	strncpy(buf, frame->vendor, 8);
-	hdmi_log("    vendor: %s\n", buf);
-	strncpy(buf, frame->product, 16);
-	hdmi_log("    product: %s\n", buf);
+	hdmi_log("    vendor: %.8s\n", frame->vendor);
+	hdmi_log("    product: %.16s\n", frame->product);
 	hdmi_log("    source device information: %s (0x%x)\n",
 		hdmi_spd_sdi_get_name(frame->sdi), frame->sdi);
 }

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-strncpy-drivers-video-hdmi-c-bc18d585971f

Best regards,
--
Justin Stitt <justinstitt@google.com>


