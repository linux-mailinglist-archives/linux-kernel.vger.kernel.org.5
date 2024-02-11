Return-Path: <linux-kernel+bounces-61008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3425850C44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68C31C21855
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D1539FCF;
	Sun, 11 Feb 2024 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FurQosrX"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EED2D629
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693365; cv=none; b=IzDOqijWskjDibcr/YEnJScdUS0UGtaES4mE7f65v829UXLMn/m84Yy8t0xVG27TYx0h2JROY95na3fRPEVjOojjixy2zNl5cdv+PvXDid1S7t9PlGCvzzn7X5IWgJQbNaPMfadKLMZ3Oy3FcKAltotQO3g1APihaVJ8dcN+tI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693365; c=relaxed/simple;
	bh=FaWrvDRhCn6qo66e2LFY1/am/fRiqeQ00xmmtBjY9fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZexRLepavRkoOTOlqnTgCd0onYeHyz7nCpTFw7b8rHIPZdMO/HQS5pGS97qTJ4tG8HkJk3rKda86+frOE7pQgdRHqr0aJVKYQoWS1DSCFcJC5WzjTcA6m3NyC8bIAc9jp+FQ8EMnULqgeiHpQty4c2fudNXL8JwbJDFuFC4uOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FurQosrX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5601eb97b29so4810750a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693360; x=1708298160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhd0Wyk/ZgeZM/EU3KZ6LbkcM94I0OFOZkDaLa9LsZQ=;
        b=FurQosrX8IiRpzZb8PF17QLrh5D2pgkHV2pa90ELq4iot1yY4hGoy/h17srKDPPAD7
         /37GdWmKoP+i6moCFUbE5hvcwSvM/keUyoVJW3IwwUSF1DXfdCuqOA/URipfa7c4TDB5
         apyqPfVNIIanz53ue32MuU68uSsWw/CVennUmhrqhobY4/GkiOFWWFIqsFbehf1235Yg
         niyOvFY7yr7f/d6/SiTsuCBmORCWTzaREP4/cgigXXGvRZ+5gPI1TTnnucC7NGwVcRUa
         yPn/9udyWBgHKJQ7uEkWZT0RfcCscUuLk9h/c+E/9L0FuPyxSFZRQX579rxbKljlBUqq
         twmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693360; x=1708298160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhd0Wyk/ZgeZM/EU3KZ6LbkcM94I0OFOZkDaLa9LsZQ=;
        b=hlPRLoQJM+O2PG15WwYCjlgBsHbovIf1Nhr+XqF1Daz76QKyEgt4xEU4ETkcfoAhVf
         OIA/7M3pN7HI2Dy3sbPQ290xJdx2I4bn1e83cx3yXajbt/MlK4yUVZN8ENlgXJ0ZLDgh
         K9K8xYbwdMN8OILwbPRr9yy5pY1AV6MC74QI0GzvhKKKxFZAhVDzThtTvflpe9Wzhdck
         4BiQBlbM19ASuiK1jfxTkUJUjjZ0IDDjlkqBP+MgIp/ilxVFaFtNIf1VBWwcRQoHnz/m
         fkqEfHMyGPxHUHDi/ZzoPdG1lP5DaGqssmlxURFwK6tV1waNa7o7TE4TNv1JyfMq3Zdz
         CnUA==
X-Gm-Message-State: AOJu0YyEl44008YDzqmlnWJ1oKX9Dw/zG9hMDwE+hhoE57PuGeEDu6tP
	n4LVPsFyLq727zsO37JerqgIOLOUPdGHBUjQZCHbstWiBgQSwCZJ8FHlnChH2yAJSoHNB0MQpxt
	E
X-Google-Smtp-Source: AGHT+IGVsdnZKDmQDBFVU0o6y0GiOE/pwX9pS0hxMa1Z8ZP6uXbjFAP767CiwKCxM3lq9wE6X2aB/A==
X-Received: by 2002:a05:6402:911:b0:55f:e2ee:6bba with SMTP id g17-20020a056402091100b0055fe2ee6bbamr7473994edz.5.1707693360667;
        Sun, 11 Feb 2024 15:16:00 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:16:00 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 29/35] linux/random.h: reduce dependencies on linux/kernel.h
Date: Mon, 12 Feb 2024 00:15:12 +0100
Message-Id: <20240211231518.349442-30-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/random.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 70e5250f3bc4..3183025ddda9 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -4,7 +4,8 @@
 #define _LINUX_RANDOM_H
 
 #include <linux/bug.h>
-#include <linux/kernel.h>
+#include <linux/limits.h> // for U32_MAX
+#include <linux/log2.h> // for is_power_of_2()
 
 #include <uapi/linux/random.h>
 
-- 
2.39.2


