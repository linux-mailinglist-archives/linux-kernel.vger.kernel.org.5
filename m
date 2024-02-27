Return-Path: <linux-kernel+bounces-82696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533E8868851
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67831F24890
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825F256744;
	Tue, 27 Feb 2024 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="KaZAm1FI"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C755E7C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008939; cv=none; b=cp8sbPwEuWx+w6yPWRHol/tL2irfrT+ceRxDFKg2SVaYyxmD+FbwXLTDdjXaRD0IzgGgASdDQKndfIul6dZLj0fpfzsqhu7M4/BjKDKYuorQ1le3Op8Py7Hcx5HpfVOkKfOiT/tzCo52QYPgwPnpB5r2PBEr3OjdfvFJC1M0HTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008939; c=relaxed/simple;
	bh=ak1O2XJwLf5BBXHTtTbxtVHaxjNEPoaM3k57V/izBQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gIh/eP6f3pjMybHkPXtV3U8oKX6cZ7bbY/pDRfL5nDyo5C6xJJV+MFhFGOhJ3c08vW4XtUGMhdOv6lkLB3MgV2EUCL59lfRkYpnh23UgK5ItNHCJt6Rgm+olmy0bmRksX31XiSFrKpBTMH6JWAYWEESjF9cdakRqU7nL0z8+950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=KaZAm1FI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e54d7b1167so9400b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008938; x=1709613738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhwwpNY1OM+oagk6uyLW9/cNGsoVYhE5v5CNamwRzRs=;
        b=KaZAm1FIFm5ZHEVQ2Nt9yidvsqpVhdA48p+/HsoEj70mYKN1/tKm9qNWB5h65uZpxQ
         SZYWBjYlgJYXaxxCzg4u9SkVd2NdsPp82uxGAF6IgRPGm6L0RJfeLIFBtcdSUvXBrcy3
         lUIHw4uBaD5jdqk+SqBHm2n4FLotLfdre6Z06GZr0c0Edso6a1c9Fhq3J/rByJWd2znm
         QvMSkCilfw2R6XAHaB5K77L7Awat2sYYwm0EZKQqNteEnUKEpV7oL6FCL3lDKfsBldnR
         mO2jWolMKpJh63id8Rwj2sselA5l7uR3Bc5DU7q3qVqiQ+UsEF6ZyhJVsG3IIRrsEJXz
         c0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008938; x=1709613738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhwwpNY1OM+oagk6uyLW9/cNGsoVYhE5v5CNamwRzRs=;
        b=Iaw+woid8ZLDp0XF5q1EfZMlrTe497u/jbshNrz8xtjnTCakv8EJrTB/Ea0CPy8bt7
         IhZ5f+9YNHjE/vQYxEYOE2LBZo4CHuKpn7gBkNtg/zMtLxol1T+4yzaMJ5wZSdqz+i7/
         XWSzBetEeKPH1AJBM2PaBwkCteW3FjhDOJKY+RhKzFPU+PepLF2r+wp0uSARWCPHqGc6
         iN2vtVHKND06bv9vAOFhq4UfrnMuOloTNBWtGArijho08ZN4jlKFlRSXaPsoL8zBFoxz
         hGl2tW32LQl/5i3OleKlv6wtwR3PiLBwmgf172Cfi6DnSo4I+WKT5yK8XxZAIkQLM4AX
         /b0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRCvNcBaRB9xYSu8BGWSJgco97T9JIkmMlm19g2nCfmtAgzPdjNnK6JcrKNNyR9UQyQM8X3p7jEVAdMbGJR9bnZ+O1x9LRgvCsu1f1
X-Gm-Message-State: AOJu0YyxAH3190eZ/bbJaW5Bzm8his+fneujivvywwmF5xCW9chjNCx1
	15I04nOasGdp9WYqyVtaujRv2+1SaGd12fKwJOzkVwND7QlNvlYK2no5uk9aC4o=
X-Google-Smtp-Source: AGHT+IF1B0X4m/Wi+vJoVTyzQJxzm3lC/s4MvESqAgztzRsvZSem8tW3W+NVFNF80zWECRN4+mycwg==
X-Received: by 2002:a05:6a20:d903:b0:1a0:fea5:ae58 with SMTP id jd3-20020a056a20d90300b001a0fea5ae58mr1513046pzb.8.1709008937738;
        Mon, 26 Feb 2024 20:42:17 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:16 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 14/20] Staging: rtl8192e: Rename variable osCcxAironetIE
Date: Mon, 26 Feb 2024 20:41:51 -0800
Message-Id: <20240227044157.407379-15-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable osCcxAironetIE to os_ccx_aironet_ie to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Fix 75 char line limit checkpatch warning
 drivers/staging/rtl8192e/rtllib_softmac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index da8be4383d69..0907bee45dbf 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -820,21 +820,21 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (beacon->ckip_supported) {
 		static const u8 aironet_ie_oui[] = {0x00, 0x01, 0x66};
 		u8	CcxAironetBuf[30];
-		struct octet_string osCcxAironetIE;
+		struct octet_string os_ccx_aironet_ie;
 
 		memset(CcxAironetBuf, 0, 30);
-		osCcxAironetIE.octet = CcxAironetBuf;
-		osCcxAironetIE.Length = sizeof(CcxAironetBuf);
-		memcpy(osCcxAironetIE.octet, aironet_ie_oui,
+		os_ccx_aironet_ie.octet = CcxAironetBuf;
+		os_ccx_aironet_ie.Length = sizeof(CcxAironetBuf);
+		memcpy(os_ccx_aironet_ie.octet, aironet_ie_oui,
 		       sizeof(aironet_ie_oui));
 
-		osCcxAironetIE.octet[IE_CISCO_FLAG_POSITION] |=
+		os_ccx_aironet_ie.octet[IE_CISCO_FLAG_POSITION] |=
 					 (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
 		tag = skb_put(skb, ckip_ie_len);
 		*tag++ = MFIE_TYPE_AIRONET;
-		*tag++ = osCcxAironetIE.Length;
-		memcpy(tag, osCcxAironetIE.octet, osCcxAironetIE.Length);
-		tag += osCcxAironetIE.Length;
+		*tag++ = os_ccx_aironet_ie.Length;
+		memcpy(tag, os_ccx_aironet_ie.octet, os_ccx_aironet_ie.Length);
+		tag += os_ccx_aironet_ie.Length;
 	}
 
 	if (beacon->ccx_rm_enable) {
-- 
2.39.2


