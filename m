Return-Path: <linux-kernel+bounces-80500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D808668F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA5828339B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0212576D;
	Mon, 26 Feb 2024 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="TMRwYD0U"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1C208A3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919805; cv=none; b=eN9Hh+R2Jbxnbknw42LJX8nNy4AoaYYvyJ/lFKtYhd8wx3+HSYH4hanxw8T81QSqVNObwCPO0u8LWnlQDwSJNmgMKO5hzh/ACDX8E5feoQZY9rpJ+JqB1dhPsaAqqlTxEmHqldM4N7NWn9oWZqXZULhpXPVavQX5oSvko4J152I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919805; c=relaxed/simple;
	bh=ccgrBS5gx0A8n+xON2ivzQIcNrT3sswX1xiI4A4qBo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEzzr16+yZCP2XatNL/6zvH1UcgBBoII7qf/iLRE/QxQlIId9xslN4Ygg0Td5c/kZktrWz0i4FgK5HLbrxULTn4v20LFDGTRgwZfzH5yEIWdeIMSIjliO9GkPc+Bpz8I6PxBd4vxEAQeBn07xP1JIm9cWgdUE0HluZq+ImBKEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=TMRwYD0U; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc139ed11fso15855355ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919804; x=1709524604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGkMtZnMwDRCTDJWkTJfXl4hQDwdTzERQIWmh/gkWIo=;
        b=TMRwYD0UtIqtSYDttiDRhduGzwzoEK7y+gLCYz7p3fsueKGL8kFBskuTdgW8L9vupn
         IOfGmlpkzAM7TCnvOhsSQnLb/QEPAXw6Zfp1Rg7QMq2kumVy8fkTbMUmoPn9O1YDcQea
         SXY2ZatJ86baAnjlq4a/iKQtIMt9nCehe6VTh0rO3pU+4WLPEfSFn+58kTDCSNTUwW6e
         wThJEm1ltZqNsoF/W4v4jbP+1G3BQgiZvB3lKoFnwFsfjlrkKujjE+IelNAfvkt2xBbM
         OXlHqHCq7QjYk6wIOSHHn+kjyKlrb+9yKIWr9KRlZ9ai0k//FIkAR7/lJM9oxRacJNGo
         QTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919804; x=1709524604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGkMtZnMwDRCTDJWkTJfXl4hQDwdTzERQIWmh/gkWIo=;
        b=Q6ipVOTJtUi7i2zw3rTkclUTnyYwtxRqWgIlfHVn1nOx995qqRz4krCb0RqwcFSFo+
         NbIGbtDP4iqawojeCjfqD/53hZ3x4buhh9hj2P6+BgBUodE7Z3KrSSvXtt0hQzZ5tkVy
         geZwgEE6CKyLUfbboiOPqemnhixBMj7bxDKGiUlaFBO3SZsyGu/ngrETU98IS7twddfH
         CBzc0KuZHKPo9QfkRW/YFt6zzu5340er2BEH9kqxsVW5SnpFKxPCbn9dTXKMvvb8wSdh
         BS26JLqF3yEFdX7v5EfAUufnst7FMy78tTTzcAZtDhaNV3qaBS9OoNTJQe2C2kdohJog
         0dZw==
X-Forwarded-Encrypted: i=1; AJvYcCWA3zb56SJok4GYaUeF/26izG/8RcDIt+8MdUQMIy7Jd7MT4syxSu3lhQ9y9Riy0IjZRCxSS2q0RPayTzM/g4uYhSB82tnVl7kaBPV4
X-Gm-Message-State: AOJu0YxKWzati2NZzaJGU0w1auC7GJw12mzxVnQi1wM3JXhYUQZtzDGx
	4D44NQaK/gVgxuW4EPUl1SjtoMjiN0G7vTEish24Tzgl316tG1PsLr0/Wk8dGEY=
X-Google-Smtp-Source: AGHT+IGxCM59OaqZsOtByTHoyhBEXZjSWSq/yZe8pOyyOlKhllSgs4tQKu17eF1+M9tRxxB6zCHKNg==
X-Received: by 2002:a17:902:e541:b0:1db:fd93:8d4d with SMTP id n1-20020a170902e54100b001dbfd938d4dmr8274318plf.15.1708919803926;
        Sun, 25 Feb 2024 19:56:43 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:43 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 18/20] Staging: rtl8192e: Rename reference AllowAllDestAddrHandler
Date: Sun, 25 Feb 2024 19:56:22 -0800
Message-Id: <20240226035624.370443-19-tdavies@darkphysics.net>
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

Rename variable AllowAllDestAddrHandler to allow_all_dest_addr_handler
to fix checkpatch warning Avoid CamelCase,

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f99cc5b639fe..fc5014f719d7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -661,7 +661,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 						rtl92e_is_halfn_supported_by_ap;
 
 	priv->rtllib->set_hw_reg_handler = rtl92e_set_reg;
-	priv->rtllib->AllowAllDestAddrHandler = rtl92e_set_monitor_mode;
+	priv->rtllib->allow_all_dest_addr_handler = rtl92e_set_monitor_mode;
 	priv->rtllib->init_gain_handler = rtl92e_init_gain;
 	priv->rtllib->rtllib_ips_leave_wq = rtl92e_rtllib_ips_leave_wq;
 	priv->rtllib->rtllib_ips_leave = rtl92e_rtllib_ips_leave;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index a5925fe75a6a..7ad8bab23224 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1493,7 +1493,7 @@ struct rtllib_device {
 					   u8 Operation);
 	void (*set_hw_reg_handler)(struct net_device *dev, u8 variable, u8 *val);
 
-	void (*AllowAllDestAddrHandler)(struct net_device *dev,
+	void (*allow_all_dest_addr_handler)(struct net_device *dev,
 					bool bAllowAllDA, bool WriteIntoReg);
 
 	void (*rtllib_ips_leave_wq)(struct net_device *dev);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 644e2dffd185..b32c190f0113 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -355,7 +355,7 @@ void rtllib_enable_net_monitor_mode(struct net_device *dev,
 
 	netdev_info(dev, "========>Enter Monitor Mode\n");
 
-	ieee->AllowAllDestAddrHandler(dev, true, !init_state);
+	ieee->allow_all_dest_addr_handler(dev, true, !init_state);
 }
 
 /* Disables network monitor mode. Only packets destinated to
@@ -367,7 +367,7 @@ void rtllib_disable_net_monitor_mode(struct net_device *dev, bool init_state)
 
 	netdev_info(dev, "========>Exit Monitor Mode\n");
 
-	ieee->AllowAllDestAddrHandler(dev, false, !init_state);
+	ieee->allow_all_dest_addr_handler(dev, false, !init_state);
 }
 
 static void rtllib_send_probe(struct rtllib_device *ieee)
-- 
2.39.2


