Return-Path: <linux-kernel+bounces-82688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D909B868849
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7BDB2562E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5485751C5B;
	Tue, 27 Feb 2024 04:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="ScJzuIBc"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB1537E0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008930; cv=none; b=ZUk3QnikcYjREWJsxuq4QiiaLcFZW8aN7phGvo8gOhyFmvyPFBAgQFHj7Dw5/QPq195tvPXHVnDH3mWwMQaN9O7I1sOoEtvtUtc9S/IEezklWemW61dVBLvtF1b+4tl3J/XtqvV9HarfBTepdPqoY2AvHKvgJpKWtM9VJ1oKG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008930; c=relaxed/simple;
	bh=CGKaZ+B6qI5A0N4TuLTmN6qUCqN+1/zEo5Tk+37WnAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7J+ll3664LVqVg5ZUcpIiio6pfH6fCRMD7JK0JNTBlKEtMHMDAnsASg9ewTipEL2kUFp2Y9jQY+EM7D+MIJqfkm9No99nZ5n8f1vSCCipsiVmybjgYWejdpTzLZtVc8xKrMek89M1ytmo7YGbI4hhpoMeDSbXamoHNcxT9qo8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=ScJzuIBc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e54d7b1167so9320b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008928; x=1709613728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXThe3Kif9ugpgRSAcB50yEU/4aW/OJUjbqWOYIQBFY=;
        b=ScJzuIBcP+uxZB/HjXtmA7KnAozoTsIvBzmHumaagw2Mg3sgKVdSFzV7bt+rcthLSK
         KRmC2wXnDFtf+TgD9k3+t13WH8vXHPH3c/Gttdv3ZVgFdtJzGFSsXiXuwaTrvP0JOhVh
         YmC4bmkj/RlqqJKGkofxpascVY+v9wsW/fh4pNNIUViYmb/RGHJldIhKUcJRA5DAf6yx
         Hbs7baWT/RDzQiuolWWdWBt44+pU4ICH1hWsgksatpjA/tk+026OzR4IxTlPenbIZG0G
         NckkoZmi6Yg4Dh4YgDvjLDLB4ZufpD3Tb8NuTuOEFvapxiKm6aqQohegtqo73hXOHBjy
         xJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008928; x=1709613728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXThe3Kif9ugpgRSAcB50yEU/4aW/OJUjbqWOYIQBFY=;
        b=h0UnLdBUT8RojMtzzkHyeX1qjfp3JgUNI/fwSYkGEquw2vT5O2JcRXXNjXRporkWef
         mxwpJTlL1MYbeImyeGbBRHh0w20CJNj6wj6iyAcMJ7E6/2/MuHqOwezE+RAXY3yfF+Gf
         UI487pk/HsnIEtvIbCSj4P1tLLKHtHgcvs3fm8bdD5NqPpFS6W+9wx2cIZlvgTYHpLgx
         Aif3XZ9TTwPcbO1XQQqrCmFhn0kK5gAnYR5gAlzRT8OovUf8lOmoCflNjA1UbiekRV39
         zl6js0GXLVhvWaZtZ7rm8ZKaMwnWpPnYZ0btWJsY9Uo7ABaR8/6wsa7N1RF2SLChmWDU
         Js4w==
X-Forwarded-Encrypted: i=1; AJvYcCWzcdRGSPGGCd5+Dlga3mqa4QimeWkaEiJBrJQhQQaK2YMxty1sSyDoRV5trjO81UEpwW4PEqfc4PmwRzwcIRvTnxA0TFn6usPbtITO
X-Gm-Message-State: AOJu0Yz1VzgxHdKrgBq+kfexkYmfD19DxRPrdEV7maFHwElOToQmvKUW
	PJTqdPn+I6mvgr8XlfWZBQELYXGyXvJSXaqzhr/etQcP1tAKhDKKSD+sJLqu3/k=
X-Google-Smtp-Source: AGHT+IHnx7Xn1kcjCN3aHYP7k+qRtt1kK28s9oliNQO6yXyFhv2V7Jcz9YIdBdm3gPPuQO6bGOIZEg==
X-Received: by 2002:a05:6a00:3d47:b0:6e5:3927:113a with SMTP id lp7-20020a056a003d4700b006e53927113amr4248101pfb.17.1709008928315;
        Mon, 26 Feb 2024 20:42:08 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:07 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 06/20] Staging: rtl8192e: Rename variable osCcxRmCap
Date: Mon, 26 Feb 2024 20:41:43 -0800
Message-Id: <20240227044157.407379-7-tdavies@darkphysics.net>
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

Rename variable osCcxRmCap to os_ccx_rm_cap to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b189ba220e22..c3f37e71d614 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -840,15 +840,15 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (beacon->bCcxRmEnable) {
 		static const u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01,
 			0x00};
-		struct octet_string osCcxRmCap;
+		struct octet_string os_ccx_rm_cap;
 
-		osCcxRmCap.octet = (u8 *)CcxRmCapBuf;
-		osCcxRmCap.Length = sizeof(CcxRmCapBuf);
+		os_ccx_rm_cap.octet = (u8 *)CcxRmCapBuf;
+		os_ccx_rm_cap.Length = sizeof(CcxRmCapBuf);
 		tag = skb_put(skb, ccxrm_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
-		*tag++ = osCcxRmCap.Length;
-		memcpy(tag, osCcxRmCap.octet, osCcxRmCap.Length);
-		tag += osCcxRmCap.Length;
+		*tag++ = os_ccx_rm_cap.Length;
+		memcpy(tag, os_ccx_rm_cap.octet, os_ccx_rm_cap.Length);
+		tag += os_ccx_rm_cap.Length;
 	}
 
 	if (beacon->BssCcxVerNumber >= 2) {
-- 
2.39.2


