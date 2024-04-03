Return-Path: <linux-kernel+bounces-129818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B308970B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C321C2649D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28710148849;
	Wed,  3 Apr 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZPTkmoF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F2150990
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150415; cv=none; b=lMMDWtx90mMMie0oM2E2fnHtb79QSjcxxl83fayw3YJ2G4Zy/PTN1GuUySfDkgw+BfbZX9lit+1/2FZ14uZCDOYync4Ylk3EsTrSCIcUdWy9ufD7m1+pMe9EmLwU5uJo5pkiB5E/lxnpucFmNwWdZRbrQeP9LP93NefgJujWFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150415; c=relaxed/simple;
	bh=I/WssGKzx2pu9m1OGtbWNQp8YlFg6iKJZjVi11y1FHs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TgpxSUNSESnt0NJSAxWhs2gtjGhEqihq995L0Re7aHc1t5NQGuUny0qrlH3tWrCLXaFPoXyPDC9FnoF8X28d7cY8cBAvlPXMdAULg9KKBm0DnhcKuWsWDNt7mOICbKOqwC1DoIaylxpTZTtR8Udc7CuECE2KYLsKdWLJOMFs2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oZPTkmoF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e8f765146fso5403428b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712150413; x=1712755213; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JEsqOJgrZKfiF2/lAe/0WeYJIosNuSPi2rFlnClcirQ=;
        b=oZPTkmoFnRDD0YGlx/b7FzKkhWl6Z+m7h4hniLRZELTDa2C0jeYjittfFrbZKrfzww
         +xyReQkZivoTWqLcsc39/GYXMuFuhnudE1yx5P+F8SrZtM5Tq5zDpSfr6Bj+5ge2qVT4
         sz8CioULMUeNlqOWjvN7w9Hh9eLACNylY1EzEYHQXwg/UKkmYFLXlmQhgZNCy30uwgpk
         r7RlY/Mud8ehE3sCI5Yh9UVgSBM+SkVhJH6sokzi6StJdmhFVcPDDt27nJhcXdsh+Vr7
         /n0c60M57/lnuvBGpG+6XjY4GIueLBe3qlXaJiFM2GKMJaTd6eKWmExu3aj6xGKsYFNG
         pX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150413; x=1712755213;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEsqOJgrZKfiF2/lAe/0WeYJIosNuSPi2rFlnClcirQ=;
        b=E1T0E72HpkZEx9EIdpsxDvNyW5Ol98hnExheH8iRldHvj9yCiACvRvkpNxZDuo3evM
         +RkKKrU2x1UNN3aeyxxalTar2ozmdkY1kEte0rUyYzU3TS1bWdSN2KT8TeucOpxdEM9W
         LeoLyGj7K9TJn98iRRkpiJAqM3qqJrD1ojH/Tn/Yy71YAbvPFGQA6OiNmlQGNVA+JDnW
         qAB2NWrBqNMZ+vHxH4md8zH+AKY28CS3aRJcrc+Ehw/ZUcal888ch7rBfK6k/CexHMBn
         Z7hXjTvD8eq2xLztdXcOo5tRZu0O28zhy9B1wlmuyHZXMWTIlHEfdje1kyr87JRZnPsH
         UmnA==
X-Forwarded-Encrypted: i=1; AJvYcCXNRl80/Lja/tt0CzuQiQ70NzHy+geg5/I/7s91IfamiAKITnTQCwovpG0NH/CVuesOQ12qyPa1z1mGld0dT1S99jhYFnGzVqWV6fZb
X-Gm-Message-State: AOJu0YxWsiRn+p7IHD3CpnhO3ZrFKNJM8A+sNEmv0g1hCMeU60o0djvB
	gKPjSo0sgfTSLDhVTfYrJlbhdVOHBtitfEhEgHYgs0qY2N6BsUhZGqKdFlYOhQ==
X-Google-Smtp-Source: AGHT+IE+mv0vqUVj752A8+B5uK4aKOSeJFS0d13jC9TEMRJbt33Mn6Zcv6SnMhyVyxPHw+XjYiPyLQ==
X-Received: by 2002:a05:6a00:4b46:b0:6ea:f369:f204 with SMTP id kr6-20020a056a004b4600b006eaf369f204mr12783329pfb.5.1712150413075;
        Wed, 03 Apr 2024 06:20:13 -0700 (PDT)
Received: from [127.0.1.1] ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id r1-20020aa78441000000b006e69a142458sm11640518pfn.213.2024.04.03.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:20:12 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] scsi: ufs: qcom: Add missing interconnect bandwidth
 values for Gear 5
Date: Wed, 03 Apr 2024 18:50:02 +0530
Message-Id: <20240403-ufs-icc-fix-v2-0-958412a5eb45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJXDWYC/22MQQrCMBAAv1L27Eo2jRQ8+Q/pIUk37YI0ktSgl
 Pzd2LPHGZjZIXMSznDtdkhcJEtcG+hTB36x68woU2PQShtlFOErZBTvMcgbSfd+8JYcmwu04pm
 46eN2HxsvkreYPse80M/+/xRCwt5Zb8hNwQ729pDVpniOaYax1voFL2GfbacAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Amit Pundir <amit.pundir@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=896;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=I/WssGKzx2pu9m1OGtbWNQp8YlFg6iKJZjVi11y1FHs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmDVeJnTVsB5vVtzC1XXd+71BouXk1NUPDkQH8U
 XZE4J+Gjk6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZg1XiQAKCRBVnxHm/pHO
 9cW5B/sFuhC43fGkXLgFBtBpf9x+bFYfUF6omoJDt7oqWbnol3Lx66367osNuqO0sYm/sv0XGQ/
 ZhrBvtltB37VYds+n2KStqf2qOjNvxpDhCPYyHTlnyZm4F1ZQFXbtpNYYy5S3GUOwL0XBaAwUkM
 WNb2Jy8eiHEGElIfZi8qGeVM94X03RXe2Ihw8lyV043M2tQo6YNP9Q00IPn0VUwJFVQIGNOc5fU
 tt5tNPI/qSusT4yIjlCyeyhfKVQ8sjYH9nc75942mJ/ftHs9ff3StuFij/1FkJBqEPcpESyLtcK
 n3zKHOD6dMuac8unAvfEkUGFPwvoKAOajqJgdTPrfslZ2R/7
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hi,

This series adds the interconnect bandwidth values for Gear 5 to the Qcom
driver and also adds the check for the unsupported gear/lane values.

- Mani

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
- Added sanity check for gear/lane values
- Collected tags
- Link to v1: https://lore.kernel.org/r/20240401-ufs-icc-fix-v1-1-3bac41bdfa7a@linaro.org

---
Manivannan Sadhasivam (2):
      scsi: ufs: qcom: Add missing interconnect bandwidth values for Gear 5
      scsi: ufs: qcom: Add sanity checks for gear/lane values during ICC scaling

 drivers/ufs/host/ufs-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240401-ufs-icc-fix-123c7ca1be45

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


