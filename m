Return-Path: <linux-kernel+bounces-86060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB686BF15
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73471F226E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876683984D;
	Thu, 29 Feb 2024 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="dTLHaCDV"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1141236AFE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174619; cv=none; b=WYR/DR1D9yXee2qLowIKUkxm2mYGhpEWhiNvO/RIqBSDn9fN7xM6iTpiH2PKiDOUtBAqd/u3D/tvCp4YJJsVuND0zVlDMlarWNqHIlIsxKwnNyA7p0sbUVNE7GjliVeIuBenQ/0D9u4M0jU55GG+v/tlQ7L+CUlzSjV2K2OVyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174619; c=relaxed/simple;
	bh=F1ihdIW8vfyX3y6wO2jcGVCXQ20EA2UlCt9aoxu89jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtrwdIr+7dBpuL1Wei4buGfd6W2rUU+zN9HGGMhJ6p3CNkF6Yd/6u9zUQNxKMdua93DYTZOHSV1ErTH1neEONC+7OG+q1XsfdBUFa1WUvZBM/yzsk+G2HFx9N6QvIb5RY2voHVmH8vdxnaGbU9ys1AoL9fZzNsS+8V30wtmPr3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=dTLHaCDV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e58d259601so148804b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709174615; x=1709779415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNnU7s6E97gQJp6cYkW4MWjfZimKMSlrbqPhhGmgBdY=;
        b=dTLHaCDV3sxyUkLsLb1s1vg+ygxjlbpfVsTmtUGSGY5KVYdEtjMDTy6u/JCevF5v1N
         NZonQGDcunG0qdtR23XBJtURCm18YJas4YkOxQvXFzyalr8cEiZBGHmgKPdrkWONdllu
         yELutproAlzTBBzuKt3QJd5Eg217KmHArUDlOP6GGA4UkY9kDpEaSTbxSXZ44TTDnkfr
         TuyRA3JasZ/yc8Votb3bHudiQmkQAMmr1Bhgn0hWCFT2r6A/E+aIQIZ7wSIbJaZAYwrB
         4n8JJju5y7v6Ta43PnPsRpKbQvhXo2JSDwaWmZSve1Rz8Pb0rW1FJEZY7GTM7FVkDiWz
         AXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709174615; x=1709779415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNnU7s6E97gQJp6cYkW4MWjfZimKMSlrbqPhhGmgBdY=;
        b=mQBFxIx34d1jOlGfDePDXNq2kKnRGsQh7MEW0KioW4d5bHYq0NE4m8Rzx/BbEJzzIO
         x6N8yfhWOW9vVlV/O8A4wyLoGb+QDqmDiNpWycjZX4LJ4inALjBupygM6ujWVBrUePrQ
         6bqgjbI7uqemd0PL/35jvAkrPUCWZBgaOBsPNFTG8D/WaPLvt8hJf7qRGQOec/+Q1Ck3
         yVtXbhwZBxZgzE2ACaFoYBHUkhpkZ8PU4/5xWjRBezW+MUkM4WJgyuXygLGv0yoG0CuJ
         nuf3idez6ASCsFKdLOam7FM8DDeRap/7ORaGILr8+OAKa3AvqpQL7yXcPGxHbd6+Q4/f
         rRuA==
X-Forwarded-Encrypted: i=1; AJvYcCXx9XQLzfqerIm4e98XVi18RazAKfAjiVQRiDXRD+o5CxmEPwiduHyjrJC5XdsRqumIpeKKyrTIcr9+ivndJREdfSF77zmBrzehshob
X-Gm-Message-State: AOJu0YywVV4vpfhBqJVGFyyxN3aPL/sy7AWIQs2+LXhj9teDHUMUn7vf
	E4J++YFuvq6PQpN32vSJhJAYKZVgo932mG8vI4oEaszYHn32ZoBRbiJFja2Sye0=
X-Google-Smtp-Source: AGHT+IHMTsOxx73ulz3UbIiLluQkOVI4rTeaxBtTz6J4PniE7ZxUgLejbee0Eot7YwVRKHTEC9lP9g==
X-Received: by 2002:a05:6a00:bd7:b0:6e5:58cf:89b7 with SMTP id x23-20020a056a000bd700b006e558cf89b7mr871325pfu.4.1709174615438;
        Wed, 28 Feb 2024 18:43:35 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm141504pfn.159.2024.02.28.18.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:43:34 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 3/8] Staging: rtl8192e: Rename function rtllib_send_ADDBAReq()
Date: Wed, 28 Feb 2024 18:43:20 -0800
Message-Id: <20240229024325.453374-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229024325.453374-1-tdavies@darkphysics.net>
References: <20240229024325.453374-1-tdavies@darkphysics.net>
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
v2: no changes
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


