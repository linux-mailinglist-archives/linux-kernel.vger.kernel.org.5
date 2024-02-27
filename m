Return-Path: <linux-kernel+bounces-82699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD8868859
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32451F24A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D757322;
	Tue, 27 Feb 2024 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="a9jfnqXI"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892E52F95
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008942; cv=none; b=jFQNnsWcKEE/2wWH2lvpdzDYX9ZpBJLofjLyDw1IMhb3QRd/driBaAxdE3GrhPAAT4sWEzWXe7VetKdWcHVpD5qtDJJXjeR+zdu/TYPnioueKgHZMYRWLw7pv9mm6OJoR8eahLwUVjRVDd1YpchvHQa7iJCkPvHxEFxCEgWGvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008942; c=relaxed/simple;
	bh=BF/sv0OBJ+auhhZiLNMXTsH8e8AmZBwl76hXFCd5Spg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1xU+SVBF8AfXZ/umB1K6Mu9Klm4bXlprDez1aDWy4ZhsZ8M2viPrrp79Ga3HlQkNAUAkraQvZ83/6M/pVyVqj7VvCcoHWWJslE+WTGdau+t1bfFv61xFIjWlrstzDxXElvn76i+/iuc9KxkVZkZxPlm0a81vAH6kgLPc8xxDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=a9jfnqXI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e4f3cbb518so1153772b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008941; x=1709613741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWeyU698U5yeL22d4/joOw8xFVDMJsDJjbUrJw2JctY=;
        b=a9jfnqXI7I35H87E0V1TkdD8v5jxZg/BLMtLvqtf/26AbltWuuFl+/4Jl4mNt55W0k
         yY3x6AfQZVsA00+Y/EVR1x0xS39cu45zmSqOVGraUPN2zk1G9XesahMUK75bEtKPnFyu
         oL74r320F5o5ZVlMkXdq/MtYTlzJKvlTSr4hHSJC6z0b+F6GZPbkv6vmhtgMadZr1A2C
         dTQ4wbNqBhi4Y46NOlHBx8A3R2DxBNOzBMZ88KcUqCpotNbNcK3prspfbyvuxwKvyLnS
         J4GYmQjjz0YH1quWaELLLtAzBuqKVXUZWNZjENTDqV9uS78nywkAauEjT7V0itmfKq3S
         GADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008941; x=1709613741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWeyU698U5yeL22d4/joOw8xFVDMJsDJjbUrJw2JctY=;
        b=YbJZ6CN0fuor0aMyiQ2GlX926rEZJPR7+VsnndUDtlAWziP1FhZ8QOXz3lnu2xFIa1
         IRwtXZoz4ogm5Ii63EtS2I6FlB0/Nult0KZy22vohlPk62JJChvpYpY3PYY/Z6UCU6mj
         LMn9XF7mXItlR4xOnw62ZhtoF9Xmg1ZoEmtGAc+8hPN2W/Rv7EkglvcfbxbKI8Z+0TOo
         ikVlWamve5Itb9KvrpH+wdQZa9Cz4AXgk06XQuwyAz6p5fOGJV7y0bUvAShqGFNQ+fT5
         riypAjQc+xFwJN/61jlf61s2ZOVTbakfJcvtZ9S+Wkv4iC2N2DyT4N9cfvCZLK7OrRxU
         gdqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiL0BGRh2CXpkZ1UkH6prdOK98s6HUj8mmjLZMWLBFoPzAb0xYWARNNYdHBx/MCr9dSwg7qudyIgsn4OpcSeVgVyW6Dm4MM2yWPNuH
X-Gm-Message-State: AOJu0YwmSgIr2lgFGZdWfc0JaIkQVjhIkOOk+1hwsACoydMPLYwXLyIm
	ARS404WbuEyhOuNfp6Ej89dFCifiL5Cdx+uB3rqi6OZLiw54SQGDvO1u54QpRqI=
X-Google-Smtp-Source: AGHT+IHPRE944yFD9VtGqCj/eXEhX45IWPacIf2hxIVECOn/sy17eCcM8px+aYUvMT4VA6Ye4ySO7w==
X-Received: by 2002:a05:6a00:3d54:b0:6e5:3b52:d4bc with SMTP id lp20-20020a056a003d5400b006e53b52d4bcmr3542618pfb.15.1709008940787;
        Mon, 26 Feb 2024 20:42:20 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:20 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 17/20] Staging: rtl8192e: Rename varoable asSta
Date: Mon, 26 Feb 2024 20:41:54 -0800
Message-Id: <20240227044157.407379-18-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable asSta to addr as it references bssid addr,
and fixes checkpatch warning Avoid CamelCase,

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 567891123960..d19895220878 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2238,14 +2238,14 @@ u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 }
 
 static void rtllib_mlme_disassociate_request(struct rtllib_device *rtllib,
-					     u8 *asSta, u8 rsn)
+					     u8 *addr, u8 rsn)
 {
 	u8 i;
 	u8	op_mode;
 
-	remove_peer_ts(rtllib, asSta);
+	remove_peer_ts(rtllib, addr);
 
-	if (memcmp(rtllib->current_network.bssid, asSta, 6) == 0) {
+	if (memcmp(rtllib->current_network.bssid, addr, 6) == 0) {
 		rtllib->link_state = MAC80211_NOLINK;
 
 		for (i = 0; i < 6; i++)
-- 
2.39.2


