Return-Path: <linux-kernel+bounces-122772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024ED88FD07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A34CB26A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F637CF07;
	Thu, 28 Mar 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+76QrC1"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5D54656;
	Thu, 28 Mar 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621727; cv=none; b=qpPSL3inzU7zDnmkHi9M95CJT0VzbDzE/D2XKdQ/lL+WC4VhU0j2+Jt+DcdL4gVeXGjgD9pTCtk/uCFqQzhrGIbCbHM0zhzQlgaN6Ptw/j90Lump1zdiU7DTZ6aI9jRe8dgLSmRz88NXrq+4eeOqLQSJ6k0iOxj806lgSE47ALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621727; c=relaxed/simple;
	bh=/LL0YUR3AHpDpeNjjd8usMh8iUvC30U5TjNpg8yGwyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxXF5Afi7DSHIiE35QwzAMZRAG39QCHtm8CW6Zz+5BBe/4JK4r02wxgfBPxXl1K5BQoDFMzhFbq2kHQkXBC50hdqTFTJ6gceHE9Eoq/uFDWANgB2o16wKOdnd71SP2nsmC17ToFZVDrK6RNAZLO5f9ecf80mZPfr7LRXJalnSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+76QrC1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515a68d45faso630960e87.3;
        Thu, 28 Mar 2024 03:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711621724; x=1712226524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9kF4Mw1ws2vuqWMyi8q7JNdyeGwjwOurqw1h77rDjg=;
        b=g+76QrC1E34PSTp5LNtruHNnfyXd8R1u2NBW/ocFneLFOWz7vEKZyhZc5BfobP7eZB
         ApHzIgEKOtistW3DaRFfw9xhmXBqem0Uito545BFNJ6uiPFaqBaXZD152MbNEalvuYgg
         m0pkxIyKRx55I8bMMe6lgeTsTUyWnzZs5wNVpQFit1q0GgFNcFoAZusrGJhjZQo28NZp
         XJDnyQYPw0/FzqRpNrGZMAS21EOqjAsnQ949HgobBRRnY2d66Yui1/IgkDgOu07kKywV
         GYRvm1molSFTdzT8FTC3gUuJHZrgWqs1vOHs54JYkvYfUE1GN5xcpMtIhcREcI8+E9Q0
         ibFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711621724; x=1712226524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9kF4Mw1ws2vuqWMyi8q7JNdyeGwjwOurqw1h77rDjg=;
        b=XD91AVcwqEa9cdg/EfLhiwvCAEOCKSKSsVPwDCL1+r9suu/l6m6hO4uBmQ5XnwOBs5
         IfPobzDdL8e6PVF6L8hVSltyarx+Ga7xh7B3c4HqcsniW8qZTnKQ52CP0E4SdOCcw+uv
         aVe+voQxewvFh0p4b0F4Jj8SyZVJBsomjhA4xfh8kWci/4W6ZMc60AoMA8gCQ0ZK/1SK
         vdckcdwSmQDg65e8+LpNpfnLa3UA3XNRCniTJctsB/snYSuaxuzK3CS6G07XCXAk5eEh
         siKW5+uprHn5EpQm2zwWrAghN4FG3h55LLQhy8UfRtR/12TcM5yg1HIabAsCHDb40+yE
         oPbA==
X-Forwarded-Encrypted: i=1; AJvYcCUOFikij9yN5w02rtMi/dOTHDq6+6UNGmLEYSmPa4pifRHaXuU1D40vDqc5dnz0ikPZ/XPjiFOi298Ab87Atj/0SvjcbQvX8eDnoKmgYdiS9DxZZw4h3ncl30/duX4c+4sipM7/QVOSwISqTAczTlbZwg==
X-Gm-Message-State: AOJu0YywZnjiyslbNC9zMy/raYeTjqjq4ocRVkdpGlAHge31nZDFu+GM
	/WCh9AZiFvq9XcwzSG5JIgl/lhY40+q0KurHselGt0EQIauXPZGbsEYNxW3ORPHOOA==
X-Google-Smtp-Source: AGHT+IEZZU4s0H27lQ4vcQ0JCkXcJGQWHC1YmerTA8qhpKZ92AvGlh077EpDsnNde5Y7s3+aweAYhw==
X-Received: by 2002:a05:6512:787:b0:515:c964:7237 with SMTP id x7-20020a056512078700b00515c9647237mr703025lfr.24.1711621723696;
        Thu, 28 Mar 2024 03:28:43 -0700 (PDT)
Received: from localhost.localdomain ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id p13-20020a056512312d00b00515a87e1288sm149612lfd.123.2024.03.28.03.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 03:28:43 -0700 (PDT)
From: Maxim Korotkov <korotkov.maxim.s@gmail.com>
To: Kenneth Chan <kenneth.t.chan@gmail.com>
Cc: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
	Len Brown <len.brown@intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Harald Welte <laforge@gnumonks.org>,
	Matthew Garrett <mjg@redhat.com>,
	Ivan Kapranov <i.kapranov@securitycode.ru>,
	lvc-project@linuxtesting.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Thu, 28 Mar 2024 13:28:05 +0300
Message-Id: <20240328102805.165070-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Date: Thu, 28 Mar 2024 11:22:37 +0300
Subject: [PATCH] platform/x86: panasonic-laptop: fix NULL dereference

When initializing the pcc by calling acpi_driver_data(), the "device"
pointer was dereferenced without checking for NULL. This seems like
a logical mistake.

Added a pointer check to ensure that it is valid
before using it for pcc initialization.

Found by Security Code and Linux Verification Center(linuxtesting.org)

Fixes: 709ee531c153 ("panasonic-laptop: add Panasonic Let's Note laptop extras driver v0.94")

Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index cf845ee1c7b1..de29758b0384 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -1067,9 +1067,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 {
-	struct pcc_acpi *pcc = acpi_driver_data(device);
+	struct pcc_acpi *pcc;
 
-	if (!device || !pcc)
+	if (!device)
+		return;
+	pcc = acpi_driver_data(device);
+	if (!pcc)
 		return;
 
 	i8042_remove_filter(panasonic_i8042_filter);
-- 
2.34.1


