Return-Path: <linux-kernel+bounces-80514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344A9866912
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FA71C2386C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB51CFB5;
	Mon, 26 Feb 2024 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Y864EOVI"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F91CFB2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919964; cv=none; b=NEpZsHBWUt5EudTAAaI43aPFNxN9lgjwgPKyHVHbo+wpxLwsa2BhpdgQGR81AkWFYLOyaeVEvY7PDeNjiBatZILBo0Y9xbJ1zkGqHcnWsG7IL1sDOVDxw6qfSyrFLI9gW+Mm8GP5/Mqp2SUXNbPrqEwWE2Os1cMHpfVX3Sa5Vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919964; c=relaxed/simple;
	bh=CUzAmkzeuNS+ardZO0IXvXaDVeR+7cwztnx1t8/HX94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBsngiqAo0Ot7XVUC/kSKIVYkAIZdV/kUk5XPJkCJAIHfhvEiOxuETIG8pQNDcttZ0ux0O7/VC7KXg/Yj/5pgBZ7Imwxl6pLDI3oFqqvbc502cBNZDbJA0Ha6oU5u4mLbfOeDtDY0Oq6suy0ratuVQbBjLJvtg6Qw1GfkjjkpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Y864EOVI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so1365976a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919962; x=1709524762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drEptZxnwbPEaWM9Gew1sqUiaGk3zefYJ8jVoMExPx0=;
        b=Y864EOVIB6+n6K+aVdKvLjye43O3QDHWbexA8zcBvbEHOgiz03np6VUy84IzSzDFnu
         uaCPdLx12irtjmwgs8SeW22Ta/C6zRLWPcfHJxYJaoqVUZUs1ZWI9/BSx2bAHpi4YMua
         Z7yqlod/JzGBJLgcxXho0C9vP8pCCDGmdjWu+qRz1h6kLowWf3GnITPRlJAdphiRUE1B
         eFEBita854RUOWCLKIZq3aCb/4da/C2toMT51eataWy1BjczxVMc06BlImGz6cRjHk3V
         PUsahlZ3Jv+RxcsWDROUK63jOv71guHn/0pys/OzJ1Wt0KJElHSy/BXANRHgfYfrcziN
         1OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919962; x=1709524762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drEptZxnwbPEaWM9Gew1sqUiaGk3zefYJ8jVoMExPx0=;
        b=fAZsiaTL0f7KRaTf6kdq9cPKPyI0aDDeYivfqHoY0C1uBbQlQZpM9HyBq91qT04ohl
         pveCZvhPMxRiEUwlrRTTpRMgEenGpLoumxFbGrS2klSBZbTH71bfatI7FPO3FJcdm1fe
         T69TKjzXgdM/m1Dp1hWWjtLCzCwE+b0IrISzuo90eZYXGPtV1p9hCIncRiwMV6N5MGw1
         IlhJAOj3DMfJJ+OXks2H1Vu34iyCP1XzqGB2MdR26Vk92FIqNNRlKttBa1niGXzcIp7z
         jkcmzxy+ImdoP4dkH9ln+Wtovx4WSi3PT3oj+SGsrHuxe/QQJKar7KJ6BIp1MiBrLl4Z
         WQGw==
X-Forwarded-Encrypted: i=1; AJvYcCXryZvCQDwQH+m9RvcHJEGBGImD8kAYov/9XM9Z2wQxtashEC1eZMz5uapYYnl6pnh3Gam5H2S2B9VlCjmc4K9K/XZ5tw3d1cUiazga
X-Gm-Message-State: AOJu0YySOkcEeyxi0wqq0Ad1ZuweNrjTbPKiS4k264IHAWvMOHnN9ReA
	8rl4npPQgFTREQ6Wrm+oZK0IuWuIazhRDJffQPsCRPqppSYmJgFQkco25H1xiTQs/8VymtTYxfQ
	P
X-Google-Smtp-Source: AGHT+IEFhqsmKVfTDyyxbzbGk44AfA5zmxXnUw1DK6TLDxr7yPgj1jVL6ty5kAY7muc/w9Fh1dYxrA==
X-Received: by 2002:a05:6a21:1644:b0:1a1:3b8:8283 with SMTP id no4-20020a056a21164400b001a103b88283mr101250pzb.47.1708919962711;
        Sun, 25 Feb 2024 19:59:22 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001da105d6a83sm2893426plb.224.2024.02.25.19.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:59:21 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/8] Staging: rtl8192e: Rename function rtllib_send_ADDBAReq()
Date: Sun, 25 Feb 2024 19:59:10 -0800
Message-Id: <20240226035915.370478-4-tdavies@darkphysics.net>
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

Rename function rtllib_send_ADDBAReq to rtllib_send_add_ba_req
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 030e0a87c931..1aa57f654b82 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -173,8 +173,8 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	return skb;
 }
 
-static void rtllib_send_ADDBAReq(struct rtllib_device *ieee, u8 *dst,
-				 struct ba_record *ba)
+static void rtllib_send_add_ba_req(struct rtllib_device *ieee, u8 *dst,
+				   struct ba_record *ba)
 {
 	struct sk_buff *skb;
 
@@ -481,7 +481,7 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 
 	activate_ba_entry(ba, BA_SETUP_TIMEOUT);
 
-	rtllib_send_ADDBAReq(ieee, ts->ts_common_info.addr, ba);
+	rtllib_send_add_ba_req(ieee, ts->ts_common_info.addr, ba);
 }
 
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
-- 
2.39.2


