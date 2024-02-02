Return-Path: <linux-kernel+bounces-49295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7F84684E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8861C229A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B6179BF;
	Fri,  2 Feb 2024 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DkxNFSg0"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212C179A1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856124; cv=none; b=s0KeZtxYq3k71nM9Vq9r8rKQWuvyWa5RTmZR0loVlx2DMr2e57Ml67AZmbc1zpb3hyno/vAZAfeUifz5X6eXV9MiAXqrXccdR8ZhcYurcQCBYTnrxAtJXKRPrCQzOnPS9zn/gKCmX24fPRxKxWWQvQT6QWIfI3tKKK7O3hEIATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856124; c=relaxed/simple;
	bh=EyPJ1v8uJ1verWOqJzXdRF7tA+iZhYTVX3CQiV6Wfbk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LDMAHcJsaHJHS0GAbHaGz2iz1Rg4xxetuJRCg5IBG/3qIsZKiqv5X4gTr1mnk5kf2epL59rItbXDqcuu6f0hyAWe0zA+RNaW2UMucscbi45ACiiWkSEFNuy/oHqTI/P+I7R3qqn1mo80tGL3cxB7Din8PdH7iqn2hWoWWbhh+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DkxNFSg0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8bc1caf00so1601090a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706856121; x=1707460921; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeB3e/KJ2ArkcAJ7cDxBQCA+oTgv/CnKDnVoit5SrNw=;
        b=DkxNFSg0UZjhOYNO9QomilU3VFGX9Oa0ddKOOE/qq8NOKjEi5oeh6AXR47Qq81lm77
         PSb7glH0eOIC/NhkSo8hmsT+/B+e3bdBCJavw0o6imYrLYjLeAdT9NUmO9RY8HdYVIZm
         XNXZ84WHDAQBSEkEufFjL8S1BwX5AuuUlSWHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856121; x=1707460921;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeB3e/KJ2ArkcAJ7cDxBQCA+oTgv/CnKDnVoit5SrNw=;
        b=jo+5Agpzkxin0mDGGOQxJfPZBHIeoNdfOcZk/Ckcmpsmdbppv8kMsMOnka2wNbSEVn
         9F400zsuQMGWED6xwRPmPkbIm4/UKr55NRaVz2qEZu0s1hCBRgCckCZBuwO+ze5Ml0qT
         3L9NhBQyScLmZ0o6iVvmIZZgiHagggDIIuAliIEsW0XP+IUtuE7GSdr8eUJA22HWiU4j
         tiGIn2KqsaX6N5sb8XLDRrEBnrq4bfIi/R0Q8VDi5yWgvY9Z68shsEXfdKdBOKSawwI7
         7Egxrri+L66sHBpX1WLI5qhHcB2ol3MRH6owl1bU582b3c02x6En2WEqEn1hgMBNdYKV
         kRag==
X-Gm-Message-State: AOJu0YwoGJEJOeeB/G0QPT63ltMI53vNirQZEIZIES4b6ma9yJT+oQRy
	Yv0K4jOeaGZZdS6oG48J3L3qgaIjM9JKuL8yvfjDeJixl9P+hEjgBBXbifsOXw==
