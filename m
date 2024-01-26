Return-Path: <linux-kernel+bounces-40774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A270683E584
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516201F2501A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E945BADE;
	Fri, 26 Jan 2024 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="H2SQTERe"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2B5A7AF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308312; cv=none; b=UB4asTQHKFtjrox4DjSidgyTwjKR+3IAvJfqadfpI0hiUfeyCrYwlOI+EmtSmIpq/VJUSa9aF/IdTxMBS3IQPA16z9QfmI317GrhyTGx/cKtzCQseieA2OOjlC2PSJyZN9tAX2tpOCaaKipIgLRoZizPmfzX2i0PoW8qPbbGVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308312; c=relaxed/simple;
	bh=5DibKgE8ybBng9suKbGUN36Q9+2sX+fsaXEhIlRAuT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KosUgvOwIpcbhxMeRaALcLNhbwSDuG6jlSqANMUr8ECeDOC0pOZFe+oQ1TfoMCOkXpCPf/ugezN2StLtuZ6f2mXtGQg9E+v4bpF+4wPXxWvO1Z3C2RcfIquO09djoW8rVPOAa5YrPXU1IN2dxaztIi8vwsM7WpaNc5PQO0HxqgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=H2SQTERe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7858a469aso6666165ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308310; x=1706913110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WasKokmHV0ULTodbn6qktUa03Tamg95nLPR+rl0Wzos=;
        b=H2SQTEReGnCdNSwiRiLSOPfdzQmQh4i4nA5Kt0plcWeU5sNoveUrRz2X3nUYx3XpqW
         E2o4LJmXijhG3p7jdf3/yVaDs5vBM3TK5lorV0WjnxvDexqB2R1y9bsgvyfJr32Tvaq5
         RcIpoVxEWFdP+gygAzff4RDYND1UeLSOmJIMt7+0IUMfclC2w9+WzesxB/mMMP5xQRTc
         fdo6mPrZpAgiF+PPH+YH047LnXaWe9dQhcXKyEfEBsCkKXdgxS5ghPurXvS+mlJM8Pv6
         bfWwCDCEapOamBGtDSIp5J6/XCfvAT6hCxZ5hBNtSdzWa4xxM+XB8agZUDIbxn4GrHNR
         Q1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308310; x=1706913110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WasKokmHV0ULTodbn6qktUa03Tamg95nLPR+rl0Wzos=;
        b=khTTDH10ox0nO3gR7M8YQhsCppN6hlDe87RovkAguZWSETVfTHTSg0hJRdyS8gL2wj
         +1MvPdz2IGObfqEvdQ1EviU0B+SqAJTfHdyvBKclf0AdK+OlH2UiMDCjUboZeCIJUMI6
         jZYi771nZ56O42bef8XtgwYSGS0x2GcYTRXmP88EvP8TwWT6KuUPFZsPa1dzd2SpJb41
         Q1aSVdZgNK2Rmyv9+bCG0Jxp0yq0S0z11ZIoed8XlrHuvK6B96wlDajeLhQVkxJqWQPR
         7cnBOlWwO7VtiuuWREAtA2HO2cqWYx0+9cx2JgHVwAoBtkokJyAL+56PU3tgPlPbBv39
         1AEA==
X-Gm-Message-State: AOJu0Yzf/EuXmJCjFfNzVG7JBBtiPpDfoZ+EDmHAp/8xBU3gRWVicT7a
	w7CVZqeBrhSqztQ9cH8ew6DDdVYpstj/mOID8/RuxUuYnS6foWwB4ieuhsx0pYo=
X-Google-Smtp-Source: AGHT+IFLVF8aBWgITFkX88TnjFdYQ2TPyMUNFabtGOuvYDXx+xiMbQhI3OX3zMTB2z6U+N2C7F5BsA==
X-Received: by 2002:a17:90a:fb58:b0:28f:423f:1cfe with SMTP id iq24-20020a17090afb5800b0028f423f1cfemr541724pjb.18.1706308309861;
        Fri, 26 Jan 2024 14:31:49 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:49 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 15/18] Staging: rtl8192e: Rename variable Octet
Date: Fri, 26 Jan 2024 14:31:03 -0800
Message-Id: <20240126223106.986093-16-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable Octet to octet to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
 drivers/staging/rtl8192e/rtl819x_Qos.h    |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 50e01ca49a4c..dc991100742f 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -13,7 +13,7 @@ struct qos_tsinfo {
 };
 
 struct octet_string {
-	u8 *Octet;
+	u8 *octet;
 	u16 Length;
 };
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 5281138ad468..e47292455585 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -823,17 +823,17 @@ rtllib_association_req(struct rtllib_network *beacon,
 		struct octet_string osCcxAironetIE;
 
 		memset(CcxAironetBuf, 0, 30);
-		osCcxAironetIE.Octet = CcxAironetBuf;
+		osCcxAironetIE.octet = CcxAironetBuf;
 		osCcxAironetIE.Length = sizeof(CcxAironetBuf);
-		memcpy(osCcxAironetIE.Octet, AironetIeOui,
+		memcpy(osCcxAironetIE.octet, AironetIeOui,
 		       sizeof(AironetIeOui));
 
-		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |=
+		osCcxAironetIE.octet[IE_CISCO_FLAG_POSITION] |=
 					 (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
 		tag = skb_put(skb, ckip_ie_len);
 		*tag++ = MFIE_TYPE_AIRONET;
 		*tag++ = osCcxAironetIE.Length;
-		memcpy(tag, osCcxAironetIE.Octet, osCcxAironetIE.Length);
+		memcpy(tag, osCcxAironetIE.octet, osCcxAironetIE.Length);
 		tag += osCcxAironetIE.Length;
 	}
 
@@ -842,12 +842,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 			0x00};
 		struct octet_string osCcxRmCap;
 
-		osCcxRmCap.Octet = (u8 *)CcxRmCapBuf;
+		osCcxRmCap.octet = (u8 *)CcxRmCapBuf;
 		osCcxRmCap.Length = sizeof(CcxRmCapBuf);
 		tag = skb_put(skb, ccxrm_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
 		*tag++ = osCcxRmCap.Length;
-		memcpy(tag, osCcxRmCap.Octet, osCcxRmCap.Length);
+		memcpy(tag, osCcxRmCap.octet, osCcxRmCap.Length);
 		tag += osCcxRmCap.Length;
 	}
 
@@ -856,12 +856,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 		struct octet_string osCcxVerNum;
 
 		CcxVerNumBuf[4] = beacon->BssCcxVerNumber;
-		osCcxVerNum.Octet = CcxVerNumBuf;
+		osCcxVerNum.octet = CcxVerNumBuf;
 		osCcxVerNum.Length = sizeof(CcxVerNumBuf);
 		tag = skb_put(skb, cxvernum_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
 		*tag++ = osCcxVerNum.Length;
-		memcpy(tag, osCcxVerNum.Octet, osCcxVerNum.Length);
+		memcpy(tag, osCcxVerNum.octet, osCcxVerNum.Length);
 		tag += osCcxVerNum.Length;
 	}
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
-- 
2.39.2


