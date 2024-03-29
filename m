Return-Path: <linux-kernel+bounces-125408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59E892594
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DF5284514
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5131369BC;
	Fri, 29 Mar 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jB5W9U5S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733166BB22
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745437; cv=none; b=cMbGA/wklbkvKwvvuAP4X+QixN6gr1lCGi00XXzc3kZIo9QcDZZZd5UjtzuIvhP229FR2S3yY+EdqXkazXmSx7OSHEP2uMMWkpZmESDooHOF0+S4YElVAi+AdmzgN+9CG0DjNhjsoFFjC3Y1OHfNx5bY+/Jk7swkx5OeuGLNlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745437; c=relaxed/simple;
	bh=R8cq5y8opsNuJGie8SiWdm0XAFuqUiR2/EHCWurGSJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0uGo5A+qf4zHRZ6I4T6I30OMFCX5If3fpXKEjqdr3CBvobH5jxefDo5LAvPrZIucAngwIZnAM3NAxtkvBqPgh/qe6sw8t8C/qJjgUnB3E3EVrUa2jOSud6CnA3lwjR6PKePU5UbuEWE4BzJx2NGdNKNUDG7gXsfF2m8JhNRooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jB5W9U5S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GkZ3VnrUmply6CPeiLZYu4w5doBYEYYwbDbS8GxE4w=;
	b=jB5W9U5Sz46C1ZYnG/3qmEmw/mF5xt9LDvW7+eExNBDRVWh1adCETa/51/NsVWlTv0Ayuk
	NspCjw14KTKrji5FOJu6ap8hmgNkVCbSL94GZJtR4Jk1UY7ed7GIXac0anq7jVjt43t2ZR
	GNuLfWFn03Yk0OaxRAEvW1Wz47UepNw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-ZbsMiq66OMKcR38YDf2HAQ-1; Fri, 29 Mar 2024 16:50:33 -0400
X-MC-Unique: ZbsMiq66OMKcR38YDf2HAQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6986f2dba1eso24297876d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745428; x=1712350228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GkZ3VnrUmply6CPeiLZYu4w5doBYEYYwbDbS8GxE4w=;
        b=q5tx5+DtlziPCPix1jcuC5rSYrsi21kJjvaGo2K53a91aUSjqs8JGzQARDv7h9foFT
         IuXU/j1MuKvyCcC6akxtBoT3ycYaCct+y7C/Zt+EVnPLtr/U9pIJKFkdLxCSXxgzlVZ5
         tiEyo7F71JnK0KRwl1Z1f8ySjTOFDItDkYn/Xsb/MFqUanxV+WpvfJTmY+jDUIXr6s8o
         8uh43NJ7+oH/HZhrtKHsXtf/3Dg+RQlssmU3nobhPPgTDdU1stKAMjhzZXKc7fPY1MiZ
         5fnILxYsUPSXiCPTadaBfukPf+IGBNrIHEF28lA/C8xE+xIO00QJsgfj0GGEgmKMp/Iu
         qMYA==
X-Forwarded-Encrypted: i=1; AJvYcCVbh6hHDpZ2kYaqtzCnedhF7XZsvb/2gFOlYK7yosZ/8Yw8ulYV+SQkB7sitYtPIXVj9UbooDa7FPm4+M+t3umQDXRhkXk6QVAqEIhU
X-Gm-Message-State: AOJu0YxjlNJJzN46S5VX/E3xGTp9cXCAUkTsMM6HMmUNwiv+03EKfm+g
	AW/wxk9YH94vEtxVp0y0NEJjB1v4DmYFv5Zl+kcOVfjzpV9twrEpw2JCkEklisKhIs76DA+aqm/
	JDpXWIOB3SpbS6qWZVSkVmdmyI5cdVKJ9/zMtcIvtPi5fFSSZYbf8C0RR3Y+smg==
X-Received: by 2002:a05:6214:1888:b0:698:6faa:74b3 with SMTP id cx8-20020a056214188800b006986faa74b3mr3372487qvb.19.1711745428087;
        Fri, 29 Mar 2024 13:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHodoPhaiAOjuThHpUwwdkVLQEOmEn/gAh7m+wdmNDjPMelrqlfUu/gZ0vzM0RrxHUZOBkGsA==
X-Received: by 2002:a05:6214:1888:b0:698:6faa:74b3 with SMTP id cx8-20020a056214188800b006986faa74b3mr3372471qvb.19.1711745427690;
        Fri, 29 Mar 2024 13:50:27 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:50:27 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Janek Kotas <jank@cadence.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Can Guo <quic_cang@quicinc.com>,
	Anjana Hari <quic_ahari@quicinc.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 07/11] scsi: ufs: core: Perform read back after writing
 UTP_TASK_REQ_LIST_BASE_H
Date: Fri, 29 Mar 2024 15:46:49 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-7-181252004586@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
Content-Transfer-Encoding: quoted-printable

Currently, the UTP_TASK_REQ_LIST_BASE_L/UTP_TASK_REQ_LIST_BASE_H regs=0D
are written to and then completed with an mb().=0D
=0D
mb() ensure that the write completes, but completion doesn't mean that=0D
it isn't stored in a buffer somewhere. The recommendation for=0D
ensuring these bits have taken effect on the device is to perform a read=0D
back to force it to make it all the way to the device. This is=0D
documented in device-io.rst and a talk by Will Deacon on this can=0D
be seen over here:=0D
=0D
    https://youtu.be/i6DayghhA8Q?si=3DMiyxB5cKJXSaoc01&t=3D1678=0D
=0D
Let's do that to ensure the bits hit the device. Because the mb()'s=0D
purpose wasn't to add extra ordering (on top of the ordering guaranteed=0D
by writel()/readl()), it can safely be removed.=0D
=0D
Fixes: 88441a8d355d ("scsi: ufs: core: Add hibernation callbacks")=0D
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>=0D
Reviewed-by: Bart Van Assche <bvanassche@acm.org>=0D
Reviewed-by: Can Guo <quic_cang@quicinc.com>=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/core/ufshcd.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c=0D
index e30fd125988d..a89887878d98 100644=0D
--- a/drivers/ufs/core/ufshcd.c=0D
+++ b/drivers/ufs/core/ufshcd.c=0D
@@ -10395,7 +10395,7 @@ int ufshcd_system_restore(struct device *dev)=0D
 	 * are updated with the latest queue addresses. Only after=0D
 	 * updating these addresses, we can queue the new commands.=0D
 	 */=0D
-	mb();=0D
+	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);=0D
 =0D
 	/* Resuming from hibernate, assume that link was OFF */=0D
 	ufshcd_set_link_off(hba);=0D
=0D
-- =0D
2.44.0=0D
=0D


