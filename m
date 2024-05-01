Return-Path: <linux-kernel+bounces-165576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADC28B8E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C171C214CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDC11304A2;
	Wed,  1 May 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U57AvwXS"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1C512F5BE;
	Wed,  1 May 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580795; cv=none; b=oNfdhSfCKOhNu0eyjFvDYVxmmOMh5iTatYHzLg1+axR9zRGR2DU1NSPr2lXLUiuqxITXywPyIeYoy0RI1aqRfYUcuOHDn4DAq31Z5077YjLD9sBNP0eajrrEu0LxKkKfMOaVQuwtr24lYr3qwXZb4SeJeZnjzAcDDfXax0CB9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580795; c=relaxed/simple;
	bh=F9XWlYsdcvjUY25fJrjVOG6I20rFQt/83OfE3Wn2Lek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L+WYmCmkxz6kvxICK26D86xwfI5zrkVx40xiy6Q/WN8S0oJLNfoFS11Ossz2gxIKUD6Qf0DWL08gCrcPeEHfvmS7NwuuHFTPQjC0572dF5+rry5VLT7XgRVebtrffTG9pY4jF5PsZElwKYJGGFSdZqwVwqpPa68SOEflwDbNh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U57AvwXS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f42924ca64so385689b3a.2;
        Wed, 01 May 2024 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714580793; x=1715185593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOnUqkuMHAwnSWqNQgVi5Ycko5vgJVVqK0L4U2r54t4=;
        b=U57AvwXSbUtUAHUiFDoon7mUzcdlALguUTyp1OXfY22FkOgiQ7wC4niQ5YELb9wvPo
         ZbpcOIK0omS2qNYDv6YPtHOli6JtQ70ri1opdyUuhsGrhW3f1cj4G5YpfzNKo9aW85Xn
         eLxNtzpOzFs/H7IgvD/o1jiE1dplzzf/KVzK99CRGQ5V8C89Wcudna04snAiKfSH/8L2
         5oQpWWPpvYYM6ZBXP9eN7zz/VyB/SqYIKBafFP3gBcwow9OopnLAUUyj+K7kRVT93uhA
         P0IaQFdt2MLr+WeZAv4mpRv9H1nzFFajzBOlmlwRam46mJ4jYyTgna/o/UwBRzUpVTLC
         HhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580793; x=1715185593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOnUqkuMHAwnSWqNQgVi5Ycko5vgJVVqK0L4U2r54t4=;
        b=ZRKoWHyUWmC/oU6q0x4tdbnJ+gOnAN806yzVyusaWXjJbPfMWET1jgy5zhBG0VhIZ2
         cu1DS/fwoZFijIDTVCGLTQM77FtXId9asd9Yn8UrNEYADz/pOY0R1UuVaftAD1kfilqd
         RAjDpDyR6hakUGCYWEKXoH1r0uSVdCdUWD10gdUvbvU8rxyzX9RDH5sbKjvEBe1+J9ea
         D1xrBjAOZJSEkf+ftPIsdmEcvq7so5wPDm1O2XDir0gzfPO/I8K11rTZdPZlWCEYJIEB
         dnpGwbRlx2qkJSlal7Gg5YpZjGSLG1an1nT1pEdEoRs9h44k1I13RE3yq9ekRq5UTtCu
         Skpw==
X-Forwarded-Encrypted: i=1; AJvYcCXyzeveRMSzJ49OiM59wyWuBuiv+y+V2K81b3f+YvKNCxTUrpPd1eMB2+K5/7hJnJWV0aBAuBZ0s8U2LP0dGZOTuc6CL9dyrDKQ3OkjT811TzpfLV7aDNH2yuqNZji6pH6gMGCHEjXSUnY=
X-Gm-Message-State: AOJu0YyARM4/d7c508l8eXmsvCG7jgb0JaYiVyoTlQ2g0f4LcUM86/ZB
	hybRisvDVuz7LZwZsIYlgrqE7BV4292b+DpqggLr2ksT14to2cOe
X-Google-Smtp-Source: AGHT+IHwKDw622ZbV1L1HorkBmhkCKboNerHmQ/mlSSn9JUfoO5O+Fa9naEaEBEeVTWaH+p4jTI4Wg==
X-Received: by 2002:a05:6a00:23d5:b0:6ed:4288:650a with SMTP id g21-20020a056a0023d500b006ed4288650amr2783147pfc.19.1714580793180;
        Wed, 01 May 2024 09:26:33 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id l26-20020a65681a000000b00606506a95bbsm11117806pgt.13.2024.05.01.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:26:32 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hpa@redhat.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: atomisp: Fix spelling mistake in sh_css_internal.h
Date: Wed,  1 May 2024 22:11:20 +0545
Message-Id: <20240501162620.86865-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported misspelled words still and member.
This patch fixes misspellings.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_internal.h b/drivers/staging/media/atomisp/pci/sh_css_internal.h
index 2349eb4d3767..5395be1ed26b 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_internal.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_internal.h
@@ -509,7 +509,7 @@ struct sh_css_sp_pipeline {
  * of the associated pipe. Dynamic means that the data address can
  * change with every (frame) iteration of the associated pipe
  *
- * s3a and dis are now also dynamic but (stil) handled separately
+ * s3a and dis are now also dynamic but (still) handled separately
  */
 #define SH_CSS_NUM_DYNAMIC_FRAME_IDS (3)
 
@@ -597,7 +597,7 @@ struct sh_css_sp_stage {
 
 /*
  * Time: 2012-07-19, 17:40.
- * Note: Add a new data memeber "debug" in "sh_css_sp_group". This
+ * Note: Add a new data member "debug" in "sh_css_sp_group". This
  * data member is used to pass the debugging command from the
  * Host to the SP.
  *
-- 
2.34.1


