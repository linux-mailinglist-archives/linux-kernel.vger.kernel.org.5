Return-Path: <linux-kernel+bounces-98868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2645E87807B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6159D1C20C01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4913FBAA;
	Mon, 11 Mar 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WHdulmhF"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADD3D980
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163402; cv=none; b=K7yU8xzdtkMsBnaXzh70ODOYRO7hVaLRF+B6JtUEbidbSNLXBmnR+m7orY9kw+QmNezlLfCSbyjJheB9zvmsgXg0wMyhj3f3oe/519Zjf+8QfdESLQL4zYDmp6LSBtLQiHiWCRwJg47X7HSGhDTnwS2YJQ6Hi06lN6dMRIOdA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163402; c=relaxed/simple;
	bh=vHiUpEvuO96B4Rc+ogaAyicJ9hfsK28eqgBuOaXlhQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNuj085vwBoeuNJ2pUYtE5agcwS/DLc2GJVwkNA6LyeeLi6BQLZ8n4J00oYwAtTpULqZIjfDd3ffQU5u5+SvNhVZ9ZUutB3h/3Eqwsy6HHyD+gFiSWeg6/tCZcWwqt+wZX1VRZuHM2Z97fLoEDQw5UGDRohl6DIO55+y7bfbayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WHdulmhF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5683247fd0fso4164643a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710163399; x=1710768199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQG8UtqxKlv15zUD+AgvjHi/8YNO+wmuxzq+WcnhXlA=;
        b=WHdulmhF6dcjJ7WgpLK3xMtFJIS8O4/OmuWCzTqPhO0reR4vW1J9axh3gi4zHw5Y5p
         E0HrYRdzzuzOCnpVJnppmFCEyQZZH+zFtMz9qFg9WAkwHsf2i2A9OPR7NBhOH9yIHgcx
         PfmFSY6P/RB6jNaWBIS8UvO57BTdk3yA0Rszl/DdP1+DEL7VmTcUQfk/wFBHiO76IxFm
         5VbECxSXahQhuD/4VtLAHwJ5AgAz5rnu7+1Fy/sxqlcdcyT6hdkNzvxC2srAD2XaJGFW
         s6bw2kYGuQHTsVISu5ZR57dirf2daynJmq5uoH4pGrASg0EjCe9MRw+Tv9SZMq3spXko
         i/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710163399; x=1710768199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQG8UtqxKlv15zUD+AgvjHi/8YNO+wmuxzq+WcnhXlA=;
        b=V+U1iKt4sQPZbxOQo2H0yCr+tyWLsI4dhIP3qpyoW5YztzLXL5ZBhjF4ZB9yNafw6G
         TdLsfhxZC/SsaN5msUD0cMxkyvSiVWJKgti5eTpVj4GTHq+mzxbuJxAwlOsSShkjtniG
         ajTlR7bwdLvrq2hH6h3Ysoev2ObOYb6vQkjsHnJmwDRII23cmcax2dc/OcE1y30t00Ia
         inlb83ZDbUf5EtMf6Kdys6eTRcQV1PofhpwFqSol/WXNdR++qm9/J62lW7755ADK2Of2
         hzJEv5dPa6Oyx45bwEGz+l5/q5Vk9PW1kVN8qSx+rCvY8y+K0vaEkkvbPmi2L5kuVccG
         7XJw==
X-Forwarded-Encrypted: i=1; AJvYcCW0b6PrQ4956Y0st4X0XpDsLP4MBHTipMLXCMomrRz0IJXpPGSezszUOGuBS6dNoGqBXc3PXZ1hV/Gp55F3e/Gj7WGw5OkoI5e5gLUs
X-Gm-Message-State: AOJu0Yxd9AwfntUcmez3IjlU+G0PB08fYagKvp8L40UA76X8x6URpryv
	OHamqoi8HKWph2ypiWf9CsGQUgxOzVgfgyBGLMEpXbw1zCydmbCZAD9C/y2Mzeg=
X-Google-Smtp-Source: AGHT+IHb2fhNwTheUYDdvSqYIzh/k2n+eFQ27Xf8cLMI4Tkne666B4zE+owcBNxAMlvlWXe9zCBlxw==
X-Received: by 2002:a17:906:4ed3:b0:a46:36a8:67bf with SMTP id i19-20020a1709064ed300b00a4636a867bfmr798941ejv.33.1710163398832;
        Mon, 11 Mar 2024 06:23:18 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906251a00b00a44cb0bf11bsm2861075ejb.79.2024.03.11.06.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:23:18 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 04/11] arch/alpha/io: add missing includes to fix -Wmissing-prototypes
Date: Mon, 11 Mar 2024 14:22:59 +0100
Message-Id: <20240311132306.3420135-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311132306.3420135-1-max.kellermann@ionos.com>
References: <20240311132306.3420135-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes:

 arch/alpha/kernel/io.c:654:1: error: no previous prototype for 'scr_memcpyw' [-Werror=missing-prototypes]
   654 | scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
       | ^~~~~~~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/alpha/kernel/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/kernel/io.c b/arch/alpha/kernel/io.c
index eda09778268f..fc5f7b80c7ea 100644
--- a/arch/alpha/kernel/io.c
+++ b/arch/alpha/kernel/io.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <asm/io.h>
+#include <asm/vga.h> // for the scr_memcpyw() prototype
 
 /* Out-of-line versions of the i/o routines that redirect into the 
    platform-specific version.  Note that "platform-specific" may mean
-- 
2.39.2


