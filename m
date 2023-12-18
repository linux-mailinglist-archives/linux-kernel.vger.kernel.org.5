Return-Path: <linux-kernel+bounces-3914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E169817511
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405A71C24250
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D12049891;
	Mon, 18 Dec 2023 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KItpsLFu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8CB3D579;
	Mon, 18 Dec 2023 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28ba05b28adso375159a91.3;
        Mon, 18 Dec 2023 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702912646; x=1703517446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sSlpTRou09JsVwTLNvbg+U7lQZsRkp+48aYZvwXB/s=;
        b=KItpsLFubQCcN29EbK+t+NAzyuOeRa85LD2h4ULEoDt2cP1YsuJg+bwoquDbcTBysV
         X4jZF23OXEBavlJGKC2GQQBFbgQXgY9je+S9z/u7e6gN5z9z/vrKzih25CUAt5z2qy2N
         WLIdCqGPczhGU4KLEC/Hph2q5BKOG94LjEFqg03GtYhDeUEt3nPHWB6c0RpmdH3dtb+e
         kTSxQUtlelcnSoZHGd7NP+i5ioK2+KdTHA84Etmek7SUylu48wyQkhUX/yOB1KqKcznc
         Oe6+tn0Hb4gNh85Uk+W2lkLZy1NfJTz9s6KayOeslsljKFbiGRjNXN9tym1zRZNL2dmu
         RZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912646; x=1703517446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sSlpTRou09JsVwTLNvbg+U7lQZsRkp+48aYZvwXB/s=;
        b=eOA9iABjsulj5NqiM3SpIXc0YjQbvmW03WG5lhnOqrZ7Y2chw/bTw2tCsH9dN+BMHB
         Dh93QGj2nJYhl/e2VQe7ATv/O4lQLS10eqHnxben3Qlc80+S/TYEbknj6O8FLeOiqS8o
         Ls+BNewnNsSsXuTLWlpTVD6tvKKakYwzoUCScJJwCDvZdaYHiTSYkCfD1eAxUnGmDr4z
         3dAFFrUhy8UePV7uqreow1ub5LVmT8zQ40UhG4r693b+14XaI4Rd98hEA9D+MoMxCydc
         jXEvwF8ih00rpw+89lQzRT23Cc5QuW2yMqRmzMe8DAFvAMFbSZqk+Lud3yWvwHqaejHW
         inWw==
X-Gm-Message-State: AOJu0Yy2Gwt/NIT3LuSiQK+zyRQ0Pivv1rRSNvpd7NTxlwHk1fCiEaW7
	MJuYCfJuDG5lrKRkhi1gQCQ=
X-Google-Smtp-Source: AGHT+IGe3IJac/lizAUEvlaMq23plr5Jr6d91eSJPJSnKbCGX35B0n+f/GzjuWPVTiDYXG5ZjltwNA==
X-Received: by 2002:a17:90a:c7c3:b0:28b:7ee0:4ef0 with SMTP id gf3-20020a17090ac7c300b0028b7ee04ef0mr667374pjb.39.1702912645812;
        Mon, 18 Dec 2023 07:17:25 -0800 (PST)
Received: from ubuntu.. ([202.166.220.102])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090aec8b00b0028ae8284840sm10514190pjy.10.2023.12.18.07.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:17:25 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] drivers: staging: media: atomisp: pci: Fixes spelling mistakes in ia_css_irq.h
Date: Mon, 18 Dec 2023 15:17:04 +0000
Message-Id: <20231218151704.449883-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script checkpatch.pl reported spelling errors
in ia_css_irq.h as below:

'''
WARNING: Possible repeated word: 'in'
        /** the input system in in error */

WARNING: Possible repeated word: 'in'
        /** the input formatter in in error */

WARNING: Possible repeated word: 'in'
        /** the dma in in error */
'''

This patch corrects spelling errors,
changing "in" to "is" in all three comments.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/media/atomisp/pci/ia_css_irq.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/ia_css_irq.h b/drivers/staging/media/atomisp/pci/ia_css_irq.h
index 26b1b3c8ba62..00e2fd1f9647 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_irq.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_irq.h
@@ -84,11 +84,11 @@ enum ia_css_irq_info {
 	IA_CSS_IRQ_INFO_ISP_BINARY_STATISTICS_READY   = BIT(17),
 	/** ISP binary statistics are ready */
 	IA_CSS_IRQ_INFO_INPUT_SYSTEM_ERROR            = BIT(18),
-	/** the input system in in error */
+	/** the input system is in error */
 	IA_CSS_IRQ_INFO_IF_ERROR                      = BIT(19),
-	/** the input formatter in in error */
+	/** the input formatter is in error */
 	IA_CSS_IRQ_INFO_DMA_ERROR                     = BIT(20),
-	/** the dma in in error */
+	/** the dma is in error */
 	IA_CSS_IRQ_INFO_ISYS_EVENTS_READY             = BIT(21),
 	/** end-of-frame events are ready in the isys_event queue */
 };
-- 
2.34.1


