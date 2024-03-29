Return-Path: <linux-kernel+bounces-125405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AD489258A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C7D284590
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF913CFB6;
	Fri, 29 Mar 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh7InM7n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A713CF8E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745344; cv=none; b=e0P1A3DioILOl2KknDpKZkMNibQjdpgOtmBLF50GUfSjQ4GdAoI4b5yDsZjGyxq0PjIxRGr3K0xMQo5XoHPAhtpFJm6X97kfuB1ErKr32tQ96sL1traxXocRUakjtXgzZy4Q+TMShYh3poxq0JzRIFjttkcvwft2nwuHzuuy3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745344; c=relaxed/simple;
	bh=O6r7hIkp4pDUEFyTU1K4yQZhhK4XwokMFD5oh2534Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fT9ih9RrtdIch61ONMnd/ekyd82KowZzwsWsmKmJchRa9gK3Iy8jGBr0u7vXHmmJeHYKHrplBQbUy+2PMVFZai7LkETFOVI5Klb+n2lOElSTpD6SwaQ2p+J4+dGbY5TyNl6VhLl3exDjHE7PUOXmQWiFNY0kmGEugatFVwH2SKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sh7InM7n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWQA/2e+hFkNwU2pe5LsnYGd5I3g3WoCTrNziOID4Hc=;
	b=Sh7InM7nqQpdize4THRmPlTOSWKz8eCYXAryvN5qwUcrP4ucg6jDEePnln0kX2Fe6+0RR8
	icZa149ERiFHna+X/CrMlej1JAnrINc7zlLIIAZiaep+sLK+el7A3bnbQEYbvM/ucdUM5X
	soJb9tcKDjFHaYw1MKzGic092tEKDfY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-6d0RGVxOP2-Ym6lfoxhPBw-1; Fri, 29 Mar 2024 16:48:59 -0400
X-MC-Unique: 6d0RGVxOP2-Ym6lfoxhPBw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6e6864c33e0so2480370a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745339; x=1712350139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWQA/2e+hFkNwU2pe5LsnYGd5I3g3WoCTrNziOID4Hc=;
        b=llQ9I+BMHcKmvmT3nlTDvrfb9CIIU5o1hs22GWvtdSjrPTNqvCVCxQYsYhWSgB6MvB
         QA9+vL/gisdqhjoVQUY5YlWjtgCl95RrXUya6I9lAfsN8WP2JO74LAVTwULj2BZ5TALs
         HwpCzd0KrLrrRqsNmEXvMkTnzDvdS73l2FlxV5FVII8sNWmxsqj+aR0Ltuv1wQbteWiv
         K7YQDVLn/3Qq0eT1UOVRv7cfL5SmjWOo2HkOwaJTSSQrfEx4GBbWxjPSGwQzcRUKn4j4
         OAtL7vHdeo/wIhTG0jmhbN1Y335cG5ZEjYVJ6lLCIWdBw6PWnAqBn0FrD/PxTL1KnV6y
         Tusg==
X-Forwarded-Encrypted: i=1; AJvYcCWZqCv12kA02PLcWY48+BuC3mqBTykTjQhPqRGm80Iz/kaxyfjJcq8ORB3Tr65HcCtmWTSxzCN7auMwnvbVCuXUWBkmWE2EvTn7apsv
X-Gm-Message-State: AOJu0YwShG617bw08xuNA73ntA9Zm7GpZnML8mIeKzWBVcf3mQb+faEW
	Jd7ZMOwoIajt5u17hXLwJBCd+qIiOME95nFd40URQAk9nm61Wd9Ur7VZfiTtc8E0dR4JhiPlj7C
	lC1R/ZO6Ks+cqcailpfhkhxxw58KWYEDBKHNjXH6fL6mS4IPKYrWIDiI+GSs9zA==
X-Received: by 2002:a05:6830:6f47:b0:6e8:80ad:7053 with SMTP id ef7-20020a0568306f4700b006e880ad7053mr997902otb.22.1711745339271;
        Fri, 29 Mar 2024 13:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdygFKimRtHNOnD4kBIoC+a16ccsbX/L5MSYf1N8IF5y+Qv/ZoWQTsz6gRpJuVnt4/kbzHiA==
X-Received: by 2002:a05:6830:6f47:b0:6e8:80ad:7053 with SMTP id ef7-20020a0568306f4700b006e880ad7053mr997882otb.22.1711745338883;
        Fri, 29 Mar 2024 13:48:58 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:48:58 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/11] scsi: ufs: qcom: Perform read back after writing
 unipro mode
Date: Fri, 29 Mar 2024 15:46:46 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-4-181252004586@redhat.com>
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

Currently, the QUNIPRO_SEL bit is written to and then an mb() is used to=0D
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
But, there's really no reason to even ensure completion before=0D
continuing. The only requirement here is that this write is ordered to=0D
this endpoint (which readl()/writel() guarantees already). For that=0D
reason the mb() can be dropped altogether without anything forcing=0D
completion.=0D
=0D
Fixes: f06fcc7155dc ("scsi: ufs-qcom: add QUniPro hardware support and powe=
r optimizations")=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/host/ufs-qcom.c | 3 ---=0D
 1 file changed, 3 deletions(-)=0D
=0D
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c=0D
index 649fada24345..66a6c95f5d72 100644=0D
--- a/drivers/ufs/host/ufs-qcom.c=0D
+++ b/drivers/ufs/host/ufs-qcom.c=0D
@@ -278,9 +278,6 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom=
_host *host)=0D
 =0D
 	if (host->hw_ver.major >=3D 0x05)=0D
 		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);=0D
-=0D
-	/* make sure above configuration is applied before we return */=0D
-	mb();=0D
 }=0D
 =0D
 /*=0D
=0D
-- =0D
2.44.0=0D
=0D


