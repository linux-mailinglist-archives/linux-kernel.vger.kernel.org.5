Return-Path: <linux-kernel+bounces-37778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F92F83B4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AB1289039
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516B913BE84;
	Wed, 24 Jan 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="fp/RkUga"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680C13AA58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136309; cv=none; b=tE74HuQtKM2AGB0jQiSRTbct1WzXe2AHBU0Sf1ygLFZfb0Ptousjfh8u8vE08yOcuvCXjdUqD+9x0oIO+X0SL49cmriTTV5jWAl4SIMwVNO+ZJdpZNigsbh0+FkM1p2E16W4PS/KM5SLaMxfOZ+8tx5EfABYm5qkHzCuXliFJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136309; c=relaxed/simple;
	bh=NPVebQOC1RZfI4g42YE6iK03ZSKXA93yaB3EGLvfYik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9dfhBdSfW2xDg9goyBGSb/3bZMIfZMe1UYhlykhn9PIUjTqTYfdFhDbAw50QF9ti5O9IfwoB74nZg4BSC9ftKvNnHK0o8I4HpFkoWpCIuzlzKVpPTm8GVPXUvWOA+Kf6L/79cA3AdO8T1oOvefzsU+NtRirC0PMgNxr5kEDLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=fp/RkUga; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d75c97ea6aso1137865ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136307; x=1706741107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/3JpBe0UCY6AdN00u9TsKTn1ffof6dRRWPOfIjAUaU=;
        b=fp/RkUgaCwidwS9SWC7H0IJUwVqr6aaPiuTzoXr4ZfWQB/FPjra2FkoCMC8VhsM2FG
         6lkVxYTlVesIVq7TmoPgK/IcE5J1+d9+uZeb4Mp8u5A1S9G1u8SaMblQHSmbNQb7Nf6L
         xyTYr41kdg+zy+RGbYnTmoFLAuGd+8hkH9eKyuahixLO89W+r/wb3EcD+mReSba1c+zD
         o0ZDYQBNPI2U1b3LEofUCDQZ6AyTFkUHCe4GPOgYZ5fNg0ka8hk346Q/RwbNtEEypfUd
         P0Svi+qJS5aQSmZFYe+lEekr0X0g/aVBec79FS/3GL/VaUPHS7IvKgFEqChxJnaDxj7V
         u+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136307; x=1706741107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/3JpBe0UCY6AdN00u9TsKTn1ffof6dRRWPOfIjAUaU=;
        b=XbmoaC9d8jjrMSRhTYBbBfsNFVxrSzQOSCjxxgJ1JtxdGw5VnPFUQsucrzRSZIQBgG
         LypahSIwMHRpDnYwa8l1to+H6C7XxB+b3WNu0uQ2A8iBE5H4+eWBDnsTabkld1jkM1SL
         Oo4XRV2GpnhP5RMmbutpJasWrPwrLRwyy1tRnSbgQhu7H8VwHPteveMtEk3tbiA4s36f
         Fq6qzfsonbHIF7qXHpeocIe59Z9YcriaNPM6gOIEDQe3WZqWKBZuZNuDcalPDJrbOy0K
         9gKKPF+FR8eAPX56DVsIZsNEh6ahpNwrpmGF7nHyuH3BTNeJgCOJ5brVTIPAOL/HD9H/
         ovEQ==
X-Gm-Message-State: AOJu0YxLd0FrdyQaAY3/mDaBeAjHkZhNhI8LnRONMgSZjVL4V/MAk5M+
	znsc69Re5D/yG5X+hBoufTroSUZ4YCpCUi22XZ6jrIn7Z67o0x+u8a3i1IE0Hn8=
X-Google-Smtp-Source: AGHT+IHFi9mGdDi1bGwPoQsVaVI3TlGgY93bJNWYhg5tAZYYb28+lDr+QTJ/OooD0YUxc2EnOYI16Q==
X-Received: by 2002:a17:903:298d:b0:1d8:20ea:4284 with SMTP id lm13-20020a170903298d00b001d820ea4284mr89116plb.29.1706136307562;
        Wed, 24 Jan 2024 14:45:07 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:07 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/18] Staging: rtl8192e: Remove unecessary blank line
Date: Wed, 24 Jan 2024 14:44:47 -0800
Message-Id: <20240124224452.968724-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove blank line to fix checkpatch warning:
Blank lines aren't necessary before a close brace '}'

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ab41632def7a..dc91e59f1bc2 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1081,7 +1081,6 @@ static void rtllib_associate_complete_wq(void *data)
 	}
 	psc->LpsIdleCount = 0;
 	ieee->link_change(ieee->dev);
-
 }
 
 static void rtllib_sta_send_associnfo(struct rtllib_device *ieee)
-- 
2.39.2


