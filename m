Return-Path: <linux-kernel+bounces-84108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6424B86A275
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2633B304F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7019156962;
	Tue, 27 Feb 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq7HRZNO"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB314A4C1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071931; cv=none; b=ms+fKiz06Wj0FrwTJ2MaMFpfOLF6D9jAJzV781k2AM/1K7b+MgmQsCvS9Z9fXwrwNeUOnSVSCObcmSdlFqdNkOYua4gGBO5SPNvm6XCk2iAP6HsAOALgaMlKjs8t/oxLc0O9BJv+tywZVqXMbkhWvoruk4ezyHTLG13x7uI5Wh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071931; c=relaxed/simple;
	bh=+2njOV5Ga0IzlzN0XUiI1XPr4AZxQTAQfakyMWn49qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LA842CeRVOx2UH6Yckgfa3PKriBnp6n4nY1wfxGJ+IK4/euWubpK9AIfPxiULjtCOznyIvCxv7FaeOS760Jw1GutQV0nRKMQ3DavyhHx6sjdFIy1AD9zUoZxfInqRXUsu4nqr5LAzq+fIY5bbiSBuPsWfX7nrLy5DGGHFoN0Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq7HRZNO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33dcd8dec88so1943818f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071928; x=1709676728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ahqsv6gOyMACRg/0NA4F3TAuiEZ+oz6aihxiy2L38w=;
        b=aq7HRZNOY+gXU7Gh0C8ug6tYzWVl7pmIpvNFOw92LzEVr8Q2iMfiRQrgCC+JhLh9+u
         zcgc6+1drFmPIJX00Lr03cqhO4RMCCqXl05FI1P88ODWlpsp+XKLMsph6hKXEsWDEJBh
         Jky2pab5f+O+ze9w/XQZvTfqoJ9NoA5OUD4DDuNI81v91KcXYG2C5iDZ6w4QPilbTjH0
         k0cDvIeGJ4NAy5qKXE/y1WRfGBNv4ES1GB8zzBcATrlvy3lRXK+HCwbVVozPfcj79aMJ
         ozAK0sRXFoQpIl14D8ROeHbUXFJDfSz7+oJAStXd7RwIW7pRYAQCnMSpzmB6vP7Rk1gY
         dHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071928; x=1709676728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ahqsv6gOyMACRg/0NA4F3TAuiEZ+oz6aihxiy2L38w=;
        b=t9vOER2G5Vj/tjP2LLCLZ0eYuixvFkgHxiJp5bvpFAsA7467bW79GS/8z6qx1kkJ2M
         rm6qSgQBS1nxFTv+ZQsTBKmyJzNV4hYFLdFgEikzgV2FtMD/l+0iYrv+kgDrjGwty/9S
         cIYWq0h5kxX1nGKMN4UUzaH2rwM3WEe6+cGS50BxFJp/45JDL5IJLG295gkDJ3MBsXc0
         mZ14RZ5JsfyyC13t1BxtNpujqXnIHnxtyzGZeO1QxvEemqEIG2tnMrh1hSkhMacNR/An
         timBb1vC1Zmsquvlqa+2ZceDAXgjiDK7AHHLC+fto50lYiHqE6uMc2dUqB4im0psuvZr
         rMhw==
X-Forwarded-Encrypted: i=1; AJvYcCV1H36XPVp0ULpVz0bPAA/MwLSG8SzejdUetb92oO7Z/QDFMIeDPonrYGd6s7yOoGm9nPEPHhpNfCbbRKdsezNdkXuXvxp1GwSqt61e
X-Gm-Message-State: AOJu0Yy30aF/sPxFCdQmacDgvnuR17BFfSGSdZ5DZCond+65OhEwAWY4
	vXVh8+cv6SnujWQ+/sUp+dc8tW3eVZSm4WI8QDL1ntGGLQEdX2SM
X-Google-Smtp-Source: AGHT+IFxeTviGcC/lzANrGD6bgEzkPpsHyY3xp3fzzfL89LThzqsCFEG6WS0XyMDXyNgRMGvxShwyQ==
X-Received: by 2002:a05:6000:543:b0:33d:1cc1:bb08 with SMTP id b3-20020a056000054300b0033d1cc1bb08mr7903187wrf.22.1709071928001;
        Tue, 27 Feb 2024 14:12:08 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id o8-20020a056000010800b0033d202abf01sm12415560wrx.28.2024.02.27.14.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:12:07 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] staging: pi433: Remove a duplicated FIFO_SIZE define
Date: Wed, 28 Feb 2024 00:12:00 +0200
Message-Id: <20240227221204.534131-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227221204.534131-1-ikobh7@gmail.com>
References: <20240227221204.534131-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIFO_SIZE is being used in both rf69.c & pi433_if.c source files.
It is also already defined in rf69.h header file.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 8c7fab6a46bb..b3b8d1abd3eb 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -13,7 +13,6 @@
 #include "rf69_registers.h"
 
 #define F_OSC	  32000000 /* in Hz */
-#define FIFO_SIZE 66	   /* in byte */
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.34.1


