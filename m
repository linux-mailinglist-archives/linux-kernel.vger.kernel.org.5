Return-Path: <linux-kernel+bounces-98375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B6087793C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AFF1C20D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399C3D995;
	Sun, 10 Mar 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VzagO1+j"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0D3C08D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114961; cv=none; b=Yh3MGi1nuMQRMLuFS8Nzi0iQaUquQVF4TZ9/blQ5+NrLSrK5U8TSdMgD5OQA1sxYJaTBNNeZkKiNF5pjEPjt7KO9sWxDGhhNVmMIWO1f2tqzvxNcdRkb2uFuTKMjTGkaVM1/Vobe1B5fAfR5ocDJtmfmQ0kOsdQJjc9OA7acGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114961; c=relaxed/simple;
	bh=/7W2TBTFMXEWX5q4IZIqxcsH8VjtOr50ERYjHCmesi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rca/AsKW/J1FCSo2pSW5DHbylENPOJb3evPHju2t/C5gFv4IgngtFP+rmexRq2oeXHfONrEVJ0E4nggicCjedd66mpejFbIutLn3uiuXNer60TmFttEQOAX+gEaEtUvhWTFRSGX27ebDS/dXCzkRi5zCdT69zb1nKIfLrg9l+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=VzagO1+j; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3563952a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114959; x=1710719759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFuDApE8FQFMLl4CuhW76of50jVUBMd2o0lVaLFxbvY=;
        b=VzagO1+jWfI9bDvHn2AZbaK/N2p92R7kETn6tsYAMYVQZfSgOjGxrN/j/clE8mOOvA
         7UiJcJPvFBvpr269BkhcpVrmE65PWE0UFEBCW1oP4FqXx56ZLFNNezMcRF3yhAQlFvCv
         9uipNjyRu3rOi/hSc3dkIzEFaydQ2dyuu83L2fLYE4rX+wW9C0ESDTmflltSysBKkuFf
         NsJWtd0f/B9cfOqYCiTjn63ywaNxxwj2gtJ8zDm2Y8SAqYU6yCy3mJeWudHeWDVJXgy5
         nlv/G36QwAEqznXmhgWOrVsBdkE2VTuPnhA1czSnWSF64kK7Sm7gh6hDMq4OCO6mFmEQ
         hu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114959; x=1710719759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFuDApE8FQFMLl4CuhW76of50jVUBMd2o0lVaLFxbvY=;
        b=MrqndcXyi+HEaglOpEES3obVc2zPw6ily0XIJZkgI5MrdNgYexq9b3BR7LSMf9j+rR
         BX17/K2eX5FMLIjdD+9rETXbPaPEdCHT7VG+Kv8q1zob7A2Be69W+9mEs9ukP6cQnPH9
         keM/32C9cEsXWHsmL/OdSePWNEhVNjY06RvPOs1APWczu9yC5MzhmNuSWHzBSKX8JXTO
         SvxniTelD8SZioqMp/BGfltyHsGgC+pOW9EP0yDFD0uylgJvyaWK99N/cfveVqzo0XUw
         YXU/GOWHJzrsy8smfsRQ+fyjosKJQOszukMnpHUZzm0/30+NEi0CiW+yvLnxKz/wAbIs
         bK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZqdsD8mAm6zFVfDslgw4+FoFuoRO9P8CBFgq3qyzjN/dNCS+aGqAtPhyVaUTyDQhlMZGrTEvsWaonCNHkFIpdo13VG89WI1pedHvS
X-Gm-Message-State: AOJu0Ywh5XLv+vOnNfBwC62ApRs8FUnl6yv205yldmL/7TTSdWfcxcG7
	LliV7TEcWZorqF9FTwkzEi+J5a+/D8bzy1npab371U2yn7qVv/UbuMzzgN2z0+k=
X-Google-Smtp-Source: AGHT+IFvNR7UEMWVzVCIr634nx0mJcfHMJDJZXdKUnyD9DRq5o0Osi1gfGQWUr1Eps07OMoJ0910MQ==
X-Received: by 2002:a17:90a:fe10:b0:29a:ee6f:58cc with SMTP id ck16-20020a17090afe1000b0029aee6f58ccmr7323537pjb.6.1710114959374;
        Sun, 10 Mar 2024 16:55:59 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:55:59 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/11] Staging: rtl8192e: Rename variable Frame_Order
Date: Sun, 10 Mar 2024 16:55:45 -0700
Message-Id: <20240310235552.4217-5-tdavies@darkphysics.net>
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

Rename variable  Frame_Order frame_order to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index fa96a2c2c916..dd0e2931b9ca 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -625,7 +625,7 @@ EXPORT_SYMBOL(HT_update_self_and_peer_setting);
 u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame)
 {
 	if (ieee->ht_info->current_ht_support) {
-		if ((IsQoSDataFrame(pFrame) && Frame_Order(pFrame)) == 1) {
+		if ((IsQoSDataFrame(pFrame) && frame_order(pFrame)) == 1) {
 			netdev_dbg(ieee->dev, "HT CONTROL FILED EXIST!!\n");
 			return true;
 		}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e165f1e32e7f..748bb25cbd23 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -343,7 +343,7 @@ enum rt_op_mode {
 #define IsQoSDataFrame(pframe)			\
 	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
 	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
-#define Frame_Order(pframe)     (*(u16 *)pframe&IEEE80211_FCTL_ORDER)
+#define frame_order(pframe)     (*(u16 *)pframe&IEEE80211_FCTL_ORDER)
 #define SN_LESS(a, b)		(((a-b)&0x800) != 0)
 #define SN_EQUAL(a, b)	(a == b)
 #define MAX_DEV_ADDR_SIZE 8
-- 
2.30.2


