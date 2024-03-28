Return-Path: <linux-kernel+bounces-122784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E088FD30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C91B2951C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66187BB1F;
	Thu, 28 Mar 2024 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9mATXzx"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B972364DA;
	Thu, 28 Mar 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622132; cv=none; b=lmcEeVLQwjT0y6fhlr23uLwzOdGMZHY5qARZRodtjfR18e0yYQLI7PpDycx5ZXSmZz+vjx9wDxI+G8wBSvHkarW19lGhr/+3x0539eejl80QbDvZnilKQJWW6FWtE5KlsDfzKz8AGwiZrrc+gMuFvhzgExZfbULmzrmkawzOeew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622132; c=relaxed/simple;
	bh=48l05X6koIb0FE3XzMyR0AcaWBlNE2UfOFJjRw79ODw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dp/vAHPnzX4qaFiIZO61Ocjo8LPmr/qTZN5SNpojHDqMv9LwHbIVhimcUIwwJeD0Bp0oCIL9Ajgiqv5H1x1nAM9tZrDF35jFbrVfaaDGoy9r6KZWIr5xAjJFKVIoOzloyMzSNGsOIcNPcwUE2WVo3i/id4dhkrDg0sZcq3KrPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9mATXzx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4515ec3aaso7115831fa.1;
        Thu, 28 Mar 2024 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711622128; x=1712226928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4vdDMEDfYJw8Xnjz/9WOt8Bu/N3DlOsn0fkGOAa6ry8=;
        b=a9mATXzxA/PCMEynwipW/93vLbVq84KMahOojOIaMBvcGVdDxxWDei8nY7crhsBugh
         6rXSoAOu9bcJ0CV5UQlT07yJbMnAs0M9WECesyclfWq934EYBkn5AI103lhyIpoQ+ibQ
         I4K50r07t2076wuaj360uyc71mwg738ikQlch7IwknG6Ed2U7L1X/zvpAXkZ+2KbLbjY
         wPEfLKcPjUlgiUw/11A1D+7gaKw66kirbkkh25LdEEw9ZF3menUC5jMKRX00P8Hao3yU
         Lfq0/YPW4NZwemO11YzctWdq2aRAlNiPjZqwHbF16SEWS+etpPX57O1JfrbT+wsSuANN
         Zz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711622128; x=1712226928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vdDMEDfYJw8Xnjz/9WOt8Bu/N3DlOsn0fkGOAa6ry8=;
        b=NiICexzN69nsQogD1Z3pQ8n03zdYaLsR/5AQjZosDs0wYSxPAanEbvIaZQ3cNytgwp
         aS0FcDVlW72jjNA0fTwbFcb32aJumm4KlqqPO7o0cceWnIMYIFG9XpmSZVVAjL49rvjY
         /lD9rziq9yO9TfHNpbTldgN/qtNLCdnRD438e1HZxhUaeFBvZLZax8JCLpbrWfujo7YJ
         6Ghwa1W9o4xW3u046m5LlXxGIfuG/h9pxEE/5DMg8kWGEoNUqAQdaIEpHxFhlsk/oUtd
         mBbg77ciPuCofFcKYp2/Iy05oJZVq1xAOrcyf3jIFfifKKFpdeOu20XyJ9spVa4jWcNt
         y11A==
X-Forwarded-Encrypted: i=1; AJvYcCWJund1zXV0thFDQhvRfAqo79JN/eM6lv2wIZDzztnNBOqiJkMmiM936vNpBA0Zpav3RF64AMZQKx66F+bK3ty69KhDltO+xF1iy08qeqInASPUxbtIpZXIbayxLpllMCxucCtTx96Gf5/R5MlIlWHOMw==
X-Gm-Message-State: AOJu0Yxu/i9JrdxDIs6zsmXPf3WeHJIeJpw7fFAnMNgGVQP2gZVEnYVX
	ArX3IMmxDNtBIqNfO8g0J9HvBdrtA0HB+pe38uXFwzLoxwPnaj4hfgma5uQAWYZWeA==
X-Google-Smtp-Source: AGHT+IFSU7iE1Pbb/RHR+06nsWtoD+yohTIKRazdftnLyeHfAUqyh2rngxJAdW3M8Q5dDylioSXRjQ==
X-Received: by 2002:a2e:a489:0:b0:2d4:86a7:19be with SMTP id h9-20020a2ea489000000b002d486a719bemr643765lji.24.1711622128441;
        Thu, 28 Mar 2024 03:35:28 -0700 (PDT)
Received: from localhost.localdomain ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id n22-20020a2e8796000000b002d46cceea5esm179735lji.130.2024.03.28.03.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 03:35:28 -0700 (PDT)
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
Subject: [PATCH] platform/x86: panasonic-laptop: fix NULL dereference
Date: Thu, 28 Mar 2024 13:35:18 +0300
Message-Id: <20240328103518.169604-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


