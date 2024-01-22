Return-Path: <linux-kernel+bounces-33796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CF2836EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F332B1C28B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FDB60DFF;
	Mon, 22 Jan 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZcK0mcJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDB60DEC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944121; cv=none; b=RkrPYgtLBB7SDiizk6HApHXKtMuRyZI+GaIloaibIgxtN4AfqLoHZvTRCmXuCYw8DmfKBPbgUQP1s255n6NBsWxZQWrzhBrY3SFV095RpsmkJxuVUFMVF1o+ODmzA9aZ3sOOlxmZBa7rROnX4xvPpSSJLKZN9M+mhtaoVaQt3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944121; c=relaxed/simple;
	bh=98P8Ul6Yd7c/3fLfOg78lrSuMF8zpONCYx14LZgSuKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSA2DpQ4wXlr7HVNj/+6Sk1JZzAfIWxKBO4L9f9MDZwFvSLRmSOcbihWlW8xR5FCZIHHVlBkOA/g2zv3sDGhou0vKQ/h0tcoMFRvia54YxcCvjBXp4uQW4CF/GgfhIszLwvefLohhKqXK34UYR13HRg6oKuWWw5ZMkgsVcNOMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZcK0mcJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R70AogzmSo/CRKtY8ackbX9p9Zw/xQ4/D9I9iZgsmTo=;
	b=aZcK0mcJ/UxbGQVHOIRR5emOiTaFZYQuGDJnDLrXv83ImNE3ladtAkZWEexhG2T7jBRNvM
	gmHkQRxBTnmB3D3YhGvo6ioMBwW+T0pLPIcv+/pkehoxv5hpGF68jnSohHDKEQH5bK8clb
	y5fjQOULNRRUTY3P0WzwjVVNgoadc/s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-rcqANBuTMLK5wGN8ZetTNw-1; Mon, 22 Jan 2024 12:21:50 -0500
X-MC-Unique: rcqANBuTMLK5wGN8ZetTNw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68694f9e037so9399446d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944107; x=1706548907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R70AogzmSo/CRKtY8ackbX9p9Zw/xQ4/D9I9iZgsmTo=;
        b=w0/BZ4c8BxTfogUbav7pbghu1noF7Y39A2fV+8JuQnfwh/tJ3rEDTzPeh+zKgxMPh1
         tw86+XFJw/l2tJfHDeHdE0dgFtPaZIDmSy3hpz9ukjuEiHZbz9EWdWjbWSp8lEIOnFFr
         T2xvd0RUG0KEzRLnLhrjzZV0DzhPKZW+giC5aQIkfTctJu5CXnxZ3G5Gg6JXUyQ6bci8
         obf0LeZfetWdHDc3oicXetueqXSt+sP8gzCAqqvXZf4Ggp4JfMllGxke0YzxE0RuWClA
         owXLCRTuJoU0VBMFyKi1NHQKCCssOP5hhj18gUeBt3mSssVGRnAM798ipdQ05ipCAsp/
         SE7g==
X-Gm-Message-State: AOJu0YyU4PutZp9GzUBe2IVlxYi1ZO1RlO/2uvDSlYcKBHMcifIj4fr6
	Vwdxf3zLaH9vI8SzQcc6qI9orTbPC3ctc7NKSTa6rGoimNGnRtP35S7gm5OxtcL33BeyxqIuv3b
	oUZ2aAQ2Pxqtt6A6eGdqBrLrByZV0n165/vw+JqZ1oYiMcK6pFQ6TZB3ykpI9nw==
X-Received: by 2002:ad4:5d45:0:b0:681:888c:b82c with SMTP id jk5-20020ad45d45000000b00681888cb82cmr6893800qvb.125.1705944106734;
        Mon, 22 Jan 2024 09:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsma1BTJH1NJyj/o8MHNafqTa7tvq2hIYGZ9YYQ15ylWOe7E5a5Aggrc/RaI6Iu3ZEfYrJBA==
X-Received: by 2002:ad4:5d45:0:b0:681:888c:b82c with SMTP id jk5-20020ad45d45000000b00681888cb82cmr6893775qvb.125.1705944106311;
        Mon, 22 Jan 2024 09:21:46 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id lf3-20020a0562142cc300b00680c25f5f06sm2567738qvb.86.2024.01.22.09.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:21:42 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 22 Jan 2024 11:21:29 -0600
Subject: [PATCH RFC v4 04/11] scsi: ufs: qcom: Perform read back after
 writing unipro mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-ufs-reset-ensure-effect-before-delay-v4-4-6c48432151cc@redhat.com>
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

Currently, the QUNIPRO_SEL bit is written to and then an mb() is used to
ensure that completes before continuing.

mb() ensure that the write completes, but completion doesn't mean that
it isn't stored in a buffer somewhere. The recommendation for
ensuring this bit has taken effect on the device is to perform a read
back to force it to make it all the way to the device. This is
documented in device-io.rst and a talk by Will Deacon on this can
be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

But, there's really no reason to even ensure completion before
continuing. The only requirement here is that this write is ordered to
this endpoint (which readl()/writel() guarantees already). For that
reason the mb() can be dropped altogether without anything forcing
completion.

Fixes: f06fcc7155dc ("scsi: ufs-qcom: add QUniPro hardware support and power optimizations")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index a489c8c6f849..decad95bd444 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -278,9 +278,6 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 
 	if (host->hw_ver.major >= 0x05)
 		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
-
-	/* make sure above configuration is applied before we return */
-	mb();
 }
 
 /*

-- 
2.43.0


