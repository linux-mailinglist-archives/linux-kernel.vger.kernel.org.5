Return-Path: <linux-kernel+bounces-95917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACBF8754F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DBFB232AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9E1130E36;
	Thu,  7 Mar 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFf/7R/D"
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB121EB40;
	Thu,  7 Mar 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831569; cv=none; b=fXGSDLZbXarnKwxtFjy0AE9QYOAQVUwk1HU2LeouwuU67DpZ5KYWsT1TsUaG4R4Y7G83c8oSU0yz1i0jagsRLPDlzX7Kj6TvHg+rEMhnxhY1Qv+xKIX3ZIG/GwfbvG1/RACpAkNa663E0Qu1RMFOZhSLEmS1JLYwNn9xGG6fyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831569; c=relaxed/simple;
	bh=i6hpcrLLCR46LG/IX6FqxmylW2weKfFyAGJ2GLuqwIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1MMeJn6TU2ffj4z5GFEuw3cFxyse75Ok0yGsvHnqd8exWdpSRgOmv+/7RAsEnK1jsqG2S+5jr9UAz7sppUtWfVia/8cYiUZAusTDayD1fWdeYgpnu3S4y9J/2rbBV1yd4YOMj+70mV30Eqvgdo4EyGGuSaW9RPOFU7RgL1ko2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFf/7R/D; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2d26227d508so14794541fa.2;
        Thu, 07 Mar 2024 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709831565; x=1710436365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP/JiZAWPxHAfkkPmvTb9IoKImN6811SzpISJpC/Dc0=;
        b=YFf/7R/DyVXZAdHNQ28NUMQEptrr4ZhxLK4AscS+qJ5CP1NhRxn8s/Zt08pPWYF/kq
         HAZclgQEje27DY3TKsGaMRzVtJbmBk1NPr0BaLUDkSl/EkIyJYUnuLzFyTv7zfEuv9uO
         fpDGGE1tUekp1r+YuOt0hfYNuBy3FVfxZy83BwkwML4dYtNyNEmwXxWIghQ9MICpc/56
         DS86BJqIDcvCphCKjoLHJIlXVEdDtn8Eye4UuR0hSjKuPhJmgyP3jhaHrLqFDNc4ptTJ
         8QO3v5ls/UBO8KMJoxpd9wuiyMSeGmmKyx+i5IokPsz2WfC9+S21ZVN9lPij+U2Jt356
         egSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709831565; x=1710436365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hP/JiZAWPxHAfkkPmvTb9IoKImN6811SzpISJpC/Dc0=;
        b=PAzu544XXcUIX6axCdFJvcKiHWbkOhA9+JUmd6P2fSbGQdS4M30bNmP2WcsW6w4pjG
         XsAxLRkHL6v1NSZDvzrPzBrsNuOZZ3tZP30cKVW50JIDFIJqBsSl0v9KDIQdRolpPZdy
         oHMwtglnDUQgRaCBIPRPr1phREL5s8ATsBeDmtThMoB27arY/DXoyAVP7eQqDog6pgF1
         DDFFZUJ+y3Fw7sQXSN3tzo6ys6vQ5YQwNASEQDT5qMpjvU9UT7Np9RDU6T2CN6vCAed8
         x14yMvXwE1+W4O8/fusFTH2epe20VgnMO6gOXou355cSAgQ1x5v+Dt2I2Lt/KtIMEvXd
         KMPA==
X-Forwarded-Encrypted: i=1; AJvYcCXwEeOelEaQncoxtfQa4/JSxbYN/0nZXE9+yuZAEEd6toaOHymAI2cr88rSnCqzDt697rU8KiSB/nEnNKh6b6n+cXav2IUWntAkoPfS
X-Gm-Message-State: AOJu0YzUPuIQDKEP+/pQXk235DFM5r3GfLGXYyA1q8fhhcAq95lTyCNK
	AaqSKJDe6OiQg5pCj4hIxgDt7bkeUwHe7qU3oQA/gHJ9i/3eLe+Id/uR2OjGoYM=
X-Google-Smtp-Source: AGHT+IF4j8Biz+xSXi0DzoIdTrTU8oXcXacVIxRSzMOB4Ifm8qdW2Gzsgg7QeLpkAS3neI1FJCi1EA==
X-Received: by 2002:a05:6512:3b9d:b0:513:d2:ad11 with SMTP id g29-20020a0565123b9d00b0051300d2ad11mr2234940lfv.53.1709831565462;
        Thu, 07 Mar 2024 09:12:45 -0800 (PST)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b0041315f221c7sm582707wms.16.2024.03.07.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:12:45 -0800 (PST)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next 1/4] net: route: expire rt if the dst it holds is expired
Date: Thu,  7 Mar 2024 18:11:59 +0100
Message-Id: <20240307171202.232684-2-leone4fernando@gmail.com>
In-Reply-To: <20240307171202.232684-1-leone4fernando@gmail.com>
References: <20240307171202.232684-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rt_is_expired is used to verify that a cached dst is valid.
Currently, this function ignores the rt.dst->expires value.

Add a check to rt_is_expired that validates that the dst is not expired.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 net/ipv4/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index c8f76f56dc16..73e742424e97 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -392,7 +392,8 @@ static inline int ip_rt_proc_init(void)
 
 static inline bool rt_is_expired(const struct rtable *rth)
 {
-	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev));
+	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev)) ||
+	       (rth->dst.expires && time_after(jiffies, rth->dst.expires));
 }
 
 void rt_cache_flush(struct net *net)
-- 
2.34.1


