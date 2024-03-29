Return-Path: <linux-kernel+bounces-125402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA2E892582
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11981C212F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D91369BC;
	Fri, 29 Mar 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYI85FcU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C666BB22
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745333; cv=none; b=ZP5QIa71uFwkD7f8K7+2Unce+nxqRKlnIzc3eg82gKYWF3oucA2MpXG0haqISTEprgGUUPdv5wvtyOY+kLFjimm5hLhmvhzAqGFLtbgOok2LwTSjR7Xg7rByf57e2xUxVvJ4bEtgNPs6Rums/c8xtixeRvH2/ujwGyyvipdOFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745333; c=relaxed/simple;
	bh=BP7pHzMFsulC5h5RfnNlVkbRbr65ixQCUgccOfbpOGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5zOMkaiXaAJiN7YGSm/cfmxzqbQatd9pT0MSq67YKgkjsCC9O6YeKe7envQQPCiw9nVROanjHt+QvgIXvoMvfHkjz4OEkup2mEFGaxQMbqmLhS5BsNokDbALmgwvOotnFAgrfaUrIKo+yhIyRTtJ773TTC6dkN5gQaBwpv82HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYI85FcU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4OnoxFSVXPqXgZAXqDum+B43kEJjiL2qzIJ+ix8ScM=;
	b=EYI85FcUwOAuAORtuLBLPdlywYe5qt60MIrNY8bh6w8TndCQft8HfCCzkQjH6GCM4ag0mA
	L3HP+AyQEQUNMI6Yvsb2JF3Kiq2vSgplfJMSZfSM0j9uhPmIi1lEMEUXGVeYDh3w8rmxbi
	gz4KTcOYMlyD+W+tTnrlg91L7sXWUkw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Jaq6ARh1N-2VsGoexVIG-A-1; Fri, 29 Mar 2024 16:48:49 -0400
X-MC-Unique: Jaq6ARh1N-2VsGoexVIG-A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69680b07160so27358316d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745324; x=1712350124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4OnoxFSVXPqXgZAXqDum+B43kEJjiL2qzIJ+ix8ScM=;
        b=Mrx1+Pub1BTz3bW2tTcBHMuD4tRUrJfSneZ71f/ZKtrBo5gsEb0pO2rPoA5TpJOWk1
         JEi4E9HKvoLt6jioQuwweM9TJASz6rWtYPx1U5JZhNkz7UKeYrpdMn/TDHV9I1G061YN
         d9ZYdmJGWSKv5iLe+14uv/NWsjU1f4UIWNGP0lEF5lSmtkBW7yIHMP2ZL3lT+SY2/UAQ
         sjhlMNfheFSBkp+Ghgni2UgJ5gPClQ3HqTia+olvoJHPUg6n4L46I3sUqNUsgRJZBvqy
         uD/pzeJekuypzYq7IWDmzL4sHzsvbKWm5amNh06nyo1ZSyEujzhipxGfXr43W0qtz1qc
         Ll7g==
X-Forwarded-Encrypted: i=1; AJvYcCWXBn9yQQhK8Qyjp70fbqmnLKgD5F59B4ueqNAu2SFZh2FjWUuax/eKXGvKAo41vd3Mv0yw2b5UdrkUwDcsy8Ph8iVQ1Z06xVGeKrfu
X-Gm-Message-State: AOJu0YxIA+4fn5CQZLh/w1d7uiU6UiXR8FXAUl+lChxRbIsI2hFawcLf
	2YyyI6g7s4sGGHdt8TgtA1DsImekBIvi2Ocd6cpB5TGEqF/mNGx+H8g9arkloM5t/TOa6JEmEDa
	gHnPehuuGMDYxm8d4N/ahURb7mccmnB0r6TaLgmXppYdTcgYWRgn5Y3p0bgCYUw==
X-Received: by 2002:a0c:9a91:0:b0:698:f39f:841f with SMTP id y17-20020a0c9a91000000b00698f39f841fmr2060278qvd.20.1711745324156;
        Fri, 29 Mar 2024 13:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJf7oVmqD60ifmlE6hginnH1lrLHud0fYzJl7uMi++kQu2bupDlSX6vEV/iu1GxrCkHuddlQ==
X-Received: by 2002:a0c:9a91:0:b0:698:f39f:841f with SMTP id y17-20020a0c9a91000000b00698f39f841fmr2060248qvd.20.1711745323770;
        Fri, 29 Mar 2024 13:48:43 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:48:43 -0700 (PDT)
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
Subject: [PATCH v5 01/11] scsi: ufs: qcom: Perform read back after writing
 reset bit
Date: Fri, 29 Mar 2024 15:46:43 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-1-181252004586@redhat.com>
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

Currently, the reset bit for the UFS provided reset controller (used by=0D
its phy) is written to, and then a mb() happens to try and ensure that=0D
hit the device. Immediately afterwards a usleep_range() occurs.=0D
=0D
mb() ensure that the write completes, but completion doesn't mean that=0D
it isn't stored in a buffer somewhere. The recommendation for=0D
ensuring this bit has taken effect on the device is to perform a read=0D
back to force it to make it all the way to the device. This is=0D
documented in device-io.rst and a talk by Will Deacon on this can=0D
be seen over here:=0D
=0D
    https://youtu.be/i6DayghhA8Q?si=3DMiyxB5cKJXSaoc01&t=3D1678=0D
=0D
Let's do that to ensure the bit hits the device. By doing so and=0D
guaranteeing the ordering against the immediately following=0D
usleep_range(), the mb() can safely be removed.=0D
=0D
Fixes: 81c0fc51b7a7 ("ufs-qcom: add support for Qualcomm Technologies Inc p=
latforms")=0D
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>=0D
Reviewed-by: Can Guo <quic_cang@quicinc.com>=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/host/ufs-qcom.h | 12 ++++++------=0D
 1 file changed, 6 insertions(+), 6 deletions(-)=0D
=0D
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h=0D
index 9dd9a391ebb7..b9de170983c9 100644=0D
--- a/drivers/ufs/host/ufs-qcom.h=0D
+++ b/drivers/ufs/host/ufs-qcom.h=0D
@@ -151,10 +151,10 @@ static inline void ufs_qcom_assert_reset(struct ufs_h=
ba *hba)=0D
 	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, UFS_PHY_SOFT_RESET, REG_UFS_CFG1);=0D
 =0D
 	/*=0D
-	 * Make sure assertion of ufs phy reset is written to=0D
-	 * register before returning=0D
+	 * Dummy read to ensure the write takes effect before doing any sort=0D
+	 * of delay=0D
 	 */=0D
-	mb();=0D
+	ufshcd_readl(hba, REG_UFS_CFG1);=0D
 }=0D
 =0D
 static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)=0D
@@ -162,10 +162,10 @@ static inline void ufs_qcom_deassert_reset(struct ufs=
_hba *hba)=0D
 	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, 0, REG_UFS_CFG1);=0D
 =0D
 	/*=0D
-	 * Make sure de-assertion of ufs phy reset is written to=0D
-	 * register before returning=0D
+	 * Dummy read to ensure the write takes effect before doing any sort=0D
+	 * of delay=0D
 	 */=0D
-	mb();=0D
+	ufshcd_readl(hba, REG_UFS_CFG1);=0D
 }=0D
 =0D
 /* Host controller hardware version: major.minor.step */=0D
=0D
-- =0D
2.44.0=0D
=0D


