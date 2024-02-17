Return-Path: <linux-kernel+bounces-69728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A51E858DC3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00361F223EF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061A1CD1F;
	Sat, 17 Feb 2024 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNKELSSA"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2511CD03;
	Sat, 17 Feb 2024 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155843; cv=none; b=cdBGfc3tZeT1ZQQYL1WK6HJOKHzBYuX0pnpeNG8LdfDkpr0CZSnzhUinBKWhgKjHf4cE11/fFjHGcou3gmkk0wtx2nK6+ct42S3Td1TgCWoRH4d+x1/VFLANMM2XiPuspLUSj5T5rEPsucLmVr4FDbRZP+GrUavwjpr6BK4gAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155843; c=relaxed/simple;
	bh=uG1gfpoRfXRgKuEHJKltjR7JrRYIjqvRvSia55JVwcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VrozBloqWiSzUrtUvcC0czoIYt8jEp5Q804gvXYeB4QuDKq7C7oUhJjvBkmQLuKNRhX1cBrSVT6jaRXoHVStbDWIH8Ya2phCE2pE41yN5mNxuJDT3N/92ZLi8xR+bJX6xwzVaEside6M3sVNuyWNcqLuT3sAa4/g2fha1Zf79Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNKELSSA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d8aadc624dso24147675ad.0;
        Fri, 16 Feb 2024 23:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708155841; x=1708760641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A93PgWbW04e3vN6J7sWJkkLxGXflBHffLu+zmG4+tnw=;
        b=bNKELSSAYPXwpyaU5/4HNNKs+in0bBgrFF84elolcxoXJCjqOQ52B59n6be6QtpboP
         7l568pJVvInmNze0rHXXqQh2NN1/jMnqI8X3mldsaEiaMV3fMJXVGvgfEAf3NFokL67S
         EbB+ZTr4TIUpshGdDgbDkLt7ITyk4rOWRDB6MyKrIlBuON/SdtiTz6Bj/dZcOyE0yNT1
         KKoBt4wGSeyHzW/W04tJ1bBBgZ6wDh4fK07+78HkxxLOdTEUx1pryUKM9tJuZC9YFMzz
         u42ON4YFWsFkNDMyXHFOsdNDdVaTMrOF3tDkL2vFSqvuvjz1YOLBThs+AkJGgqYkQ/kh
         9wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708155841; x=1708760641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A93PgWbW04e3vN6J7sWJkkLxGXflBHffLu+zmG4+tnw=;
        b=jO0r+Gg8WHAlUc9i4fMpdVgtCerlOWIUGv0dRk9sZ/+9kRyxvNbATJI8APE9CBDRdZ
         wZHBlV4wVV6UNDOmhPfesnirbhPiGKsmdW+OfPQELd+S+YYJ8vnYw2yEbor/7AzTcu2F
         SVtWrEseC4dkXwxe3dVvXJjvC39DuNiF5R5HuudU7LOMLPHHTAPJmU+Zq85/22HMC6J8
         rBsUCrVv7YRUTKvaAmJMlYOLJiwfF23g9Pkup3akzX0l0wTxfX3qabA0Akq+dF3nyRFZ
         DYH0idtZCk6Dv37Yy8luasuMhronHpHU4T4zs45j4FjWdg9aQ538MozfqXO5rvT+2nMh
         e7+w==
X-Forwarded-Encrypted: i=1; AJvYcCUD5jD22nS6O+E10ILnBmI9wN+LFdP59W7ZJYugr8wevXtDTX65Y4FRm+C2JVX6OJj4MO8P/d7IdVo7hfzan4rYvjcyu+NnTnBaPFCW
X-Gm-Message-State: AOJu0YyQXGXGkJLMl02j7/BTSPXKmQDkq6wzJMZxUkfEZrFRF7s2mPHH
	QhYndDL7NB2o1199JzdWwt9ZU6/GjpOrJrq/1QULhAuIaeJHRdP5id0LE8Wk
X-Google-Smtp-Source: AGHT+IHzYQ1ItysbcXQfrjrnwCsZSlE3FGVl+hW8uk5eTdQqVOZjnXqaOQI6DMcdRI1BDJflnIv7zA==
X-Received: by 2002:a17:903:298b:b0:1db:c143:abbb with SMTP id lm11-20020a170903298b00b001dbc143abbbmr1847165plb.29.1708155841011;
        Fri, 16 Feb 2024 23:44:01 -0800 (PST)
Received: from prabhav.. ([2401:4900:1c23:6dce:8ac9:4d57:e401:745b])
        by smtp.gmail.com with ESMTPSA id jh18-20020a170903329200b001db3a0c52b1sm929452plb.88.2024.02.16.23.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 23:44:00 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH] Spelling correction patch
Date: Sat, 17 Feb 2024 13:13:53 +0530
Message-Id: <20240217074353.19445-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc | 2 +-
 Documentation/ABI/testing/sysfs-bus-cxl                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 96aafa66b4a5..339cec3b2f1a 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -97,7 +97,7 @@ Date:		August 2023
 KernelVersion:	6.7
 Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
 Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
-		for the users to configure explicitly. This file is avaialble only
+		for the users to configure explicitly. This file is available only
 		for TMC ETR devices.
 
 What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred
diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index fff2581b8033..bbf6de5a4ca1 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -224,7 +224,7 @@ Description:
 		decoding a Host Physical Address range. Note that this number
 		may be elevated without any regionX objects active or even
 		enumerated, as this may be due to decoders established by
-		platform firwmare or a previous kernel (kexec).
+		platform firmware or a previous kernel (kexec).
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y
-- 
2.34.1


