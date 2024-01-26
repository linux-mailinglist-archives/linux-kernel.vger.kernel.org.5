Return-Path: <linux-kernel+bounces-40767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D9283E57B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4FCB24B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B415579B;
	Fri, 26 Jan 2024 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="cIunWCn9"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977185100D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308306; cv=none; b=IArLmqiYjniMfw207e1dR4hPGO0dIsWX2j7MvbrbkTR6DrOKfDOEjgFSCOGjNzdUHbQeFaSS/DMd3b9scGDmL/S2FOYuJToOsM1fBkNwV5uMQ4fNXITiX6Tfwb5r+TcZtGJ69GxC24Nannn69ZE4T25fbOsiFqO4CFwQl9O/rIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308306; c=relaxed/simple;
	bh=KxRSwXJ9jCK0ShEK9HzdulULhVMtNJ4z9PL6t6ESeVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOM5rhPu8QD8CKrZUogBry2lrR32vmgEdbdXEl8aDFIdxmctpwALcF4hqAIlTX9ibwafisOmpMH2psOpSa0f/HDbVezSuxlxAJRQdtbAEnpbY6PxkkT4ZZwa4ofVvO7PyXSAEIHlIA6VMheCcKQis0SBJHg7O0FTCF4c8I7uU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=cIunWCn9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fa455cd94so634073a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308304; x=1706913104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HejJUwRGy/yaN7bOykHpPvwZVhm5UuAHdB14cEQD7Do=;
        b=cIunWCn9ga0ToP2VnDOSMfal7IIYTZY9tvnu5d3EBesxg2l5HJA0Nhi/3c3aoPfDwy
         kGSd7c23AqZjAVucnStXVqEF5NeloQ68C+DGq4l0kl/OMu+9O7elGE+e80SpWUtOwUya
         QDjr4B2fBQUGpIT1Wh2E3YR2bUT7iZuGZruFliBih7ziLscBJC3JYhgG2t9jHNGTaWCg
         Ct4869y4C3Es2yUTp4ZCXQSOdXQmpsIOhq+ywSVU5povCJCTzgRK3gk/Y92hwSeqYdRm
         2ycbi4IFoy+Mz47UzqZ19QmYuWpSoeX2Le2qdqwJ+lbE30+5CDSKUGtaMlZMQxObcDCq
         eOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308304; x=1706913104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HejJUwRGy/yaN7bOykHpPvwZVhm5UuAHdB14cEQD7Do=;
        b=cxHV4MqDyYQuYIhfACBZgGBnbM/dvpTbMdUy1rMGQezb/WiP3yPs56xEzILPZS47O6
         Jgw+JzyNmuH8c9tnGTKWZsTWajxmuR8JpDSd5TCb03Y7NPWwDRl5GUdkTWvnQ6iYf250
         LBBUXbKApw3e2djhZjQF9bgvduiDuWUQQiQHZdI5nvnJbHr3j3eOTCNi7pCDGEkd1B6b
         Oy6Z+vImmN9KlmgHf4mzpRfLDmm3uYtv1b6orOnQzlidMfEV//RmEBHskNSpJorNVIsA
         NeIN1m5qAAZri7VgiXu9du/ydl9Wmj8+rVWfPTgmEIp09z2oULP8qN/IHFXKnsAXGCWZ
         P7xw==
X-Gm-Message-State: AOJu0YwaBt8X4t+T+o3ciUO+9gmu/fMCbhTQAAlz7FkFHin2QxOctNhv
	qb4kJhbg4UFRletb1+TKLBTE9bjA7EnZNONOXkyQNTO5L6ZVmkPTlorducQ6ixo=
X-Google-Smtp-Source: AGHT+IEyfpbPnx/FF1+3hbs/6ok7gcrd8xshqjG8z7W4mV1TjYc8x6hkSe6gNzsa8KmGB4CmFgKw3g==
X-Received: by 2002:a17:903:32d1:b0:1d7:8b3b:c46 with SMTP id i17-20020a17090332d100b001d78b3b0c46mr863984plr.28.1706308303935;
        Fri, 26 Jan 2024 14:31:43 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:43 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 08/18] Staging: rtl8192e: Rename variable PeerHTInfoBuf
Date: Fri, 26 Jan 2024 14:30:56 -0800
Message-Id: <20240126223106.986093-9-tdavies@darkphysics.net>
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

Rename variable PeerHTInfoBuf to peer_ht_info_buf to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib_softmac.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 29e1206078fe..18dab893270f 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -100,7 +100,7 @@ struct rt_hi_throughput {
 	enum ht_spec_ver peer_ht_spec_ver;
 	struct ht_capab_ele SelfHTCap;
 	u8 peer_ht_cap_buf[32];
-	u8 PeerHTInfoBuf[32];
+	u8 peer_ht_info_buf[32];
 	u8 ampdu_enable;
 	u8 current_ampdu_enable;
 	u8 ampdu_factor;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index cea3284dd787..98f0ac80f1fd 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -442,11 +442,11 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	else
 		pPeerHTCap = (struct ht_capab_ele *)(ht_info->peer_ht_cap_buf);
 
-	if (!memcmp(ht_info->PeerHTInfoBuf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
+	if (!memcmp(ht_info->peer_ht_info_buf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
 		pPeerHTInfo = (struct ht_info_ele *)
-			     (&ht_info->PeerHTInfoBuf[4]);
+			     (&ht_info->peer_ht_info_buf[4]);
 	else
-		pPeerHTInfo = (struct ht_info_ele *)(ht_info->PeerHTInfoBuf);
+		pPeerHTInfo = (struct ht_info_ele *)(ht_info->peer_ht_info_buf);
 
 #ifdef VERBOSE_DEBUG
 	print_hex_dump_bytes("%s: ", __func__, DUMP_PREFIX_NONE,
@@ -520,8 +520,8 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 	       sizeof(ht_info->SelfHTCap));
 	memset((void *)(&ht_info->peer_ht_cap_buf), 0,
 	       sizeof(ht_info->peer_ht_cap_buf));
-	memset((void *)(&ht_info->PeerHTInfoBuf), 0,
-	       sizeof(ht_info->PeerHTInfoBuf));
+	memset((void *)(&ht_info->peer_ht_info_buf), 0,
+	       sizeof(ht_info->peer_ht_info_buf));
 
 	ht_info->sw_bw_in_progress = false;
 
@@ -579,8 +579,8 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 
 		if (pNetwork->bssht.bd_ht_info_len > 0 &&
 		    pNetwork->bssht.bd_ht_info_len <=
-		    sizeof(ht_info->PeerHTInfoBuf))
-			memcpy(ht_info->PeerHTInfoBuf,
+		    sizeof(ht_info->peer_ht_info_buf))
+			memcpy(ht_info->peer_ht_info_buf,
 			       pNetwork->bssht.bd_ht_info_buf,
 			       pNetwork->bssht.bd_ht_info_len);
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index aa98d22db90a..9ee6364f7b00 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1609,7 +1609,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 				memcpy(ieee->ht_info->peer_ht_cap_buf,
 				       network->bssht.bd_ht_cap_buf,
 				       network->bssht.bd_ht_cap_len);
-				memcpy(ieee->ht_info->PeerHTInfoBuf,
+				memcpy(ieee->ht_info->peer_ht_info_buf,
 				       network->bssht.bd_ht_info_buf,
 				       network->bssht.bd_ht_info_len);
 				ieee->handle_assoc_response(ieee->dev,
-- 
2.39.2


