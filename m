Return-Path: <linux-kernel+bounces-98377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35C287793E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FCDB20F9B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2C83FBA8;
	Sun, 10 Mar 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="EqCgf90j"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B473D0C4
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114962; cv=none; b=u1xkYBTw1vqpCwfTxIDk+WkpFfcYnO8P2lBbyc/IVQqfKYsQ9KPAW8QCUoTo52Na456Fpzy/ZVDFVN6EVdLieoxc+TiYB2qsAGNLw/yduBxG/E5V+4UQHSGJ0RVnclc70uSDMDub33I7+rt9Zequ/C7+rtlFyUBpPca/Yz1AOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114962; c=relaxed/simple;
	bh=2z5au05SIFx2OjI10T3LxZdsNMivY8wiNBtTg1TTQfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSBM3MQXexF3aTPgY6OlqS9JA1xxEjiMNwSWzfXHw6sotxC+f5wApjHWwfI3tOAVys2ArCMZDhA3NIDkvhRXfaMUH9FP+Ca/C9I11Hh8AK0BQOCl+qxFa3jhoWOWnWTtQkKFCV5oUNLDVMkUxdMRFTKwhQvghYMyyf8BaM0ZBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=EqCgf90j; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29a2d0f69a6so2510896a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114961; x=1710719761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aLp3TbZt7Nin0dNx9AujLhlrUoyJ4oXXhWmCb5RlNM=;
        b=EqCgf90jrm0IPIw0JPvIKdX1Vjc7daD3hcMpd7HjDY41QQCNrfkjtL14r1Xdc5Hpvc
         jgVSVvc4eRivuF0VZKJ7BdH+Dk8dHOpLiseHb0eDGal8GsrkTEpaxtFxxbKNp1b3uE+6
         qxvCz+spk9kZ1xPvr7YwucFH+YYOe61I3wbm6Kh/TDh+mwPFaX5+dWEysD6NcN2mg+Hv
         VnR8z5+sp81a61BYYKTkmZ+wveLahyuY5l+kdyVkEix6EhkIya5W8XdCUd4vO2OOxyU6
         yu786ODhvjHVitVXajNzcWOkMphX93I4kqtbQSIQXpyCwOeM6tvEQeoVO41eJ4aDANuP
         Q3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114961; x=1710719761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aLp3TbZt7Nin0dNx9AujLhlrUoyJ4oXXhWmCb5RlNM=;
        b=TWliNiV+UNbULl4GHIll+iWgQh1LlWFKU5ukvleEirGc25OXOwxVpzw9abnn7hK664
         3yGOy2bSl68ws/a4BpW64tS4LplfzGyOnVl6PdyvhVGT/LI86ihOV3l1Mn/cY3hI9bDF
         KzPzHQGT4i/G1ZSv0+6OgVvXue53Jm+DhKAm9+9QR8ltBn08MeXJqjr0ZuEkuSiYBZOg
         f8OOxKAO2vmPM4DQl98lXYBnv+iLy2KsLuu4rb15HpgNnyHzVJFjUkHXs/dVI49IWowW
         UpTaYZ4IrPo2R6Dm3nktX5hIYAV8fgX6hwGyaQMOxKunsQGLSZkEV68/JWLd408AaySw
         FH4A==
X-Forwarded-Encrypted: i=1; AJvYcCU9OVoJg5SDDuWokzTT1UhNg4eUAGmaN79jxRaHgRgqC5RSLlSalskpGiFPVb1bsO/E3G4fPiThSCvnBmgk3yc+bDLqbtw62k03hCn8
X-Gm-Message-State: AOJu0YyGDZ1tnG+wOfdKPNlgjF7dmLTdZn5vyffVWyWcaLTwlezynhdy
	rklGQGcUmfy8sKgwRoq5yMv2nn+LvIpwhO0vqup71D7ge0Pa0iGEK2zsSM0vfFY=
X-Google-Smtp-Source: AGHT+IEQUXU4Mse6356LFmqZAOo6r/3WjPG3NJ6sjRGTpTcR4Wb8U0xFVc7PTDhsih6auD7Wz+96ag==
X-Received: by 2002:a17:90a:43a2:b0:29b:90d7:36dc with SMTP id r31-20020a17090a43a200b0029b90d736dcmr3537987pjg.19.1710114960871;
        Sun, 10 Mar 2024 16:56:00 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:56:00 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/11] Staging: rtl8192e: Rename variable posHTCap
Date: Sun, 10 Mar 2024 16:55:47 -0700
Message-Id: <20240310235552.4217-7-tdavies@darkphysics.net>
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

Rename variable posHTCap to pos_ht_cap to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index dd0e2931b9ca..1c3ef1b7ebd8 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -235,7 +235,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 
 	if (!pos_ht_cap || !ht) {
 		netdev_warn(ieee->dev,
-			    "%s(): posHTCap and ht_info are null\n", __func__);
+			    "%s(): pos_ht_cap and ht_info are null\n", __func__);
 		return;
 	}
 	memset(pos_ht_cap, 0, *len);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 640fb8abcfa3..525242b0313f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1736,7 +1736,7 @@ void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 			enum ht_extchnl_offset Offset);
 void ht_update_default_setting(struct rtllib_device *ieee);
 void ht_construct_capability_element(struct rtllib_device *ieee,
-				  u8 *posHTCap, u8 *len,
+				  u8 *pos_ht_cap, u8 *len,
 				  u8 isEncrypt, bool bAssoc);
 void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
 				u8 *posRT2RTAgg, u8 *len);
-- 
2.30.2


