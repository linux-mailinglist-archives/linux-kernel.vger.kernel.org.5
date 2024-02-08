Return-Path: <linux-kernel+bounces-57651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C782084DBCD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AED1C24BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9E71B2A;
	Thu,  8 Feb 2024 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj59yN2b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E76F50B;
	Thu,  8 Feb 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381930; cv=none; b=pRNvSYdpR6WtHe0ixlMojdHwOLJw2ek08pdHY5Gh/THdpAHUK0RktIrMgFf4ETHlQvyCHYMf0eYDQwP6ccsLhYhAPHOVHcO47NPJcyVbhzRRdxCO/7xqPIvqELZ0TfzyOcYK1d/Z+m7/6g0mXEg1AsCfNK9zopYMVjv7taI6kRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381930; c=relaxed/simple;
	bh=POI6uCurjz7K0SS0gUH7C3Dj3W11IBfcHS/B+rMzmkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzKDprN1HdM+KjIMnES3wfAaXrhCWSlkBmRcPwwVZw9/u8IcUpH6K1vPXoVcp7QdC+67ffTUJJJoqHccse8M3njbSqeJCH8e+DF5U2RsRHSwnl5KNwOH7OQycsLSUV43WqbMp/tD/LGNY5ReMtcRSS2D43o0Hjd4mg/NbVmXItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj59yN2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D6BC43390;
	Thu,  8 Feb 2024 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381930;
	bh=POI6uCurjz7K0SS0gUH7C3Dj3W11IBfcHS/B+rMzmkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oj59yN2bU3sJBgizsn6x4fu41c/QIs6ntSTGN6Z6dvCS6XlPGrpVhwSHlXNhm9jYA
	 BBwC+V2MHkoX+xdCMOcKeEIgSyivDMoGE33cZyG8h5dsmw80W5L7ddNrgWnq+JOGOY
	 hVto3EU37cOv/sJvJH7tQRWIIqxk9tMHVc0myon3u/a8NBRPOaPeZVHf3dGTA/3YYl
	 RzeI1rmPJ/BZHLFQx9+ctK99WAV7ebDzgMq9h7lQULRsUzX6IvJzq3SpsaZ8uOUMzL
	 TkZe+CbIPCDJmesRHbtfmWSdsLeR2vbt0ClkeMbRGCnu0VDW4/w3fLJIgkg53EXybs
	 pXeitHIQV0JkQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 05/10] scsi: aacraid: linit: Replace snprintf() with the safer scnprintf() variant
Date: Thu,  8 Feb 2024 08:44:17 +0000
Message-ID: <20240208084512.3803250-6-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
References: <20240208084512.3803250-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).  So let's
do that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/aacraid/linit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 69526e2bd2e78..0e47d9c4cff23 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -583,7 +583,7 @@ static ssize_t aac_show_unique_id(struct device *dev,
 	if (sdev_channel(sdev) == CONTAINER_CHANNEL)
 		memcpy(sn, aac->fsa_dev[sdev_id(sdev)].identifier, sizeof(sn));
 
-	return snprintf(buf, 16 * 2 + 2,
+	return scnprintf(buf, 16 * 2 + 2,
 		"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X\n",
 		sn[0], sn[1], sn[2], sn[3],
 		sn[4], sn[5], sn[6], sn[7],
@@ -1302,13 +1302,13 @@ static ssize_t aac_show_serial_number(struct device *device,
 	int len = 0;
 
 	if (le32_to_cpu(dev->adapter_info.serial[0]) != 0xBAD0)
-		len = snprintf(buf, 16, "%06X\n",
+		len = scnprintf(buf, 16, "%06X\n",
 		  le32_to_cpu(dev->adapter_info.serial[0]));
 	if (len &&
 	  !memcmp(&dev->supplement_adapter_info.mfg_pcba_serial_no[
 	    sizeof(dev->supplement_adapter_info.mfg_pcba_serial_no)-len],
 	  buf, len-1))
-		len = snprintf(buf, 16, "%.*s\n",
+		len = scnprintf(buf, 16, "%.*s\n",
 		  (int)sizeof(dev->supplement_adapter_info.mfg_pcba_serial_no),
 		  dev->supplement_adapter_info.mfg_pcba_serial_no);
 
-- 
2.43.0.594.gd9cf4e227d-goog


