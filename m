Return-Path: <linux-kernel+bounces-33794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB12836E99
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A051C28A43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0E660DCB;
	Mon, 22 Jan 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm0riMaq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19460BBD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944108; cv=none; b=EUW7oM4qCG12ESqRun91L8MgE3ZXhY5P79nnFDSmbQ82LqrsVsJY/k17rNKz7cpGPXlft1qmeX+jOyxKj8Eo77gjF2NEsy1J5iB6GWszz81udRjT1ls8roBrpOFuD5y1YkgGDdulA+ID6LV5tfKjSb6urmA8xokUfyobwToGyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944108; c=relaxed/simple;
	bh=r/jz8Df2KX737BM4u04ZW0ds9pGrXMmBG5wbF5ma2rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7rOVqgB7E/pvGPRBcLFsNaCIK+O7xeVzR+1JOTQEaC0i3+LLUGkDoujy5cvOgvHS21iLsw7UP0QV19+fvi72OZjIzWORVUS4LqeFhWTzlORpkrxJ9+SnM+LtbHtS78nGm7b0cKIFS1AOx/xnKrRiPQtNWUuHfMH1OwW3ATOf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bm0riMaq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjlATDY0QO5uIJmBTf+Xy8olJtH1umxQHbsM1EB2vCM=;
	b=Bm0riMaq7FedhH6LvV8eIA7aKkBcSF0bkLHcocmpPIQoDvqxxePg0rUiHCZWPqsvmDMTA1
	2IIbiMXB3X/y7rJZuYOTBHMqFA/GKjpfG+nL9GDV3e2lYmD3qKv3ecTr41koTV5jEgrh91
	0F4j9MGo3w6fmu4HfIiuqM9XUzQWT3U=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-SMI5aN1dNmyZQ5KZits38g-1; Mon, 22 Jan 2024 12:21:44 -0500
X-MC-Unique: SMI5aN1dNmyZQ5KZits38g-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-598e30e7e8cso3286744eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944101; x=1706548901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjlATDY0QO5uIJmBTf+Xy8olJtH1umxQHbsM1EB2vCM=;
        b=pLpVfa5qzkSEcP78VCcdhNkpuNNMjYvkgwJtdjEXSnz5ThvwambT3qPOwTBpGvhzjI
         wmBQqOnEipxrFy4T7VvNGxsdOfuIoeNpvKGtJE/fTAlEW7sD/eetumwJjoG6BG4TC1nt
         7NL4XvhOPEa7SwZ509ZLmTbkqOpnEcMBnpxRj4asaCc/lfMIbGH4K1suKjIIGp5ZArme
         MPoKtvt3lYvOen2brXoYKglTvC/+OC20ghKc0jFI67Ih7eF58LLYLlBNWNwyPD5hubGp
         t2TlHCJcdFGHj23o9g2avQwBZ0/W7B9ZDc0q80x4bfRmF3bOa7n2UZ6CyV3rdBIBjmbn
         dMLQ==
X-Gm-Message-State: AOJu0YzPr8dUq6QPVc4L0FywJ/O4M7P1OjD1kkYJJg8m58vP6lFsoNZR
	PUiXriUWE/RtYdt4UL9L3tMNvx+lV84Y+6UtvOgPtUtq86l44PxvAG4CEDC76ppxnAcNfi4sRBB
	+3QKrJ/taMfOHUzDYJJLZDyQ8W/9/Qk1HXTrTn4L2Yc5bHGVXpv5/sEXlkoDLtA==
X-Received: by 2002:a05:6358:9386:b0:173:203:c5c1 with SMTP id h6-20020a056358938600b001730203c5c1mr2261912rwb.62.1705944101721;
        Mon, 22 Jan 2024 09:21:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuePQ2c2TR6znf0LRpOqv6HnOFMSiNT+KeM1co6Jjj6P9hOielxqplttblTBbZvrww1rTKog==
X-Received: by 2002:a05:6358:9386:b0:173:203:c5c1 with SMTP id h6-20020a056358938600b001730203c5c1mr2261899rwb.62.1705944101357;
        Mon, 22 Jan 2024 09:21:41 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id lf3-20020a0562142cc300b00680c25f5f06sm2567738qvb.86.2024.01.22.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:21:37 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 22 Jan 2024 11:21:28 -0600
Subject: [PATCH RFC v4 03/11] scsi: ufs: qcom: Remove unnecessary mb()
 after writing testbus config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-ufs-reset-ensure-effect-before-delay-v4-3-6c48432151cc@redhat.com>
References: <20240122-ufs-reset-ensure-effect-before-delay-v4-0-6c48432151cc@redhat.com>
In-Reply-To: <20240122-ufs-reset-ensure-effect-before-delay-v4-0-6c48432151cc@redhat.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Hannes Reinecke <hare@suse.de>, Janek Kotas <jank@cadence.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Can Guo <quic_cang@quicinc.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3

Currently, the testbus configuration is written and completed with an
mb().

mb() ensure that the write completes, but completion doesn't mean
that it isn't stored in a buffer somewhere. The recommendation for
ensuring this bit has taken effect on the device is to perform a read
back to force it to make it all the way to the device. This is
documented in device-io.rst and a talk by Will Deacon on this can
be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

But, there's really no reason to even ensure completion before
continuing. The only requirement here is that this write is ordered to
this endpoint (which readl()/writel() guarantees already). For that
reason the mb() can be dropped altogether without anything forcing
completion.

Fixes: 9c46b8676271 ("scsi: ufs-qcom: dump additional testbus registers")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 0603a07a23a2..a489c8c6f849 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1429,11 +1429,6 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
 		    (u32)host->testbus.select_minor << offset,
 		    reg);
 	ufs_qcom_enable_test_bus(host);
-	/*
-	 * Make sure the test bus configuration is
-	 * committed before returning.
-	 */
-	mb();
 
 	return 0;
 }

-- 
2.43.0


