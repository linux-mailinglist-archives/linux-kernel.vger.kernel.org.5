Return-Path: <linux-kernel+bounces-84104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB086A256
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBB9B2FA45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E3F153512;
	Tue, 27 Feb 2024 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC5SYPrq"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C8E157E86
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071855; cv=none; b=vENbUDeVHI7HHyyFAYLuHiY/UbffVEm9sddMKiNqh+QURJV8ubFU12nIlYHVqXKh+qDRgCTD5RrJjQ6SqRJQhKuUnYF4XDq58zJbSgAZnAWHYlTwvGFCymxAkKefFyHPxOivxU2+2kBtbSP7z6uRLmhWKi9oMDL33b037dabEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071855; c=relaxed/simple;
	bh=ZLpd/FTiTFzHnfpWMzTXSPkcqYPvkCAzdFD9LpcTNSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRViLyAFEzlgDenwxKKJPtn6swJzM5x99r2WJqKX5Dvk1rmEh2nWwsJMc6s+HDIl2Ks3RAEeoQ24Zqe39G06TeIvQf13Ki94nDJNL59JDc9kY87sRWLhUqChnVQ1K6Hia674XqoVuBqlYaWEQjklEntJn+Y1FBX6vd5sll50Ggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC5SYPrq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3392b12dd21so3902827f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071852; x=1709676652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56OYpxv+7Sg0fmYSpVc7Gnw4S4WJ/wpnYoYBTxSpZBc=;
        b=OC5SYPrqqqZD4UmSfaGGBMQVFG1rjlIs96UPR054lE8gAah03JqZwdzmLpXlKF8s6K
         7bt6+Nxc0z24xm+XdjR8yC7kiRUy7Gfao1VTTqNF5nLq53Q9KOKq6yzE4ToqkMbkmwoa
         n5IKMhjD3cKyJMaJj2imaZQBpemqlNKPDVlnwG2V4LNOIm7XnrEWEBhvganSWEaU52dn
         +4F8/f85/mSh6i61UcC+MyFfa/FTPR0ecCaDMOVR82Dhl391iX66RWd3w0Mu1siJ+N+7
         d0/IwrXkqZ3w1iazWcX0pf1DHOtjnu8B3WzK0g6LhlXbDjIvXN7LO3NyYAgkXMxZtQxR
         C48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071852; x=1709676652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56OYpxv+7Sg0fmYSpVc7Gnw4S4WJ/wpnYoYBTxSpZBc=;
        b=QJgAO3ct2LL7jZ9e+PbKHnXanMMF3LeuGYG44ADX8ZWX9i/pcsfgFmOvUL4R+VZaIp
         K8I85ycThqvAQhVJndDIaGIzq4iSCwiqQ6b3OkwbhoAZDLeyTKVHcZsqtVB0t3EGQWoN
         jRWp/qpOcIEUKklOxd33AqVY1w5BOwnm82v2lyjQzC1Tp3/jwhbRCKykcH2HXgc7J4I7
         aagCrtH8Z8AsQ47MCNeFeSXEWlljtYIx5k8dJFRpN9uHeh5cC7CihkEzbq+qcPP4xMfk
         VC9ro1FicC1kw1T9Vsi2OU8i9OVwy1X6Tt1toZ3QVAe6XtiZaY9ajecFnSokKf2emOzL
         Rvng==
X-Forwarded-Encrypted: i=1; AJvYcCWoRwudOBojVKLLN+sLxsNJ2cXWCCkkvyfhVetd2ndJhTtwLxX25KcpU5e0nGmyvHpfFQfQOeh/BgNsjXRjyEwoVUjiD35JfTEExkNk
X-Gm-Message-State: AOJu0YyxJV0RuOaN1sTNsYUuWCi29NEG/RTsHIRG3gTUFd1WH9qmOYth
	8rw6mVNj0ps68gR1kHB/egNW3UgJmhxWfRDGHetZDeZ3OtmhWiFM
X-Google-Smtp-Source: AGHT+IHgPMJZmLwhDrz4UIT1yJut/ieKa6GrcqGnCzDoy8/Ahz90hV1a1K0FUpu6/qr6TdNFGieWPQ==
X-Received: by 2002:adf:f58d:0:b0:33d:4f6d:de84 with SMTP id f13-20020adff58d000000b0033d4f6dde84mr7765794wro.6.1709071852037;
        Tue, 27 Feb 2024 14:10:52 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b0033cf5094fcesm12562384wrc.36.2024.02.27.14.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:10:51 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: pi433: Remove the unused FREQUENCY define
Date: Wed, 28 Feb 2024 00:10:42 +0200
Message-Id: <20240227221043.532938-5-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227221043.532938-1-ikobh7@gmail.com>
References: <20240227221043.532938-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FREQUENCY is not being used, delete its comment.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 52e43a909b03..e63e87fd6cce 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -11,8 +11,6 @@
 #include "rf69_enum.h"
 #include "rf69_registers.h"
 
-/* NOTE: Modifying FREQUENCY value impacts CE certification */
-#define FREQUENCY	433920000	/* Hz */
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
 
-- 
2.34.1


