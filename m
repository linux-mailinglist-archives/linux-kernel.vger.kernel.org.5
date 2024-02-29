Return-Path: <linux-kernel+bounces-86681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B7886C8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C680284DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7267B7CF24;
	Thu, 29 Feb 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW5ojejy"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389107B3D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208897; cv=none; b=U0+WrG3auUtaJ9wUVYGcVEeUfEOkb2jieAXv4SqH5q0UptPWp0Qf9zjOLMUrHyDCg+pFECMQ9VcgOwbFSfqA063Aj3X1BTK2tlIwm3eUo5nIK8+kLcI0fpL/6f8en6dNw/0c9Ztvp9qJnyGKGVwm4Z9CqlLr//amks22zusDDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208897; c=relaxed/simple;
	bh=ySkx+nF0oOo09md0ORc8Dfqmpo0SPAXHrokykDeq3VI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KaX4trq5iYDyVhka/TsZJ5BF/7PA8pE4JH1yFdphh8BLSU+5TfVchuPLqp5DU6BFaaccbPSXw4vf7bsHA7X5GfrGOVfjBXWhrAJGmfwnue9RrWpJzj8SPSDtq9ghzzAkO7ZxwF8qhZwes6RdAKWqfZAce3crze2eJ30IXmhhECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW5ojejy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d2b354c72so650579f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709208894; x=1709813694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J1VdybrLw49RhnSmXSNVwhPANRO67JVgxx+H7CTRzq4=;
        b=RW5ojejyLwth1o6NjD5u27U8LzdQZY22MuvM/i5p2GaT6dhImToDOg8+T6vFX5DOXX
         Lo3qtFIAw4cPf7CNL+69ulqBQMTVSoONj11dfwKIHKhvT4ekbNeVCpgMQs6upQgvHGrj
         tyo7eauXvl3bO4itmk+4jMBKXqbPkK1CYGSyjyl1m1jEFitnQxhWGoiPbySu5UZh1TXw
         CSrVeKUPCaP2KStRCHx2Bqtp2dSg2tEG9QUvCUfsKvCafp/jKu9r8j7yde7GkQpcQlGf
         z7L1RwwBMFD76GVgMg0gnTyxoSJBQGSvix6bEacki6lxZQQcwjLCduXyKA6X/FuobjD6
         zzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208894; x=1709813694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1VdybrLw49RhnSmXSNVwhPANRO67JVgxx+H7CTRzq4=;
        b=Vseb+fR0IFO1bjfVd0Wisw4ELlR7CUheCN9Lj3bgCIByx1wa3bXqFwKEkCsPXhFf8M
         LaCLMtkCs/tisZwKxIxvdEXiBIC/IEMFE9Nc5qRg5oFoIAWES11SAMwD+sOhlMhRRStn
         BZMRccCEymyIcWrVggDtAN3Nss+8IfgNyw0stZGvntiPzEREgeVpC3gonN9txFZrOMYe
         fCo9H+GVAYEQviAlnOQa7z+ShX5sPgR5NSDZuhY8JvQmPXkvxTHeM5taArf9fwbo+OAU
         yICVkp82qQ4mh07+4T+vL/imBNlXErYA6miiSCUChaN0nNMGBzSxOB3Ib2NTtuOfcxuc
         7YeA==
X-Forwarded-Encrypted: i=1; AJvYcCXlzvSWrs7Rgj3gBfEZ/jItZNhNepIdovcfbH33x7SDQ3xSmjTm8p3cwgTiSi5TGOtD2v7N/ryl+hjmTOlaI37xZm65pTFTJB1/8KVD
X-Gm-Message-State: AOJu0Ywcy8LXQYgaTaQ2zgz29pUBbu1daTeEr4F9Ih20D/lnPDefERla
	Mk5krsUKerUDUB9YbgMh+gVV5Gbk1HyYUOAoREMJ9hs/g3C/2xjx
X-Google-Smtp-Source: AGHT+IGO10l0BIfkOZZeL6729rY0wh3AB0FiSPqwCHnZZfdJzJs7YzsXac6E2dDLIwI3+lkO+59Cug==
X-Received: by 2002:a5d:4581:0:b0:33d:bb65:806d with SMTP id p1-20020a5d4581000000b0033dbb65806dmr1352355wrq.50.1709208894422;
        Thu, 29 Feb 2024 04:14:54 -0800 (PST)
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id bj19-20020a0560001e1300b0033e0302d892sm1678557wrb.66.2024.02.29.04.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:14:54 -0800 (PST)
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Thu, 29 Feb 2024 14:14:51 +0200
From: Meir Elisha <meir6264@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@gmail.com>
Subject: [PATCH] Staging: rtl8723bs: Remove dead code from _rtw_free_network()
Date: Thu, 29 Feb 2024 14:14:45 +0200
Message-Id: <20240229121445.22257-1-meir6264@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean dead code from is_same_network() and _rtw_free_network().

Signed-off-by: Meir Elisha <meir6264@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b221913733fb..a6bd7f15aa08 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -169,7 +169,6 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 {
 	unsigned int delta_time;
 	u32 lifetime = SCANQUEUE_LIFETIME;
-/* 	_irqL irqL; */
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
 	if (!pnetwork)
@@ -389,7 +388,6 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 	d_cap = le16_to_cpu(tmpd);
 
 	return (src->ssid.ssid_length == dst->ssid.ssid_length) &&
-		/* 	(src->configuration.ds_config == dst->configuration.ds_config) && */
 			((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
 			((!memcmp(src->ssid.ssid, dst->ssid.ssid, src->ssid.ssid_length))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
-- 
2.34.1


