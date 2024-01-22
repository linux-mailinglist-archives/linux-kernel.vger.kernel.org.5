Return-Path: <linux-kernel+bounces-33812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D59836FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02546B23BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA963138;
	Mon, 22 Jan 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiJFdtad"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE336311D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944343; cv=none; b=Y7ea48qrRCU4e/Tw7Vp5r/XVo31pNcbjSb/YlLp6IAZU/rUvnM7jWCjAetTWusM3NvHHgxVkOV7hMRwB29rFe2vDR+1+QuoX395PTL3nqO9TCdep8YZzUvR3u/zjHXs6HStp5J3oE+8tZnHbcDY5PFHSGpleTocHy8T8ngnfefk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944343; c=relaxed/simple;
	bh=lrt06U9MjfT0+aAqB1+xoJHCrTf+UY09+oCiHhhT3Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMJox8Ke/1A4TX99+Av6XZYpyBCXF3Szm+Xry9mZV/WJDpy40H68O6aMnIopoP8g2/NLoU8ib/9AY6e+ZZMEhoqyl8qvHlzgAE36XjAUuC8IovIXNvQYmrYK+1cdDmEiRwewTW05aBqCpvIl6G71ObtqK8qwMqmYVsOqhZlDVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiJFdtad; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvA2uv2JUZrdT2MKiipHpiF6tbdfVobWEO3O5fZ7MOA=;
	b=NiJFdtadtsWkArX3ayAncZ40S/JUERmz1qvDg5ab1wMNKh37ejImxFQ9pGY5mtPXvMd2Wz
	4158UowfHMQ/G1FXaXugpf4X30dJiN08ABoqzSRzmVSb831FPj9yiFJt5uyHbGQmBm1Pyc
	7d0gv4txrYRFfG+Kj3h5jieVdZkOPdY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-rh2gyoGSNWKc9lqTtPT1_Q-1; Mon, 22 Jan 2024 12:25:39 -0500
X-MC-Unique: rh2gyoGSNWKc9lqTtPT1_Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-429d0905823so63476991cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944337; x=1706549137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvA2uv2JUZrdT2MKiipHpiF6tbdfVobWEO3O5fZ7MOA=;
        b=hCz1sFeqIsedWds8MpMI5xyf63oljYi2k31Rc18sDWt4rtyGAVfSXofagxMcBRUx7X
         /7AZQ9noG+UIBjCXb3uwMPKAriG0rrJ+mzzEtIjF9b+YS832EigTNHn9JqC+1gss1ZLV
         hPXoH74VGWg3ekGjmT9w4v/VYY/qDyGAInaGuwdbNzosuWDL+Jt0Zr581LVuogXvx2qy
         9wUM+66bxhsJhbyZ737bsBfMN8WbE/pDArHCtRDMVWL+h4KVNrND8e5skeNQEJirw9cp
         ihFnJyfCTqsA009wg1sLyCjgwFw29kQ3H7A+dUADteP0LDZ4YkHV/NFubIYtarP3qi/K
         Stag==
X-Gm-Message-State: AOJu0YxUm77Bs177CdlCjTIdOzKU/pImkN3cKJOslAYc6bX8AmBLi3kR
	JS1mC+Eej1gxmL3muBHQ80ZJL5nK7EsbLm8x6iiP/W6tWlB0syxcGsERgVuFIyhfahQ8A4ZBFrp
	kmOR80z87kuS45xzenTSuqCRpLZwlDMk081L3yXgeswR71/+hDvSZs2Hdb3m7trItLjeKhQ==
X-Received: by 2002:ac8:4c8c:0:b0:42a:2666:a410 with SMTP id j12-20020ac84c8c000000b0042a2666a410mr5552768qtv.63.1705944336847;
        Mon, 22 Jan 2024 09:25:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJcK9rtAYzFRJnLuAvRQK60DVL+9ETfuJh2rfvtLBRbekkrCVPXBMhXR6sp/967Twv/QzifA==
X-Received: by 2002:ac8:4c8c:0:b0:42a:2666:a410 with SMTP id j12-20020ac84c8c000000b0042a2666a410mr5552733qtv.63.1705944336119;
        Mon, 22 Jan 2024 09:25:36 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a200700b00781ae860c31sm2280992qka.70.2024.01.22.09.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:25:35 -0800 (PST)
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
	Can Guo <quic_cang@quicinc.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 11/11] scsi: ufs: core: Remove unnecessary wmb()
 prior to writing run/stop regs
Date: Mon, 22 Jan 2024 11:24:07 -0600
Message-ID: <20240122-ufs-reset-ensure-effect-before-delay-v4-11-90a54c832508@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122-ufs-reset-ensure-effect-before-delay-v4-0-90a54c832508@redhat.com>
References: <20240122-ufs-reset-ensure-effect-before-delay-v4-0-90a54c832508@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: quoted-printable

Currently a wmb() is used to ensure that writes to the=0D
UTP_TASK_REQ_LIST_BASE* regs are completed prior to following writes to=0D
the run/stop registers.=0D
=0D
wmb() ensure that the write completes, but completion doesn't mean that=0D
it isn't stored in a buffer somewhere. The recommendation for=0D
ensuring the bits have taken effect on the device is to perform a read=0D
back to force it to make it all the way to the device. This is=0D
documented in device-io.rst and a talk by Will Deacon on this can=0D
be seen over here:=0D
=0D
    https://youtu.be/i6DayghhA8Q?si=3DMiyxB5cKJXSaoc01&t=3D1678=0D
=0D
But, none of that is necessary here. All of the writel()/readl()'s here=0D
are to the same endpoint, so they will be ordered. There's no subsequent=0D
delay() etc that requires it to have taken effect already, so no=0D
readback is necessary here.=0D
=0D
For that reason just drop the wmb() altogether.=0D
=0D
Fixes: 897efe628d7e ("scsi: ufs: add missing memory barriers")=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/core/ufshcd.c | 6 ------=0D
 1 file changed, 6 deletions(-)=0D
=0D
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c=0D
index 21f93d8e5818..358857ea9ff6 100644=0D
--- a/drivers/ufs/core/ufshcd.c=0D
+++ b/drivers/ufs/core/ufshcd.c=0D
@@ -4722,12 +4722,6 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)=
=0D
 	ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),=0D
 			REG_UTP_TASK_REQ_LIST_BASE_H);=0D
 =0D
-	/*=0D
-	 * Make sure base address and interrupt setup are updated before=0D
-	 * enabling the run/stop registers below.=0D
-	 */=0D
-	wmb();=0D
-=0D
 	/*=0D
 	 * UCRDY, UTMRLDY and UTRLRDY bits must be 1=0D
 	 */=0D
=0D
-- =0D
2.43.0=0D
=0D


