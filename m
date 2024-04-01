Return-Path: <linux-kernel+bounces-127109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150CE8946C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4679B1C21662
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEF055E73;
	Mon,  1 Apr 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLgkaOvc"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B754744;
	Mon,  1 Apr 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008447; cv=none; b=iXCwE3481b6mbj2qk6OgAr2nSEcQG8DcQL06Lh2JOGNRGhvlMw9AsLUfEv4kfUcCXASubE513gF7er5krDr3tKN0ZIobTbsgfv2Zcz2ydlWNv3/rKn+7Z/MbrhXX1DuhwcMnDjTo/cfdue4Tl5I4U2NYVPKvHDfojgOWrm+FjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008447; c=relaxed/simple;
	bh=Tby9SwNmyiiwFffC8TGSgy7B+o5zysI1sDIz1lHUBUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=U8ob47F6NRblBaFRuaVcPdKXyy1IEcvqVuxlYo/W5oH9v2RPo+mGNoB5dZAiI48Nlsxw1+EraMFR9MimHyydq9IMI7ddbUxR32M8dj60bqYVz7q108heblVnyjxLrIhKL2EnvSH1ysLAThqfbBxa+o22dwlvLM7jkibl38PhPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLgkaOvc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4156dfa8a75so5755625e9.1;
        Mon, 01 Apr 2024 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712008444; x=1712613244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7iUisfySJlUpllNR1rWEURtls5OEygug/FNDU7BTr2s=;
        b=PLgkaOvckSLZFhcbiTgZ+Rm+crQYhIIZjtdgwNhzJjVhhL9pNRNO5ux83PscgMDVkA
         Hake7xlFY/+LjAuS/HRygDX4oXjDIgPvYVjt8RcWBZ1nxzlHkuJvbHKa8DAud9waB/pL
         ZInm6bSqReIgbGkEee6dZBH1eeXK3oNXnZ/TgIIt4du3s6UKGbyFMsn3Hx8sUzWUxa/1
         W+tqwPNGXOtQYk6aJ+lnXdf9XCDe9Xk4cDT+kTSBS6KiA2hRax+phasepFG79SxnMNKH
         o3RVT7AqsZp+nEN3Ri+RMS2eEP4eD4sRK80v4S3UcdkTtK45IxXfNPKjwHFnv8l4+ypp
         vcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008444; x=1712613244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iUisfySJlUpllNR1rWEURtls5OEygug/FNDU7BTr2s=;
        b=OSpicp1fjbqM+LCQEVsrVZ7vYklq/cl23ourlJmedL8MBZT+yUshhYKWNXV1guJgV0
         oXpnFYvIwdoveH2vEIST0ww+iooQXXhNSApfcL+54wTCp1Z41ThWCYRrPN+/ulewwM1z
         rZT4yoQ0WWAxOh+kuBJ8PCR0uV7oi5qKPNqyhQ/zeu0yWKgcPIUp01e9WQwyi9m9XB+7
         /ocseaPyNGDQnXO7ugQgZ23cBIvgGhA5cnhV7E0/qT+u31fukimmCfyZm1XgiAKI1CtX
         SjRvyXIhU1+wMvd91GYSirD6B3rECRMeBQAmMMgZ2KBxum2iCRDdGJkKVUc+a0RsdzXa
         TuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVduxiKKB0WEspqdN3OtbQZ+87A5NdTwdcTjoTQMLaPraDrQCgVsaYucB/qNAzwd3/o/K3lGvB8GfrLchZjLI7IRxK76TW0CLMSbhxy5A00TeHgEFYCkwDsIPZLXMDXqm+wub1X5xWF9jrVUYA=
X-Gm-Message-State: AOJu0YwGV6BhSjcYIKWFxocMqw1O2R5RnMl38YYr2sbF3vOaudRoCEtd
	ufAoVo9BRA+fIyrgsDobtmf4w3XbRocZCsykigEmx2/t9ajJSljz
X-Google-Smtp-Source: AGHT+IHW+hjEDlhg1rFNI/CeLAEyX5Id3FTjduFBw8r0aS5TowLPLl1mAVPweSZ8nfwwdF13N0ZmPA==
X-Received: by 2002:a5d:648e:0:b0:33e:c528:c900 with SMTP id o14-20020a5d648e000000b0033ec528c900mr9509436wri.55.1712008443930;
        Mon, 01 Apr 2024 14:54:03 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id di6-20020a0560000ac600b00341c9956dc9sm12506046wrb.68.2024.04.01.14.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:54:03 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: brcm80211: Fix spelling mistake "ivalid" -> "invalid"
Date: Mon,  1 Apr 2024 22:54:02 +0100
Message-Id: <20240401215402.1348565-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in bphy_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index b99aa66dc5a9..5fe0e671ecb3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4549,7 +4549,7 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
 
 	if (!brcmf_valid_wpa_oui(&data[offset], is_rsn_ie)) {
 		err = -EINVAL;
-		bphy_err(drvr, "ivalid OUI\n");
+		bphy_err(drvr, "invalid OUI\n");
 		goto exit;
 	}
 	offset += TLV_OUI_LEN;
@@ -4588,7 +4588,7 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
 	for (i = 0; i < count; i++) {
 		if (!brcmf_valid_wpa_oui(&data[offset], is_rsn_ie)) {
 			err = -EINVAL;
-			bphy_err(drvr, "ivalid OUI\n");
+			bphy_err(drvr, "invalid OUI\n");
 			goto exit;
 		}
 		offset += TLV_OUI_LEN;
@@ -4622,7 +4622,7 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
 	for (i = 0; i < count; i++) {
 		if (!brcmf_valid_wpa_oui(&data[offset], is_rsn_ie)) {
 			err = -EINVAL;
-			bphy_err(drvr, "ivalid OUI\n");
+			bphy_err(drvr, "invalid OUI\n");
 			goto exit;
 		}
 		offset += TLV_OUI_LEN;
-- 
2.39.2


