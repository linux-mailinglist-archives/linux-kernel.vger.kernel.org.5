Return-Path: <linux-kernel+bounces-37772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248C783B4EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C0C1C20DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDC713A247;
	Wed, 24 Jan 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lzlCPydm"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAB137C58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136304; cv=none; b=h99lqThTRvF7lj1BwR+uZsILoJ+f0pqHzBpw1IMfcEcYe+p4CoAZpqM/jkUNS5tGApVzw6Jl8tHQTm5lE+cifUTSA83kOSWbw+1fqPxjyQjEwdjy1kcaK6PyoXu0xgfxzKMBrSzPOShe86qgdLTEsj4UHSg2P1pucyyLUqsPLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136304; c=relaxed/simple;
	bh=zJcEGQUEJanJ9we3ahFFbmyhJwV1vhU8Jfa6Nz+VevM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NughapBlMgB/CleV7+paD7T7nawz2Nqx9FTjh0x6+dwedM2rOTyBkpX2H5HbTHvtLLbHtNgsOfUL7dkzzFUDwJzUN1UC5ZPYUOr9M/DzZsbaHHBu/Bkh+eBJ4K13Pp3oGzEU59V4MuWfl0M5nyIP2MNqRDTXqtqjwymGrBGI4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=lzlCPydm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so3260444a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136302; x=1706741102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+/HyYKXvtKh770pAaB0RJymXt6WVZx02f+o8iLBVC4=;
        b=lzlCPydm/6SHlP32GGab9ol8H6qcFk09nxlxuaHBCDd5ofERcCfZ4BVYuwEDHDQceJ
         NYXpJPFQJw6djARDlFL9qobt6EBPwO2w1oDIL5i6UOiD+h/bWF4YToawrp9GyZpd4Njj
         43LEEXR5BTd+8BeZCWoxKBtMS/1NZCPMiAyvCaiu0toEfv7402D8G6u6C9Z8lQdl1EZY
         zuu8pM7tv8qhP1zPQ9lun80ybdwHPNXVWqB4R1m28D9kBopxSnEPsH9Y9IGl2kcbP8Hn
         1Kye49eLeu5WC6vWITIDJ7qQCEIrc7ekEG7SWdh/Yt4pFc34U4E5pKT3EBQMNTK9KBYq
         KoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136302; x=1706741102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+/HyYKXvtKh770pAaB0RJymXt6WVZx02f+o8iLBVC4=;
        b=ev19D42L2oH2Hk21qV+usXSNzYudAmlt9iwEFMXh4txBckR59tsP3+LQObSewo9Y2j
         11jE0b+9CfNIRnDE95mbuf6J107SL2YXV6juEyVuXkpZNJR93n9mb1Lhs2q5XxVtftqI
         PaePg0UJjn0jSBYMhmzVbKME6sBak/yHbfF8zkkt94xs+1y/FW1Zu2uJY9tqXOmYsiG5
         LA1Jlg8wlSdIMlYpZLBpZrTAxN4jwM1pN6rykN0QW4VjFP3aMVRpjNi+mdsYwOCeGzil
         Rr7KpfIP/jH0uHibXscp9dHKdS7GUJDVWYAvQUPrpcuR48n98Wyo+6iDcDvABUwdCxY6
         HKvg==
X-Gm-Message-State: AOJu0YzTGloU/pmWLU8Xepvfc0VhVYjqsCe0TpjJopP9O9MWdH9W6nk2
	360c49G7kjbphuMGvU184n2YNhTXuXhNiWoSuEjl1hvCyqr8WCkE6oD3uEXZDKY=
X-Google-Smtp-Source: AGHT+IHECZiI21gXPyt14QRzAlAbWWN+sApWGys689uljb1M/8OSV5/22z9oHdid5jwxwNiUj/dbWA==
X-Received: by 2002:a17:90a:9417:b0:28d:6230:c1a2 with SMTP id r23-20020a17090a941700b0028d6230c1a2mr233139pjo.50.1706136302185;
        Wed, 24 Jan 2024 14:45:02 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:01 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/18] Staging: rtl8192e: Rename variable PeerHTCapBuf
Date: Wed, 24 Jan 2024 14:44:41 -0800
Message-Id: <20240124224452.968724-8-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable PeerHTCapBuf to peer_ht_cap_buf to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib_softmac.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 68577bffb936..29e1206078fe 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -99,7 +99,7 @@ struct rt_hi_throughput {
 	u8 cur_short_gi_20mhz;
 	enum ht_spec_ver peer_ht_spec_ver;
 	struct ht_capab_ele SelfHTCap;
-	u8 PeerHTCapBuf[32];
+	u8 peer_ht_cap_buf[32];
 	u8 PeerHTInfoBuf[32];
 	u8 ampdu_enable;
 	u8 current_ampdu_enable;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6d0912f90198..cea3284dd787 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -437,10 +437,10 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	}
 	netdev_dbg(ieee->dev, "%s(): HT_ENABLE\n", __func__);
 
-	if (!memcmp(ht_info->PeerHTCapBuf, EWC11NHTCap, sizeof(EWC11NHTCap)))
-		pPeerHTCap = (struct ht_capab_ele *)(&ht_info->PeerHTCapBuf[4]);
+	if (!memcmp(ht_info->peer_ht_cap_buf, EWC11NHTCap, sizeof(EWC11NHTCap)))
+		pPeerHTCap = (struct ht_capab_ele *)(&ht_info->peer_ht_cap_buf[4]);
 	else
-		pPeerHTCap = (struct ht_capab_ele *)(ht_info->PeerHTCapBuf);
+		pPeerHTCap = (struct ht_capab_ele *)(ht_info->peer_ht_cap_buf);
 
 	if (!memcmp(ht_info->PeerHTInfoBuf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
 		pPeerHTInfo = (struct ht_info_ele *)
@@ -518,8 +518,8 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 
 	memset((void *)(&ht_info->SelfHTCap), 0,
 	       sizeof(ht_info->SelfHTCap));
-	memset((void *)(&ht_info->PeerHTCapBuf), 0,
-	       sizeof(ht_info->PeerHTCapBuf));
+	memset((void *)(&ht_info->peer_ht_cap_buf), 0,
+	       sizeof(ht_info->peer_ht_cap_buf));
 	memset((void *)(&ht_info->PeerHTInfoBuf), 0,
 	       sizeof(ht_info->PeerHTInfoBuf));
 
@@ -572,8 +572,8 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 		ht_info->peer_ht_spec_ver = pNetwork->bssht.bd_ht_spec_ver;
 
 		if (pNetwork->bssht.bd_ht_cap_len > 0 &&
-		    pNetwork->bssht.bd_ht_cap_len <= sizeof(ht_info->PeerHTCapBuf))
-			memcpy(ht_info->PeerHTCapBuf,
+		    pNetwork->bssht.bd_ht_cap_len <= sizeof(ht_info->peer_ht_cap_buf))
+			memcpy(ht_info->peer_ht_cap_buf,
 			       pNetwork->bssht.bd_ht_cap_buf,
 			       pNetwork->bssht.bd_ht_cap_len);
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index c231e7acd606..aa98d22db90a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1606,7 +1606,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 					kfree(network);
 					return 1;
 				}
-				memcpy(ieee->ht_info->PeerHTCapBuf,
+				memcpy(ieee->ht_info->peer_ht_cap_buf,
 				       network->bssht.bd_ht_cap_buf,
 				       network->bssht.bd_ht_cap_len);
 				memcpy(ieee->ht_info->PeerHTInfoBuf,
-- 
2.39.2


