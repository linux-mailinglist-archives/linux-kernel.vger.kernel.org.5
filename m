Return-Path: <linux-kernel+bounces-35988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CBC83999A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAF028A4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679182D71;
	Tue, 23 Jan 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/VUt7kK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF1823B6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038513; cv=none; b=p1X68WRIkO86A0AhB0hASqxvVOTb5QqQW4p7r8pYegrfd1i3xms8NnUSvxU23xVa4BfE1XdzvjM+nhMAJaIajp2zTH3l9sbcmQudJ1OZLfX0wtJ//CwtC/V0J6iYGzQdOFrnIs/gTu3h6WSBBagyYhDSDoesWPHy6ByiZR16fHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038513; c=relaxed/simple;
	bh=1ufWa9+DhMazuCg6k/kGAKu9JKJdvlAyAGQCtBYJHHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=I2gYX4FmQNrxLr+yW0iDHPjA2NDuIuldOwwScnu/umhcaX3Jh4jMGweu//RlXLv5t9NtYqlACpM9zqMgRtmB3RowtLh65JkCTz2D1eGPven89/FOXP1/RU+MzP0K6WJ1VFY2srPnujuyGWkZWXuCzSOdLYh52MA1ZXGCFg4OEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/VUt7kK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706038511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H24shksCDeTPX45yEa+ObHdQIbM519gVV0wB9Kkfn3A=;
	b=H/VUt7kKrQdD05IrnzBBxJaidtpJxaW+y9PonKSCUv98q0scxqhJ8PVFbpQAEoqPqlBgOq
	mcmxG5omMASi28DHSXb6gaRrzNLAi7q8+1DkUjfpHCfp3ANhA+r5u0eE19hcyThy55QJ/W
	AvE6BmUqGaMyWokoPZ8kga6BC+euG5M=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-fMMcQW2sOlG1TDSXdXPL0A-1; Tue, 23 Jan 2024 14:35:07 -0500
X-MC-Unique: fMMcQW2sOlG1TDSXdXPL0A-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6de423c4a27so5314506a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706038506; x=1706643306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H24shksCDeTPX45yEa+ObHdQIbM519gVV0wB9Kkfn3A=;
        b=WgPuPhAZa4qrPyEJY9RQpOsO7ZomgZjIOVH2EfT0RVxsJnlbV8WHM0kkdSZsmr7Lzf
         r+GGshZiHXtis5Zte7I2btfHNmlKTCVektyo2n8XCVeWKCw0fAKTT/kox5UAdPTNmsMd
         0QwHfxVS4S+eZknildgSmP1yqga69GErVIdATj3SACaLvRpbnhP1NSGyb2VbQiQzsDHK
         2xRR/JmhsZvIuPV5jnqGEF1dbIaZYWLppTrKcziys6UF+ojDSKBbeJw605oIEOShXO9E
         i3U7N0FMCTNf+vwZrdHrjwdfXUfcew30+38l7rkS3FXmZQ4jK9AVOC5Dsx/4eKdzzETS
         g2ew==
X-Gm-Message-State: AOJu0YzCSY2OSXJ1kREi7b2jRmubmKG/EtTXUfDCd8g9Q18NlWJMzHNp
	9/MfWcXIXzWS4cIRlDIpjqv+BHMNBCv7ZgEH3qWQsavq666nHJfvYW7K55DnMbC1xsGUAAlmPPo
	IuVCvvdFo24rKCr24S1Mljeb0Ec+ymqgQVusmAs4vS1Y4+mxFI/Ra0O4AT110Ag==
X-Received: by 2002:a05:6358:27a8:b0:175:49f7:952f with SMTP id l40-20020a05635827a800b0017549f7952fmr4343839rwb.63.1706038506663;
        Tue, 23 Jan 2024 11:35:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG55nVARfi6rbNbtYFtYEGGYgAOCYX6yFXx3Hm30MskjrUGrGE8LCEbfcX1uBv7zLrzCl5LcQ==
X-Received: by 2002:a05:6358:27a8:b0:175:49f7:952f with SMTP id l40-20020a05635827a800b0017549f7952fmr4343833rwb.63.1706038506364;
        Tue, 23 Jan 2024 11:35:06 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id or9-20020a056214468900b00686a4f9312bsm656719qvb.50.2024.01.23.11.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:35:05 -0800 (PST)
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
Subject: [PATCH v2] scsi: ufs: qcom: avoid re-init quirk when gears match
Date: Tue, 23 Jan 2024 14:28:57 -0500
Message-ID: <20240123192854.1724905-4-echanude@redhat.com>
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

The REINIT quirk only applies starting with controller v4. For these,
ufs_qcom_get_hs_gear() reads the highest supported gear when setting the
host_params. After the negotiation, if the host and device are on the
same gear, it is the highest gear supported between the two. Skip REINIT
to save some time.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---

v1 -> v2:
* drop test against host->hw_ver.major >= 4 and amend description as a
  result (Andrew/Mani)
* add comment, test device gear against host->phy_gear and reset
  host->phy_gear only if necessary (Mani)
* Link to v1: https://lore.kernel.org/linux-arm-msm/20240119185537.3091366-11-echanude@redhat.com/

trace_event=ufs:ufshcd_init reports the time spent in ufshcd_probe_hba
where the re-init quirk is performed:
Currently:
0.355879: ufshcd_init: 1d84000.ufs: took 103377 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
With this patch:
0.297676: ufshcd_init: 1d84000.ufs: took 43553 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0

 drivers/ufs/host/ufs-qcom.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 39eef470f8fa..f7dba7236c6e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -738,8 +738,17 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		 * the second init can program the optimal PHY settings. This allows one to start
 		 * the first init with either the minimum or the maximum support gear.
 		 */
-		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
-			host->phy_gear = dev_req_params->gear_tx;
+		if (hba->ufshcd_state == UFSHCD_STATE_RESET) {
+			/*
+			 * Skip REINIT if the negotiated gear matches with the
+			 * initial phy_gear. Otherwise, update the phy_gear to
+			 * program the optimal gear setting during REINIT.
+			 */
+			if (host->phy_gear == dev_req_params->gear_tx)
+				hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
+			else
+				host->phy_gear = dev_req_params->gear_tx;
+		}
 
 		/* enable the device ref clock before changing to HS mode */
 		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
-- 
2.43.0


