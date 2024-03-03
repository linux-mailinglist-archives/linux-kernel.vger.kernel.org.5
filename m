Return-Path: <linux-kernel+bounces-89773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7586F583
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7E51C20A38
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789D55A118;
	Sun,  3 Mar 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuHHO2h+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BABE5B;
	Sun,  3 Mar 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709475786; cv=none; b=kLZggjCcwxBZr+NrXHYI8rWhSaPZQFrUWzcFXn56R0Ajl3vPdoboZbHGqE1P8THDAy/9Oq6k1+eDNmYl4pbU0/LLYXwsboGLVVo07397tgHsrbXnHcsunNOmN0Et0uftSM3p6PDy8uX0aUPxrXm5Tgtn8NHD3y1UAAr69UjVhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709475786; c=relaxed/simple;
	bh=t5jBL7YflSrKd4hHS9yTmYvU8CNC76z53TMa+27R98M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GWGJK/JtHwE/DZ3n9bJUNM6ORnzv0UyKWZ/+jQ8PNNJLM0se7yw5PZhaLX7QfXvOO35WJ7gsrGnEgO4QWaddNuSUwOj4R7IkCHpX/o0WS371aVwyWEmmHYFF6i5Ezw0HnwMRI8sbDdRa3oNSX+d5R/y2y4cHXQ1d0jT6d7dyY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuHHO2h+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc0e5b223eso31692535ad.1;
        Sun, 03 Mar 2024 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709475785; x=1710080585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Id6mziPFV2Bo5BUrdfcO2e1rBc0/eRCQTm2X30V/Jlg=;
        b=CuHHO2h+O4l7Lb5HXukJ71gTaj2SQK/MJJ4kJFgm763gTLbvnj7XAQA3vZfdxRAHaJ
         S0P4jm9fIzn0zOEM0ulsWoFozlNeth8qI3AYDq+5xrPqOhc+cqys8Y7htHwclaxW7IxB
         nGwaAJlwJEq7odE093vPLmqkvtbzE0zUhLYuqmUkO2YV71t8xfL5edXub9hCMz4m1Adl
         Dql041oWbMxxTavzpQI6g9kDgVXZgXDOmfDb5ZCTDlG0Rgywyz87UX5VS2YqDb7zdFF4
         XwCmBcGh2zbUBLa8CQZvMiH4Uxvw0mg79bbMspEZe9F3VE5aqIv6MLrSWrRRBVHIbkGf
         h5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709475785; x=1710080585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Id6mziPFV2Bo5BUrdfcO2e1rBc0/eRCQTm2X30V/Jlg=;
        b=V/rEcyB0s39jE/7LPQR4FTaxYhD9oIXRbAXFsVoTNxFZoA24AlzsFoI3ZRA1g/C1nl
         rPYOIKrk/18YrPn9oQpe7Zzg1XepyqwxwXncgg9QutAH1NQdcGq0hKMsS8sPkPyMjUxu
         tmMZDhVh+Pv2J8QoFgZxr+YLrqFrkRep38KJyCG4SadhXwl5mDV5KB5aoPg+V8ATZ0+Y
         KTo1lyRgCf+8X7o5SUEWwgNl/b1YVl//DeR7a5X+onqyDve8AUajF/nKCdRGAKFhheNu
         J+62I003Hdkps7sgqFdzxUJQCLfi8f1qqAzkoEcp8YWukSkcsNfNth5wa0U1ZPtHdbeH
         LgEw==
X-Forwarded-Encrypted: i=1; AJvYcCVhELUi2aHwLPK+hUTzMDT6mIrEmHspLDm+vJQXaSi81fgVlfW+8V7l0FmzdMxSKdtNkfBk4TAabgKka0AbuECnyBzYGxNoZOjrIl20
X-Gm-Message-State: AOJu0YzHr4xl73VuEZORpeX3vS9VTakLcrrmRkPH/wvIfkh5Y1WAU3+f
	pQRSGABW+3/Rhk8wg9j7ffLhzlJ8K/fvd8yLk3gOKDfXdMJViuPM
X-Google-Smtp-Source: AGHT+IHF0b3I75HECWEIPvqQ7CoeEGnCAZrJspkLyufByz0tVoA6esIOGEVF7CdXptYj8dXiRWipYg==
X-Received: by 2002:a17:902:d488:b0:1dc:c17d:6edd with SMTP id c8-20020a170902d48800b001dcc17d6eddmr7572433plg.20.1709475784790;
        Sun, 03 Mar 2024 06:23:04 -0800 (PST)
Received: from kernel.. ([2402:e280:214c:86:98b4:6d91:d5f4:8f27])
        by smtp.gmail.com with ESMTPSA id l1-20020a170903244100b001dc95f56848sm6697305pls.92.2024.03.03.06.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 06:23:04 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: bingbu.cao@intel.com,
	tian.shu.qiu@intel.com,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Removed __acc_osys field description to prevent kernel doc warning
Date: Sun,  3 Mar 2024 19:52:58 +0530
Message-Id: <20240303142258.6590-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2778: warning: Excess struct member '__acc_osys' description in 'ipu3_uapi_flags'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 drivers/staging/media/ipu3/include/uapi/intel-ipu3.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
index 926fcf84e33c..4aa2797f5e3c 100644
--- a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
+++ b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
@@ -2722,7 +2722,6 @@ struct ipu3_uapi_obgrid_param {
  * @acc_ae: 0 = no update, 1 = update.
  * @acc_af: 0 = no update, 1 = update.
  * @acc_awb: 0 = no update, 1 = update.
- * @__acc_osys: 0 = no update, 1 = update.
  * @reserved3: Not used.
  * @lin_vmem_params: 0 = no update, 1 = update.
  * @tnr3_vmem_params: 0 = no update, 1 = update.
-- 
2.34.1


