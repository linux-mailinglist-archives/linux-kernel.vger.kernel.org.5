Return-Path: <linux-kernel+bounces-89756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72C86F525
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DF81C212E7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6A1FC16;
	Sun,  3 Mar 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMrKSLbI"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313475684;
	Sun,  3 Mar 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472754; cv=none; b=GutdplUfaaFr0gyelJGjcP757U26gb7Eg9zV/lkW2A9wEnb+rMwXoMYJhQ7DgUxMtyS4J5cMY14eKWWQNUa2Fqe8QXX/80eomvak1q5rLZBHDO/enMsMJmYEe6AA2aM6rSoHgE9/gHKkszDTFHBbQNw8bp9sJ+ftwCd87Ws2j0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472754; c=relaxed/simple;
	bh=3xboL4uDKO9puxjaC/KLuajulbpu8+6bh9CscgkXE6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JcPjBvK+o8lDSiOt3e+vFIOz+WcPZhphAs+xQ3GYCq75a8DF0K4dV7RjjT4vr9xYTgsLRLPgEsMwN62OwRAp8BEt82ovd8vSMA06N7z5oc3dX905kbrPXNT/QbcrgZ2LuLQryMEMtNxR6ZhkNtDAY9f7LDXyo8ceYx8NdwKY8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMrKSLbI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc29f1956cso28478895ad.0;
        Sun, 03 Mar 2024 05:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709472752; x=1710077552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwlx5IgoHl5RII/i/nv9JimUnsVXypM6jybnxn6UlcA=;
        b=aMrKSLbIfjQ1rXHem83eSr6FLYGmd7NVad2A24IX/St6eAPlwVCaJuDWaM0pWHEk7J
         yuK6UIVYdHkVrTJg1tTLJt2HZUEPBIUcFht5fv+gzkIQcSy86eHL4uHy0lzfjUXTeYfV
         xDH3sWoRQDQW/UJWha8l4+MmzbATwCTYkp44eGqQcChBzN3gN7SIm7kVPZJzCnyWLMUZ
         qDBNpMp2SGDIB+dQY9gZaf16Uv94XeJglUew65ExfEDTGRjg9nA0QnAnG04UG1jlUm3b
         LfDqnTnxTnLRGhmjnrBEiv4lRhn9FL5kuxuZvf14jEu8NMwyrV+ChI4DEnaRsNqriXrJ
         UaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709472752; x=1710077552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwlx5IgoHl5RII/i/nv9JimUnsVXypM6jybnxn6UlcA=;
        b=EQdSJ6xsF/c63mHo037AmXKhNb0sDH7efApVGpoXaxwphjQ2FI9B9JG4XNCWjR69nY
         hI4pCm4QRdFBxIB51nicbcunfEglDOVgmMiR5WJWgCdfRb0ir6lo9eO9xCjRL/LO/pjK
         aM71vhGm6OSVNmqnu8QiJ7xi0S6gclhs29dSTviKIBrDTS7xxlLjy8ytNs1Rm1CrxWtW
         vTIgrryZ4nuuV1E7ER89I2IMJxpFpnoNuPqJ08d53OpHdbCd0/1LNmtEdr15h5L/WLT8
         +yv3yTOwqSISv9Nb/gGY2cSY+oOGSjTyzf528FmNSAPvywPuibudbGICvFvQ5JULKb90
         OF9g==
X-Forwarded-Encrypted: i=1; AJvYcCXUP1VdJN2qLJDujztkzdmWa+NX9094wWF1imBXjPH75w5xuNQPy3iAeK9zMV9jjiC7js4eZJdfzQ80ug/YHTJa5htWV7BjwHW+A7kS
X-Gm-Message-State: AOJu0Yzay5IwhYIaZbY0DVMVGiC9bpx2mrHeC5aPGoe9MYUk2HU6mLk8
	BolSSFGaxBvan+PC3NVpFingWojd/YH3YrZUPQoqmSpk2BU1Ia4n
X-Google-Smtp-Source: AGHT+IHySZPGneCeilbyiEHd2PBEFR0SDxJNhhWhViVxgeze4L1iRiaZQ0PmXq9Zn3zXXB12k080lQ==
X-Received: by 2002:a17:903:2408:b0:1d8:e4b8:95e5 with SMTP id e8-20020a170903240800b001d8e4b895e5mr6717407plo.32.1709472752496;
        Sun, 03 Mar 2024 05:32:32 -0800 (PST)
Received: from kernel.. ([2402:e280:214c:86:98b4:6d91:d5f4:8f27])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b001d9a42f6183sm6634803plg.45.2024.03.03.05.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 05:32:32 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: bingbu.cao@intel.com,
	tian.shu.qiu@intel.com,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Removed reserved1/2 fields to prevent kernel-doc warnings
Date: Sun,  3 Mar 2024 19:02:23 +0530
Message-Id: <20240303133223.5506-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved1' description in 'ipu3_uapi_acc_param'
/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved2' description in 'ipu3_uapi_acc_param'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 drivers/staging/media/ipu3/include/uapi/intel-ipu3.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
index caa358e0bae4..926fcf84e33c 100644
--- a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
+++ b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
@@ -2485,11 +2485,9 @@ struct ipu3_uapi_anr_config {
  *		&ipu3_uapi_yuvp1_y_ee_nr_config
  * @yds:	y down scaler config. See &ipu3_uapi_yuvp1_yds_config
  * @chnr:	chroma noise reduction config. See &ipu3_uapi_yuvp1_chnr_config
- * @reserved1: reserved
  * @yds2:	y channel down scaler config. See &ipu3_uapi_yuvp1_yds_config
  * @tcc:	total color correction config as defined in struct
  *		&ipu3_uapi_yuvp2_tcc_static_config
- * @reserved2: reserved
  * @anr:	advanced noise reduction config.See &ipu3_uapi_anr_config
  * @awb_fr:	AWB filter response config. See ipu3_uapi_awb_fr_config
  * @ae:	auto exposure config  As specified by &ipu3_uapi_ae_config
-- 
2.34.1


