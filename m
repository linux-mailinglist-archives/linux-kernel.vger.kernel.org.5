Return-Path: <linux-kernel+bounces-125401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D1389257F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A8A284432
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8641353E1;
	Fri, 29 Mar 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZV75nOc8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03745955
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745322; cv=none; b=TNu1mtAV81F0c54qOzCHt80LnWp4HNQpX1PrLedm9W6Kb+uka8HIB1+2bTlADz+XrVrSW2gKNVUXpXQCGFxgqO1xkdT6gJy+RSMB4PjYY/Xftr1z1NjaDFOFRuppzt4gubWTP+fBCoe1rXE1Zn/hPcRZnUI7bNEh5JO26u4Takw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745322; c=relaxed/simple;
	bh=lwlpcI5A8BQcar0sMy35uEcYUx4hN1D1zdDSj4FSLeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HJAfWjNB7sm3pw1JuMQWozE/m9j37nIN9BbOS7KDz4r2dmH0I7cUaoDGWEzjVu55ytaZm/HcSqx7IWnS0FHa3Xi4Ot9tCgloe1hPjYso153tnCOQquTmNN6abYYoIY8VT2QWJsDBpiWMRozE4LIjJq/SfXW3uAFeOzX0GqST0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZV75nOc8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pMvHo0hhUkUgt9K7fEcKX9ASN8rbTIhxdwYeOP1BBsI=;
	b=ZV75nOc8E0FhGClsFwTwJNV8X3HklUGUMhcO1RY9FmZegy6cWK9GopMahjn6KVzZg/YPYL
	CHkzSPw7R0YUG/z10mHPXkHw7HJeCgLOF+IhY2Osi0EnqrTKaftQHCaz/JPt+NERD7TV4m
	4rPbwuLa4f7OvDGZkmD5qw3M4Mz0Anc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-n9MopW2YPD-npa3zPiP_BA-1; Fri, 29 Mar 2024 16:48:38 -0400
X-MC-Unique: n9MopW2YPD-npa3zPiP_BA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4766bd576fdso956831137.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745318; x=1712350118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMvHo0hhUkUgt9K7fEcKX9ASN8rbTIhxdwYeOP1BBsI=;
        b=uOGyOmf0S4MBjvL5DOIskvc9qQYWYLmnbs8LLQMza2dKGIz/2A8E4dgdc1/oLkH1qM
         mr/35HaF1SZsmU4+7t2xOqroM1k4pj+CAA7sdAGfztEW2WyF4N2WIvJBVd0Jxd21mDZt
         nC1218Ll2jfEId+xisEwGNRBXPGVYC0yU/Ni6s8L7/R2xS4G6V1IWWyNf8CMz/Lznq3X
         fZD/bLRIj8KBusKg1iitiEAVRW+OPKdCLAHG7eUYnkleOFzdCZPMwCt8Q+yLqd77cIDe
         f0IHyThXXz/DoWLHOVxkyF8Tgz007QlaltKbc8yykenThBxDh+8+rsouFg9lzu7yvtyt
         ZXXg==
X-Forwarded-Encrypted: i=1; AJvYcCWKOd1tEAp/3M91ANlEaHOfehgQGzzwzZLrT8U8CTnVGzDfe9rlo0Ow/7e1aeVyWkRUtdBoO8WChDeTxjSfMyAqd1ZmJN2CEwPyDmZ6
X-Gm-Message-State: AOJu0YzsCUrfTz5MwtPHFWZgYoMh5rV1rqRvTuNjQFo1Gipznh4l4+Tg
	6AmYGTzyNzmZhRya2mD59TcXiqvHOD+fvmJcOk7KGXKPnWIEUYnKmqDWgfaUTmj3E7+Av6aqIiU
	MPiu/OBilr4Jo018Z3YF2JFYCfR9dS9PTUaCdB1/LEt98VlmDXqkaFn41RLgIQg==
X-Received: by 2002:a67:e98d:0:b0:478:248d:c6b8 with SMTP id b13-20020a67e98d000000b00478248dc6b8mr3000607vso.29.1711745317808;
        Fri, 29 Mar 2024 13:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6McnsPGPp9Wj4K8DINN5NlCqUDVWwV0L72vTeD0Ck/Y4pgw2iS7e2jkCmndL73KM7xdbvNg==
X-Received: by 2002:a67:e98d:0:b0:478:248d:c6b8 with SMTP id b13-20020a67e98d000000b00478248dc6b8mr3000592vso.29.1711745317442;
        Fri, 29 Mar 2024 13:48:37 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:48:37 -0700 (PDT)
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
Subject: [PATCH v5 00/11] scsi: ufs: Remove overzealous memory barriers
Date: Fri, 29 Mar 2024 15:46:42 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
Content-Transfer-Encoding: quoted-printable

