Return-Path: <linux-kernel+bounces-80486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BBD8668E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F001C216AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1151BDC3;
	Mon, 26 Feb 2024 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Cnsu+EAX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E41AACC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919793; cv=none; b=B3tmxIudP79CgXUa8mZOOrwVBG4Yeuj4efd17T4QqOmkmXBEmoiZZTHeGEQN+u3KWgfPVP/xUVU37kV20mqa5+8UD0JbN/cCNkGVDQqY9G4s5MjnYejCkn+oUSyS9TZMldQS5DKrjT6alnE46rzRpCcPrCIz6ngpL6MCl976HIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919793; c=relaxed/simple;
	bh=4QYfnCHT5IF0k+ZPFYR0XE5aULvE2R+dS6ZM00LhHhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MdsaiG9Wd4sr/Vcln3x92E7JSqe5Kmz6DSNqxc3qoTCyyCmaS6h72ZdQgUDDgv6ccXhO7jRf53eTj4NWbV8M+Tu8Z71bhb6d0eLjMgj5+nguGc5KcjVZQb3UKhEnTwffzhdtrGrDQRekLqB7JPs4c4jQzBk58/xZ1nt+dOv08l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Cnsu+EAX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d51ba18e1bso34667395ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919791; x=1709524591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBKGzHk8InlkFKn1JmjT6uwa3TRy3S2Nn8Oc9mkuYiQ=;
        b=Cnsu+EAXiEd8onMwz18QvAOvcHhKX+/wH4F30nqjqIeeOK1sFYzTcMesDagGyDmDHB
         SrSpHEQCeEdpBbydpSa+EpieH/QwC8XEu7qxjqAKlXMbHiPT07fhg+5e5Y1TOTc9q2QJ
         ciXV1Yp/Y/61rc4hvD831aXZiht4CGgRJYPmfnBUJcaBG2LH+MqFOueYCbHvt45WfVuV
         6aVkcfVyzF7nh/7Z9OIkLgr+/8RhhvU25I/v/3TkAoCKFiijr+xksGHLbThFAHKH/cWa
         U0E8OLzi1IBhDyrFbla+mK0+epK6zhoNf/nJV0ZuWQ4uDTNnGRsXIjbFGGSeHJL0Sjs/
         jFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919791; x=1709524591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBKGzHk8InlkFKn1JmjT6uwa3TRy3S2Nn8Oc9mkuYiQ=;
        b=TJIUN9j9bG9dIc8gq3UWfxC3tf3+3rABh8P3hk3kcpkhCAH1NnXO0+thy8H4+QpqCk
         C4bNbjgwfFKxAaTR8A2wsBHLoiXTB1MG8O0/k/6Av4d024Gibu/PowMUeeWBZQnQR3h7
         su+7j+PoKtXbSYoCsKZSX6IhtFvhhTW5BS1taUuRKMTV5b1yAp4Vh7Gu1R2C40wXESTb
         xOiqm4n5Gm5nblWnKpewCZvefRfJ2H91/443dZ3JNhVM+Su5OavY8ox8Jfs1WVSsWkD6
         hZhybG0Y4V5WErO2RTTopsrvhJPZUzfil24ewqL+qySNpoXsBZCJ57I7tBjPJFC/iyZ5
         UKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5gbn55L4VPpXQ/EHoa3QdTPDAdnfUg9/mdGODSjXq/DaItyQjJJxn5/8wvUMG4h51GEILV2F3lKI834EkYDrVFqcL7+9kaEsEQkG6
X-Gm-Message-State: AOJu0YzHdMtzw44T5jWxb74CAvQtLkill/m30WFOLOTLKj5evkOffBVE
	WYjngty1n8n3EVioz2eUzSKDJ9qRSGDG8nF4VhCnWJ6ntZErA58YpXNjeRS96ac=
X-Google-Smtp-Source: AGHT+IEuE+p8lr2qFRqJ7tnGYs20pVRaLD6XV1Rp+rB4gGWpR7TDkDqHq+FWmbUDJCoQdJAnb4XU1Q==
X-Received: by 2002:a17:902:d488:b0:1dc:8042:3b76 with SMTP id c8-20020a170902d48800b001dc80423b76mr8622073plg.2.1708919791021;
        Sun, 25 Feb 2024 19:56:31 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:30 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/20] Staging: rtl8192e: Rename variable PMKIDList
Date: Sun, 25 Feb 2024 19:56:08 -0800
Message-Id: <20240226035624.370443-5-tdavies@darkphysics.net>
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

Rename variable PMKIDList to pmkid_list to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 30b9178071ae..a00db0d153da 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1281,7 +1281,7 @@ struct rtllib_device {
 
 	struct sw_cam_table swcamtable[TOTAL_CAM_ENTRY];
 
-	struct rt_pmkid_list PMKIDList[NUM_PMKID_CACHE];
+	struct rt_pmkid_list pmkid_list[NUM_PMKID_CACHE];
 
 	/* Fragmentation structures */
 	struct rtllib_frag_entry frag_cache[17][RTLLIB_FRAG_CACHE_LEN];
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 607122ab4b00..239ed95982ac 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -669,8 +669,8 @@ static inline int sec_is_in_pmkid_list(struct rtllib_device *ieee, u8 *bssid)
 	int i = 0;
 
 	do {
-		if ((ieee->PMKIDList[i].used) &&
-		   (memcmp(ieee->PMKIDList[i].bssid, bssid, ETH_ALEN) == 0))
+		if ((ieee->pmkid_list[i].used) &&
+		   (memcmp(ieee->pmkid_list[i].bssid, bssid, ETH_ALEN) == 0))
 			break;
 		i++;
 	} while (i < NUM_PMKID_CACHE);
@@ -881,7 +881,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 			tag = skb_put(skb, 18);
 			*tag = 1;
 			*(tag + 1) = 0;
-			memcpy((tag + 2), &ieee->PMKIDList[pmk_cache_idx].PMKID,
+			memcpy((tag + 2), &ieee->pmkid_list[pmk_cache_idx].PMKID,
 			       16);
 		}
 	}
-- 
2.39.2


