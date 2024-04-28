Return-Path: <linux-kernel+bounces-161606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6534D8B4EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234A61C2084E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83117BA1;
	Sun, 28 Apr 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="miWA37Tg"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0033C8
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345272; cv=none; b=FzQp5fpPVnhtIhGXKrRFzDOOz6yPhXetCSVE+mTBsUOKz6jT20MmVKOtBCwIn0UJDz11akJfJT+QcmzwHnZ20TPxKEkJBIrXOCMSLE1nOxWTAtvcWDgq5WZUj09HW1WdvbxfEnORKEYeVYz7Lqd6fIq1LVM3BsKW0vhuF+wox/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345272; c=relaxed/simple;
	bh=3ZTw8BeceEMrLI2eXWrhHPIMhWTE257zxH1ARkgOI/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDrFGJUbB7KZxsALDBldq23WFgp7sJbOFdwALef+PFaooQcayUI0XI0JvPmr7Cb+MbXuPl3hnMbjBMuJwU9C1oduKeXznca9xTPrOrHAkwD6nZQuDNYs0RgA5MM7Y15JVm+1bAU14RxVsDlVPjO3mSwh1tG595gijEtoAaC+VG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=miWA37Tg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2284735a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345270; x=1714950070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6pdYepRZz8G1EwreRVScRjhNUy4bVKjwuiU8xh1WxQ=;
        b=miWA37TgbDtuLVKxcPWHKBFH6WINpbVH8Wm1DcdwAIAPrgXeUwNS9ohAa/lJMaflQL
         MZhQpIOCLq+AsiNTJyIvp43saLz38Pin5seqD1B6+vJf+DYowGlNWrwdaqtZxmY9/Oqz
         d3DpFOscqxPY5wi354UIfxQ3Tvt0wh6j0z0A7fSzgDxy0B5KF4WAgZJGS1s5WtJXQnoX
         aJx1jeNSOBHtidyrJHXZDT9co5XEU+rlxjOLtLUjMY0u4QtwnWP2wmf8tWRV3AGT9Am5
         WYmSsu5b7zc0WxRAUyuaaSeihA+pdHzmjsoNBM5/Xay2VfmxUtgilIW0mI/zzHstTtTY
         PzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345270; x=1714950070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6pdYepRZz8G1EwreRVScRjhNUy4bVKjwuiU8xh1WxQ=;
        b=UKXPGHIBOuBicQPtzgwBBHLSUDGgtrqTT4gxurnsqhzfKe6xdy3or/IvWT8r+2MRWT
         6+mjCZqUFvLD9xjVAFhE4UCcidU7Z06wAUQoTS7TLXdzaUU0iNCzYO3HMZNoQuAfPhPx
         Ngr9cb9bRBZsu4duG82q3SK2lGMUFIbWeK/54x5fZYhYEwsAQPbWs3qAfiPxzEBqEA8x
         X0nDHUQM4vtcAMwIgTJUXQHuuqpScihcsbLsoFi3FcMtc4NPI1ZSo8VoB5oE4Iu2TeHB
         zm6A3r1lKqiPWXDwpkOvviazE+HwRhGEex7NJu+3T8foWVtgUSR8QcJANESFmHd7iRdO
         gUpg==
X-Forwarded-Encrypted: i=1; AJvYcCXnR7hKtVkgReH5f1W9OzyfGsC31PVIkV/KbBiGwiu+UTOyB4fu6FMhEOmKHaN2h/Qwg+sGJ8L43Y0oUVPvb2gtc7OVrrTdIQbcf09n
X-Gm-Message-State: AOJu0Yx/1aIp2AKwYct8PFxWCJS7K4Q684nCNCy1edoc/PrL/7LCaY38
	XcJnkH47UvVctCN/UPPzAcWbl1zEkhSS8Y5b1n2mUjVg7zvqzf5IZYgirkGHEp8=
X-Google-Smtp-Source: AGHT+IF21UBD9P5VB314FqSjAvmC1hZ2R5W0zntXq9dHkyC0QLzOSszvvqhMX0h7QWUpecwyBoH6Pg==
X-Received: by 2002:a17:90b:2303:b0:2ac:8366:8ab4 with SMTP id mt3-20020a17090b230300b002ac83668ab4mr8214191pjb.38.1714345270321;
        Sun, 28 Apr 2024 16:01:10 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:09 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/18] Staging: rtl8192e: Rename variable CurSTAExtChnlOffset
Date: Sun, 28 Apr 2024 16:00:49 -0700
Message-Id: <20240428230106.6548-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CurSTAExtChnlOffset to cur_sta_ext_chnl_offset
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 12 ++++++------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index a4580445305d..eeb5a5eb94be 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -109,7 +109,7 @@ struct rt_hi_throughput {
 	u8 forced_ampdu_factor;
 	u8 forced_mpdu_density;
 	u8 current_op_mode;
-	enum ht_extchnl_offset CurSTAExtChnlOffset;
+	enum ht_extchnl_offset cur_sta_ext_chnl_offset;
 	u8 cur_tx_bw40mhz;
 	u8 sw_bw_in_progress;
 	u8 current_rt2rt_aggregation;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 618523bacc8e..e82e8c50c090 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -638,10 +638,10 @@ static void ht_set_connect_bw_mode_callback(struct rtllib_device *ieee)
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
 	if (ht_info->cur_bw_40mhz) {
-		if (ht_info->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
+		if (ht_info->cur_sta_ext_chnl_offset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel + 2);
-		else if (ht_info->CurSTAExtChnlOffset ==
+		else if (ht_info->cur_sta_ext_chnl_offset ==
 			 HT_EXTCHNL_OFFSET_LOWER)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel - 2);
@@ -650,7 +650,7 @@ static void ht_set_connect_bw_mode_callback(struct rtllib_device *ieee)
 				       ieee->current_network.channel);
 
 		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20_40,
-				       ht_info->CurSTAExtChnlOffset);
+				       ht_info->cur_sta_ext_chnl_offset);
 	} else {
 		ieee->set_chan(ieee->dev, ieee->current_network.channel);
 		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20,
@@ -680,14 +680,14 @@ void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 		if (Offset == HT_EXTCHNL_OFFSET_UPPER ||
 		    Offset == HT_EXTCHNL_OFFSET_LOWER) {
 			ht_info->cur_bw_40mhz = true;
-			ht_info->CurSTAExtChnlOffset = Offset;
+			ht_info->cur_sta_ext_chnl_offset = Offset;
 		} else {
 			ht_info->cur_bw_40mhz = false;
-			ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
+			ht_info->cur_sta_ext_chnl_offset = HT_EXTCHNL_OFFSET_NO_EXT;
 		}
 	} else {
 		ht_info->cur_bw_40mhz = false;
-		ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
+		ht_info->cur_sta_ext_chnl_offset = HT_EXTCHNL_OFFSET_NO_EXT;
 	}
 
 	netdev_dbg(ieee->dev, "%s():ht_info->bCurBW40MHz:%x\n", __func__,
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index d6bc74ba9092..11542aea4a20 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -319,7 +319,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht &&
 	    ieee->ht_info->cur_bw_40mhz) {
 		b40M = 1;
-		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
+		chan_offset = ieee->ht_info->cur_sta_ext_chnl_offset;
 		bandwidth = (enum ht_channel_width)ieee->ht_info->cur_bw_40mhz;
 		ieee->set_bw_mode_handler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
-- 
2.30.2


