Return-Path: <linux-kernel+bounces-33792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC7C836E94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D5F1C28695
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5160B88;
	Mon, 22 Jan 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB3a9STo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144B60B81
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944100; cv=none; b=igJJc1o33nwV2dedcVtMzDRzbS3QBLqecLFtqG5+9YZ4MYjzx5k5HRiJ+4gdPPBbV5WXw3AQBqshWCYiDxQWTvPizawrMsE6/xRuQzs6XFqyqCcTkKu1gmfPbV6a06lVQ+MI5I80cLoqaXQ1LfZVC05vyc63TdoPPFjuYlJokpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944100; c=relaxed/simple;
	bh=09zxCdt+NCfT08JtVbcGX9+GXw8iPNk0hTs2e6ou3d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXi3conuUmOlYHfnTJFQCIs2L7frsxjNYKwXiaa9+6iCDzU/o4r+fX5XrxA3UyToWN/vcbyemH/kuxmq5fsyr3qvNgU82txljdWVqxcIRQ4iP+1NfpT9WbxoReqKXbO3OWKDIs2X27bKrH/HOzQcqGkD3+OG/pck72rjthZwPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PB3a9STo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NX3H6VfoJEzhW/8XTfEE0I9qy52CGxJXMOtu5CoBhrc=;
	b=PB3a9SToQmCFQOrS49eFGu2GvXqKDbJNfgatNdPrZByPzNbnMHO8UK6VbTmhkYIjEI9E1r
	l0UA3pBEJdw1wImqzbIUUpSPWYqhSE5ouH3/mWhqYhnicorzcXUcI9UdfO0GnTKdL2ZNPU
	gWVIIDEIBVaCjSyuOhzWZct1QL8nuPE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-lfwNzo-vMeW2wDInJNqAUg-1; Mon, 22 Jan 2024 12:21:36 -0500
X-MC-Unique: lfwNzo-vMeW2wDInJNqAUg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-685c9384ecdso32487886d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944092; x=1706548892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX3H6VfoJEzhW/8XTfEE0I9qy52CGxJXMOtu5CoBhrc=;
        b=cT1gt+qJG44GtqQt4wH05Xu4T2eOa57RaIy8sAV/5L4uyoZJ1iUj9Tj9KkB1T6Og/z
         GQtCe6HQ7JzVas2MBW6MKQGx4k9g2rIXqaPpJXkXOQ2p3DbQ2xnoWwutYUyhWrUfQjyR
         MOHRsj1bKw6qPlusWgJRm//uuj0TSuZ/bEHy+EEX14FfrC97zVTvFUn1FiGQvifI74Rs
         XFCqfdiqGMfptmlvt28T93XG9+mKV/XZMEI4LxiGCswoiqd6TXNBi7+REsGqnueZvuvA
         4fopXda7BK3A6uJfI0MIWqKXiJkA8h+eCsHfkbvJhmbWo3SvdsxUJbOD3HGrxXZ/c5Pq
         ldLA==
X-Gm-Message-State: AOJu0YwQ4vH7d7t+fZKDbbPvXEAEQeuFnV5qXFH2dentQe1AFPdJ+aBJ
	ngA9p9+B/Lqw61i3qdv3F9voMiCBgoAt5G6mzmc86sKuk8RTnwDvd2TyTBxn29DjZ+aKBPXuXI0
	ACfklEcL4P/jB+9s+H3TVkiERE5DZIaRCFuTC08VgLsf2kntkXUq7JxeCURtzsA==
X-Received: by 2002:a05:6214:76d:b0:685:7524:dd7b with SMTP id f13-20020a056214076d00b006857524dd7bmr5671171qvz.97.1705944092383;
        Mon, 22 Jan 2024 09:21:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETM3O+0LREiehrGMV5y+Bz61CfAxNisi0IJmhr61MCq4f9E5bPXPlQXvd5/xIk78wvftei+A==
X-Received: by 2002:a05:6214:76d:b0:685:7524:dd7b with SMTP id f13-20020a056214076d00b006857524dd7bmr5671151qvz.97.1705944091962;
        Mon, 22 Jan 2024 09:21:31 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id lf3-20020a0562142cc300b00680c25f5f06sm2567738qvb.86.2024.01.22.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:21:31 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 22 Jan 2024 11:21:26 -0600
Subject: [PATCH RFC v4 01/11] scsi: ufs: qcom: Perform read back after
 writing reset bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-ufs-reset-ensure-effect-before-delay-v4-1-6c48432151cc@redhat.com>
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
 Andrew Halaney <ahalaney@redhat.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.3

Currently, the reset bit for the UFS provided reset controller (used by
its phy) is written to, and then a mb() happens to try and ensure that
hit the device. Immediately afterwards a usleep_range() occurs.

mb() ensure that the write completes, but completion doesn't mean that
it isn't stored in a buffer somewhere. The recommendation for
ensuring this bit has taken effect on the device is to perform a read
back to force it to make it all the way to the device. This is
documented in device-io.rst and a talk by Will Deacon on this can
be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

Let's do that to ensure the bit hits the device. By doing so and
guaranteeing the ordering against the immediately following
usleep_range(), the mb() can safely be removed.

Fixes: 81c0fc51b7a7 ("ufs-qcom: add support for Qualcomm Technologies Inc platforms")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 9dd9a391ebb7..b9de170983c9 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -151,10 +151,10 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
 	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
 
 	/*
-	 * Make sure assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
@@ -162,10 +162,10 @@ static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
 	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, 0, REG_UFS_CFG1);
 
 	/*
-	 * Make sure de-assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 /* Host controller hardware version: major.minor.step */

-- 
2.43.0


