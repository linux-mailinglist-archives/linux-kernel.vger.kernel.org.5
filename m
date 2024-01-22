Return-Path: <linux-kernel+bounces-33803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA306836EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05DA1F2E258
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7627354660;
	Mon, 22 Jan 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clNL/NcM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4853E2D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944278; cv=none; b=lGwyx85cM7ych2K1jVwMHBeBmq7nVCabvgx+Ux+Ti5whkKiXPOrHBlMmJgN4Lr2nKJw1v6F2Ey0uRk4w8UoMUiFkUcgEHc8QsKy/Cs9Bgbdxbf7czUC9ZUGGuDRIHYI9Qi7TAjaoWTfhJ4tzRkBgYH8D21tUJKXrX6JPOad0QoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944278; c=relaxed/simple;
	bh=s5zG+L/VGA4r6opNYDq/X6r4u7Dz3JHhUiw1v8rHzzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irnAFjD480p3qobaNfjd3zcmGEJYot+hNfnuO36cdD7hwJNZD2bhn0CI+cZAmg5HfR/PSYZ10hsLd0GcjvXd2rLwXURmMA6R6P4DlEEmRdrkzZA0AEkFejagcbH6O3DtYUX/qlDr0Ez7oEBDQHJ2nXMIGGOpAsyRTB7z/luV19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clNL/NcM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nbn1T5pI3z/UbfuUYU7cHvzOeNQR0JNnB8PBypvklZ8=;
	b=clNL/NcM1B6zQ5NSaMG/XxX8nj5lVZ1CB9WQI2+z7+Lksm0uAjGl/Mq5+VrXrhbVx5syLA
	rSsh7Rp65o2zFHgQ2+TkjulCphYT7K6cfiV3+ac8eNjNIDu/GhFeJkFP6UaV0g0bYb04/R
	SLEuY5vYoKLcyB0xNXMIR+o8qUgptEw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-Ft3HtnJJPl2yqRrJheVuNA-1; Mon, 22 Jan 2024 12:24:35 -0500
X-MC-Unique: Ft3HtnJJPl2yqRrJheVuNA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7835bb86ca6so578391385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944271; x=1706549071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nbn1T5pI3z/UbfuUYU7cHvzOeNQR0JNnB8PBypvklZ8=;
        b=N7rJ68o+Yq64Wtt0XRwvvq+6ELPvWzmrtf6zD/iHCe8i6Q2WAdNnjXakV5o10hfsgU
         Im5vz7o8P4IsjGQWFiFJBoqS3ukIhVkLZYUhHwFJbzp5h+P+Z2VhF78OORpDaYOMVfum
         46TRNm0wJXtIb5WaRJyJ1sp5EvBsaCX8kOErxhxMtAjNnuIDWdZ0NosB8l1mqLSEOrW5
         zyLqGL8w7whzqXk+CUttGtfgwKyWsdgLNwkL5ARfAEFIfjOHyE19mXrD4nWrH6w+/JBz
         cPNzGhBvNSoKJ901/4gk5UfU2B1I9PA1Av9PHb/KcsLX7m+cdxskTGnyHXCDCvPBsEtZ
         SLKg==
X-Gm-Message-State: AOJu0YzLyAUcqx5VZ1pPr6ksym6D/4MaP2Kezb7YFHynFEiKZ9KwkMdF
	GG2ScCgv6dNFnLNfLao7tw+M1CajTU8rG6Bo5OTfjiXiYfxBLdgp2jBOfetkdsEYS4z3ri4IUut
	PMP9VaHRru702lZoJ5Nz7IIYBnRipG1P08t6uylEqaGVa6NCSA2oYq82V0j0UPA==
X-Received: by 2002:a05:620a:4092:b0:783:a2ba:eebc with SMTP id f18-20020a05620a409200b00783a2baeebcmr1181215qko.24.1705944271369;
        Mon, 22 Jan 2024 09:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+cIRyR7E/BPa15GlhIFB+sJnWKn/RhvzQjmmC1gCPckHcfoCIOnQhcFc6TJFKCb9MtxlDLw==
X-Received: by 2002:a05:620a:4092:b0:783:a2ba:eebc with SMTP id f18-20020a05620a409200b00783a2baeebcmr1181193qko.24.1705944270958;
        Mon, 22 Jan 2024 09:24:30 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a200700b00781ae860c31sm2280992qka.70.2024.01.22.09.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:24:30 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH RFC v4 06/11] scsi: ufs: cdns-pltfrm: Perform read back
 after writing HCLKDIV
Date: Mon, 22 Jan 2024 11:24:02 -0600
Message-ID: <20240122-ufs-reset-ensure-effect-before-delay-v4-6-90a54c832508@redhat.com>
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

Currently, HCLKDIV is written to and then completed with an mb().=0D
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
Fixes: d90996dae8e4 ("scsi: ufs: Add UFS platform driver for Cadence UFS")=
=0D
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/host/cdns-pltfrm.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/ufs/host/cdns-pltfrm.c b/drivers/ufs/host/cdns-pltfrm.=
c=0D
index bb30267da471..66811d8d1929 100644=0D
--- a/drivers/ufs/host/cdns-pltfrm.c=0D
+++ b/drivers/ufs/host/cdns-pltfrm.c=0D
@@ -136,7 +136,7 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)=0D
 	 * Make sure the register was updated,=0D
 	 * UniPro layer will not work with an incorrect value.=0D
 	 */=0D
-	mb();=0D
+	ufshcd_readl(hba, CDNS_UFS_REG_HCLKDIV);=0D
 =0D
 	return 0;=0D
 }=0D
=0D
-- =0D
2.43.0=0D
=0D


