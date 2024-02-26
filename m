Return-Path: <linux-kernel+bounces-80483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B98668E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A82B20C42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E54E1B7F6;
	Mon, 26 Feb 2024 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="fcouDLC8"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D417BCB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919791; cv=none; b=gHJbOEhfoAgrA+QGkuQ0EuDxZHFvYPdjONjJLTZ/Og6HI9dG1hhqvq3R/P+UCs6Dx0U13zfX//VZMQCsen7q42n9YswN5qbTn+991S04a5csmPT/issUHVChOOaOSjed1i8voLzx1kz6vUPXeIQA7Sb4vP3LRD+htfvOVbiyHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919791; c=relaxed/simple;
	bh=sG2E7Tx1tg/+CAx5H6kqvYJ3Q5NCVVFSyDgm79XwFV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0o8Xc0WXTLlBMt7fx/mWsJVE4jofSw8LJuVMyJ6LJQlOY1Q5IwPn7kembwfnael68qxQ6g7tdzjT/T595LaDaztPsaa3ao3tFDwEuVwANv43KgbP1DK/6cLszP++6UEBBjIt6fXS4CbUU4E8FlKAMU4ARZjG2oQVmgVCkDZl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=fcouDLC8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so9450855ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919788; x=1709524588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK4nK1+Wgv2R0A48KVW0YYzRGfghNu68PTm5896qEzA=;
        b=fcouDLC8woICXU6uE8qko3yWaIYS1CWKYJsYnUDHZhQQtardGI06lviYAEctU/JkhZ
         /0Umskewj7hlu32m72pFK1Z45L+Iwg1x8KIwtafjHq3VoO9Rw7VvjmYvBZIaxRgYzCQE
         IMLK92WociOAJqQuyI5CzxOGlUo6fMill9Yb9uryBwt7vcOLUSduLFTT5oUKoyTHOTeT
         3Hf4kssV80UjO2hxAKITvFwh2bpswWeAShCT9tEOH6020msL0xLJVUeNrcGQpGwaZPov
         K2FN88axyUEq1DTlATYn+O5FX/BlplTZjhem0PD2vpKyAnHjoPlXPceG6feFoKMlshoV
         qTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919788; x=1709524588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IK4nK1+Wgv2R0A48KVW0YYzRGfghNu68PTm5896qEzA=;
        b=PxsBXgE+vPHbHWMDXzb809Q2YAKIRjs1mxG90GSrW6rYBuskdyiZ71WnU/1TgZLCIf
         4CGI6Be4XSi3T1UicRaPTndn2/xZVuIGGskjt8NSuaK+AVcwcoqZ66AcTcrOvGucEB22
         jCqCMRPKxIxUDhV0SiIJfaOKPtV4e+OSP6q5xd+BY+ZCSFiGs7yfq2PQqDtM/1pHEJWv
         HNbAeMfMC5/zidXDFUlDuAEhxFzGSqSrccnNRX/2tKoK1MKo6M08mo4NLLGG7OJz6iG1
         zoi5spH0iuk9vN+b64GU6hWp56TTv8rNjGOCvq6UkZMCYSqCLAvR5Bb6MRnqz5jRgigV
         Czvw==
X-Forwarded-Encrypted: i=1; AJvYcCULjTpt/Bl/FRDWqW2s0nSBUAD434sedeU5Ud/0a2y7DXJ1SaJhNgmh59w6XjCCvAmw5S6ZSwhqqkAgm/3wjb4u0la5YQsl2k9Gdjtj
X-Gm-Message-State: AOJu0YyKB39mYA9DdVO8ct7PK7Rr8S6lhl8/L2fWRiqA9lo78sUX9XEk
	Imm6BwG61gCg22Qf0b/NXLFx16Eq9ijduArc22GLgkBUsj/9KUUw6LoYTqTkSCg=
X-Google-Smtp-Source: AGHT+IGsPFCBVAuUvnJNjV4MnKOkICMtszR65BQ3kAjOqFuJHdFkBQRVHA111zC2v4NxO9gH1cya9Q==
X-Received: by 2002:a17:902:a383:b0:1dc:20f2:77bb with SMTP id x3-20020a170902a38300b001dc20f277bbmr5526743pla.29.1708919788427;
        Sun, 25 Feb 2024 19:56:28 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:27 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/20] Staging: rtl8192e: Rename function rtllib_rx_ADDBAReq()
Date: Sun, 25 Feb 2024 19:56:05 -0800
Message-Id: <20240226035624.370443-2-tdavies@darkphysics.net>
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

Rename function rtllib_rx_ADDBAReq to rtllib_rx_add_ba_req to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index da7319c124e7..bd1d86e0323d 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -211,7 +211,7 @@ static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
 		netdev_dbg(ieee->dev, "Failed to generate DELBA packet.\n");
 }
 
-int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
+int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_3addr *req = NULL;
 	u16 rc = 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 348644998744..95a8e9416f61 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1771,7 +1771,7 @@ u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame);
 void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
-int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
+int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 2545ac8963c4..f12ee685e989 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1551,7 +1551,7 @@ static void rtllib_process_action(struct rtllib_device *ieee,
 	case ACT_CAT_BA:
 		switch (*act) {
 		case ACT_ADDBAREQ:
-			rtllib_rx_ADDBAReq(ieee, skb);
+			rtllib_rx_add_ba_req(ieee, skb);
 			break;
 		case ACT_ADDBARSP:
 			rtllib_rx_add_ba_rsp(ieee, skb);
-- 
2.39.2


