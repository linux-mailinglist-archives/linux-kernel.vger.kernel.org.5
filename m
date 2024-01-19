Return-Path: <linux-kernel+bounces-31506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA35832F40
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25EB1C2429D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54055644E;
	Fri, 19 Jan 2024 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejtkZp7L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CC54F87
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691122; cv=none; b=oKXCb+ZSqS+Ty0POHvMutmYYgIjqlDBDQyRxNlLH1LCG73X8f/ZsovC7FFr+34rWnAPr5J37oxCiPTRlTglgDGdT3V+IgYwXR1QoQH+9emsuZy2VTtCnpDIV+PIzaBjxPA6Q86+MGckuiCxA/TmE7jiC0ZCXpMBSXZEk6hGaWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691122; c=relaxed/simple;
	bh=i3mHQi3y8X+GXccdvNGpfS2jPcXaEZnke1U5uVd1P+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=JDzCkvP/0XdSXkKjD7POToZ+ozGsTTZb70mMV7SxjNbYiwLXt96w3KIZDMKmiQncqAodlmbNewGV9fYZ6bqaTR7RaYdGAJfes7wbAL5q+I6Rl7YaZUvPtEGHDbfPJrDiU37EK0++oCO7BWrCIEW2FAgNFcOsnJasWyleezmAkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejtkZp7L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705691119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h7dgBmNFNgtTu8p/Tt/5S3Mre4JNaLCa+imUc7DnV5Q=;
	b=ejtkZp7LSRCp4+bA3Hn/7M04SEIsY6kfef0mnYhXJ9dnMKyswNvRlyI6gVycoWOBYq/hnd
	w/nbC+ZL9scxAP70HKwgVMxAQowK9k3BFxcgFaYAjyJG1GcwFJcoi68tx4Ic27ntDkwx2b
	nWhIuw0GgQZTxmUB3FndvqkEl//OcNk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-pDQZMomTPJu0Bz9vNI3p3Q-1; Fri, 19 Jan 2024 14:05:18 -0500
X-MC-Unique: pDQZMomTPJu0Bz9vNI3p3Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7831aaa797aso202323085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705691117; x=1706295917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7dgBmNFNgtTu8p/Tt/5S3Mre4JNaLCa+imUc7DnV5Q=;
        b=hAjWZFPN8Hq5qChTCdLjapD6MUnpRbz18VKNHMftE7YNZbrBj+tDz7S2yemg8clowJ
         gDspZTgx7D6piiS41vgnqRZwAlfSW+VPHi+oTHNbO/GwxMTzRKZngDLIcQO70lbqJUiP
         SLqFZ9FzfgRr3NEr3ZgVZLYPyQ9oN2NNlZ4Fx5VSAlbMUSzXN7zP8zjIZRrTCTWLjMl9
         YmT2QyWQEAodJ5oaXl/F+yqfhGajqnGsELd08+WImVxW6PTk7VYoyqCcSjgj4N2/DIas
         iHdnoBB1uupeeBq+JTYzDKeNv3p3DM2ZfnA9aVrCpcIbbzNx/GR5J9g0OGRkywp40lpF
         7h4g==
X-Gm-Message-State: AOJu0Yxhnb9Lc2JVH+EK+TFMLlHdOkCPX1ilyp6+N+OJaGSpzk6uz+5O
	Y4f9sPJJU+pL0bOBIUggxDvt5hxBN82EjxZ63er+3U4caCgNj1aQKyuTO8BZNO9ZVq9MTIh/BAg
	hTXsrJyGtC+avYUra/AkZ38efYwY0sE/bR0TURjQFL512JuplxsK4XsjVU1jNfw==
X-Received: by 2002:a05:620a:1452:b0:781:b188:c7ec with SMTP id i18-20020a05620a145200b00781b188c7ecmr2179294qkl.74.1705691117379;
        Fri, 19 Jan 2024 11:05:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnitkklOlkAea0wuDu3imNg0amnLcKHcfVls7EZFUAy04xphx1lt2NiVY92r0IToCk2uRflw==
X-Received: by 2002:a05:620a:1452:b0:781:b188:c7ec with SMTP id i18-20020a05620a145200b00781b188c7ecmr2179278qkl.74.1705691117114;
        Fri, 19 Jan 2024 11:05:17 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm7912081qtb.65.2024.01.19.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 11:05:16 -0800 (PST)
From: Eric Chanudet <echanude@redhat.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Chanudet <echanude@redhat.com>
Subject: [PATCH] scsi: ufs: qcom: avoid re-init quirk when gears match
Date: Fri, 19 Jan 2024 13:55:47 -0500
Message-ID: <20240119185537.3091366-11-echanude@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

On sa8775p-ride, probing the hba will go through the
UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH path although the power info
are same during the second init.

If the host is at least v4, ufs_qcom_get_hs_gear() picked the highest
supported gear when setting the host_params. After the negotiation, if
the host and device are on the same gear, it is the highest gear
supported between the two. Skip the re-init to save some time.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---

"trace_event=ufs:ufshcd_init" reports the time spent where the re-init
quirk is performed. On sa8775p-ride:
Baseline:
  0.355879: ufshcd_init: 1d84000.ufs: took 103377 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
With this patch:
  0.297676: ufshcd_init: 1d84000.ufs: took 43553 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0

 drivers/ufs/host/ufs-qcom.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 39eef470f8fa..f9f161340e78 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -738,8 +738,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		 * the second init can program the optimal PHY settings. This allows one to start
 		 * the first init with either the minimum or the maximum support gear.
 		 */
-		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
+		if (hba->ufshcd_state == UFSHCD_STATE_RESET) {
+			if (host->hw_ver.major >= 0x4 &&
+			    host_params->hs_tx_gear == dev_req_params->gear_tx)
+				hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
 			host->phy_gear = dev_req_params->gear_tx;
+		}
 
 		/* enable the device ref clock before changing to HS mode */
 		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
-- 
2.43.0


