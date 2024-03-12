Return-Path: <linux-kernel+bounces-99839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E175878E22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F62B22500
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD0D533;
	Tue, 12 Mar 2024 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WppVTang"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD2C8DE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710220735; cv=none; b=XJT/JX2OI7joYINZdNb5G5mjkfhzstxHjKzc0pKsdHbGIgmx+VCLPbGW+txK1v5UyaCb2TSs88sA2Ih8imVKU8xm1orCoaoDoDKvFgxn4gJnBxa8zFNJmF4ElwLTwFyMGW9WVHpU/EAwRdfKWlhqx+TT6iX9AA9VSM9KTm9eu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710220735; c=relaxed/simple;
	bh=RP1j5F3ilhjJOWGmbsI2diL9/wVsYVFld/rkiRg2fKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+nj7UKktKUCYDEWjMWDCP3eyTjkPsFUfu98AkVXxylAIRmWpW8uB24DpgDipF9g3p5313TZmy/iheWJkcl0TI8Q3l+giCdXfYIZ/4yu04Wy6pM8/dob6l/KQzo2wzHaMifEN7jW8AQN9GCOgNAOMLNrdJ43TNXvF7EqVP15eN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WppVTang; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso5951468a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710220732; x=1710825532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/CMcUQ+LYVcURKBiUi24bqTd6PybV2hkFC8M0WQ7cs=;
        b=WppVTangzSu9Bj8BySs79uqDu8PCif7LVicdfDHmPRUWQGt7lUTe3yoEC7vIYIRyvk
         EpbX6gmxbqad+oXXKesmhnaWPqwuNZ9Ph4hMp6Lk0UlDK8fzPDiBVQ7hkFqeY16Rq8zb
         +1Ihis0IVQypfMrqm//v9G/0zQuBY0yVvThUga6z5D8+FwtcmYP8EmnBRCYDPOa7UAyP
         Tr2wEHeUpLDVuiSM6aJrbRhMRoaj5PTWHil+FFMvHp2FlcDWY3nGkFzFFJiTuXG8Y3b1
         S3TbKEKCLBzqvXOv+kNEawOfLRU6JWtVGgqudza09fDfjTjbyq683Duy+iVWpUaxxSHT
         N3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710220732; x=1710825532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/CMcUQ+LYVcURKBiUi24bqTd6PybV2hkFC8M0WQ7cs=;
        b=LBgPpTbwUFZg/D/ZifpD1BBXfqxyLLUZ4iP32SzJTfYoMevRzG2zDjZ1fw/j9wfSi3
         jQ4dpVfVPcu0W6ImKiZ3g35klse7k32Srdi3jC5xPXjt6kGaFVYtRiAzxNWc5OfaHesw
         D4h1cZci0k/nKygXbfKGVSEM1RgTjBfg+CK7dcCSnucsEFB8TZsV8jKyArdPIrhdXHz3
         MOTc4vE1lGpPv3Iv+CUGzrs3kO5RCfxx9yLsVLmKViOhVwZpPHKOH3WvhSj7+05Xipie
         YJQR6qF0sobnC7yGdyxkQIXxBqYrSVmMSD6XZyx6dPu71lFVbjpyHU7iJJx/5/Wbl9bf
         IX7A==
X-Forwarded-Encrypted: i=1; AJvYcCWIypJBcJhbBVB2QUTrwyHuJuIs10/8n/du7UVfzUgbfSzSPjsUODfMDD0FAWzSB1jD433rDCQeRw8mZFePpg7eHYtS1Nadd+5TSYTu
X-Gm-Message-State: AOJu0YxPuoTwzzaYe6GEud+Ii2ZGCxcz0Ekq4UhDWIwdmMAxDBTuL3lY
	0hxYxNT9NHuypEccnlJbsNOpmk6mJVcTE7GyQNHa9a3faoWujJWi
X-Google-Smtp-Source: AGHT+IEZ12MTVUKMwELi5EBVmBR7dR1eUI8jrfC3zV1xIOnKsEifTaxOj60tmS1lErnhdEFg/FSL+w==
X-Received: by 2002:a50:8d5d:0:b0:566:117c:cfca with SMTP id t29-20020a508d5d000000b00566117ccfcamr5567856edt.4.1710220731643;
        Mon, 11 Mar 2024 22:18:51 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-17.web.vodafone.de. [77.25.34.17])
        by smtp.gmail.com with ESMTPSA id s27-20020a50d49b000000b0056729e902f7sm3791578edi.56.2024.03.11.22.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 22:18:51 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8192e: replace variable with direct return
Date: Tue, 12 Mar 2024 06:18:16 +0100
Message-ID: <20240312051816.18717-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the variable rt_status from rtl92e_send_cmd_pkt() and return
true/false directly to improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index 7f0c160bc741..e470b49b0ff7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -11,7 +11,6 @@
 bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 			 u32 len)
 {
-	bool				rt_status = true;
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u16				frag_length = 0, frag_offset = 0;
 	struct sk_buff		*skb;
@@ -37,10 +36,8 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 		else
 			skb = dev_alloc_skb(frag_length + 4);
 
-		if (!skb) {
-			rt_status = false;
-			goto Failed;
-		}
+		if (!skb)
+			return false;
 
 		memcpy((unsigned char *)(skb->cb), &dev, sizeof(dev));
 		tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
@@ -77,6 +74,6 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 	} while (frag_offset < len);
 
 	rtl92e_writeb(dev, TP_POLL, TP_POLL_CQ);
-Failed:
-	return rt_status;
+
+	return true;
 }
-- 
2.44.0


