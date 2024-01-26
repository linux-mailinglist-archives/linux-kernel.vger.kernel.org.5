Return-Path: <linux-kernel+bounces-40766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F3083E57A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528EB285826
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C9854BF2;
	Fri, 26 Jan 2024 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Pl4IfqUS"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5E50A93
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308305; cv=none; b=iZvWRzUAyLJOHtFpSy6VSqq3Dz7NGbUz/jbI+dgBRzrqgFdLR33VUlIBpDdjeXzfxdkzfGb0MswvuKi9qifykDiyLtMAQgqBZn6S9JBmAMXxKvn9O1u/L3nTwAltX26UUBBaEVDvRAyVCyug5FELytia9TAYZ0Y5ceCMyt5g9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308305; c=relaxed/simple;
	bh=4eD0zWr2QDQ7SdfNZ8wki3VUresfEX2VZTryP/dcDdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/eZywG8wZcCgPGwM3tpZvm41K5hOXru377HIJtGeLOE9yvBW7YOe6tKmQxiwOyFl+W2IWKtBV8JpdHtB1zwGVAbrkpxEZdsuWplmdnSPGpGHNLcXsthtckmOFq9uhT2slmjvO8VviZeZdHStVtbWzET75/mOQNrXKcAXO0ghsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Pl4IfqUS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d70a98c189so6782075ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308303; x=1706913103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPBwdmqwxN46G+anfF19y+aU22YsXkVedyuw45vTXGw=;
        b=Pl4IfqUSNS2XtXZRbBgvK2k2wNUBSV3PKt7Naj7V6lrqNUkYo2gKOJFCl7naFxUTtZ
         h5kZV65XYWTFZHRjLuBIHg7blbnwD23fUlCz4/UfVUmQMk9J6c+8ANptv2hJuDLmNOd0
         mZEUruwC6wwOp3FvKYteqNs7LGtw9r/uLE8vV7o/1MO9YqeG3z153WXaY8U9sDrO13+w
         h5wjpNtiWtrPOWj5IrPKDqU5ldEGeR8BPRmUyHyJ5Ucp5HS40tYWaDFGi4MAZYgFGFQV
         N/14PT/qnDecsCA8vy9MqM5MfS6l6gG1TjhhpsRseLhikO5kldkegs/TTjmS+8W7cBp0
         cfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308303; x=1706913103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPBwdmqwxN46G+anfF19y+aU22YsXkVedyuw45vTXGw=;
        b=vDQlopyzM435FLHpKcAqMyfwq/ywWEYSpcK1j+9Bk2B+XxyZCBczD4ggX6lBpikuov
         tZvTltvTDgs+1DKpeEI0UQtZFhlrrOXZvtJRJgmcezjd1QcunoxQlr0Lb7MJdNwI5ncd
         eRlq84REuzPXeXkh0C33sSA/PiVq27bLegYSNxrJD98tr+xnQNEBFZKumo7PKyN/K+SI
         Z+jjDvetnJqa8GBdqKipZqoH0uaYOi/TtAsls4JUgS3slG4tKyTEEtHmuuvx00q+10la
         ku1wnnTZy8kEdiEHUxjL5LM6S57Q64xfa84nskZ9qqWwe92Yy50D4eGw/ax0itt7PeQu
         /hVw==
X-Gm-Message-State: AOJu0YxcWSvVUxFLNcw2DmDbtCkQ2zOIyzRwCQMjNVsx7K1R7Zak4j/F
	t5bbxE62361RpkeUjl8ooX+at0CiaZnCZHzVRfeWoWpBreh+2Ez0hhCxplUxrdw=
X-Google-Smtp-Source: AGHT+IES78eHHfi74bkNkTCu6OPx/Epr2IPdRTatLFXIayhQKhvIar4Qf68ZGihQYosZPrUBW6g7GQ==
X-Received: by 2002:a17:902:8501:b0:1d7:3067:aab5 with SMTP id bj1-20020a170902850100b001d73067aab5mr437589plb.57.1706308303163;
        Fri, 26 Jan 2024 14:31:43 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:42 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 07/18] Staging: rtl8192e: Rename variable PeerHTCapBuf
Date: Fri, 26 Jan 2024 14:30:55 -0800
Message-Id: <20240126223106.986093-8-tdavies@darkphysics.net>
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

Rename variable PeerHTCapBuf to peer_ht_cap_buf to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
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


