Return-Path: <linux-kernel+bounces-60569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0A98506D9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF53282BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0255FEE7;
	Sat, 10 Feb 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvM9JKh6"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1975F84E;
	Sat, 10 Feb 2024 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707603329; cv=none; b=AKZwEXhBz1cMaHNK+L7ks8Vx62iXzGlyWTiZjQpnR+1ijHRrsu1yY1r8wkMNKQu3eGCxB7mhdJ0MDI9vYgX7z+wKuF0Lg1lPFrKTZx2PK2ufDvUIvkKf3sggYydV1vlqiHPdZp40PdixE/DBZ6inuvh54XWw12sKYi3ghciuoSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707603329; c=relaxed/simple;
	bh=BRBXjjTaaIg/lDsxVQno90HBFLswvVpFxmbOQLTe0Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVTCAZUB2gKiDPbCzCjtwwwStxC2pb6aioGeH/iN4fEDFc7SthzHQ2FjpKJrZkPV+RicHDo3mY9SyN1S+NwMJzorsFdKYu+RKD8jCXTQtPBuwUVI9D0jtafTUrKDG5VR47rpIHaXGs7x0XiCYikmw50Pi7/UbmXWpiRpwKufdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvM9JKh6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b2960ff60so1727481f8f.1;
        Sat, 10 Feb 2024 14:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707603325; x=1708208125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3rm1Ms90qHIEjQmaGDGejHMu8DwmDql6WBGu2dQWVI=;
        b=YvM9JKh6PEBdwuaiG8LAjqF7LLEHpFZxrLiPZEWK31IohrpTpJSWxkej+zgOInZkU8
         nUxStFcXDQgrSgaA+866XQxwclXuPTJ0dQvxxT1cEXiR0zDUgQKWK7QjMHGJv68OpUQ9
         mQmJ/hthhCA69+1CUPoA49kIEv9ZzWKxH7Jv0hJal/9Zfy1+FD8dRG3Xz4y7TmqjLRDZ
         ct/YQuYHfmmtxiiCrO/BRHP1vj2EaKOkeBAOkAj/XQFas9sHdYtdw7LqhZiwp4XYeHrY
         qdU4sWY8D3Czu3Y22kRUyMyN2S4alJNrevmKV1Sd0cMBCA0BbwuDBoZX+orafuK/aXKe
         FauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707603325; x=1708208125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3rm1Ms90qHIEjQmaGDGejHMu8DwmDql6WBGu2dQWVI=;
        b=k2eCXEGyxaZbHv72RvaJUC/aEny7HFQWgOktxpMSZJ6nTiosmdl2ub9TxpD65ncqLQ
         fEZP0KwIQP0RqdL/lSQqPsRNHnfKSbD746EL0DSOIjvfisVsh5JR7PKf7HMPwtZAtckI
         GpETw73F6H4wIAEOk9NpIOYg7QWVNG3GFl6/9FV2eRoGArFdcQ4vP628V/7fsU8Af5eM
         kdnJ2oW8tcUCwkkwxZBxi8Zbv2+5WUufQ5oLy+QSVfPte7Y6BPDSqrtoynvUv2q/aksl
         3h4NoslbY9El9V0uU415fsxYBftjZOqhHFIzTlza6hACQmxdXpdPLjM5V6Yh80F+oobF
         6+TA==
X-Gm-Message-State: AOJu0YyJv5GNN8wZZcxKk9Z9UvmHLNHKblobqE5r9xo4CyIobki94LtW
	N/fsuftvV/Shz9fHOLNq+obE7uCCTqUGct9yRIvXJpmd0XEdPoIv
X-Google-Smtp-Source: AGHT+IE0y+UCG4EdFJdQie7+RKChfwLRw3RuexFy6HM/rsWFm9N6XtTqLivyWTYUC7gXTGSRVK+0Sg==
X-Received: by 2002:a5d:54c5:0:b0:33b:6cf0:e33f with SMTP id x5-20020a5d54c5000000b0033b6cf0e33fmr2406246wrv.7.1707603325409;
        Sat, 10 Feb 2024 14:15:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAwifN8+ycN566trEq3a6K9iz8dhjkjXHR4SH46LU6vsERvjPqq/72+WrhyoNBvYThpNo46kNZ8WfAizqqVrOF58Li3XYA/gnbu5jWtVI0Nzr9DRlJScSsvAGydFqJ6FohMSc5MsQvKIOVLJx27jUBAozY9NpK/ojPJClZLYXm9ymSryVRlMfM8iLQ1xmxEHX8HSBMklNyzg7o3VOQ8N+zTKv7dodE1GL19O+sSNDvFDCekbqLGCgl6lhbCKJ4HHrZ3LbGZD5JOXZuQpC9/cBzKoOTo3CjBlOErvYgnCCNaPiSSzKqjxtrXGRrRCo4UOmFMvM9sj550xjH5vx6NjcibQ==
Received: from localhost.localdomain (cpc142640-benw12-2-0-cust620.16-2.cable.virginm.net. [82.0.14.109])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b0040fdb17e66csm4448843wms.4.2024.02.10.14.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 14:15:25 -0800 (PST)
From: Youssef Quaisse <yquaisse@gmail.com>
To: sakari.ailus@linux.intel.com,
	bingbu.cao@intel.com,
	tian.shu.qiu@intel.com,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org
Cc: Youssef Quaisse <yquaisse@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-media@vger.kernel.org
Subject: [PATCH] Fix three warnings when running `make htmldocs`
Date: Sat, 10 Feb 2024 22:14:38 +0000
Message-ID: <20240210221451.27769-1-yquaisse@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running `make htmldocs` generates warnings for file
drivers/staging/media/ipu3/include/uapi/intel-ipu3.h.

Fix was to remove the "excess" definitions.

Warnings in question:

```
/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved1' description in 'ipu3_uapi_acc_param'
/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved2' description in 'ipu3_uapi_acc_param'
/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2778: warning: Excess struct member '__acc_osys' description in 'ipu3_uapi_flags'
```

Signed-off-by: Youssef Quaisse <yquaisse@gmail.com>
---
 drivers/staging/media/ipu3/include/uapi/intel-ipu3.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
index caa358e0bae4..4aa2797f5e3c 100644
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
@@ -2724,7 +2722,6 @@ struct ipu3_uapi_obgrid_param {
  * @acc_ae: 0 = no update, 1 = update.
  * @acc_af: 0 = no update, 1 = update.
  * @acc_awb: 0 = no update, 1 = update.
- * @__acc_osys: 0 = no update, 1 = update.
  * @reserved3: Not used.
  * @lin_vmem_params: 0 = no update, 1 = update.
  * @tnr3_vmem_params: 0 = no update, 1 = update.
-- 
2.43.0


