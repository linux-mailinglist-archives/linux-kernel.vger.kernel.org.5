Return-Path: <linux-kernel+bounces-34504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4912837DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EE6284C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51595EE81;
	Tue, 23 Jan 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvKOomai"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510D5BAEA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970161; cv=none; b=nNgLUOZaMahJChCccVhvUmKn705gJxDR6Dv2poyGjqdzopK55RXqYu+a+98pfOot6nqaQSeQI9eydt0O8bLMXEB8f/zzizr4Vc9BLNb6ivvwtbGXAIWlDhPlMST340/1/QflJJ3nfmwWAgTljhKUJt3JKVkpzTkhRZf+zJWwm74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970161; c=relaxed/simple;
	bh=JaJ2RzkYot/4sV3jiZLTi+/y/zDvkmsfkl8XZ+sAZv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFb1jhfOtv6s7oZ58fykE5Hp8zj4RiaJIkR4P1Xr8wwQeMvME/RknutvDI8YsCRgtRaUthxmWCthXgVh6RLTfHhcC5A+mirYafNFrhhY4/E2GYTjPk56wdBTff9MDlotC+vmzYwygHUgWJpYFa2tBiJTDUZ/hsPdiiA1F1ZywSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UvKOomai; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d71e184695so13585375ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970159; x=1706574959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIWUdIrQWRkhOO5TDXuKcaUsLitTbGyLlklsAfWCzWo=;
        b=UvKOomaiN2VhtkDv5+8QNC+MtjXQx/iwGzTtFLEcj5s1VSKPBHwN2l2gwIDJh4mjBL
         zFvy+2Ct3bGei9Mw5MsNWsE/Djk5CfXLRWpyVexzj5Wml53eHNq93AIxm5GsGJ/wZx+w
         dVai29oFleneBo8Y+z3PkQ2GT9BFfJa0FDSaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970159; x=1706574959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIWUdIrQWRkhOO5TDXuKcaUsLitTbGyLlklsAfWCzWo=;
        b=O4DUCeRZjXlHVOaVUDudmSMNhbHyaWl/3uERsbWa2/iZ7i/9SsXqsIA/E1Ur6lNWOv
         pzBXTtXWcQ6bRmWqY2XtgsfJYjNAsNP9+iKpI4LovyDFPAuAHiQbhY+aP4CerRzbwbmE
         O7PpSyYVobUAex5gvpp2A8Dk3v0HV6w1OWtYWFq7D9VKH6F5AMB1UB7BXARpzEyToyE0
         8V2v8e1wXpZARy0cohK/S3DaFy66dLeIDMMjwWvGFdL91pSyWFJ3jhsIyS21h1/25pdB
         BMF0F6ovLF7BvV+3lDOoytMVE1HG1wd+/r5HxpQicVcsheN4tmjWYADHld+vocu0emg0
         d9EQ==
X-Gm-Message-State: AOJu0YxFJC13KN8K1/63f9JTl3+HkSQo/lgTJj3QjXKPCp/YC1OI++EA
	QKVUOGAKXJyB8Ot8E9FvFpEv8CF7enYE7NPrQ6T4h+sbkrbsocDSLVYyma2+1Q==
X-Google-Smtp-Source: AGHT+IGbD3nHFvLOHAqRpTgdheaQGatmkkSF5LsUW843Igdg/5hvIeA3Y0uoIVSr4tGmabJc+mdbbg==
X-Received: by 2002:a17:902:e5c8:b0:1d7:3563:88ef with SMTP id u8-20020a170902e5c800b001d7356388efmr2199690plf.99.1705970159024;
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902744200b001d5f5887ae8sm7708987plt.10.2024.01.22.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 61/82] scsi: mpt3sas: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:36 -0800
Message-Id: <20240123002814.1396804-61-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2218; i=keescook@chromium.org;
 h=from:subject; bh=JaJ2RzkYot/4sV3jiZLTi+/y/zDvkmsfkl8XZ+sAZv8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgKR/y0c/t8XBxk6HBTKTo2onZffQ1Swuzxk
 YruIIw+tTCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICgAKCRCJcvTf3G3A
 JsGHD/wO+1S4S3MYfwC+Xgo0UsnlP4RNEo76XTqku6Gtqo7+RgF/OJErJi+PSvELd675QOu9xdC
 EMr1YFfvIBEMrbHHvwJWkaErziO0Y3hRKhrFQr02QIrOnXeDwnIPzHDCv18K0d3Q+q041p/sRyj
 YB7tjSXSsTcFhvkEQ9dY+VylEL1PLD4Ozx1qB10yg6+pNkm/uCWrmiLvfSgSXIluY++aIRb26NL
 VaSRkVOonQ4P4lvoMg00EP5cCn0zHYNyG1e6Ea4+cIaFLUKcV46uB4xzGTwfw+vtbMdtn3jZaly
 hU/RxpkvU2oW1VIYwSeakNHq76noGBszsSTs6meNnd62v/yEdmDyqyTfqFKcm5jwd4LupJnffRl
 PaKJclzIEUwHDQGYtmTMzzYksMJ7+emnQ4pgS08Dr4frBXv3Kw20xwphAev7CU3j6ei4ghTajDd
 xxiU8Oq8sW9mW5SwmfrVaIgLmJe+Uwy7bC1EHgFeqFpqK/AbTNh+FplhncR9+E+Gonpq3iKfGC8
 46fX7SBvoMASJQFlZP+ErSYOfIkvdt5fDwy3899f5cTVxe+NtVeUWwbBhp0I/BMoiXbh/N4Wz/m
 1JLczsOR6Y1t0bzwiFfJd2zNYEyI8gvNaAak6MrluQfkHLAx0zAGsyXDQta1R52iYGD2+9KjtmB cB9P/HPcsvjdiPA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: MPT-FusionLinux.pdl@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 147cb7088d55..b36a9188720f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2382,7 +2382,7 @@ _ctl_diag_read_buffer(struct MPT3SAS_ADAPTER *ioc, void __user *arg)
 			    karg.bytes_to_read));
 
 	/* Truncate data on requests that are too large */
-	if ((diag_data + karg.bytes_to_read < diag_data) ||
+	if ((add_would_overflow(diag_data, karg.bytes_to_read)) ||
 	    (diag_data + karg.bytes_to_read > request_data + request_size))
 		copy_size = request_size - karg.starting_offset;
 	else
-- 
2.34.1


