Return-Path: <linux-kernel+bounces-167587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DBC8BABA1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E70B22330
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C08152523;
	Fri,  3 May 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ex1N/J/z"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B9152517
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736023; cv=none; b=rVwkqCGdSHbID/D/0dsNzI9Og+wWARnrDtroF8Lv3udPdWKicGS7DvnvFWJ1FY9S1HmXl1v+v6tMpkV4EG7CGYJJ5TlNpn0hroxcqbUaC8YQPd6BsVqH5gou/uAZqa/gh9b6vsr5JSO5Qdas/tcrkbrbw66M00v3cXomzZRfKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736023; c=relaxed/simple;
	bh=WADYspwgMs2YdaZV7xUa0mIJSKnYTWlC60xHwnIngW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tWcAxh6pniR3kbwBSovpP7DBekJKYlTR3mKAJSgZn9yKmxzkvFmMA/N29yXuKp5cSovYJo4hQPdQS77KqwvH0/Cv7DgRVJYGGZ4IraDSJPnrZx52FdmVFLlVrydzl+L5x77UEpQXIuyH1hnkmV9Q5HCG+wCzLBReItIBYEMfPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ex1N/J/z; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-790e7c02430so508018985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714736020; x=1715340820; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PV1uvsPD3hPVQBDeLEfhqbETDS++mq2cZ2grIK4TBwQ=;
        b=Ex1N/J/zXeUWtVlEw9zP/ShKR7HxAkQC0S0l6bqsdPbmsy4j5FWojUOxxiCq9iixAT
         u5lZi/2Xwon1dGTs8UKtzrrYrb4lfX7Id/5Xkavud9r56NFIjUcJSFt60sMs10b69kiP
         Tgv6MzV4c1Gy5Yb/Dr5frXHF9dZV4ExXsRGjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714736020; x=1715340820;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PV1uvsPD3hPVQBDeLEfhqbETDS++mq2cZ2grIK4TBwQ=;
        b=kLrBaA4E1k6c45d2MEc1L+RHDQ1uAk0muvhIDipZX2E4CHEf2rK9qQDByOiIIlzr5h
         TN1GYULg3wKojjRmZr209iv07/DOWKG5I6gsb/Ec5WiN/gGSkuhWjUbsS1yKmX9m1Wi1
         LIh1k29yyqzQlnH3xIskE/vcaz+1dfq6Y2wKoLd8HEz8bDJsmctGHL+RFuciLJaKvuUI
         aCK5/O04viI8dvtIDC2f336uRbdOX/xgkkk9J3m4NtxWpse9+ciDWM2oy1uduTYpB0AG
         O2ksFvuNI8TgnUW7p7/1bhQXifMHr5Q3mMX54PuQAt2vsTMMZAzpW4uUK/STDBI2oNvQ
         6vCA==
X-Forwarded-Encrypted: i=1; AJvYcCUbgjTyKQWYSzs+RaIqU9/S0cGG8jqgbwuuhHqRxnpUi/NOTAtD54jSrT7erJY5Tz/eyjUvQOaN1N9WhrSZ3ER0dujHe6TmZn/L1+6x
X-Gm-Message-State: AOJu0YyBbeNdig4LdX1z6okqZztnEZa0KCRZ0UO4RPoJZuMsbzDaVf/V
	Um7EKJhqarb6FAvyDlTUcx3yoTlfiSRPIj86/Lq+P7qqu8ffrxRjmHL00f/EhVsz/wfGlTdRUhz
	mng==
X-Google-Smtp-Source: AGHT+IFPT+c5g8iGSubsJn1MAU4lk1gCDhjOfclD78asjQf9ys4/KXilDg0+WfalUYicwon901btig==
X-Received: by 2002:a05:6214:501d:b0:6a0:a7c7:4d5d with SMTP id jo29-20020a056214501d00b006a0a7c74d5dmr2533425qvb.58.1714736020543;
        Fri, 03 May 2024 04:33:40 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id f6-20020a056214164600b006a10054acadsm1137432qvw.19.2024.05.03.04.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 04:33:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 03 May 2024 11:33:20 +0000
Subject: [PATCH] media: cec.h: Fix kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-fixdoc-v1-1-44d26e6f9dba@chromium.org>
X-B4-Tracking: v=1; b=H4sIAH/LNGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwNj3bTMipT8ZN0UQ2MLg9QkIxPj5BQloOKColSgDNig6NjaWgCZWnJ
 4WAAAAA==
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

is_claiming_log_addrs documentation was missing.

fix this kernel-doc warning:
include/media/cec.h:296: warning: Function parameter or struct member 'is_claiming_log_addrs' not described in 'cec_adapter'

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
https://gitlab.freedesktop.org/linux-media/media-staging/-/pipelines/1169148/test_report?job_name=doc
---
 include/media/cec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/media/cec.h b/include/media/cec.h
index d3abe84c9c9e..d131514032f2 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -187,6 +187,7 @@ struct cec_adap_ops {
  *	in order to transmit or receive CEC messages. This is usually a HW
  *	limitation.
  * @is_enabled:		the CEC adapter is enabled
+ * @is_claiming_log_addrs:  true if cec_claim_log_addrs() is running
  * @is_configuring:	the CEC adapter is configuring (i.e. claiming LAs)
  * @must_reconfigure:	while configuring, the PA changed, so reclaim LAs
  * @is_configured:	the CEC adapter is configured (i.e. has claimed LAs)

---
base-commit: 1aa1329a67cc214c3b7bd2a14d1301a795760b07
change-id: 20240503-fixdoc-d1380eb243cd

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


