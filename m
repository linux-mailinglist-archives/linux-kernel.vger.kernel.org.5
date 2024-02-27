Return-Path: <linux-kernel+bounces-82690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7E86884B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA611C221B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697854BF6;
	Tue, 27 Feb 2024 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Wa74ECTQ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36154746
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008932; cv=none; b=rhRERs49Zpbna1JUbd15TgHF8WKMecICMh/pd071C2gnBqEFc+ChDLxDof8M5CVyjLjcJgTkYRcQ3rRxXzipz7e4GK+m0jiFrKNPpiAM+hhAhgmaiB+EYaW/2MlxopP0cbOx1S8x9Tm5z46eNmicoGeIIaJoMMSQoZjGALDzZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008932; c=relaxed/simple;
	bh=NgTkCr0gehBgV1KCivs1oDK2kOFW7oHrFLKDK+Ht7tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZEXyfOh3UccnGpRtQrVuswy2KAZK1lvxNp+AQ3jGq9x3NaxhJ06T0GfbEFP5mRTutX+/86iG6SuK6TuK2C8B8hEADPFTQB2ousB0Iwacm8P5f50lS+iNImm5ygGte5bdg6+37mdnlQaaxbaMRS6fBARlv5UF2uZh6LGNVOKtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Wa74ECTQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e45d0c9676so2309983b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008930; x=1709613730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OTz9b34bEXHsUaswBLFVAyQKLcaocJ+qtGhmHq+b+c=;
        b=Wa74ECTQ8+VQKeGxpXty0+dC+Ajh6F+F3uBjcX6ZTMieqCuTziLULYePTDPJTm3kwr
         R8IesraEdsEWPGRxcGIwE4ObSB2EDOvuMNwdpQ1EYbaSAcXARO9Vvj1SXPjGuZPLs25f
         4bWX25pxhKwpEO2tvkxtsHWkl7n0K39XBm2fMV9mvxSUGzr4EACqTCpM8uwGL5banh1H
         6ToJua9EDHYitoPBAOEJW5KVKtmj6CwAmwBSOJ6V9PVtEeDDIlwgw/r7zIhJXAjAsmhT
         dBnvlY96lfHWSAbCLyTwQKjIedXmCR6LyWEfNN4srd4MUzy6yBcSTYFbMOhjGKE7wTDs
         Rg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008930; x=1709613730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OTz9b34bEXHsUaswBLFVAyQKLcaocJ+qtGhmHq+b+c=;
        b=IbWyxYNCVUGjBiNXHiVN8j8qC3opaIrhuWtB2BCzF72QlL2bo3U737JqaJNo1ktPgM
         Nv82gq06cGlq0h3ucyeJZ4kGXrgbM0Ht/yfPKsrKj6cskLeeVoCFj3b6TnE+0HjrH4bY
         x+0awwhkwubWXBfjJp0e7UkgiDHR/PGctutD6nn8cdHL8dAbSOz3n0PTp6KljrMAyCgp
         8rdnh6maJ26HC41CPUQeQYCdvmNe0g6tXtjIFvZRzqLKVjq0JLrwG4OlT52emHCX4AvN
         vI4gV7QatA2Ci7eaQUo8YtwJ7Pl98joHOGOhzpI37AgPXbnk7bj1vWryeOJ18Syr5nTh
         wbVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWKhQUPRiuupBE62iXXyR7z4Y9r9fOQUTxldt3/hKEKYPe37WQTmECFClQEONvyOJM+2+NJIajNJEuy69fZu+jOkUS9RrTRolnEsX0
X-Gm-Message-State: AOJu0Yzb7BQv4BOpWsfW5/X0lkQX/DAjitjncrZ/SloRQrwEizKDnxju
	EhDIEANIGKPNn+VwqzDdvxXGHkFPgjBUx3zfeCPOKT+l5tYFPB/ws5AMNN4FTek=
X-Google-Smtp-Source: AGHT+IFdTmBeovwypIs0SfBKmu3Z6v4WmoeSKrxw9xCqvJg/OV6k/8Is0ws44olSC4graimBO5WmzQ==
X-Received: by 2002:a05:6a21:998f:b0:1a1:e4c:2ff8 with SMTP id ve15-20020a056a21998f00b001a10e4c2ff8mr1089510pzb.12.1709008930323;
        Mon, 26 Feb 2024 20:42:10 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:10 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 08/20] Staging: rtl8192e: Rename variable bCcxRmEnable
Date: Mon, 26 Feb 2024 20:41:45 -0800
Message-Id: <20240227044157.407379-9-tdavies@darkphysics.net>
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

Rename variable bCcxRmEnable to ccx_rm_enable to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 8 ++++----
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6cab19b03f4f..9ec4a3b8ae3c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -929,7 +929,7 @@ struct rtllib_network {
 
 	bool	bWithAironetIE;
 	bool	ckip_supported;
-	bool	bCcxRmEnable;
+	bool	ccx_rm_enable;
 	u8	CcxRmState[2];
 	bool	bMBssidValid;
 	u8	MBssidMask;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index cdb7e87c0c89..103117692a88 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1818,9 +1818,9 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 		if (info_element->len == 6) {
 			memcpy(network->CcxRmState, &info_element->data[4], 2);
 			if (network->CcxRmState[0] != 0)
-				network->bCcxRmEnable = true;
+				network->ccx_rm_enable = true;
 			else
-				network->bCcxRmEnable = false;
+				network->ccx_rm_enable = false;
 			network->MBssidMask = network->CcxRmState[1] & 0x07;
 			if (network->MBssidMask != 0) {
 				network->bMBssidValid = true;
@@ -1833,7 +1833,7 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 				network->bMBssidValid = false;
 			}
 		} else {
-			network->bCcxRmEnable = false;
+			network->ccx_rm_enable = false;
 		}
 	}
 	if (info_element->len > 4  &&
@@ -2351,7 +2351,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->bWithAironetIE = src->bWithAironetIE;
 	dst->ckip_supported = src->ckip_supported;
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
-	dst->bCcxRmEnable = src->bCcxRmEnable;
+	dst->ccx_rm_enable = src->ccx_rm_enable;
 	dst->MBssidMask = src->MBssidMask;
 	dst->bMBssidValid = src->bMBssidValid;
 	memcpy(dst->MBssid, src->MBssid, 6);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 0915f4f8761f..f5e0741af047 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -742,7 +742,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	if (beacon->ckip_supported)
 		ckip_ie_len = 30 + 2;
-	if (beacon->bCcxRmEnable)
+	if (beacon->ccx_rm_enable)
 		ccxrm_ie_len = 6 + 2;
 	if (beacon->BssCcxVerNumber >= 2)
 		cxvernum_ie_len = 5 + 2;
@@ -837,7 +837,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		tag += osCcxAironetIE.Length;
 	}
 
-	if (beacon->bCcxRmEnable) {
+	if (beacon->ccx_rm_enable) {
 		static const u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01,
 			0x00};
 		struct octet_string os_ccx_rm_cap;
-- 
2.39.2


