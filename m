Return-Path: <linux-kernel+bounces-137839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523989E82F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49934286BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E510A09;
	Wed, 10 Apr 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SrjgMzCH"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E108F6C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716321; cv=none; b=Udq5TYihm80PFV6u+F47RX+fO1iggE8N8vM+yFzExtUzVpE1tNM+iRiRNW5Crx0krfY+cW7Cltt8bzgdBreXP9e3HTgO3vn+JQTc3fytuEMe5347IpDNMsjpmjouyUa+WGE1/XgwLN5TisnEhcAZdRjddnvYd6n3HDaCnBFwxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716321; c=relaxed/simple;
	bh=JCsgCprEWa1l4SCGDGbUB8ubZ+h1Yzs/Ma0V4GeDTGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLozJfTsNqY+tQRJGi+tOYBP6BepuBWnM5rqAZWPQFBPCj6ftJRBiWb/wEGl8Xp4WoqCVDRHvpmhmBZlTSmdlrsYXnJtEPTtzB1rcKHTYciEEJXCVMn6jd3MP91eEWLMDp7frdQCJAdb2++b+iZ2eT5Tl+lXhLBOJ5qOWyaUzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SrjgMzCH; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22a96054726so5361588fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 19:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712716318; x=1713321118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHRtLi+awmnGIE7fYkBoAx7My8kibiodg7yHDLCH7Io=;
        b=SrjgMzCHjCwLVE0DmA2jtUfljAsa64Y0dpMP2DqvpSH3EgnxOYJMEf3pb0WpYXdLOl
         bD+jrEop+NuUU2VOGumehkgikm/fVjFqCySQvpg6xJoo6ZVGpPjnoV7RL/Aa0q/GlXct
         tKtz0VMN3sSs1CDv8+V86ayWric/r32NNK03w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712716318; x=1713321118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHRtLi+awmnGIE7fYkBoAx7My8kibiodg7yHDLCH7Io=;
        b=ErblCGiwi22p16XiM5SpJdKW++cVyzdkp6C7y+gXK+m9XRG3cvULiNEUu61UsNm6ji
         ZHxZrdMsNtlf3ddWdUyliQMxkYihQWzq9M7jBbJqbGYnwfYj9j9qmwpK8rmV3hnZMT6C
         GuUwcEeFT2hm/Vlo+EARK1YjTCAKxe977NBfqspP8A+jVUocNnj9AlmU1R250DHyk2wH
         kySJ34hIYW353f3QnLH8V0Wx5g9S8Iym3WWh+EH7nmA/VCCNaYwU20cO18UFbBH5jKlb
         glhARsHPohxAjUDaMSsmLkCRKBNl9fsuIFmuSdfFdGnAYUNDO8cRkgVdgtP3E3Qyo+zy
         vImQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwcIsgGo+cbWKSx4vMGkXBPqGvc/uOcFKBRklB3B/fvFE8WGqaVL0HdAWNyQu5faXX3WAlrwyoSTASva+aAd4gb6f5sT+hB+KAiUZb
X-Gm-Message-State: AOJu0YybEBmXQJA3j+ApSdAUZD+C8pEJUfC1J/xu843qvSTA3V1sxThT
	scx9I9wH8FmhU99byWA73Wo3myfg9k+8+YkbcmqyQMeF+LlfHK6aZrf99ieqJQ==
X-Google-Smtp-Source: AGHT+IFRyXg0eTdw450Vq36zHeNUtw3iCaUhs4VSlyDJfb0DpKJHBxFM33ehx65aD4AK2nBbeg7RxQ==
X-Received: by 2002:a05:6870:13c9:b0:220:6edc:1fd7 with SMTP id 9-20020a05687013c900b002206edc1fd7mr1259703oat.1.1712716318261;
        Tue, 09 Apr 2024 19:31:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p4-20020a056a000b4400b006ed06399e0csm8065458pfo.72.2024.04.09.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 19:31:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Kees Cook <keescook@chromium.org>,
	Charles Bertsch <cbertsch@cox.net>,
	Justin Stitt <justinstitt@google.com>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Shevchenko <andy@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: [PATCH 2/5] scsi: mptfusion: Avoid possible run-time warning with long manufacturer strings
