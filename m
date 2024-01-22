Return-Path: <linux-kernel+bounces-33795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9C9836EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1FF1F2CC63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCAA60DFC;
	Mon, 22 Jan 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWZyyodt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152360DEF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944121; cv=none; b=H48ZrnM88L1n1KYEWbmDZOGLXpMRjgW+KM1jyIyAt1aYR1FTPesrG69LHhZSxYerchfiXpCFlaVJyPa3lZje/HwsD0OES1/eTrEEb07+7tHaJm8TuKHZGudQ7GR/VwfTT+QTWlH8w7/Go6zu11ORMsmbm026VcCGS1ThW1PqWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944121; c=relaxed/simple;
	bh=OxrzxxUWihz3B2zxHQ6fTBKU+t//zIV2dCIEuKHpOM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUMkqPTAxyY/fy6T5ncGUakPjpBkM8qAetP8ayPidhGi/T0/dR0Jf12mRfNCO26CMWBguj4tSJozqnLaHKi1m7HLIrZTAItLMCBOX0RQNxYDuVmYfv2qlhC4nQqC0a/Ug52mZNVFZT7epo/AWAOtEV30Ct8lxn007h8YeUCuqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWZyyodt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rD2RVNfwDn0BbFWtf0meNmC+cZt+1EvBJ+MzhncMZA=;
	b=PWZyyodttiPWgQSY7JSd3/iKAKtUYGrlq6WB7j0fGDe66DJ2Rh4925QHA0DaYfDX+VQetw
	rF9ZCW0JDYpO4C9QntRmyprq6HN7c8VT00SdTp+azXtR1GHXotGPm0q0vEZf6Mgc6Py78P
	AgNAZwfFAnLKBEID5bGE3ESeXtir/wk=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-gIS6TGeTMBCqCxBXG21xHw-1; Mon, 22 Jan 2024 12:21:56 -0500
X-MC-Unique: gIS6TGeTMBCqCxBXG21xHw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7cee1755d80so912367241.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944111; x=1706548911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rD2RVNfwDn0BbFWtf0meNmC+cZt+1EvBJ+MzhncMZA=;
        b=jimMZfQ2jI0vFW4VeYF7nInlJ0DQjZhlVvaVKEhaFsqL/QjxRyi9nRNTU7OaJ+OpKH
         FIP/r0kDc31F3uVDlvsgOtnXeURukjdrTBD7NruINg7tSgrd8lnVu6DREiuigY2kzT0Z
         PmKgwdSk5JwN81TC/yde0JGT7PPxU6Z+NAPCDutheG+17hLDWTF/zZkhf3gUimUYqalg
         lhQZ4gAPCgRc6SY9y82IJWrDND2H7TwNKeeLTlyawRjNRYDRsjZBVy8WeEjXndLArTH8
         sKM+uUppFLURnqHGbdqYmXDhj7IpPinHeCsTf8bgkQI3Sxgb4BEddvu0YKCqRBw32c91
         FIOQ==
X-Gm-Message-State: AOJu0YzN86vov4mYlijkZdQ//1OmTBsE6W6CqE9oMgs3qd2SLW1d3NDv
	ldfzSIa4DuTBvpTQd8xzMO2H2Oey3CWeQfGz1OU6c9+BkvOfxyi8Aw1uqVrGiBE4U+vWj7cCZsf
	G0fKr1oWclE2/AoyDBdp/F6J0Z7/fe4mt9PqH1U7WTkG6F3ERF3p0ISzVuvoKpQ==
X-Received: by 2002:a05:6122:179c:b0:4b7:422b:d7c3 with SMTP id o28-20020a056122179c00b004b7422bd7c3mr1787498vkf.20.1705944111717;
        Mon, 22 Jan 2024 09:21:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF22UHtqop2p9ldWS0FUSCe44a8uIXyYTv6zwTkEm4KTH9So+jKN01poJ3m4ghRt3Y9yA0QGA==
X-Received: by 2002:a05:6122:179c:b0:4b7:422b:d7c3 with SMTP id o28-20020a056122179c00b004b7422bd7c3mr1787474vkf.20.1705944111456;
        Mon, 22 Jan 2024 09:21:51 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id lf3-20020a0562142cc300b00680c25f5f06sm2567738qvb.86.2024.01.22.09.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:21:47 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 22 Jan 2024 11:21:30 -0600
Subject: [PATCH RFC v4 05/11] scsi: ufs: qcom: Perform read back after
 writing CGC enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-ufs-reset-ensure-effect-before-delay-v4-5-6c48432151cc@redhat.com>
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

Currently, the CGC enable bit is written and then an mb() is used to
ensure that completes before continuing.

mb() ensure that the write completes, but completion doesn't mean that
it isn't stored in a buffer somewhere. The recommendation for
ensuring this bit has taken effect on the device is to perform a read
back to force it to make it all the way to the device. This is
documented in device-io.rst and a talk by Will Deacon on this can
be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

Let's do that to ensure the bit hits the device. Because the mb()'s
purpose wasn't to add extra ordering (on top of the ordering guaranteed
by writel()/readl()), it can safely be removed.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Can Guo <quic_cang@quicinc.com>
Fixes: 81c0fc51b7a7 ("ufs-qcom: add support for Qualcomm Technologies Inc platforms")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index decad95bd444..881074fc2329 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -406,7 +406,7 @@ static void ufs_qcom_enable_hw_clk_gating(struct ufs_hba *hba)
 		    REG_UFS_CFG2);
 
 	/* Ensure that HW clock gating is enabled before next operations */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG2);
 }
 
 static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,

-- 
2.43.0


