Return-Path: <linux-kernel+bounces-82685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E885868846
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF1B7B25580
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFECF5338D;
	Tue, 27 Feb 2024 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="N2Z1aryn"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29152F72
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008927; cv=none; b=EjwfDEalMKgwviGaBj2gGemyKdUsiadmOBlA9Cq3OkQSwNHS3ZSPssEjn8oZqNWbrdHQNRlXt/itHwKg811WZroSpZAbaXm7SO0Iyn3BvtE/5ChY5iiZWA9yFU00y0g7cywCIfb4xpIJN5hMEZv2SNyGvfkgFh89R8XVDpDRBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008927; c=relaxed/simple;
	bh=dq3YV//7M2+aRXQXq2i4NiwbXhCDwSSqmDEdFPEI/LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/TPOnJNfGoYFklyyAzj78OVcCfMwl+TEz/1witVyeRUNBFT02LLywhbRJgZ7R3AUqltfA0JKnBtU9iNdH7ir8L96wqHTWwN/1q2UDkcmctTIC58P/H9XIUfy/DchyFHQd4HHmpeiNWg7iO3/zRsphlR2pu3twCTD75mmOoW9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=N2Z1aryn; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c19e1846ecso1121068b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008925; x=1709613725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSMAHR3ug17T4QZK2rA8IItpS46EcjEzSoVhVSetFZY=;
        b=N2Z1arynqt5yW/vgT9F2SpW2n+5viQCGZ3UjkmKkmHuHxJbN3lJ3RBPl2d0f6Fhc3w
         rlBOG4AyRO0LFRDX3KrX6JYAc2D0v8XLkNaBLf1qtaz0qzGnBwV6oQY1OjIck0+reiiu
         CJLPPNjZJBXjxOgFr7v9kmF7JGU7VNqzHl9Jy0poaZQfn6ZugI+2zYYccmTPc+BC0EVJ
         ZycHQyCgLLqDBazU8bHmIo9Eh1eQhW9rDVyx5hdq7j/tNNoJTNYcF5bunrxrfASqNOyp
         mW5kPTBFGAtJmPlHktAwQ9eaU7fVqFflf6nl7oRDrPLfyQez22UjM6EKZm1T/N9ObDop
         o2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008925; x=1709613725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSMAHR3ug17T4QZK2rA8IItpS46EcjEzSoVhVSetFZY=;
        b=bgPbgjV5CSgOlTgXkfKXCRQeF/vxeeG8Uj9lBJMBydGzJRcJ1ZhSRcpJp3zl9ggEXQ
         NNmW4auxxn36CV9CBP1PN9V+u+LWsSYh2sFP7Ra7SXCnTIIhRkHBG9HNdTEjqVAB+8VP
         HK34xvcwL77B6elxC3QmF+MP84Ey46SxI+4KkAxgM8/o1jQjbsPQ3hSfIDS8sVjvsEfY
         oAhm8Q7UBGXpxdQWN4iqvryelTgk/lwxF4zFOSCiujdDgS624Q8Ujg5M8DPG8916j7Hs
         Oe1B7dTCUj9cb1MQLT5K3fFNMdfO7c0I2LUeySQsTy/MgtySa1DyhMbGWEEceQ47d/Dh
         pTRw==
X-Forwarded-Encrypted: i=1; AJvYcCUfHPk64bHZMKvU/boCnLzL/vajDxydMq5nsA05+BPqvmmeGe6QN0ACxcJmgs51ZWxNf98a1O1wdGGIQHoAHufdoxCRjpvUBCry0cIj
X-Gm-Message-State: AOJu0YysZQpGIgyW8FBvxlK6ZrSmMOeOeKgIAbU6AhD8Ya/SJMO/wDu7
	4iosyEVEnTBY89zX/I1xlEqGY2kSbsMB8HDarqKs/eTLTqIWOR5ps5b32lIvL+c=
X-Google-Smtp-Source: AGHT+IEPZqrpTcBKp/rzy8jYhUX6fj4Cyb90cGQuZN0otY5MFd5Gte5RW9O9W/RZ2JfiIl2CCHcyDw==
X-Received: by 2002:aca:1c15:0:b0:3c1:836d:4def with SMTP id c21-20020aca1c15000000b003c1836d4defmr938380oic.26.1709008924870;
        Mon, 26 Feb 2024 20:42:04 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:04 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 03/20] Staging: rtl8192e: Rename function SecIsInPMKIDList()
Date: Mon, 26 Feb 2024 20:41:40 -0800
Message-Id: <20240227044157.407379-4-tdavies@darkphysics.net>
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

Rename function SecIsInPMKIDList to sec_is_in_pmkid_list to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 83f337e27209..607122ab4b00 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -664,7 +664,7 @@ static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 	return skb;
 }
 
-static inline int SecIsInPMKIDList(struct rtllib_device *ieee, u8 *bssid)
+static inline int sec_is_in_pmkid_list(struct rtllib_device *ieee, u8 *bssid)
 {
 	int i = 0;
 
@@ -747,7 +747,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (beacon->BssCcxVerNumber >= 2)
 		cxvernum_ie_len = 5 + 2;
 
-	pmk_cache_idx = SecIsInPMKIDList(ieee, ieee->current_network.bssid);
+	pmk_cache_idx = sec_is_in_pmkid_list(ieee, ieee->current_network.bssid);
 	if (pmk_cache_idx >= 0) {
 		wpa_ie_len += 18;
 		netdev_info(ieee->dev, "[PMK cache]: WPA2 IE length: %x\n",
-- 
2.39.2