Please review with care as I'm not all that confident in this subject.=0D
UFS has a lot of mb() variants used, most with comments saying "ensure this=
=0D
takes effect before continuing". mb()'s aren't really the way to=0D
guarantee that, a read back is the best method.=0D
=0D
Some of these though I think could go a step further and remove the mb()=0D
variant without a read back. As far as I can tell there's no real reason=0D
to ensure it takes effect in most cases (there's no delay() or anything=0D
afterwards, and eventually another readl()/writel() happens which is by=0D
definition ordered). Some of the patches in this series do that if I was=0D
confident it was safe (or a reviewer pointed out prior that they thought=0D
it was safe to do so).=0D
=0D
Thanks in advance for the help,=0D
Andrew=0D
=0D
To: Andy Gross <agross@kernel.org>=0D
To: Bjorn Andersson <andersson@kernel.org>=0D
To: Konrad Dybcio <konrad.dybcio@linaro.org>=0D
To: Manivannan Sadhasivam <mani@kernel.org>=0D
To: James E.J. Bottomley <jejb@linux.ibm.com>=0D
To: Martin K. Petersen <martin.petersen@oracle.com>=0D
To: Hannes Reinecke <hare@suse.de>=0D
To: Janek Kotas <jank@cadence.com>=0D
To: Alim Akhtar <alim.akhtar@samsung.com>=0D
To: Avri Altman <avri.altman@wdc.com>=0D
To: Bart Van Assche <bvanassche@acm.org>=0D
To: Can Guo <quic_cang@quicinc.com>=0D
To: Anjana Hari <quic_ahari@quicinc.com>=0D
Cc: Will Deacon <will@kernel.org>=0D
Cc: linux-arm-msm@vger.kernel.org=0D
Cc: linux-scsi@vger.kernel.org=0D
Cc: linux-kernel@vger.kernel.org=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
=0D
Changes in v5:=0D
- Rebased on top of next-20240327=0D
- v4 changes need review, so please pay attention to that bit=0D
  still :)=0D
- Link to v4: https://lore.kernel.org/r/20240122-ufs-reset-ensure-effect-be=
fore-delay-v4-0-6c48432151cc@redhat.com=0D
=0D
Changes in v4:=0D
- Collected Reviewed-by tags=0D
- Changed patches 3, 4, 10, and 11 to drop the read back && mb():=0D
    - Please note all of those patches got reviewed-by tags by either=0D
      Can, Mani, or Bart, but one of the three pointed out that they=0D
      thought it could be dropped altogether (some of Mani's comments=0D
      are on my foobar'ed v2). After some consideration I=0D
      agree. Therefore I'd appreciate re-review on those patches by=0D
      you three to make sure that's appropriate=0D
- Link to v3: https://lore.kernel.org/r/20231221-ufs-reset-ensure-effect-be=
fore-delay-v3-0-2195a1b66d2e@redhat.com=0D
=0D
Changes in v3:=0D
- Nothing changed, I just failed to send with b4 (resulting in 2 half=0D
  sent v2 series on list)=0D
- Link to v2: https://lore.kernel.org/r/pnwsdz3i2liivjxvtfwq6tijotgh5adyqip=
jjb5wdvo4jpu7yv@j6fkshm5ipue=0D
=0D
Changes in v2:=0D
- Added review tags for original patch=0D
- Added new patches to address all other memory barriers used=0D
=0D
- Link to v1: https://lore.kernel.org/r/20231208-ufs-reset-ensure-effect-be=
fore-delay-v1-1-8a0f82d7a09e@redhat.com=0D
=0D
---=0D
Andrew Halaney (11):=0D
      scsi: ufs: qcom: Perform read back after writing reset bit=0D
      scsi: ufs: qcom: Perform read back after writing REG_UFS_SYS1CLK_1US=
=0D
      scsi: ufs: qcom: Remove unnecessary mb() after writing testbus config=
=0D
      scsi: ufs: qcom: Perform read back after writing unipro mode=0D
      scsi: ufs: qcom: Perform read back after writing CGC enable=0D
      scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV=0D
      scsi: ufs: core: Perform read back after writing UTP_TASK_REQ_LIST_BA=
SE_H=0D
      scsi: ufs: core: Perform read back after disabling interrupts=0D
      scsi: ufs: core: Perform read back after disabling UIC_COMMAND_COMPL=
=0D
      scsi: ufs: core: Remove unnecessary wmb() after ringing doorbell=0D
      scsi: ufs: core: Remove unnecessary wmb() prior to writing run/stop r=
egs=0D
=0D
 drivers/ufs/core/ufshcd.c      | 15 +++------------=0D
 drivers/ufs/host/cdns-pltfrm.c |  2 +-=0D
 drivers/ufs/host/ufs-qcom.c    | 12 ++----------=0D
 drivers/ufs/host/ufs-qcom.h    | 12 ++++++------=0D
 4 files changed, 12 insertions(+), 29 deletions(-)=0D
---=0D
base-commit: 26074e1be23143b2388cacb36166766c235feb7c=0D
change-id: 20231208-ufs-reset-ensure-effect-before-delay-6e06899d5419=0D
=0D
Best regards,=0D
-- =0D
Andrew Halaney <ahalaney@redhat.com>=0D
=0D


