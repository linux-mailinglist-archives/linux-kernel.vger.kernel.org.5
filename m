Return-Path: <linux-kernel+bounces-125409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EA6892597
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E23BB23880
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A25213BC13;
	Fri, 29 Mar 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmbUAGnt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCEA137926
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745439; cv=none; b=GaZ1bbvkKsonddkegd2jFz6+3gSr1/EKVP5TKrFGWC8Ib385uOu2cwyDnYdLINCSlcbZthbNB3py+NfURsHwZYX408IhLadiMeoAKNwWqpNtE5pUKnCrM2ILA2yZ8WUtuOpj3/ytpOVZNYWSE/+9arOF2HQm/dzY3aqAZri0e9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745439; c=relaxed/simple;
	bh=rUiFGJENhkjaL5XQk3rVKmNTCac0phrGlXxO+qQgbyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9eNAsNt+OnpOBxtJh11fCZWqRe+72nKhImGIGBOAu/csQAfkfGWVdKlUW2y0x/5wdMrk2pbZG0yLvR+DOO49vWYdCaOUVvN4JzB6bjXeY/m4t8bRUva/b9NqsaXrE2oTSZmJhBtL/7OKglgz0eygvuEyR3R/jkOaHtyt7DEydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmbUAGnt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfliicv5toOd2B87oyO1cEhsCWrclX7x2KOA+OKHojY=;
	b=VmbUAGnt4b05/RgOdjitICe9TrA7kH75WQpWBJcwXnyaF3mjSlgjaw7TQ+5XiBM+eojpO8
	y4trZip2T495pDg5BUQnSOL1d/8v2dAWJcn00Z9u082vsoVir5wKF5BovvD4OUEDgxpR2b
	FXv0w92RIcHlI4r0cKrx3jmOW41lNZ4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-h4HcLK2qPiCJz0d-jSU3OA-1; Fri, 29 Mar 2024 16:50:35 -0400
X-MC-Unique: h4HcLK2qPiCJz0d-jSU3OA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69680a9fe29so19408196d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745433; x=1712350233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfliicv5toOd2B87oyO1cEhsCWrclX7x2KOA+OKHojY=;
        b=qXgegDDIlLUaFW/5ytGjB5EYwBSnl3muMebJOnqhJz6sMUFUrR7dJz6c2TBoDyWpWj
         j0QC+3UEP1HfiH+HQIrBE/95XFiCL3XJK0yvrvrhe82e/C+Zj5qjjva6YShgBaNtp56F
         fRMzO/Lo7PDWATqDxB0zPaL0W0u7jXwZQCAckz3wiA4odJ0pTlOaj96c/4z4EYr+24La
         0PERzv2UQaQ0V/kwUleWjH2NQ7gBl+/WGNoe/i4UK6l6uIFCZR8aMiK+3+nnbFbCNdct
         PxIMOSWrV9LGCrushJBfJks14Cnj2C/FryIM5AWpuAtD05GqAUAKVhpL8LaunQQo2N4D
         SyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsPMkntHbTKfb4XORaxRGl3LoKyaGnWxBUcV49eC2Mro82qo/koIKXMS5vt3XtZYE7V0XU8k9/DcT4r4TcScWULMJam6GeBYmsB8Ko
X-Gm-Message-State: AOJu0YzVh7KXYQRBO4gLY9zsbJDLV+pFNI9c0M70AfC/Rrg/PU79zlFl
	fSqVxIBq/mpPEwf8o6yOsjbxPxoaPmwPgWYYhzziOPtD90H7pz3c8T/9dD4Tu7fgMqTaZHjsbft
	YU5YQ1f95onN9ke/dgDgm7ylu5eWiCfbVA/SzWvlNz96lgvjsBZCblhUKi2cDkw==
X-Received: by 2002:a05:6214:190a:b0:696:b095:c429 with SMTP id er10-20020a056214190a00b00696b095c429mr3119267qvb.40.1711745433050;
        Fri, 29 Mar 2024 13:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSRd/5i8QlyLSkwg85Jxr+u352RMnwF3m/7r26iSWU00W9M/Q4Hw8RMOt9vf05jAbg6L8gpQ==
X-Received: by 2002:a05:6214:190a:b0:696:b095:c429 with SMTP id er10-20020a056214190a00b00696b095c429mr3119243qvb.40.1711745432697;
        Fri, 29 Mar 2024 13:50:32 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:50:31 -0700 (PDT)
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
Subject: [PATCH v5 08/11] scsi: ufs: core: Perform read back after
 disabling interrupts
Date: Fri, 29 Mar 2024 15:46:50 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-8-181252004586@redhat.com>
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

Currently, interrupts are cleared and disabled prior to registering the=0D
interrupt. An mb() is used to complete the clear/disable writes before=0D
the interrupt is registered.=0D
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
Let's do that to ensure these bits hit the device. Because the mb()'s=0D
purpose wasn't to add extra ordering (on top of the ordering guaranteed=0D
by writel()/readl()), it can safely be removed.=0D
=0D
Fixes: 199ef13cac7d ("scsi: ufs: avoid spurious UFS host controller interru=
pts")=0D
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>=0D
Reviewed-by: Bart Van Assche <bvanassche@acm.org>=0D
Reviewed-by: Can Guo <quic_cang@quicinc.com>=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/core/ufshcd.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c=0D
index a89887878d98..268fcfebd7bd 100644=0D
--- a/drivers/ufs/core/ufshcd.c=0D
+++ b/drivers/ufs/core/ufshcd.c=0D
@@ -10616,7 +10616,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *=
mmio_base, unsigned int irq)=0D
 	 * Make sure that UFS interrupts are disabled and any pending interrupt=0D
 	 * status is cleared before registering UFS interrupt handler.=0D
 	 */=0D
-	mb();=0D
+	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);=0D
 =0D
 	/* IRQ registration */=0D
 	err =3D devm_request_irq(dev, irq, ufshcd_intr, IRQF_SHARED, UFSHCD, hba)=
;=0D
=0D
-- =0D
2.44.0=0D
=0D


