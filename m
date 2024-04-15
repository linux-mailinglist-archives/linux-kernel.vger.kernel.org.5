Return-Path: <linux-kernel+bounces-145917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363178A5CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3391F23AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3066B156974;
	Mon, 15 Apr 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kZQW97HJ"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09214156F32
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215721; cv=none; b=KJjX5ByUX5WyADCzbuJC6fdZEV6k/sJLD7A/2Imk8t4C+/+3yadPJxXZyRjjH+5g+RC0NlG009Y8qhXBOZlId9NaiLRUWIIFwcI5x7UfeLG9R734rsoVtsxQdaMfaF58Lgx2tvtwX9pqh/mSCkB6CxVB/yvYtL5o6xVkOup6D7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215721; c=relaxed/simple;
	bh=Up0AFmKvJgWdTQvHHflIIpGjsCQFkFLSnaf0RWof8hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lVB7xXG0vmaIbp1jsD1QG8bGx7Vh5loIqYXb6JurYobyqgY+wX86HgtdFQa67kTU5bLe8RbYOx9xx/6OeibeRIgiAP1GYddSL4LQeawfzPJbttuXSCNGhQY+CstqGe1108RdI7Js9YEGMXlpA7prEIvsAK4KY9S+58dmH5RuwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kZQW97HJ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa318db8a0so2470472eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713215719; x=1713820519; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=noGDNhlYTVCOxYMkKSiuv/88YZjTVfCnIqr69mquf1I=;
        b=kZQW97HJheJrQ81wC2CmETGgubQNi3B43ViIEbGmN5T5Qh2w2ropGgRE3bmIxNyqB4
         zBhdDrz3JudQdJhYkm1BBgVqB2QXofLlJLVJfJFmqiEUK1T+xvTejUOZGbiMJ/V9VRPY
         nMfUtomwR3xT4s/5QzAHCcpjZ+kfdImzY8zm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215719; x=1713820519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noGDNhlYTVCOxYMkKSiuv/88YZjTVfCnIqr69mquf1I=;
        b=eM9b836faBqpVkxUVbrvzynldAFCfGP3zuCwh4xBGG1OojDb72F/MieIk/vXpL8f1D
         jttHYqPLOsESIXiq29+zzijn08e+/z98CQv5P6T0Y7jI87ZGGTOgmj8DehT3YsN9Y8m+
         g5oFxmRulypg7bBQ6vt+IZEsQMF3tZdhEHVrPaE0UpeYFqLNwI2LXfuyuZINaBsdJhv4
         YZPfpDIVWKnP/xoVhxUxaXjtRwUVkqx/xdGfnd3lSuae8HlIFRwS8Tmq+9EvZIQAxAnJ
         fdXJoYcmtnqH5FC3A1gUN7fTOWYuMMF3BJIxCpqeyzlH87cjS4HLchDbClNvV60MMyIp
         f5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCX5lEZd8RszTHF8HCfdRSpAp3vUS/Y8E5xKUy2ELkiiBDgyR1uNGoG27j2CByTnJ/ergfoBNWou54fvMdiSZ/NCUD2aZPcv+zGJQfHo
X-Gm-Message-State: AOJu0YzaWV2NO/QsexDfWkBW0C/KYQUc/TsEbA3bOeDliBf7CS8RSug4
	KmrnaFfGwgrkoRhh4qHoXsW9lt6OxRWCQTMRfXjXcLfuxcQ+g9z/omQEGasUKzifRLr3tZ/eZiK
	Nag==
X-Google-Smtp-Source: AGHT+IHf1qn76SCzUXH6Z1+2/uU02m8Fl85aGDYYCydfcEn0/Vn+rHDNiaMu2dloPj2wsKVWi8Ejmw==
X-Received: by 2002:a05:6820:1a0b:b0:5a2:37c9:d91f with SMTP id bq11-20020a0568201a0b00b005a237c9d91fmr12909057oob.5.1713215718858;
        Mon, 15 Apr 2024 14:15:18 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id c15-20020ac853cf000000b00434ec509ce9sm6500847qtq.46.2024.04.15.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:15:18 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 21:15:18 +0000
Subject: [PATCH] coccinelle: misc: minmax: Suppress reports for err returns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
X-B4-Tracking: v=1; b=H4sIAOWYHWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0NT3dzMvMzcxApdw1RLQ0ODFBMzS/MkJaDqgqLUtMwKsEnRsbW1ANT
 b+lpZAAAA
To: Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>
Cc: Denis Efremov <efremov@linux.com>, cocci@inria.fr, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Most of the people prefer:

return ret < 0 ? ret: 0;

than:

return min(ret, 0);

Let's tweak the cocci file to ignore those lines completely.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Following discussion at:
https://lore.kernel.org/linux-media/20240415203304.GA3460978@ragnatech.se/T/#m4dce34572312bd8a02542d798f21af7e4fc05fe8
---
 scripts/coccinelle/misc/minmax.cocci | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
index fcf908b34f27..ca4830ae3042 100644
--- a/scripts/coccinelle/misc/minmax.cocci
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -50,11 +50,26 @@ func(...)
 	...>
 }
 
+// Ignore errcode returns.
+@errcode@
+position p;
+identifier func;
+expression x;
+binary operator cmp = {<, <=};
+@@
+
+func(...)
+{
+	<...
+	return ((x) cmp@p 0 ? (x) : 0);
+	...>
+}
+
 @rmin depends on !patch@
 identifier func;
 expression x, y;
 binary operator cmp = {<, <=};
-position p;
+position p != errcode.p;
 @@
 
 func(...)
@@ -116,21 +131,6 @@ func(...)
 	...>
 }
 
-// Don't generate patches for errcode returns.
-@errcode depends on patch@
-position p;
-identifier func;
-expression x;
-binary operator cmp = {<, <=};
-@@
-
-func(...)
-{
-	<...
-	return ((x) cmp@p 0 ? (x) : 0);
-	...>
-}
-
 @pmin depends on patch@
 identifier func;
 expression x, y;

---
base-commit: 71b3ed53b08d87212fbbe51bdc3bf44eb8c462f8
change-id: 20240415-minimax-1e9110d4697b

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


