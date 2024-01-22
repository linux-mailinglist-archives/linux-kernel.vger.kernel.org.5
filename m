Return-Path: <linux-kernel+bounces-33809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F9836ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AE72906D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373A629E6;
	Mon, 22 Jan 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUTtXlL0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543E5579A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944333; cv=none; b=czyhm0NZXJNje4Piywployro2GKmbDDVNflMBbw/+6FV1HISAmc/wiGblXmaXt8rA6ocswWzOQHS8CZqDLdbUJRsT4VBpIdjd9U/WPwgCJ5DNrLCDBDh7uyxmGztJ6DGw2lAlTuWmTOl74eLtlZIJ8GNFyDDurZ8T1PdksmSy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944333; c=relaxed/simple;
	bh=MER45LHvwiXQD+ULDnSvsVxwXZ1b2Z5xk98z1OKFCA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HslToyDLpVOqYbNF/xltvHRtam7o1Nyah1TPKM0x0usx0uwWb09suw0ZOmWfkxwQHMQct4Z5Im+xYBJJUH050gd3QDTkWmoPD9b/fbtKGscxkTCTEqEcaJ2w4HdfOC/0HL/bCh8c/s7hZ37VRQS111WftqWQWC+lR7U/iwIzy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUTtXlL0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWSD/O3bKBCmQqSFNDTq3XZwC2CZzWCGf6aiHY6rT3c=;
	b=WUTtXlL0vFyi3Hn4WjZEZnZ79liCysFF1Bzx27qN9f+jWyp1F66+qofaiP+cmr4p44cVPu
	/g/cEV78g4pLFZDFt+pDGtYAwlk7vRv1+IAJ+IxR9D/sVo29LfaNKtr/SoKs22S0vmQBki
	O8yKJLcsB6p/m0qObNomzO0SapvGIq8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-e4xl3UFJOWCVZFPfg7H4rA-1; Mon, 22 Jan 2024 12:25:28 -0500
X-MC-Unique: e4xl3UFJOWCVZFPfg7H4rA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42987be5d14so51522901cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944325; x=1706549125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWSD/O3bKBCmQqSFNDTq3XZwC2CZzWCGf6aiHY6rT3c=;
        b=c5qXmRc4LiMR3Y+3Q0alatRa9JNf3Iu6NNHZE0fON3JVp+AjdiFbTe4R4AuHS5ttkK
         EfTPtRGII0b5mBZnvMzsI3Ugt9+0l+dxORQ+9BbZQlS1iXfHEbgPY4WtnRp8kYQH8vKn
         4wKbUwZ3xm1WfFPDps7UqmFTrGFq4gf0HOEYZ6LuIPcsnOVL+538Nl3H2bDQsFrFn97M
         B8lzkhRXh0kOYu3H3R6icdEF4AMMH3sUQRlS48+qGwdhKtUqgaSs1wzzG3TVrrExSEoJ
         1HF/H+vn7ZRAHhYNvvDNj55Yb7hDk+WuWaJs5OKfnRoDWEMRnKCn/7RXoKTtMnvoBBw7
         exwg==
X-Gm-Message-State: AOJu0YyLH5QW4Ygh4XOwljJRYR++170/FxPkCSpHL9t10T6YAyNfqm/o
	2GSB8UUsEBG5Q0sU1MrjFH1SJHn4WWARE270I2ia5Ff+f6AiRI/pR349qihkVFVuTGpCJu/O1US
	Xj99cJk2IHpHAB1qdk2UJaxqoYXEHsTuNmExrEwEEOLbNtq6346Jg9H667iGt3A==
X-Received: by 2002:a05:622a:153:b0:429:bfe8:7cbf with SMTP id v19-20020a05622a015300b00429bfe87cbfmr5989896qtw.61.1705944325632;
        Mon, 22 Jan 2024 09:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1/s3ITcewXmjQuuSVj/VeSaPz1pDK0mjWP46v77x8t9CGNfS3RSXaOLDKXeUxl+tVObwrkA==
X-Received: by 2002:a05:622a:153:b0:429:bfe8:7cbf with SMTP id v19-20020a05622a015300b00429bfe87cbfmr5989887qtw.61.1705944325372;
        Mon, 22 Jan 2024 09:25:25 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a200700b00781ae860c31sm2280992qka.70.2024.01.22.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:25:25 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 10/11] scsi: ufs: core: Remove unnecessary wmb()
 after ringing doorbell
Date: Mon, 22 Jan 2024 11:24:06 -0600
Message-ID: <20240122-ufs-reset-ensure-effect-before-delay-v4-10-90a54c832508@redhat.com>
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
index 9bf490bb8eed..21f93d8e5818 100644=0D
--- a/drivers/ufs/core/ufshcd.c=0D
+++ b/drivers/ufs/core/ufshcd.c=0D
@@ -7047,10 +7047,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba=
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
2.43.0=0D
=0D


