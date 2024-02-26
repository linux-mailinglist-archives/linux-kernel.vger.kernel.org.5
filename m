Return-Path: <linux-kernel+bounces-80489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D28668E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED912821D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032A1C6BF;
	Mon, 26 Feb 2024 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="hdPovzsl"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908A01BDE2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919796; cv=none; b=qAbD2yN5FZmPN6DCX6mrXLoZkAUOXvzdchwHv2a1IOZ+/QTAxEaO2ZWgem+x7bIx1rhy4uJt+v4g0fde69bPsnal5i0oTullSRi84Pe/HbpX1UHH7bVoRr+dXYPBUllG58XdIAkuAijQm2CHU/wgZMWvxLHTbTAmdjOTvpNdQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919796; c=relaxed/simple;
	bh=tvCd1JZbDcbdK3kn4usK7ETaBJvFw9gj/XdlgVRJmic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpgpJcA7UHVQZqpV2XuUlwLE0aYyaXonCGoQ4CkjGpi1VGsC43gVwJINYFvASEo9EdrBGcRsDSlNFh6hX7mKHBfoOQShjs2nuCKZJHbxWDa1qDv6W5GSTGCXxQPtjApD4+gMFm9ryoO0CChPUCo8bU8Iqr8UN3GbpctdgtUqjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=hdPovzsl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d93edfa76dso22503435ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919794; x=1709524594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BD0k6CXlE1uoUebpY42xLDy9lNO1Gq7kA5Vc0ymnQ0=;
        b=hdPovzsl+Q7qAce4SJQOi/ajTiLIMFpZdXU1a0KdcNMb31vv266E2MsxY4dKM8aykS
         smrTKvR4Yh6+MMkRgg5LQmqrP8PnuInozOainwcFRbR75yxA5+X113YtY5OVjscsKpeX
         pkMMM/stuNSyfXa8X5HqFb4DvLUkq54NVp3jiVbq3t4s9i8GxnzbdwXzIcXNbWFJ9b9V
         bXRvu0cCqW7LkOgdrfEGa74+Y4iUZcTH2ZLRbIxv4sF0k55zeYFxx5MvfHZgqRkE4Zk7
         dbzv8Cpi1/UNdrlVZqmWJj1aG3TQR1Gtmj44a3m3AseKkL9UBjnxio6ovcrh6L1hHcJu
         l1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919794; x=1709524594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BD0k6CXlE1uoUebpY42xLDy9lNO1Gq7kA5Vc0ymnQ0=;
        b=Q8VxTGollbsiJm24q2bIYnBuAqNj7f+N5hRNUyt3+FpXErCfsxxd0B1O1YUjG2Utsm
         8a5p+GGzicoX+6n/aKuT3HHSE2YJRtg5RaTNhASpeKeFgtyby2e34RlPzo9lb7QS89pD
         MO72aq/WqRVSn+YCc2Dh1AQQmaas02oC22504aK6URoAN/zVN9GF5puoaMA0nxa/PjC1
         3d0P4To76QptZ9FIX9fvS65I8KZLELhja+xNez+PnH3ywg8DBUNP10R/614y0kOuWiLd
         qq1Lo1QPQdlPzkNWZNXaZZI7BQVqdJRF/+2QRa7UVK8sr/7TZFTbgVXF2aLlo3a2wDGY
         c2uA==
X-Forwarded-Encrypted: i=1; AJvYcCWSM1oUcdGHu98CtI1mNWQC0IqWLuWzhcGw5KaSVcMvPzyAvOTBWeFvuN6pPgtI71zs8QXeASTM/+eRhO0AaLFci3yjrK3UozQvfhkG
X-Gm-Message-State: AOJu0YxyGdvdKqvEBEjL8OFvA8F8j07fpzWgkieNC12ntNSXUQjzSxVU
	n+Uz1ndWL84vP7DS2DdLDNr1VkDphLC2cvJEk6B5m6ngXYm4pwt5GJhjenXgt+a/6Qn294tIwxO
	j
X-Google-Smtp-Source: AGHT+IFfmXluDCSnkzzStA4PWMC531WtouMTNhGivXaIBwHrHdEwzGEOO2m9A/r84P6yjsHUwIBk9w==
X-Received: by 2002:a17:902:cec3:b0:1dc:90c0:1e9a with SMTP id d3-20020a170902cec300b001dc90c01e9amr4544170plg.64.1708919794062;
        Sun, 25 Feb 2024 19:56:34 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:33 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/20] Staging: rtl8192e: Rename variable bCkipSupported
Date: Sun, 25 Feb 2024 19:56:11 -0800
Message-Id: <20240226035624.370443-8-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035624.370443-1-tdavies@darkphysics.net>
References: <20240226035624.370443-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bCkipSupported to ckip_supported to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 8 ++++----
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ea08ac058421..6cab19b03f4f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -928,7 +928,7 @@ struct rtllib_network {
 	struct rtllib_qos_data qos_data;
 
 	bool	bWithAironetIE;
-	bool	bCkipSupported;
+	bool	ckip_supported;
 	bool	bCcxRmEnable;
 	u8	CcxRmState[2];
 	bool	bMBssidValid;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 63e3b655e4ee..cdb7e87c0c89 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2099,12 +2099,12 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 				     & SUPPORT_CKIP_MIC) ||
 				     (info_element->data[IE_CISCO_FLAG_POSITION]
 				     & SUPPORT_CKIP_PK))
-					network->bCkipSupported = true;
+					network->ckip_supported = true;
 				else
-					network->bCkipSupported = false;
+					network->ckip_supported = false;
 			} else {
 				network->bWithAironetIE = false;
-				network->bCkipSupported = false;
+				network->ckip_supported = false;
 			}
 			break;
 		case MFIE_TYPE_QOS_PARAMETER:
@@ -2349,7 +2349,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	memcpy(dst->CountryIeBuf, src->CountryIeBuf, src->CountryIeLen);
 
 	dst->bWithAironetIE = src->bWithAironetIE;
-	dst->bCkipSupported = src->bCkipSupported;
+	dst->ckip_supported = src->ckip_supported;
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
 	dst->bCcxRmEnable = src->bCcxRmEnable;
 	dst->MBssidMask = src->MBssidMask;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index fd4bf3486804..d3837fa2c859 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -740,7 +740,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		}
 	}
 
-	if (beacon->bCkipSupported)
+	if (beacon->ckip_supported)
 		ckip_ie_len = 30 + 2;
 	if (beacon->bCcxRmEnable)
 		ccxrm_ie_len = 6 + 2;
@@ -817,7 +817,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 			*tag++ = beacon->rates_ex[i];
 	}
 
-	if (beacon->bCkipSupported) {
+	if (beacon->ckip_supported) {
 		static const u8 AironetIeOui[] = {0x00, 0x01, 0x66};
 		u8	CcxAironetBuf[30];
 		struct octet_string osCcxAironetIE;
-- 
2.39.2


