Return-Path: <linux-kernel+bounces-33808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE110836ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6BC1C25424
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98B055786;
	Mon, 22 Jan 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbWfcELD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525E62804
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944331; cv=none; b=el41+yNWQder4+dGfNOKYD7vL46tltuEA1fHl5N5rQqZGEZGMm17x1iKoeqH3ruREl9lVi/7MFRcP9Y1eX9x4/FoVhIZ/DWLaHpVGt4BeYcOTGClWwIdQgFscbW527Qkqusty3b3yjKOZm74An24NSBudYfOTx9NpqsDiLHkQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944331; c=relaxed/simple;
	bh=eqU9bnJJL8L6334KQv0i2/sTryAarZX2XDro3a1bVTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttWeroKZFlq7eI1gFgogSDAPsYcpDzqWT/+9IjQff5AjdnIupjC2MlqAMhXSjgt/GsMJzJYBkGB9+IaHbfAJufVx3/XflbXggL4Tczss+V8HXNCWYjMjU/ViT/iUx7JH759lENDEzJQrXJSqVUpR0YgNksecSWeOcptVwk8T8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbWfcELD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9E8LP/sXchUxMDynkpMldI5w3cNLtCQjxmXDj4qu+Y=;
	b=cbWfcELDfp2bs0f1f6+LR/6H3MK/P0VRX1dUUsRIjkLCdjdGuYrSQzQ6RXJOA/aoiJU/QK
	EXVuG5SaVMx/CrF0s3NtpSXuimMjISdaS2Ctb1U9QBZILG1eyG1bYVgDs5ZW4FxkW/+ruc
	cV4dy1iaDsUleGUN2N7/2RMlUJ+YucM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-XObZFEpTNLKs0an3hYqgQw-1; Mon, 22 Jan 2024 12:25:23 -0500
X-MC-Unique: XObZFEpTNLKs0an3hYqgQw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42793cd9d33so51642681cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944320; x=1706549120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9E8LP/sXchUxMDynkpMldI5w3cNLtCQjxmXDj4qu+Y=;
        b=iL4G5SdCmlZ/3l9huXpCbAyhVUM0QxrpCz4Ef1ER+znF8w5hHEaIcs39gRx+ysyrJR
         KfAQQJDU3h78c1BQjDLVNlRcZORQ1u6u6Ewl5fVu81prFHtX+COYvrDGj7rxEp6isH8n
         VkXYEY1eU4ia47Bg6bFBCbhELjmgiF1RNaK3yR4f50jDOOZthwfAisC32NtLbbSY4zyZ
         G2SVU328GIzV41TYvbfvq8rh0tj//xrhDG+J+oRjJyLguiFs+07Y2m8LydEQxhDep5Cz
         GWeeR5v/S2F5ZPdVgdhWuR/wr0Zd0TvL1/4Wv9POQdipmXFTORloOoVnM5FtcUiJ4KSh
         8Hdw==
X-Gm-Message-State: AOJu0YxRustR3t1shLN0d9cCy7XuavhnUwVEpESAykpDP9pAL7B3wN9v
	Hx6tGmq3mXGPPWm8iGewm3bfa4WC60LdasqChI4kyEMDqOwZyjU1mYvE/OtcBeWNa1nrhQOlWXQ
	Y3xT6wGdU85wWx9qWveCDpXxWlbzIVUafu7Z8MJRLwoSwwkrWb10iVze03turzQ==
X-Received: by 2002:ac8:5c06:0:b0:42a:2be8:37f8 with SMTP id i6-20020ac85c06000000b0042a2be837f8mr7667936qti.46.1705944319785;
        Mon, 22 Jan 2024 09:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEw9tYpVM1Vb6nwYLykf7yZWc23Mfc1dOE48wD53sQO6xtnskKBD0ZYOxmi4yAMEBoT5Y13vg==
X-Received: by 2002:ac8:5c06:0:b0:42a:2be8:37f8 with SMTP id i6-20020ac85c06000000b0042a2be837f8mr7667911qti.46.1705944319483;
        Mon, 22 Jan 2024 09:25:19 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a200700b00781ae860c31sm2280992qka.70.2024.01.22.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:25:17 -0800 (PST)
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
Subject: [PATCH RFC v4 09/11] scsi: ufs: core: Perform read back after
 disabling UIC_COMMAND_COMPL
Date: Mon, 22 Jan 2024 11:24:05 -0600
Message-ID: <20240122-ufs-reset-ensure-effect-before-delay-v4-9-90a54c832508@redhat.com>
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

Currently, the UIC_COMMAND_COMPL interrupt is disabled and a wmb() is=0D
used to complete the register write before any following writes.=0D
=0D
wmb() ensures the writes complete in that order, but completion doesn't=0D
mean that it isn't stored in a buffer somewhere. The recommendation for=0D
ensuring this bit has taken effect on the device is to perform a read=0D
back to force it to make it all the way to the device. This is=0D
documented in device-io.rst and a talk by Will Deacon on this can=0D
be seen over here:=0D
=0D
    https://youtu.be/i6DayghhA8Q?si=3DMiyxB5cKJXSaoc01&t=3D1678=0D
=0D
Let's do that to ensure the bit hits the device. Because the wmb()'s=0D
purpose wasn't to add extra ordering (on top of the ordering guaranteed=0D
by writel()/readl()), it can safely be removed.=0D
=0D
Fixes: d75f7fe495cf ("scsi: ufs: reduce the interrupts for power mode chang=
e requests")=0D
Reviewed-by: Bart Van Assche <bvanassche@acm.org>=0D
Reviewed-by: Can Guo <quic_cang@quicinc.com>=0D
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/core/ufshcd.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c=0D
index 9b6355555897..9bf490bb8eed 100644=0D
--- a/drivers/ufs/core/ufshcd.c=0D
+++ b/drivers/ufs/core/ufshcd.c=0D
@@ -4240,7 +4240,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, s=
truct uic_command *cmd)=0D
 		 * Make sure UIC command completion interrupt is disabled before=0D
 		 * issuing UIC command.=0D
 		 */=0D
-		wmb();=0D
+		ufshcd_readl(hba, REG_INTERRUPT_ENABLE);=0D
 		reenable_intr =3D true;=0D
 	}=0D
 	spin_unlock_irqrestore(hba->host->host_lock, flags);=0D
=0D
-- =0D
2.43.0=0D
=0D


