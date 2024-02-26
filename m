Return-Path: <linux-kernel+bounces-80517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B234B866915
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F2CB23DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF394D5A2;
	Mon, 26 Feb 2024 03:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="CYkNyqoM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99045034
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919967; cv=none; b=WMvgWVAbC8BNclgSjkOxEugNOiyW9alOwfPlaeD1jn5PlVxJqdJEIi8T1odThM7kH7lmkhSlebjitwtuWdsa/SAfB8Gposd9pQC4Mqg6Rhs59svxTd4MEGU1KRQrffVK9O7wO++G+iDhgm6i9sAntIBpJAK4/2pK0SgzjugB7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919967; c=relaxed/simple;
	bh=aL+J9YpPCTXZjblY7lvooQHdP2S0Wbtur0yP78NWTF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9G+BJeFpCRKkMs2ITT1OAUlMT+6Atk3bdeq0NtViiKAjH6ikZ3z3vvgNBFZ87uB5rgsAQk6v8b6EmKaXU+Vau6HCrx9ldg/lVvlCVj9ofx6izc7uCZhUeaxR2NhkbkgTpBsRRTkhdXr6IALlbaDVGeu9oSzVyCr+DdQzvltGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=CYkNyqoM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc75972f25so19768045ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919965; x=1709524765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiLiFMfWKCcVhhDB/j6NQ7MKUt9nWfWJUvYg2/4dEk0=;
        b=CYkNyqoMtedV2f4XjNHHb7mF/vUtz1xAKRENAzEPGq+Ij8C/3dAH0mCtlsO8XXwDut
         /5OO415elDYFLgup08PiCPwAvwxCWKrlsKBckdInZnKN7QKH2VBJ/qQMtvz1hmlbtTAa
         wM6tv3n0FWwxp9RbGuOFM6xRoh816QNquMOTJP4Es2zw55ODQdxk92ZX8qsddy78w5n/
         Ftln9WARkHCLoSIcaiZheT5xUo79MXE+fMOhMXSwjIzo4yY42ln73KXYf/5pi0h7GHOW
         H3QebflN66RRhI3mC+yfx+b7pbkLdzXJFG2ngRpbMcntcAqH5D3DvFZlhcf6/Np/WDUx
         +RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919965; x=1709524765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiLiFMfWKCcVhhDB/j6NQ7MKUt9nWfWJUvYg2/4dEk0=;
        b=nm3c1PeGw4JJ2/c2o7+GpV/tkE672CMA3btDbh6Y+G39Afrz9F2COKawb27DVmLdaf
         juZFAN3MRq+OvzosbYmKzPXlOuAkMKZPzUCo5PiAz38F8Yggrxbo0CdTWrMcOCTyPuNc
         zOTBWbCT5e3QkPZXyCG4Q997SdbQxcmJ+9g5ujPaWjCV1fJRzv3MBRXxzIhhXlBRCzb7
         E9Fpm+BeoOcw2NHw4ffp1tcqouXL8NvcjOhvaxFbm+RXfhFjXSwabi3FSiY0fVGEgq2S
         bNG/yJNe4caHT60un9eUgwHf+UcLn3+5TUEYurSuy5Fa5Lt28amFRe+1N6ag0t8diPLt
         fXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt6QrvdJklvH5GzGQOjHjk5wC7z7mDeEFDCrZRXRMVJZCte+61Onp7078Tx+2Qkmh9XpazubVEErRsVuX4FpynoS+ceZq2YhmuhaTH
X-Gm-Message-State: AOJu0Yy5T9T8QEXJUem2L9GGNQb5EKe2wXHMGlylEFU8P9GBh4TTscrb
	kSMvKDKHclN1XRcOIcCykgmtPuJLnDxFWe7+xXEZ65KPEI4rKk3l17l59QMPJnLdrPN7eBRW1Fu
	U
X-Google-Smtp-Source: AGHT+IGN3aK7O320K7eb8MOrqC1J7wETIlCGcBQj5npNjt6jSljmKpzLvD3ApAiqfFMyQJH6CruhYQ==
X-Received: by 2002:a17:902:e842:b0:1dc:78bc:ad0a with SMTP id t2-20020a170902e84200b001dc78bcad0amr7007029plg.36.1708919965391;
        Sun, 25 Feb 2024 19:59:25 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001da105d6a83sm2893426plb.224.2024.02.25.19.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:59:25 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 6/8] Staging: rtl8192e: Rename goto OnADDBARsp_Reject
Date: Sun, 25 Feb 2024 19:59:13 -0800
Message-Id: <20240226035915.370478-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035915.370478-1-tdavies@darkphysics.net>
References: <20240226035915.370478-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename goto OnADDBARsp_Reject -> on_add_ba_rsp_reject
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index a3a2fe72d644..0581ed1e9ed1 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -334,14 +334,14 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			    ieee->ht_info->current_ht_support,
 			    ieee->ht_info->current_ampdu_enable);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
-		goto OnADDBARsp_Reject;
+		goto on_add_ba_rsp_reject;
 	}
 
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
 			   (u8)(ba_param_set->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
-		goto OnADDBARsp_Reject;
+		goto on_add_ba_rsp_reject;
 	}
 
 	ts->add_ba_req_in_progress = false;
@@ -358,7 +358,7 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			    "%s(): ADDBA Rsp. BA invalid, DELBA!\n",
 			    __func__);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
-		goto OnADDBARsp_Reject;
+		goto on_add_ba_rsp_reject;
 	} else {
 		netdev_dbg(ieee->dev,
 			   "%s(): Recv ADDBA Rsp. BA is admitted! Status code:%X\n",
@@ -371,7 +371,7 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			ts->add_ba_req_delayed = true;
 			deactivate_ba_entry(ieee, admitted_ba);
 			reason_code = DELBA_REASON_END_BA;
-			goto OnADDBARsp_Reject;
+			goto on_add_ba_rsp_reject;
 		}
 
 		admitted_ba->dialog_token = *dialog_token;
@@ -384,12 +384,12 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		ts->add_ba_req_delayed = true;
 		ts->disable_add_ba = true;
 		reason_code = DELBA_REASON_END_BA;
-		goto OnADDBARsp_Reject;
+		goto on_add_ba_rsp_reject;
 	}
 
 	return 0;
 
-OnADDBARsp_Reject:
+on_add_ba_rsp_reject:
 	{
 		struct ba_record BA;
 
-- 
2.39.2


