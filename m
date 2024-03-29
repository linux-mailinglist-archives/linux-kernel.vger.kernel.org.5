Return-Path: <linux-kernel+bounces-125410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D489259A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3FE28460C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD401386A8;
	Fri, 29 Mar 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHflgzF0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8D137774
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745447; cv=none; b=HTfkGDS0Y/N5nzlpfb601ZcaceA748KoIq9E8a5gqtuyCo1xsc5yUj4TVXpWz07Trb4JRdcXyRL6zFS3iltv2O8+6JwOt+alhWhT8PrAZBXTJSvFpoNaCTK1sP3JbJvGR0MEn72Onh57TEmdi6gBFuDDFW21SLl1tgIGV/HTepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745447; c=relaxed/simple;
	bh=PqxfmcZUl71aJ83+FVaDE3fBXAA/MF4FXGrWqbmE6/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=et+zz1QNrjp7qNHK3W8EuvtWAOWGruArD1IRu7vK6Xy0h7REUuhxp0j4b66AQk5xsU6RVOFUfdDMYvKi5/RLHMEEJ98gKABhO7IJcJ+CJYDND6z6jVbtM9abXqVBj22R2hmkP5gbGUN4RhVIrYVyb1cFV94sNhdepFsn6lNmYpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHflgzF0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QjyaSVMjBwePVdedDMMBn4vO294tfAzIl87qC/KNtw=;
	b=EHflgzF0P5yX6TShKGtcuC4P4vJ+NvB66NY8pI//qSSMz29QExKZud8YxgMJI9JdDV9d4V
	polx1CJ/jMVrRbfwslR4TXbzni5XydzvvTwS+W77t5io+K3j9WPb5pPek15p3Okc3gbE/k
	dg1qWIGizjLNfI5i8WxSzYELq5vPPhU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-eGt5RmheNd-Iv2bL9E0AWg-1; Fri, 29 Mar 2024 16:50:42 -0400
X-MC-Unique: eGt5RmheNd-Iv2bL9E0AWg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69649f1894dso28367306d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745438; x=1712350238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QjyaSVMjBwePVdedDMMBn4vO294tfAzIl87qC/KNtw=;
        b=a5i1BrIV9M7TL94gw/B2N1/2aL5MJ/83vIuEO4oXQ8iEnGpHNAtRarJjee6H8EJrYO
         Ehcd7lw/l82BdEsWzsXPOLTGt3adVwrsY0bLr8luxWTaJ6y7y3U2zfjFa/pslzp4twvH
         wOQSajzMhALCu+F2ezvuULzqsF21sQTiXphYkzbwinlhNo1mvBAY9hdxPffwtGa8qDhG
         vgWsipIqCASq2XL2Mc3kJIL6+iuEUoDbRNeDueGbi/a3apnVq6gMUy5g3mktwwrM/8tS
         bJ94O7SRb5aJWimT2yUMiuC3U7aGCCwO4+QZ22fFBhBFXM0Ega1dkg3YzAejhyG2ueQ/
         xomA==
X-Forwarded-Encrypted: i=1; AJvYcCXI/KV0aZ9y7deLHkivcUQx+Oy8gXhoDROXwVxQrsW75HVVzWCuNMr7Lf7nBxM3xSK1ghUxkEqLrzpRlF0LPe8g6V6i3W6AijtQhU0Y
X-Gm-Message-State: AOJu0Yz7TZ3fUVX+D7H78qqPWLzT1nbWdao9ubYr9wIA332Z+0HRmjS3
	ZIbuLRO48HULp4ldg70xDubXNVAi8mAyYHvKM9vrRyPH0T80J5ycTa32SWBXOhlZSQn+6iRoGPF
	X+UfinT20/KSlvRdeNALhxYZyo2cJc7s/xJ7UjM3EKzISPlZNfnnxuz0ygfGRcg==
X-Received: by 2002:a0c:f98b:0:b0:696:b03b:95c9 with SMTP id t11-20020a0cf98b000000b00696b03b95c9mr3554504qvn.45.1711745438110;
        Fri, 29 Mar 2024 13:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeopnUxHF7SURKgs64+ifYV1WqjEh+CLYVI3V7yZtqeLq0zE8KjS5O671BagYz47YJT4NKBQ==
X-Received: by 2002:a0c:f98b:0:b0:696:b03b:95c9 with SMTP id t11-20020a0cf98b000000b00696b03b95c9mr3554487qvn.45.1711745437715;
        Fri, 29 Mar 2024 13:50:37 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:50:34 -0700 (PDT)
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
Subject: [PATCH v5 09/11] scsi: ufs: core: Perform read back after
 disabling UIC_COMMAND_COMPL
Date: Fri, 29 Mar 2024 15:46:51 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-9-181252004586@redhat.com>
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
index 268fcfebd7bd..dfa4f827766a 100644=0D
--- a/drivers/ufs/core/ufshcd.c=0D
+++ b/drivers/ufs/core/ufshcd.c=0D
@@ -4287,7 +4287,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, s=
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
2.44.0=0D
=0D


