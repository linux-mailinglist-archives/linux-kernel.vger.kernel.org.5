Return-Path: <linux-kernel+bounces-125406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79B89258C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E322842DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58365137926;
	Fri, 29 Mar 2024 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y913eFy1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E1913D604
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745348; cv=none; b=QDNyRC9pHefqpwHc/Zk+UqDrnB9B2xuKHFUPmwAz9+20P+qblxSuiGSPC1m1BHWaDXaHHY1UGRauu+4l6yJBxEepN3H3Md9TiZ0SQICaToqlNI8vB0yaQtnLMsD9GMYXmAis7VfPBSfweSnpySWdR7cRVgXxJPE6//HIBL+zXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745348; c=relaxed/simple;
	bh=JPm8JpiIg5DDpXdT/Hl8Z1KYHSXLOLaFeveBG2eb/HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsAdQ3ZrBADb+T5M+VsNVAjLIUHVzzON5yGmAdUW4kRD67ihSuUZ5YWtHwxJYd21YmQWFDdF6YDPf03PjwfpN1YK5DB6j0LgAoGkYxZsldWzxkrx0PaDiOC4Bdud3/XQk2dtgpbVTHrpDlgPApY+Cl0NJfcoVLCJCJfrzPandAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y913eFy1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHNJWGEhyWXwbIrUI9vWUKtE+BqvwNE/X15Guew4lg8=;
	b=Y913eFy1zb7lZD0DDG9A3HhM9eqJPJJOSJ7Z1pAJ+jZzSi2A/IpjPYBWsX9GbEG6peqD3z
	NoWgyR3af5o1YfLpOkeq0vH54RJwbyC03liFE7o5Qbn/JQklQg9M+iiEL7IDH0IRA6Rkm4
	M+nI2j4uDzOYdPp7IdkAIircMGmpXgs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-wdFKE7cKMdyduT_VGQocbw-1; Fri, 29 Mar 2024 16:49:04 -0400
X-MC-Unique: wdFKE7cKMdyduT_VGQocbw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-698f302cec1so8126656d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745344; x=1712350144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHNJWGEhyWXwbIrUI9vWUKtE+BqvwNE/X15Guew4lg8=;
        b=JIa/Rcj4nDy1U10tE1yNERT02fCPzYIXzaTgBGEF+OzwKzBJlh4rMb7BHm9BJK2lfu
         oDZmkCgjj3AiglS1aM6kGWNoasZPcKTTTmUX5Tc/KqDTYmfw3gKMPJzaK4T44dUswFhS
         fOttv0gLvOC0eJV9dmZog0wrism7WhMnQdP2DE40eoYEGuKS6U22lJ/42x92ullezKU/
         EqJrnKHcvbIhHANzkcCXEcEuJIsTWR22Up7tiqPm6gpeXeKFGOWEFFPDxw9oHymGvdHG
         pkB52xTt8AZ30ydvAJjRDnhw941fauj2zN0g2J42EMEceIOstGnOgCy+KRdPwanPTFNo
         tt0A==
X-Forwarded-Encrypted: i=1; AJvYcCW2X8e7u3iuAuIJc19ypNF6l0OxGdZ303fbS++XP98MpAvVJFOYJyDP4x8H/McjV14aSu4lUuZEWkt/pitrs98yYAumIwTN98HYkm5g
X-Gm-Message-State: AOJu0YxXVHy0PVE2SrubWmrqd78aQXjskuxRGegENWPNcmUb6Im5gct5
	o2EeaiSBYA0gj5noJlo/zrBudjlAMAXWhL7Kpj8afv8OdSYUaDQpntJkk0+0ku8NhRRi0+LDMl/
	Kkrq+ICX1xJ8veKlXr3dyU3eT6eg9klub/XoIdExcGTwDHtHnvKSE57/kpxNE4Q==
X-Received: by 2002:a0c:f808:0:b0:696:78fd:560 with SMTP id r8-20020a0cf808000000b0069678fd0560mr2809362qvn.50.1711745343831;
        Fri, 29 Mar 2024 13:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGaO1tH4VVlNQZbk2JjonLDJ9CuVy6dpCa31G0F7BhjlUaz/qGRnFWhAFgA+WY2cPB4nTOgw==
X-Received: by 2002:a0c:f808:0:b0:696:78fd:560 with SMTP id r8-20020a0cf808000000b0069678fd0560mr2809335qvn.50.1711745343423;
        Fri, 29 Mar 2024 13:49:03 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:49:03 -0700 (PDT)
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
Subject: [PATCH v5 05/11] scsi: ufs: qcom: Perform read back after writing
 CGC enable
Date: Fri, 29 Mar 2024 15:46:47 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-5-181252004586@redhat.com>
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

Currently, the CGC enable bit is written and then an mb() is used to=0D
ensure that completes before continuing.=0D
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
Let's do that to ensure the bit hits the device. Because the mb()'s=0D
purpose wasn't to add extra ordering (on top of the ordering guaranteed=0D
by writel()/readl()), it can safely be removed.=0D
=0D
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>=0D
Reviewed-by: Can Guo <quic_cang@quicinc.com>=0D
Fixes: 81c0fc51b7a7 ("ufs-qcom: add support for Qualcomm Technologies Inc p=
latforms")=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/host/ufs-qcom.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c=0D
index 66a6c95f5d72..1439c1df0481 100644=0D
--- a/drivers/ufs/host/ufs-qcom.c=0D
+++ b/drivers/ufs/host/ufs-qcom.c=0D
@@ -406,7 +406,7 @@ static void ufs_qcom_enable_hw_clk_gating(struct ufs_hb=
a *hba)=0D
 		    REG_UFS_CFG2);=0D
 =0D
 	/* Ensure that HW clock gating is enabled before next operations */=0D
-	mb();=0D
+	ufshcd_readl(hba, REG_UFS_CFG2);=0D
 }=0D
 =0D
 static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,=0D
=0D
-- =0D
2.44.0=0D
=0D