X-Google-Smtp-Source: AGHT+IGkxoHrn5M23ZvqLsrcgWb9Dxe4chh56p5rjnQf81e2tLgOZlZAD6cC22pLx6DS6kx/4ch7Rg==
X-Received: by 2002:a05:6a20:9326:b0:19e:399f:7bed with SMTP id r38-20020a056a20932600b0019e399f7bedmr4407693pzh.35.1706856121632;
        Thu, 01 Feb 2024 22:42:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUSv8KyeVxLzlGyhyhJ6/k5Q8l3rOmZnebm5Ftte6euQTEIyGzkjD1oV8Cyqg6y2bKRShGnz/qsu+E5D9h1OLSVVnu84HPXx7PLd5AgFJfvfginU3vSbn1Jyi7RnXvVdEq+bFkO47Zwrq/rLX7o756g05VcM3Kko6+PIh5jDoU0gQgNF3OHccJnR0hZpbe1Y06qv4h8qSFrnEhsGOLrTQoKnGpXivVi4shl/FNK4m1L3o8+vSZqqsv0S3wMcmdERd8EJhTOaZ0PH7W2w6p1bfCEQaLzN/0/w6QZGBwzpqlN4EQOPhwQGxkfy8HJhsbkyUxzRysBfA1uG4CXq1egORvciiFbGJkVKpTYr2N2BpYLQdBSHlgHNrlyBIdB0O+Aoxt7l11Wa7GVWyoTdjg/cOmdceBMrnJ1QDGZsjz0Lz9u+bmbEWiRefNwhkPQQicN/vAkTnHZ8DuoIswbpmksZRumsxfA5YJcJRepZCixavqoYSVuYWECbbW/FXKzEYJZGmL3knKe6cS5u4qkdeaAO/uzJQR5HAA=
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id kc12-20020a17090333cc00b001d94a245f3fsm880583plb.16.2024.02.01.22.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2024 22:42:00 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com,
	florian.fainelli@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [PATCH v5.10.y] netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()
Date: Fri,  2 Feb 2024 12:11:21 +0530
Message-Id: <1706856081-37418-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Dan Carpenter <dan.carpenter@linaro.org>

commit c301f0981fdd3fd1ffac6836b423c4d7a8e0eb63 upstream.

The problem is in nft_byteorder_eval() where we are iterating through a
loop and writing to dst[0], dst[1], dst[2] and so on...  On each
iteration we are writing 8 bytes.  But dst[] is an array of u32 so each
element only has space for 4 bytes.  That means that every iteration
overwrites part of the previous element.

I spotted this bug while reviewing commit caf3ef7468f7 ("netfilter:
nf_tables: prevent OOB access in nft_byteorder_eval") which is a related
issue.  I think that the reason we have not detected this bug in testing
is that most of time we only write one element.

Fixes: ce1e7989d989 ("netfilter: nft_byteorder: provide 64bit le/be conversion")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Ajay: Modified to apply on v5.10.y]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 include/net/netfilter/nf_tables.h | 4 ++--
 net/netfilter/nft_byteorder.c     | 5 +++--
 net/netfilter/nft_meta.c          | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2237657..2da11d8 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -142,9 +142,9 @@ static inline u16 nft_reg_load16(const u32 *sreg)
 	return *(u16 *)sreg;
 }
 
-static inline void nft_reg_store64(u32 *dreg, u64 val)
+static inline void nft_reg_store64(u64 *dreg, u64 val)
 {
-	put_unaligned(val, (u64 *)dreg);
+	put_unaligned(val, dreg);
 }
 
 static inline u64 nft_reg_load64(const u32 *sreg)
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 7b0b8fe..9d250bd 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -38,20 +38,21 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 
 	switch (priv->size) {
 	case 8: {
+		u64 *dst64 = (void *)dst;
 		u64 src64;
 
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = nft_reg_load64(&src[i]);
-				nft_reg_store64(&dst[i], be64_to_cpu(src64));
+				nft_reg_store64(&dst64[i], be64_to_cpu(src64));
 			}
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = (__force __u64)
 					cpu_to_be64(nft_reg_load64(&src[i]));
-				nft_reg_store64(&dst[i], src64);
+				nft_reg_store64(&dst64[i], src64);
 			}
 			break;
 		}
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 44d9b38..cb5bb0e 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -63,7 +63,7 @@ nft_meta_get_eval_time(enum nft_meta_keys key,
 {
 	switch (key) {
 	case NFT_META_TIME_NS:
-		nft_reg_store64(dest, ktime_get_real_ns());
+		nft_reg_store64((u64 *)dest, ktime_get_real_ns());
 		break;
 	case NFT_META_TIME_DAY:
 		nft_reg_store8(dest, nft_meta_weekday());
-- 
2.7.4


