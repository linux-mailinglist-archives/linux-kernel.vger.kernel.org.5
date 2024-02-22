Return-Path: <linux-kernel+bounces-77063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246598600C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A891F26928
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A215AAAD;
	Thu, 22 Feb 2024 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue0/3Pe+"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1215959E;
	Thu, 22 Feb 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625673; cv=none; b=asCFZHCESruGdYSwV9//BgYvDCXG655Sk2eDC+bt5u0VnxWCrRjUn+j+AXBksfr5u1/KJxQb2Btd15G7z/0r7mSGUP9XPcm0Pj/Ub9c+NpP0OIrRWq7cUiyDrtTrjmh/0Pzpivn0IxomyCbUPJTh6rVkTtLHHtaWma6IxzZjgnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625673; c=relaxed/simple;
	bh=oGXJR8OhoCabOTPanO1K+l2Sjh3ownabZ5/7tEogxag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dI/R3j/tVC79j51ti5T5V+vMEoibYXi1PO/XjzEhL15vdFLhPok1k4x3x/OWfQ1b2784r6011kg4ZmT4L5nH4dDvO1IwXJYZ3JWq4mxviRv2nLsiATcHXJ+AwJ4JxCOuGSSvK4uV+8utmJoCeTjGBeoKrzZkMztoh+RnFal+Pnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue0/3Pe+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b700c8ebso117215e87.0;
        Thu, 22 Feb 2024 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625670; x=1709230470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbPuoFHthQO7fGdQQUUYWZPA9hiREThQLMfvHVCy2ro=;
        b=Ue0/3Pe+98cA6Dx8aXaNIy1267GfazE0vHHCY9ei5ADgtMhWGXUttPRDFJreOOcep/
         jVWKh0Hgc4QgSLyT/Nx5Vd26iOhPhrV1xUOnigRkur67vXrKmhkX8BxdvDjvnPviLnvH
         AD7apUbirr/QN80LsxgoH9ry/uMI87xDuyBLFhH8xYp7NBxmGWkX6tBqjbbDBAORgm9O
         RmPQ/2SazPu+xBKZFgZ1GPVJHurljQegMSau0NP4/90oFSjTjo5kfyYivpsh2Id+RgXf
         jNPcWGU4kex+zqgC2G7gNBTRJhpJe3RpMAiMAVxDMY1zHF0rkUn61nuJPRaSAkp1Kh8t
         OdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625670; x=1709230470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbPuoFHthQO7fGdQQUUYWZPA9hiREThQLMfvHVCy2ro=;
        b=GulIygj5WUKCmGVQq8hTV533J5L1ogafeXVXlkfLrPxVvfvhe9JHNCKi/4CHJf7bwz
         2a+l1Usq9/e4nXsF/Gg6uvP1aXJxk7nlDNx7Im9rtZsa1vz2oUtSldWY9Bm5sqJ18vES
         OfobTogfp1Kvq0JE/8r3OPeyWDIcYzSd0V+Q7dZ0+q4sfdGovloRVT/kj06ZiiYQAsAB
         rec38Wl1rjIbK4JdBxZW5R2f5YOSpOxdqhzinOAYYqEBzcWWVnNoECKUs8Pr9quGW8l3
         quY+NXkQt/4eYPcB0LNsl99AGDG4otVhwZM089SVUpBUK6P/XLOJDFtJZ087iwuYus5U
         AfWg==
X-Forwarded-Encrypted: i=1; AJvYcCXRgM7vyQaMi6GYcy4BgUTFFo7CHW9QVG2FK7JM2bzBZcbhHl0NVZz5V7i18alsV+l+I6RHR2Ha+ne3Eu3TpXX1LRJLMnSTxfj1QV2uX18zlBZNKRVjKe3s3ppSEgJn4/G7fgHgsZ6LYw==
X-Gm-Message-State: AOJu0YwFOejWtaqBUBayIMVGGlB6lTqdoNmG7HUpGnnCf+QdcA1Fdke6
	5twace8Fj2SW/AxzR+Rrls2ptPCyBaHf50z2GtCkKZbZYAkVZuGb
X-Google-Smtp-Source: AGHT+IGub+R7lksw83N6+DHfltE4tBIGvnJJIwOUCUdGcZp49D75S0w8KHqmr2FCPWTC9/SRdqNmdg==
X-Received: by 2002:a05:6512:31d6:b0:512:a9a4:d933 with SMTP id j22-20020a05651231d600b00512a9a4d933mr12295115lfe.69.1708625670043;
        Thu, 22 Feb 2024 10:14:30 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t4-20020ac24c04000000b00512acc62388sm1837562lfq.237.2024.02.22.10.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:29 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH v5 05/20] EDAC/synopsys: Fix reading errors count before ECC status
Date: Thu, 22 Feb 2024 21:12:50 +0300
Message-ID: <20240222181324.28242-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aside with fixing the errors count CSR usage the commit e2932d1f6f05
("EDAC/synopsys: Read the error count from the correct register") all of
the sudden has also changed the order of the errors status check
procedure. So now the errors handler method first reads the number of CE
and UE and only then makes sure that any of these errors have actually
happened. It doesn't make sense. Fix that by getting back the correct
procedures order: first check the ECC status, then read the number of
errors.

Fixes: e2932d1f6f05 ("EDAC/synopsys: Read the error count from the correct register")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 drivers/edac/synopsys_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index bd6e52db68bc..fbaf3d9ad517 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -418,18 +418,18 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	base = priv->baseaddr;
 	p = &priv->stat;
 
-	regval = readl(base + ECC_ERRCNT_OFST);
-	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
-	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
-	if (!p->ce_cnt)
-		goto ue_err;
-
 	regval = readl(base + ECC_STAT_OFST);
 	if (!regval)
 		return 1;
 
 	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
 
+	regval = readl(base + ECC_ERRCNT_OFST);
+	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
+	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
+	if (!p->ce_cnt)
+		goto ue_err;
+
 	regval = readl(base + ECC_CEADDR0_OFST);
 	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
 	regval = readl(base + ECC_CEADDR1_OFST);
-- 
2.43.0


