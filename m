Return-Path: <linux-kernel+bounces-98376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2887793D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031F91F21771
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AEF3FB95;
	Sun, 10 Mar 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="gJIaLuYt"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B33C484
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114962; cv=none; b=lUzkgCcqekX+YvAqbSJO9TgzpfSYljxDcwtwOQeZ8fd5/woynfwvD96aM+kZ7cvXFeNuxOWWWHzQEbNd7w3mAl9QCv1omBVJnZRZQbWUUdnj7oZ8priILGIr3h0p/fMlZEP3Br5qC/XVvyVLlNWLl0xqmKws0jtGML1xHCD3+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114962; c=relaxed/simple;
	bh=bweBxxz3LlZ0HmKixuMAFxkEfCgWUQfWz3S2D81EsJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GiZRitfLfAL51x7POczReIkTtukBY3yeJhAr8WNSc+3RtM8MZR1eVJSGjr9GTyjvRIhNxd4SzAyavC/uLgdD0iXIPB1JZUvrcHvZjAjlsCe20fsp7Mi+j5oaVV+U7HVk6z64OADDvYCv0IRHbJDGoWMdyf0EnnpGA2T9rrPK8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=gJIaLuYt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29b7164eef6so1922078a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114960; x=1710719760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBTPiNFuf4aLeiCUUd1FRn8541x9xrCbKeUzzWFh6y0=;
        b=gJIaLuYtmiojDD210dfDrpHi0QeP1aYrG59hqkxhaWFUSiKolrgVZBSIDkK0CXYK6M
         rngFaNYcS0CHUKSAxTG96eV7HCYWl6ACcCmjHdDiGqjes7XPBqGssuD6LjOpr55cY7Ks
         jx8Wd0oCPfAAF+aOtcMPc3O1+bvCJBJcQtX3CH4ssKFc3J84sTVWN8JnPhvPSddRcYR+
         F0JtcyCA3OIb32X+HQeHYTm/nX8zJsO7vbVwdWyrqDLqzRoaDPzK7XcAQzayT4KtYWDw
         1joxfD+SKPz/h/4/VLryPpwr+mtMBiuAaoFk3Kb0VwcUXmfvwmt+dbBuU07cyKkVQyTI
         RcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114960; x=1710719760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBTPiNFuf4aLeiCUUd1FRn8541x9xrCbKeUzzWFh6y0=;
        b=Pvl6o8J5lMVWNyCkTaHgo77MtXTSpDYMGdusvVWaV3t9LSUQqNmvKzxXkyMQEPsHKw
         k4gJ3jzbW+u6ZQlaPyCoaWS6XPK00wmMOMxmO6o6376JpddF1MTCI+y9a/ojD+OdW355
         +lgXRUzCWs2Pyf+qlO28yIjULIfiULsoeCQBTeFFt1PMtTTwIO/AVlphsJ/6EZHkFm99
         4SeSxswo6KFVg6OIVfrZ9NSOV91NBOpxJRWautnV4EDo9Kex5tzrdSLx32UUgAVJy1xA
         YpL+sEHLTi4GjizcLMQEv3g7wt1QtzFEc7C13egt/s7APAZeH3/g1yV6m92e+5mh6PCv
         oA4g==
X-Forwarded-Encrypted: i=1; AJvYcCUNfehV2lSapZ9SXSwf/vwlQqNwTgqBQsLxZt4/TCa2/DQWx0Lm7jTUnqV0XozhAZrRECKdu4oyiTwl6LMIR16XmRkR5n7O6rMlNMap
X-Gm-Message-State: AOJu0YyHfEsx8HjO9aw7sBDI7HJNjlHR/zAbE0XhVTpE5BCO68P41l/2
	2ob6yJ9VN8BYb16iI+QnIsV/zQjDIsyBYWpp2B/w+QjfRcm4BUYwW+nJo4eWOmQ=
X-Google-Smtp-Source: AGHT+IEZmMmuGHF5Ga+XC93hN0IcCqDus5vAc6pEcEZMM5blm/JErY6CmFJSYnAk7cNANb0tFX9CVQ==
X-Received: by 2002:a17:90a:300a:b0:29b:2779:2a69 with SMTP id g10-20020a17090a300a00b0029b27792a69mr3712320pjb.36.1710114960070;
        Sun, 10 Mar 2024 16:56:00 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:55:59 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/11] Staging: rtl8192e: Rename variable aSifsTime
Date: Sun, 10 Mar 2024 16:55:46 -0700
Message-Id: <20240310235552.4217-6-tdavies@darkphysics.net>
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

Rename variable aSifsTime to asifs_time to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 15b0ac6e6eef..dcb78cd2e840 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -130,7 +130,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 			 &priv->rtllib->current_network.qos_data.parameters;
 
 		u1bAIFS = qop->aifs[pAcParam] *
-			  ((mode & (WIRELESS_MODE_G | WIRELESS_MODE_N_24G)) ? 9 : 20) + aSifsTime;
+			  ((mode & (WIRELESS_MODE_G | WIRELESS_MODE_N_24G)) ? 9 : 20) + asifs_time;
 
 		rtl92e_dm_init_edca_turbo(dev);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 748bb25cbd23..640fb8abcfa3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -299,7 +299,7 @@ enum rt_op_mode {
 	RT_OP_MODE_NO_LINK,
 };
 
-#define aSifsTime						\
+#define asifs_time						\
 	 ((priv->rtllib->current_network.mode == WIRELESS_MODE_N_24G) ? 16 : 10)
 
 #define MGMT_QUEUE_NUM 5
-- 
2.30.2


