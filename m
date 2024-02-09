Return-Path: <linux-kernel+bounces-60135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C2850098
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D621C23681
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380F37149;
	Fri,  9 Feb 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJfR1ahq"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0836AE3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520061; cv=none; b=TM/x9YDb2wCAZIhAlpDldmzNMWNZCMcdK6Xa2cKSWGlaIir+apMUJAjy47l3T7Fysd9j8C3p4qFP7lb9R2TDzueWByP48hW0XUn+qjy5CfeyB9hb1bbWHIG6Ijkr7QzAj7kxLcVjeBj49kY/H7PH6L83kHj/peWDLT3TnlsEGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520061; c=relaxed/simple;
	bh=8HElzopGcSrPzjmzDlv/HH9iotHcogieQOgXsP+RqXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2Kl4ws0LX/obKqIfUgdAwy/o+N8eZ0I4TnVgi3y4PlpTwnh2cpbBW1d5tqJFmaRLpTOgx7Yee72FWr9Gk+s/MGPm2TG8QsLHrdd+W4ay7+Gx2VJWqYKt/1D9MLXNp7Potb1ZV7rO87u5Z7fc2M+LRYTLoGRqkMpI2076KwgV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WJfR1ahq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d8aadc624dso12541135ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 15:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707520059; x=1708124859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0AAKh3Wo2mucOY5wb8UuYlu0VE8Lc/bx4O9HZBol2Y=;
        b=WJfR1ahqD8O7oAh+zpfWEx8wGoaOu9O6fC/fpWhSzc4pnxsbWZm2LBenJBevTdADgs
         xqFfSgqK4GITzO3c17nAnExv8T6WhcHtPbSvM5WJvkb9Zcw8eE9P5ybT5ID6H91R6Ejz
         EWbYTJiXiTKCLeAA4r+B4lnyQuYsIgpN8o4+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707520059; x=1708124859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0AAKh3Wo2mucOY5wb8UuYlu0VE8Lc/bx4O9HZBol2Y=;
        b=oSQwSh9/J9eReBOMCDiOukiLWecvKU9YypNHUAQYJ5xIPymfcT5xo5CdsZ7vODuhtY
         7kD74OxqldZESKLV6XoMBR/sKR52IExRrCcOLF/fBnGNR9PVdG+I0Y0BEA9B80SAdWHQ
         DdE61At/KT2f+jhoLnXj1hRKDrDSuMEr+XhgtJN7Ix5VPAFO8nzyfQiC/YoVOYvoEZvm
         3M14Abe0AODXiOb1PZZWWVdXXC0BXNQYqJ+ymc9jlve+8dt7gnbfcBkUnqw9KjpQv+Dj
         OMkpOXGDJqAqPDrNeGKjiC5bZbWWx2xn4G8DJioYAC0lX0IOJayUp8UYtmm4Nd2rJrzm
         7Bow==
X-Gm-Message-State: AOJu0Yx5OfF9HCH9Y0G4wREDph10UOL0uLqABM0k+ZTkx0e7L6j9aq2o
	zSj2BbP+ao4OKTTuRA4uWtNuUO3Z2BA4y6R1nDmtfEyeU6Sn46IvbFON+RtsxeWRXEnZ43sc4YI
	=
X-Google-Smtp-Source: AGHT+IFL9RHVk3uCQFF0DprNvA484nSxWe0VP1yRH/6W7hVcnH4/YHX0eTHjgAM2QC2IjPg9h3i/dA==
X-Received: by 2002:a17:903:3287:b0:1d8:ef8d:a7ec with SMTP id jh7-20020a170903328700b001d8ef8da7ecmr791832plb.2.1707520059124;
        Fri, 09 Feb 2024 15:07:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDE5Zm1a3P2M31ED2lYDsdVKWUiifBjfeD9GUtliSejJJrynoU9gkJUtoO6XXHnS1vOPr3E8JFge1ePG6ubgi4reDU62++bgfk8yAPJ5T/zMpnyWMmMD/NQdfb9XF6iA3IS9xdiVJ/EQObB3hAWcZ3wQqGeh47uF7AXwWWMUMUU2zpOeT2tSu2yvD50s3puYpYrIg+oVKUWO5IlGivHe/z3+FnkoQVIkzglH5cV0DRHdzWwWGKGVrcMBjwOcX8buRSldvAWrYvORxpkWt+NZP8eF5uXIDgmuVmTtiCPStVX89vIUqfAax0gMHLF5ZYqTzLtFqqZItDNIJ8KqYgxIZLk4yhng==
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id v7-20020a170902b7c700b001d989dd19b0sm1988210plz.140.2024.02.09.15.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 15:07:38 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: David.Laight@ACULAB.COM,
	pmalani@chromium.org,
	andriy.shevchenko@linux.intel.com,
	keescook@chromium.org,
	torvalds@linux-foundation.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] minmax: Add notes to min_t and max_t
Date: Fri,  9 Feb 2024 15:07:02 -0800
Message-ID: <20240209150657.1.I45addf7579e1233fa97c05ba72120cd1c57b4310@changeid>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both min_t and max_t are problematic as they can hide issues when
comparing differently sized types (and especially differently signed
types). Update the comments to nudge users to other options until
there is a better fix for these macros.

Link: https://lore.kernel.org/all/01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com/
Link: https://lore.kernel.org/all/CAHk-=whwEAc22wm8h9FESPB5X+P4bLDgv0erBQMa1buTNQW7tA@mail.gmail.com/

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Andy Shevchenko made me aware of this particular footgun in
https://lore.kernel.org/linux-usb/ZcZ_he1jYx8w57mK@smile.fi.intel.com/.

While David + others work on the full fix, I'm hoping to apply a
bandaid in the form of comments so the problem doesn't get worse by devs
(**cough** me **cough**) inadvertently doing the wrong thing.


 include/linux/minmax.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 2ec559284a9f..96646f840a1f 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -154,6 +154,18 @@
 
 /**
  * min_t - return minimum of two values, using the specified type
+ *
+ * Note: Downcasting types in this macro can cause incorrect results. Prefer to
+ * use min() which does typechecking.
+ *
+ * Prefer to use clamp if you are trying to compare to size_t.
+ *
+ * Don't:
+ *   min_t(size_t, buf_size, sizeof(foobar))
+ *
+ * Do:
+ *  clamp(buf_size, 0, sizeof(foobar))
+ *
  * @type: data type to use
  * @x: first value
  * @y: second value
@@ -162,6 +174,10 @@
 
 /**
  * max_t - return maximum of two values, using the specified type
+ *
+ * Note: Downcasting types in this macro can cause incorrect results. Prefer to
+ * use max() which does typechecking.
+ *
  * @type: data type to use
  * @x: first value
  * @y: second value
-- 
2.43.0.687.g38aa6559b0-goog