Date: Tue,  9 Apr 2024 19:31:51 -0700
Message-Id: <20240410023155.2100422-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410021833.work.750-kees@kernel.org>
References: <20240410021833.work.750-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=keescook@chromium.org;
 h=from:subject; bh=JCsgCprEWa1l4SCGDGbUB8ubZ+h1Yzs/Ma0V4GeDTGk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmFfoapA0jSRgfPR1sV3aqPHMnroQNsZpklKX1t
 cw5ZZgf3nmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZhX6GgAKCRCJcvTf3G3A
 JtFpD/9RjRSGfqMioS+VbASHaxCQLXGu+eeHR8PmV46+1XHXwlDmiB4qhXcJVPn5SxTvumjfLdX
 cdsWdPitwCDd1rmdkhZFQBFbApN7JZY19OPk1IznV224pMgEJ4Wr3CjGYAKwQhkLPfr+FJ4WBeQ
 YAZWx8wxcI9qFgauL79FwHCAksDToU5TsQTVoIjEUThMSk0bbOqxzurszTfbe0CiwGXs6ihSFvZ
 6SSrzNj9YZADh+Vb25DzyScDWlEdcsnhbvjgjQUofPfR9l9VnqbnXxtUy6f/Rq26f6cL8VDnTI8
 EiJbj6cZy+Os+xtOACFtn11kqXedJhygwP3STSt8nhs4vHK/ZnTEiQV+ZV9jKBXPJTuCFpcUf5n
 LcmgL5exH6LePjRTgbfTBxjcN2nj4Byc4uEG1InJQWdyhQW2CuHfNgLfjldBNVE2ovcAcrBVSma
 tj20k1udmZ3v+YmUNKx9p5idV3ouKxHF0mZQeVFPCzkdHEWZuLJp7m9oFGu/B6tTZ1tIb0HmDoQ
 gln22cDiz9N0izlWpnyyseCi5ph1I6BDaOMRX45SXJ956/M2yor0WSprV24qbsHQQtVNBd/qx+t
 PpZRkeOXgc3/6Kk6dE0eFaSgNcq51hvmrE3Gq/T7Mj+1kL1UnGf0sNdJZvXj0mLL2emiFR9g2r9 S3cIpGQntVIb/GQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The prior strscpy() replacement of strncpy() here expected the
manufacture_reply strings to be NUL-terminated, but it is possible
they are not, as the code pattern here shows, e.g., edev->vendor_id
being exactly 1 character larger than manufacture_reply->vendor_id,
and the replaced strncpy() was copying only up to the size of the
source character array. Replace this with memtostr(), which is the
unambiguous way to convert a maybe not-NUL-terminated character array
into a NUL-terminated string.

Reported-by: Charles Bertsch <cbertsch@cox.net>
Closes: https://lore.kernel.org/all/5445ba0f-3e27-4d43-a9ba-0cc22ada2fce@cox.net/
Fixes: 45e833f0e5bb ("scsi: message: fusion: Replace deprecated strncpy() with strscpy()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: MPT-FusionLinux.pdl@broadcom.com
Cc: linux-scsi@vger.kernel.org
---
 drivers/message/fusion/mptsas.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 300f8e955a53..0f80c840afc3 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -2964,17 +2964,13 @@ mptsas_exp_repmanufacture_info(MPT_ADAPTER *ioc,
 			goto out_free;
 
 		manufacture_reply = data_out + sizeof(struct rep_manu_request);
-		strscpy(edev->vendor_id, manufacture_reply->vendor_id,
-			sizeof(edev->vendor_id));
-		strscpy(edev->product_id, manufacture_reply->product_id,
-			sizeof(edev->product_id));
-		strscpy(edev->product_rev, manufacture_reply->product_rev,
-			sizeof(edev->product_rev));
+		memtostr(edev->vendor_id, manufacture_reply->vendor_id);
+		memtostr(edev->product_id, manufacture_reply->product_id);
+		memtostr(edev->product_rev, manufacture_reply->product_rev);
 		edev->level = manufacture_reply->sas_format;
 		if (manufacture_reply->sas_format) {
-			strscpy(edev->component_vendor_id,
-				manufacture_reply->component_vendor_id,
-				sizeof(edev->component_vendor_id));
+			memtostr(edev->component_vendor_id,
+				 manufacture_reply->component_vendor_id);
 			tmp = (u8 *)&manufacture_reply->component_id;
 			edev->component_id = tmp[0] << 8 | tmp[1];
 			edev->component_revision_id =
-- 
2.34.1


