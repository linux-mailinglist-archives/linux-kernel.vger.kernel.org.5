Return-Path: <linux-kernel+bounces-125412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863F88925A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41F91F22DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867FD13D608;
	Fri, 29 Mar 2024 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WS45LIxt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEAD13CC7B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745456; cv=none; b=gMi0BghKJPVMW/JkkwfWBIGhQzZ+otEw3LBjeyaCWeKUF3+mJeqp2OL1gah3h7PCe6IboDWoHGPW596X9iaI64kjPTeOVys0mAqIWnFjNGxT/1gVFQfo6ky+klnSPzuTUkPzLVmmrgo0p2VzTNrauiAszxem4dXBg/MSShJoFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745456; c=relaxed/simple;
	bh=BGXknjcLA50bcUKtFtKJCi5N6HFf284Wv0+1aI9g+Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFbyL3QNrR+Coh7weNGrIzyzR1cx1yeGKABNYo74kcDVCWx/hNMpapfC58crdTtwXaoMIW1iYEVuPk9CMreRAGEOn4q22w2SsynnkouMEs1bxYFvQhKTWNnpfhiM9/bfWmOsmOUZslnDUR8ujGvyOyBtkL09Foo6ilzDM5pSOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WS45LIxt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711745453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf4SOXbG4RAjshjCtScug3Y0ECaz5dSCoqxe3hdLj3E=;
	b=WS45LIxt+73ka+u0dMHEHh4mkYNp/ea28nhcF3tNO4Gxg2hzAWnVoa9CybQzRILzxTT2nQ
	CP/Oin2999sViZNSMZOQ5rnVwjc4XaU5fTNWVreWhapmtS//zg9K76FG0RBP/Rggb6z4CN
	9HLRvqfXf9eI9hRRzCS44LdCA1xHGbw=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-W7u7lTE0OAeI856p3qJq4A-1; Fri, 29 Mar 2024 16:50:51 -0400
X-MC-Unique: W7u7lTE0OAeI856p3qJq4A-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7e0388aa775so1162785241.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745448; x=1712350248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uf4SOXbG4RAjshjCtScug3Y0ECaz5dSCoqxe3hdLj3E=;
        b=Bfmo9bajJ1BvVsaGZI76LJ63wSGMCoQ41QtpmguvhKCnZSuVL112dhcmmy+C41JAWA
         DX/XpoLvZ7TwSBDgZ8lbW+FO/Aue+Zsxe/T5ufdGyAMUOgJxqIl6b1V/8gVa1kteXt/X
         YRJs0CrMHlTN3xOrgeJNL5sb71VxebM6VGgFTw5ItzOS9dbpVcBBKbzUNO8aa0+kWbml
         YaGs2kqNBppIjpvhEM6EvgyTSG3JEKn5SFpbkKZEPiCi9/LA9gBMH7zszZrh9jPe/QCS
         p7gdFqpn2VBximMdVel/4X6TlMvXOw+8Ngohag2378K9X7+LzSLxrurMQ8CQ6QaBrv12
         DADg==
X-Forwarded-Encrypted: i=1; AJvYcCV+KEovhkpiJIyua+VRIcJurgRvad7d8BrUc7Ek+B2RO04HK3puUOG62OE4AeAhsYJIOx9fpQrrz9oQRON9LMq4sCYrbe4l6wwTrIPT
X-Gm-Message-State: AOJu0YzdXOlskImcDw8LWB0e9z9iGKnBLeeEsGqCJfIa8r1t9pfXej/q
	oZjAEXlXWmnTfcUbPYws2lW/xrbDNOsz/v0eQ60kJdD8QLKkITjhXJSTbcd7pRFXLcHgJDBzvvV
	5ZuiBpG4vDnbU/+R43Au0gs2da4LA9Oj2q4WIKP8qiLlrSrFknGEfAtqP1m7bdg==
X-Received: by 2002:a05:6102:dd3:b0:476:fab9:237d with SMTP id e19-20020a0561020dd300b00476fab9237dmr3651552vst.2.1711745448242;
        Fri, 29 Mar 2024 13:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbJHgBjF3eN8i3ddN3z1R3cQ/XH02K5EBI2mtVmXktFIkJdXz1ZhnDrVZGUZxKmIZMOtcJjg==
X-Received: by 2002:a05:6102:dd3:b0:476:fab9:237d with SMTP id e19-20020a0561020dd300b00476fab9237dmr3651537vst.2.1711745447887;
        Fri, 29 Mar 2024 13:50:47 -0700 (PDT)
Received: from x1gen2nano.redhat.com ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id jz10-20020a0562140e6a00b00698f27c6460sm794271qvb.110.2024.03.29.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:50:44 -0700 (PDT)
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
Subject: [PATCH v5 11/11] scsi: ufs: core: Remove unnecessary wmb() prior
 to writing run/stop regs
Date: Fri, 29 Mar 2024 15:46:53 -0500
Message-ID: <20240329-ufs-reset-ensure-effect-before-delay-v5-11-181252004586@redhat.com>
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

Currently a wmb() is used to ensure that writes to the=0D
UTP_TASK_REQ_LIST_BASE* regs are completed prior to following writes to=0D
the run/stop registers.=0D
=0D
wmb() ensure that the write completes, but completion doesn't mean that=0D
it isn't stored in a buffer somewhere. The recommendation for=0D
ensuring the bits have taken effect on the device is to perform a read=0D
back to force it to make it all the way to the device. This is=0D
documented in device-io.rst and a talk by Will Deacon on this can=0D
be seen over here:=0D
=0D
    https://youtu.be/i6DayghhA8Q?si=3DMiyxB5cKJXSaoc01&t=3D1678=0D
=0D
But, none of that is necessary here. All of the writel()/readl()'s here=0D
are to the same endpoint, so they will be ordered. There's no subsequent=0D
delay() etc that requires it to have taken effect already, so no=0D
readback is necessary here.=0D
=0D
For that reason just drop the wmb() altogether.=0D
=0D
Fixes: 897efe628d7e ("scsi: ufs: add missing memory barriers")=0D
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>=0D
---=0D
 drivers/ufs/core/ufshcd.c | 6 ------=0D
 1 file changed, 6 deletions(-)=0D
=0D
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c=0D
index a2f2941450fd..cf6a24e550f0 100644=0D
--- a/drivers/ufs/core/ufshcd.c=0D
+++ b/drivers/ufs/core/ufshcd.c=0D
@@ -4769,12 +4769,6 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)=
=0D
 	ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),=0D
 			REG_UTP_TASK_REQ_LIST_BASE_H);=0D
 =0D
-	/*=0D
-	 * Make sure base address and interrupt setup are updated before=0D
-	 * enabling the run/stop registers below.=0D
-	 */=0D
-	wmb();=0D
-=0D
 	/*=0D
 	 * UCRDY, UTMRLDY and UTRLRDY bits must be 1=0D
 	 */=0D
=0D
-- =0D
2.44.0=0D
=0D


