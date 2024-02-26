Return-Path: <linux-kernel+bounces-80499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C4F8668F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18221C22B27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACEB22EFB;
	Mon, 26 Feb 2024 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="jgDFEyg+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AF1F94C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919805; cv=none; b=Za0F82HUxjO91jqa7PUiB2svmrLcp2GgeAuAJU2nzX+UDCKO+TJWkLbvSn8xccjSyM0zB0ORBHkUrNKtl7HhxHWot19UbBt94Z7rY2FnThWzXNtpkngL91R1qZQJYHRryo9q52Tm+I/w1J+CiNp2cljim17c9ckJgWe49VnTtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919805; c=relaxed/simple;
	bh=lY6LEt+VlaNFkPSMPKLNDUAWoJIQyD3uckL91txfO0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSgHcYISfGFtNE/H5VSiYj6dM2mudFVo9TxOG7z8biGG61e2/Sk8ADFUi7me7QsCFHy30m/h29UX5EjHrdU9rnxS4QMptjceHwavmOwrau+bM2Kb+TQGkhpGSDUaW6RcEUlGGAPsER3V3iqBbL5EkYP8I/FfMi/1/xSNrsr5z0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=jgDFEyg+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc9222b337so8292975ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919803; x=1709524603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHL7kvJVXgjGfJYrabpYDmkLoWmPK0wOdeTjteAaFF8=;
        b=jgDFEyg+IELbM65856poKSojVeoEarGjWLry/t7LoY33B0LfUxZ+qYAu4W7VJNMkjJ
         zoczC1BSlY9UDH+e23OezYRnTRIcZXk4AOQr2upUl6PKU0n+JfPfSMSQNtzhwMwX1f/h
         wyXZWelkZIA4RyRW+xYtWv/r4PWh8ELh4ErDKYM9AVtpeXzSVE7KklpccXfa4YObNcSr
         WrZzPsjpTMhYz6m6C8SiPxs0IqX+AfG3FiQH3Qt+Nz5ZHzLTmo9GenPLifralhA2Uv2n
         pwSkg6DCFYpZgMGfUybX8pC1yRDyQM+qW5DtZYxrGwAGVZWhTyrTUMNyilUisT0mE5iG
         k4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919803; x=1709524603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHL7kvJVXgjGfJYrabpYDmkLoWmPK0wOdeTjteAaFF8=;
        b=XiQOO8jse2CDGQFcE4RlrrruEGQ5Ufy7+Ulqh9FwyBiq3dMENzcsjHg2UeERkkGIur
         XKN1FANop0urDWijqVqmjJUNtoO6Hax2YWNcKHVoAoqiCv3CdOUBjB0DDP1nOd9u79Al
         SCHD1ibgLRGR8K3jAuEoMNpgnyLCN07JCECSAOqqtTvY/0CFYmFH78oGUzexOQk+sl0c
         FpXTFHXvkxyAci2jZxuYFaJIx03xIMUj99NjdaMP6Eq7aUKGyMdwpuUZKFVHhadMya62
         n8bxBqcNxFVv7aqeaFOW/h6dXX119Vywbbrjv2drokGSpzR3C6ZCnkS7DLKzNpRkScmd
         b3hA==
X-Forwarded-Encrypted: i=1; AJvYcCXVz5vEZnY6u1N0d+X9UppmjSNRVbvWiRNoFNvK1e33/Ub0KjcDbcHHj5dPEMjxZxsGoyhsdgQE4fnwn6Nsah/biY9d4C14JQnki+tr
X-Gm-Message-State: AOJu0YyC6K1pOuzvmtIWyC5Qm8plDQqe+Dg9P83yYqf6OgQpx7B76Hru
	iUjch0qSKX5qRU0SzgYyGAYQKC52lZqYTfWn7qtUgPCgjUG+n4hO8q2sdCy3D4Ani6zU5C6Kk+9
	j
X-Google-Smtp-Source: AGHT+IEqb1L/zyrtKFIOXiLdBnw2yqUtWy8GMDkrbBKSoRpmL0n98rphHHx3+CtMW25sj5DkYDl89g==
X-Received: by 2002:a17:902:e5cf:b0:1db:7c5e:f07c with SMTP id u15-20020a170902e5cf00b001db7c5ef07cmr8802969plf.66.1708919803225;
        Sun, 25 Feb 2024 19:56:43 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:42 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 17/20] Staging: rtl8192e: Rename varoable asSta
Date: Sun, 25 Feb 2024 19:56:21 -0800
Message-Id: <20240226035624.370443-18-tdavies@darkphysics.net>
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

Rename variable asSta to addr as it references bssid addr,
and fixes checkpatch warning Avoid CamelCase,

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index bc08018185ca..644e2dffd185 100644
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


