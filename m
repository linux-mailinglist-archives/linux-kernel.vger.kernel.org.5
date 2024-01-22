Return-Path: <linux-kernel+bounces-33793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D53836E98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670521C289C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290860BAE;
	Mon, 22 Jan 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmLlzKrj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388D60B95
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944103; cv=none; b=p29rY1zVJb2S+Di2U2V4Z6EL7hfFGD5ndXyUmAav7nCkyyQ2wYqhvtFzydHtB1WY6FQDpQCXjw+3piZU52gLE8D/8AVRPrvFt9OZ7hSz2C5baXMqbBD2YOCzyJFv9eORffQeeStORdAgEVXBDq5UF3GfhiOqwlHyFy9pJ+IG800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944103; c=relaxed/simple;
	bh=0P1cnI0mD8xM/AjnAgWtUBg7VLq6L+5OdBjFcSoDduc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKOlepbhag5CUWd9h0+GlK1rVIHdr1YfNNAkrRIoQoISP+kVAwqmiPIpvzkoyXUPMNCp+DtWV0u4uNBc/s+pl8CnPrP+l6U4ettwIhpkLoj4gsU7meW6dSlC5t8RmQ9xPlttybQ/DJy0vH+ibm5MWtmihPxTra8Meud52hEySo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmLlzKrj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KvF/wE7cle9SwAgTLO4kAe2SOvejFGQAYKmJxo43jY=;
	b=TmLlzKrjV4S4UXYVXar1JTPl+ouBcAqGeekrFsy+GZ24cIpHcgfKb5e/QUIawymyVzqwCH
	C0sGfVG/iw5OhQanwRQ/gdgPpGeqQsLSfXfawvlbZ/QiHISyIoBNRmKOI59Q+e2VySal00
	ZhjRMXiky4AE7aBgvlIvEsWjL00loO4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-7Ws6_TiBORCBsd-VQfLxJA-1; Mon, 22 Jan 2024 12:21:38 -0500
X-MC-Unique: 7Ws6_TiBORCBsd-VQfLxJA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-681998847b0so66515206d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944097; x=1706548897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KvF/wE7cle9SwAgTLO4kAe2SOvejFGQAYKmJxo43jY=;
        b=NiJ3av+H8OjyUPp7PkxukzdZYaF98YZC09IfeePNqJsn5wmt89DfuUJyE+lIAkrST1
         QlKH5YMOibiR1CayGa8/NKV/uT+QDsgFKkWPGRTFsSgOa82ud6t/8cas9T0OJ6hpO2zD
         bE0pQWUrvMIJvBzIfSw0/SSBZBN86kSD1/YqUSYt1soY33aERjdXTVwnEu4RQ13/T0ci
         GIzQDj+hWKbmJTj5aZgVh1yTumUfE5vUVVmjzYxInA4enq7xoosrdPem+oZpKo0MMruY
         ejKMKdH+wLcRQek5W0obDAGjW1BT6qkL8FIscBhIVT+OwTfL86LQ9WNrk5Js1m2X1vsB
         Dp8g==
X-Gm-Message-State: AOJu0Yw9IlcyB7VLZf6RwreMXk1vYN73lcmjpt355H/UVsO8Pv0y5Y//
	Z2MfSy0Hzd3N4XSmYkMYGw9qTWchXoXmORv2WoTkkKU5fM8y7y9tATGyv3YuHtkfU68iDzPelNw
	W5v0cZyPB6GWf1f7nfTqreurBAnxnyi9a3/qoXrxwTmbzQiYHGVy2I6fVGMS8yg==
X-Received: by 2002:a05:6214:1d2e:b0:684:d2a1:990f with SMTP id f14-20020a0562141d2e00b00684d2a1990fmr6930848qvd.40.1705944096917;
        Mon, 22 Jan 2024 09:21:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXXHmtJA2fouZvXWZRPuBxW0a4kvTjX4BO9HFSw11OKwZJkbRHiV8Pi9144jdwfGRsA2ozXw==
X-Received: by 2002:a05:6214:1d2e:b0:684:d2a1:990f with SMTP id f14-20020a0562141d2e00b00684d2a1990fmr6930834qvd.40.1705944096647;
        Mon, 22 Jan 2024 09:21:36 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id lf3-20020a0562142cc300b00680c25f5f06sm2567738qvb.86.2024.01.22.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:21:33 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 22 Jan 2024 11:21:27 -0600
Subject: [PATCH RFC v4 02/11] scsi: ufs: qcom: Perform read back after
 writing REG_UFS_SYS1CLK_1US
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-ufs-reset-ensure-effect-before-delay-v4-2-6c48432151cc@redhat.com>
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

Currently after writing to REG_UFS_SYS1CLK_1US a mb() is used to ensure
that write has gone through to the device.

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

Fixes: f06fcc7155dc ("scsi: ufs-qcom: add QUniPro hardware support and power optimizations")
Reviewed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 39eef470f8fa..0603a07a23a2 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -501,7 +501,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		 * make sure above write gets applied before we return from
 		 * this function.
 		 */
-		mb();
+		ufshcd_readl(hba, REG_UFS_SYS1CLK_1US);
 	}
 
 	return 0;

-- 
2.43.0


