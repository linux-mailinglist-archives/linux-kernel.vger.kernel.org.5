Return-Path: <linux-kernel+bounces-98374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78F887793A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F821C20DEF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FFD3D0DF;
	Sun, 10 Mar 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="LE0VdvwO"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469A3BBE3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114960; cv=none; b=YWckaQGqzDhhTXBBKtEVpwzW2n80S5Xa0tabznzcP2Owzqtt/JPnI01fBUw6qx/c0Vc0SKVnm9yFbO9ZseSHvZAb4HPsfk6qsMM4Np2mCc2rCbWV0SZ95OSr/kFDomsWl+LuG1mvvcFyUO4rtHtXg1+ZPC5G764Wa5T2NiP9W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114960; c=relaxed/simple;
	bh=n7KXQpozyW+nnrXGfVAreK2+9LiwspOCcLcvVc6HNXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cirRYKvNp2sJ366k+HFhvp5QRAsBjVE5sjfDZWpVg5KZK9B+gTpukeWDpBomfMqu/zOXHAjndQJQivEsiz0XHLp2+UceDAY2YiyGAhrUQiswa+mt9xGk72FLloVahNHCksjR09uHH7aat0TW384Vt13bBuvlWjkxbniXwtgmEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=LE0VdvwO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29bd0669781so711862a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114958; x=1710719758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL8d9MTcpYN8bDTWPCmzHn5aeTaz5Kj78gvK+tvBcF8=;
        b=LE0VdvwOveZrykgFgRbaKy8gGT41plEfInE/x2+s4gQOjZHKDGArvHD+U7Vy275+MM
         eZRN8rlS+vQwpo2vHkwhwHS+GSrI9pS5//9QUADNiL83hDf2MVnziK+hTQWIk7Dqe170
         2HmyHfJAtkX28pSb2XdWALb+I8VdtHuBw7OxxofB2/nlBzgyLdbVDiCQZyJZc+Az/B2z
         bXmGyE3tBDeM11IJnEAFM4Api+v1Cpmu0N4yLu7XpbmfpLD3NdLCA0RfhrfJpJ5f4hPL
         hVjmiXCIFV2n424ZmVL1CfTq7RHJtfGXw5c1V7e4qvT0i/LZi657u8+os2cr7kriUDkq
         HQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114958; x=1710719758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL8d9MTcpYN8bDTWPCmzHn5aeTaz5Kj78gvK+tvBcF8=;
        b=etTIELKXRPNILW1LfZFRjCxoqTM9gmqv6m7nU0/zkvPpI/sm+6g+RO4mPa6cffyv0U
         zEP38W07XINZ5+RhW7X0hYjeDwgQZZJxhHvO0M9tFRAHdRKQU5dzQQgJ/wcA61/BYG1K
         1PveGwWqEg9inn5KZq2zFkWcTuS55gnsLLOPeAjbckEPgMrB++m1xbZOU9YDzX0BxTyk
         5lA3HWh24nyNqUAzHkzDGdTW06xU8Ub59lEvUjRD1AYvunKS1pk3ALDhxfvfQIhLKNWp
         8Tyfnyrd8kKtklvZPX6nZ2lGAV1kF+d9zr51aL1hyAxACXbXhFha6s1EXB/RKxsbhnya
         W+JA==
X-Forwarded-Encrypted: i=1; AJvYcCUTvUHzHX9VmcT9UhIskb7xBCjFHybojUHJLLCNHb9Dmg4ZhJxuL0uSszTdocGWB7JzaV9oxtfXX1v8n0JJD60Yr//pyX+VdsA71rSn
X-Gm-Message-State: AOJu0YwsTkvQlltUMRt82gZYpSky8dx4PovuUZprZ9hofPchbRNfJRhu
	DS0qf99WTC2f8JbYAi8UyK1zdpOKjcdGvNjxsDF8sBf37dE8OOhhQb4/b2ZrSvU=
X-Google-Smtp-Source: AGHT+IFDJkt+sGBsjG7YpqYO6xmDXouhYwlWkHzbp38WU4LKg4lxD5K1SNC3CWszOYhKTjfwWFIgeg==
X-Received: by 2002:a17:90a:9f8d:b0:29a:6b1d:4d32 with SMTP id o13-20020a17090a9f8d00b0029a6b1d4d32mr3951003pjp.38.1710114958723;
        Sun, 10 Mar 2024 16:55:58 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:55:58 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/11] Staging: rtl8192e: Rename variable TimeStampHigh
Date: Sun, 10 Mar 2024 16:55:44 -0700
Message-Id: <20240310235552.4217-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240310235552.4217-1-tdavies@darkphysics.net>
References: <20240310235552.4217-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable TimeStampHigh to time_stamp_high to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 480315404969..15b0ac6e6eef 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1660,7 +1660,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 			    (pDrvInfo->FirstAGGR == 1);
 
 	stats->time_stamp_low = pDrvInfo->TSFL;
-	stats->TimeStampHigh = rtl92e_readl(dev, TSFR + 4);
+	stats->time_stamp_high = rtl92e_readl(dev, TSFR + 4);
 
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
 	skb_trim(skb, skb->len - S_CRC_LEN);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 72264e1ef877..e165f1e32e7f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -483,7 +483,7 @@ struct rtllib_rx_stats {
 	u16 bICV:1;
 	u16 Decrypted:1;
 	u32 time_stamp_low;
-	u32 TimeStampHigh;
+	u32 time_stamp_high;
 
 	u8    RxDrvInfoSize;
 	u8    RxBufShift;
-- 
2.30.2


