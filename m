Return-Path: <linux-kernel+bounces-125411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6517489259D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A871F22E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E6A13B5AE;
	Fri, 29 Mar 2024 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8XyaoAk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544A13CC5A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745451; cv=none; b=fbXdqw3dwlm358GZpdIPYqrUXjk3LyFXWSiQH0Bhx50jOJD6oDcaKvLRRXDR4hQ4y1YywLcHJ67/mPeY3hGtnJ3TzdRNs54eqMJLblkA6WULIIlKFOq1mgZp8FSKr9do57FBxDH6CX03U5vImegooxfRVtFy6DKbfAHxQJeGBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745451; c=relaxed/simple;
	bh=Zy+bgvSnjLkgq0s4C6zNdmvBRZh1cOH+2n6Swd6Xvls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLA0cZhG+QXPXO+Y5awDl/h4ezUJxjtxL0Aswbp3mctrhMXITbn4gdP+8Liz0F2xr71xzVR3uDcoji5egAQ8wsXSfqC6fyXz14h5drLixvu84u4JTe5u+vymL4DWMdW9olZbN+39bWauhQalqvaR7yLMGrAvm4dLbkHQDAat0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8XyaoAk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPnsustGT4GoUrGTcO/hGoT1b1FUZsTVit4gdTDovY0=;
	b=I8XyaoAkNKrhJVZdVCVfT91hxw8aYnhcf0GTpqewiwO/vnKFg35QSWY6MVwnF3BtGJhkTi
	/1UjLVZyj8CUlfQ81266wppAdGOMWTgFCkP3cAYVxspbVKzhDY58tNH1AAYadBtEv1DYo2
	LK3+qTgh7JPeKCrdtbAqxX7QPlYyNqc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-orxG8o-0MmytUPj7nIGYeQ-1; Fri, 29 Mar 2024 16:50:47 -0400
X-MC-Unique: orxG8o-0MmytUPj7nIGYeQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69173411419so29936406d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745443; x=1712350243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPnsustGT4GoUrGTcO/hGoT1b1FUZsTVit4gdTDovY0=;
        b=tko4yCURzUUZ1pxyELen6LmRdPBWmTVrcJaMg14OS6rB/NnrOYuKJRyYPRxX8SNrII
         8eWRPYs128FEpMXfPU7fb9+nqlVFf+4M49YWo7wHado2QIjpollKcd5DH0ZxkkOUtaJL
         bw/ba7wq4QilBZhrA+1C1zt7wiO8oNtj3IQreP0ACKqPByt/8i7IsPr9TzW5VecMF4Jg
         8gblCIv7wRESrPelM1f1UxAd2YjgVT7wT8+/Ia58jOgXkurOixlU3Pi2VakSAhOd1qJf
         P/KHps1NuESQQQynkuLKMm9K6w0xHFrgnoC9nBhm5dKw5qIz42QJrh4ZXnqgR1DTZc4b
         yvCg==
X-Forwarded-Encrypted: i=1; AJvYcCX27kBF04vcfgWMbukMhxQ41pHG07ySlH54d4cyyCpMT3U9tlbPwu+H+WUUd/rSXb6U552VMw8JeZXQmua6BJJn0L6VzSFMPB7IXJR1
X-Gm-Message-State: AOJu0YxQLgOilZu9YY7qew3S7+gNmGpFCG81n3QUTRI2zhETAP5lZlEz
	8xSbLn3x8YqNG6fM9/oFQxLPFlDPj5158olLu07Nl5i6dSMS/zLRKz8msk2RJq6O97QqCMF/ij4
	GCa2JG2iIIm1ZQxl63XFtRshLQ/fNOKIG6oG3e+qJFdKQOT3zSKhC7icTbZtLQA==
X-Received: by 2002:a0c:d646:0:b0:698:f3f0:39dd with SMTP id e6-20020a0cd646000000b00698f3f039ddmr2065505qvj.6.1711745443261;
        Fri, 29 Mar 2024 13:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBLrn+K4mLNtCh2Rz2Xmh067Hv24Kl9mQ40ZdwbQbhkZQb5T0j5S5g1FGjMUP56UzrNARqQA==
X-Received: by 2002:a0c:d646:0:b0:698:f3f0:39dd with SMTP id e6-20020a0cd646000000b00698f3f039ddmr2065487qvj.6.1711745442848;
        Fri, 29 Mar 2024 13:50:42 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:50:39 -0700 (PDT)
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
Subject: [PATCH v5 10/11] scsi: ufs: core: Remove unnecessary wmb() after
 ringing doorbell
Date: Fri, 29 Mar 2024 15:46:52 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-10-181252004586@redhat.com>
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

Currently, the doorbell is written to and a wmb() is used to commit it=0D
immediately.=0D
=0D
wmb() ensures that the write completes before following writes occur,=0D
but completion doesn't mean that it isn't stored in a buffer somewhere.=0D
The recommendation for ensuring this bit has taken effect on the device=0D
is to perform a read back to force it to make it all the way to the=0D
device. This is documented in device-io.rst and a talk by Will Deacon on=0D
this can be seen over here:=0D
=0D
    https://youtu.be/i6DayghhA8Q?si=3DMiyxB5cKJXSaoc01&t=3D1678=0D
=0D
But, completion and taking effect aren't necessary to guarantee here.=0D
=0D
There's already other examples of the doorbell being rung that don't do=0D
this. The writel() of the doorbell guarantees prior writes by this=0D
thread (to the request being setup for example) complete prior to the=0D
ringing of the doorbell, and the following=0D
wait_for_completion_io_timeout() doesn't require any special memory=0D
barriers either.=0D
=0D
With that in mind, just remove the wmb() altogether here.=0D
=0D
Fixes: ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the door=
bell")=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/core/ufshcd.c | 3 ---=0D
 1 file changed, 3 deletions(-)=0D
=0D
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c=0D
index dfa4f827766a..a2f2941450fd 100644=0D
--- a/drivers/ufs/core/ufshcd.c=0D
+++ b/drivers/ufs/core/ufshcd.c=0D
@@ -7090,10 +7090,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba=
,=0D
 =0D
 	/* send command to the controller */=0D
 	__set_bit(task_tag, &hba->outstanding_tasks);=0D
-=0D
 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);=0D
-	/* Make sure that doorbell is committed immediately */=0D
-	wmb();=0D
 =0D
 	spin_unlock_irqrestore(host->host_lock, flags);=0D
 =0D
=0D
-- =0D
2.44.0=0D
=0D


