Return-Path: <linux-kernel+bounces-38628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD983C35F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D6F1C222C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4C4F61E;
	Thu, 25 Jan 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+Hz0P4O"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5AA23774;
	Thu, 25 Jan 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188378; cv=none; b=myyzNTWJ85dFxG2EWQm9XP+JworkRoVIg2L3nWBOWhku+UGH8JRZ0aVw4be8FGNqCh7AmaRp2Ngt4G48zcyCnLY6E3nBWIcMSN1GsoTrSgb+RbliKSWIS/Mimxn951eKqoMkEqY/xYH8eawcDxcnFONCBrbykMlCa4vq1I6FsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188378; c=relaxed/simple;
	bh=Na/rHa5dAP3l50X//9FCmhKqVB813/sR9Yz3qZ8PB4Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PQbzmHEIlzd8wgjeVNkzlGopTmKjqlIx+g2Xm7U8uYE/ZrbLcNnqkkewXJaGVGT6xB8JYaZ6reC2K9bTNVfCvyf+pyM0J677oiFZSB2z8ymMcOGHr7r51EjEyLRPqQ100ODw3e3gORhAqVX2uVKjdVKM04RRHGssURWltHwInlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+Hz0P4O; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-40eb2f392f0so36670645e9.1;
        Thu, 25 Jan 2024 05:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706188375; x=1706793175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUC5+LMrNmxS7ctyeH5pl2x/dqcP46pJUlAebEkKzMY=;
        b=b+Hz0P4OruBTQRh1xMNTysGVlcUVFi101rYbRbTcXFMxitGpm1eb4NuZUWWTb/wVwY
         UJ2A2f+kMIgufISKXuUu6U/CvOaUO5xEenzZ+c7qTRts/P5STGvadC92LytSueYy+Ot8
         0lyia4CNMjQn40Z20x9/jgE83kZrNbC4uXc9CM5PfVs/4qZoqYy9NyQ8FX95BJ4N0GtN
         ILjbqEzM4OavtrBk+7thE4YjXqPuwqhetYsWv76voTjJE5LpFkkxWGTvXxXitQBptLQG
         U2RkdOGZmAGX6Tz3KjvtilzYGlzVZtP1hlQ3hJrZWCA75nWs13Wf2CmsTQSfZn9W9x2g
         fAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706188375; x=1706793175;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUC5+LMrNmxS7ctyeH5pl2x/dqcP46pJUlAebEkKzMY=;
        b=kcpe4rfmBttte/9AvnJSBWzx1DbWilvAS0U+s6b+kajdtQ5G42jI33iUaujPha6/9U
         Rs/FaWuRoAO7B/KrGoPN3yScucAHfYblkBHCKZnxl/4rNLb4oKVLhkIsPJfeDBhlG+fN
         JQ4EG/Bj2gMwuholx7KlHLPeDbXfPaRHM5FigML+h+w4gUkgUhakLVybv1Y/VEh00NZ7
         umd8dggqMRo9IiR/BLvNckJnf7XYgnwSy2G/KUceU6oAMl240KkORWaez9+SPL8100UN
         0cCGtLYVn6rn1eQX2isyg0qgD9BmVVmJIqWZl//xdThRdbj3mCDL52sO851xFx9aSOD4
         YHOw==
X-Gm-Message-State: AOJu0YwBFXYKqnDoUn2aQTOoLRt8jZecPnCxh3/tvGQkhOEunTCRW69J
	s1AqwPrjAC8wkqqNnl+JA1jOh5CIqb02okQ5In8eCwK/FMYA5Gqn
X-Google-Smtp-Source: AGHT+IHjlvwBX+Y574xgT+Z3ZGGsiKzys5jeucBVsLZ2sI4/NvncCt82obiTN8x1uTk4OruxJ06csg==
X-Received: by 2002:a05:600c:91e:b0:40e:9f6d:61f6 with SMTP id m30-20020a05600c091e00b0040e9f6d61f6mr512336wmp.184.1706188374954;
        Thu, 25 Jan 2024 05:12:54 -0800 (PST)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b0040e549c77a1sm2621155wmq.32.2024.01.25.05.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:12:54 -0800 (PST)
Message-ID: <a6c0b46e-e5c1-4aec-b2e1-8bf610fe98fb@gmail.com>
Date: Thu, 25 Jan 2024 14:12:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [RFC PATCH net-next v1 1/3] net: route: expire rt if the dst it holds
 is expired
Content-Language: en-US
From: Leone Fernando <leone4fernando@gmail.com>
To: dennis@kernel.org, tj@kernel.org, cl@linux.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com>
In-Reply-To: <d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The function rt_is_expired is used to verify that a cached dst is valid.
Currently, this function ignores the rt.dst->expires value.

Add a check to rt_is_expired that validates that the dst is not expired.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 net/ipv4/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 16615d107cf0..7c5e68117ee2 100644
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


