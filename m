Return-Path: <linux-kernel+bounces-125404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BE7892586
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D681C213D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A513CC5C;
	Fri, 29 Mar 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBz1ad5l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FC13C3C5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745339; cv=none; b=O9udCoABp4JvCiJ1VnC/u7A/qqhYbFdcb01YuoejUCMghujrMYvhOMn9hmps6A4xNiIz8hhXhDkpOaJLgmv7kdLzrVCLMwwd/spXk9Od1KXUreLF0nO3yexMupTYY1Km3KKt+7w6gv0mwKAfMqxLigmWp/g6N+56gw8uUFFsr84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745339; c=relaxed/simple;
	bh=M0HmSuHrJbtKk/I/nkhQeb6zl3F7XLvSgrHE9dAggrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOnXPc+v8MbFg+5ejUO5yQOHxUyO7PxjJ4AFmuVrTm2oZcKyj9qMlGapjcnW6jpKR766leofk/6fyJ8XDVkGhDJu4vvLOW9Z6eKFsoshH/FxoFoH2WgtcgkWdesBuZk9YtROJ56tEnVk7XUhPL+e7Tw0ehYgWNWUf0GzRdKcYLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBz1ad5l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0qQj3sTFTK+mhy/Yusmh65mAI4F/GLA2+G+J6DdmJA=;
	b=LBz1ad5lyULF7zvl6I6S+PDDw82ZgwR7kjC1abZCB8cV181OUyA6H2PiupYKrT5rJ0H4rX
	M1zNpZK06wuAV7H6sEpYYlCcAN9+05j44BA0nbHClF6Q6kIeO1I1nSu2Oku7zlFakzQKGO
	4N7jErwnSH83AM1avmVQrPQgb0MD6JQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-QhIizzE4N5Cq49yuAVSkTA-1; Fri, 29 Mar 2024 16:48:55 -0400
X-MC-Unique: QhIizzE4N5Cq49yuAVSkTA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69057317d23so32252076d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745334; x=1712350134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0qQj3sTFTK+mhy/Yusmh65mAI4F/GLA2+G+J6DdmJA=;
        b=hBsywfo9zzk7dVVFW4i5/zRWuFWMwbi1dJKlqrr/4ahtdYZhubJdtQjSVGHLYY/2L8
         NfEDW9vi3dR0Bm5NV5dzRNrG9KWv5mnkTD08hXxbTzasrTer9zb6nXp/lfeofUyfcdMu
         cMZ2tYYxjW7f3Rxb5zyus7Kzh+W+gIoZljEYxTi1aaBLwnGRY1F5oi1B8SP0nWB6DDmk
         ZpkFXoBCRURCBxZkJJ7p32PYFYiIr5Y0Sf/uvTJ4QDATL0qJ9tsTdZyQEinjc5AnCfir
         tZ7HTUflWzVKqxhidARknU0WUjKHvw2HiE7yIXQTf3rgbdT19edzdyVbAX0Wn23pkN2h
         HOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdQCVKqLqqmDegRsWfpFCvl5wEeOEJD410tDE90e7rj3T8N9nt6HGQwQktGhtY+Yc6gHO6YM2+VRrXhZg7XCu3E0UeBBNxe4DPDv1L
X-Gm-Message-State: AOJu0YyZS2PGSJxKsje4HDyx6XYloYJhWYwdp+u4kdRh2lSwMQNJbg4l
	CouHu/BvIRvCRTA7BCrKj4iusPU4WDvyJrggYAMUaNJm5A2mLRW+HnLUORZIVKK7AL50ydWbOKu
	Fc8oT9fV0lPRap3h+JiMqItQPHa0SlTEMWfdFBlriyT1Rw4Y/Fr2Ssa1wzgM2DQ==
X-Received: by 2002:a0c:efd3:0:b0:690:d4e9:fc5b with SMTP id a19-20020a0cefd3000000b00690d4e9fc5bmr3083309qvt.27.1711745334037;
        Fri, 29 Mar 2024 13:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGISpvmF8VgRSHeRST+j7omC+e+VDTZ18XcHvzjN+d0L1YGqF6uvIupDDiFZlzuG+tXsm4PSg==
X-Received: by 2002:a0c:efd3:0:b0:690:d4e9:fc5b with SMTP id a19-20020a0cefd3000000b00690d4e9fc5bmr3083293qvt.27.1711745333564;
        Fri, 29 Mar 2024 13:48:53 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:48:51 -0700 (PDT)
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
Subject: [PATCH v5 03/11] scsi: ufs: qcom: Remove unnecessary mb() after
 writing testbus config
Date: Fri, 29 Mar 2024 15:46:45 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-3-181252004586@redhat.com>
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

Currently, the testbus configuration is written and completed with an=0D
mb().=0D
=0D
mb() ensure that the write completes, but completion doesn't mean=0D
that it isn't stored in a buffer somewhere. The recommendation for=0D
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
Fixes: 9c46b8676271 ("scsi: ufs-qcom: dump additional testbus registers")=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/host/ufs-qcom.c | 5 -----=0D
 1 file changed, 5 deletions(-)=0D
=0D
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c=0D
index 804dc8153e7b..649fada24345 100644=0D
--- a/drivers/ufs/host/ufs-qcom.c=0D
+++ b/drivers/ufs/host/ufs-qcom.c=0D
@@ -1445,11 +1445,6 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *ho=
st)=0D
 		    (u32)host->testbus.select_minor << offset,=0D
 		    reg);=0D
 	ufs_qcom_enable_test_bus(host);=0D
-	/*=0D
-	 * Make sure the test bus configuration is=0D
-	 * committed before returning.=0D
-	 */=0D
-	mb();=0D
 =0D
 	return 0;=0D
 }=0D
=0D
-- =0D
2.44.0=0D
=0D


