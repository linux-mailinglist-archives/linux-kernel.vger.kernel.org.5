Return-Path: <linux-kernel+bounces-98436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8718877A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5211528219F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D231C3D;
	Mon, 11 Mar 2024 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRE2QOhx"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD81851
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710128649; cv=none; b=Xm1NSfYCoy35GUI5HYILbL2N4Mj1l8b3JZGVjbE/HKiCEwFKrBcyrEJaxuzSXCdWMeu0OeYRfdU2HJNJQUEgDi4mwnwFdUn+aS58dnmpJ1L/SAe708INLvxsjqMZmIHgbYP/RF7h2VCT3ocH9OKsTbf62fgslPdv5XBZ9w2lbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710128649; c=relaxed/simple;
	bh=Dz5KLd3tIqprW/GVHSjYfOPNf1sfHIEZQhjHu//Tv9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uzYWReBX2TpMAWfgqjZ9mSurQF5nKvR/bQ+yDJks+r8yN72+OWH2cLC/Cc/J35uM12y1MQYoeB7rqV5hnCI5eAm7x2Tk/S4Dv3kkd0KopzCttYOdYZpvzOgkmWFVJFbvBCtS541yejMw5BB3gzz/cKCLQnYx/32tQvnfyKmGVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRE2QOhx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd6d4832dcso3566335ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710128647; x=1710733447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqf/Jkk0NFQZ1ArKKj86vJrb3nslVxHqnT0lqQ8B590=;
        b=kRE2QOhxXJrOJvjmYIxstFFZpXdxYx/k4SgRCCE67unqDYVsRiBbIw5lACPEBWlSyK
         luAKaWKUmVm/ykLmRLR4vJfjwyuu26/y4wSlEeuixiFqpuTEWlDWC9kRE+BgeABjI0Js
         ZYu5tg2CWfae5MG0/e2ZCMEEByDvIs369B7dA0OH2HOdCKVgfCv3aQqb0TQ/vR9144GN
         lyTxhwQ6ZI7rlOc9Z79Iml+gj6JOGlsfSn1wRQo1e8G6DG1iIl7sHhahubOPtA3JU/4l
         9sXzmXxV71c+bWb+ceqQnicfc18cCdzghcp7r7k2OPfrPFhhke9woNhtTluiEdAuZkL+
         RaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710128647; x=1710733447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uqf/Jkk0NFQZ1ArKKj86vJrb3nslVxHqnT0lqQ8B590=;
        b=HuOFRaK7QUZwz0WOkyuVf+hZDaxDwrZrP72cU+bayKH74X24ZHFJhvmZXUISLHZoHV
         JI8EPGx0neV4brasV/EuQMntv08jHoyqQ+DXdVYU3c95uMtG67SS++baAYfLmhFaVpJu
         f7zKpj86pf5m6xwtfEPa8LMLbrQEzaVPmUEPLqNOS9AWIER+0J1XjyJS5dGvX2JtUckG
         monNZmUnQ+Di4JHOk0rSS54rNbTWHjaGGGfHwFDp+JGrzGcB3jiWDjTQ6V2FiCbNeddh
         W2D7HTetZfczPYIxCUbQLp1nacnCBIh2D9Mdxe3NihFZgYE4KtzrmktYmBS2Njfm2GY7
         Yp0A==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZMxm7nthtQEgMuoepmqnHk0yQnfV0D0MnumiIG16g3KOCAULiHWS5OpddLNJhVhtCTBBQUVCyvWA4vHoj9T1cL5O+itSR0QXVSxJ
X-Gm-Message-State: AOJu0Yzgx0qi7n+t/SqqN/xTkloEVoQiIjAw3mQwqT+D7KhFGtEPrdlN
	N68E3/b2K064pHGnIyfZUYmqU/pAIVEAF07QrP9krg1SFWMa7ew6kBEWiLrayCA=
X-Google-Smtp-Source: AGHT+IFpyX1+j2mnwa8ni51KfFT4JSVV3tiX8GAi4YroXgQjyCnwVsmAbVHPUnQonnidiVVHEd8cpg==
X-Received: by 2002:a17:902:d395:b0:1dc:fcde:853a with SMTP id e21-20020a170902d39500b001dcfcde853amr6096389pld.1.1710128647004;
        Sun, 10 Mar 2024 20:44:07 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:b289:6f57:682e:c7f1])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001dca68b97d3sm3494934plw.44.2024.03.10.20.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 20:44:06 -0700 (PDT)
From: I-HSIN CHENG <richard120310@gmail.com>
To: philipp.reisner@linbit.com
Cc: lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	I-HSIN CHENG <richard120310@gmail.com>
Subject: [PATCH] lru_cache: Initialize hlist_head in lc_create
Date: Mon, 11 Mar 2024 11:44:01 +0800
Message-Id: <20240311034401.234854-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use INIT_HLIST_HEAD to perform the initialization for each pointer to
struct list_head in the variable "slot" to provide more safety and
prevent possible bugs from uninitialized behavior.

Signed-off-by: I-HSIN CHENG <richard120310@gmail.com>
---
 lib/lru_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index b3d918761..ae122792e 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -105,6 +105,9 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 	if (!lc)
 		goto out_fail;
 
+	for (int i = 0; i < e_count; i++)
+		INIT_HLIST_HEAD(slot + i);
+
 	INIT_LIST_HEAD(&lc->in_use);
 	INIT_LIST_HEAD(&lc->lru);
 	INIT_LIST_HEAD(&lc->free);
-- 
2.34.1


