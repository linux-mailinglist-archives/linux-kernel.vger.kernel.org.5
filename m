Return-Path: <linux-kernel+bounces-167448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2388BA9B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648E91F24BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322EC152DFE;
	Fri,  3 May 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjCBSDLc"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC96152519
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727936; cv=none; b=l/DSCIYeOB0Qw+VqtVP9nhsasgEE1M0ZfCI3klQTEQqzaXSp3yVJ7P2VWrqPrgkTjUeSL9ZvdN5AJCO6QduzTwomMweYRMYjpul9r8Mxn/XLo8TTJbDuH+7Dj7oFW7zgXEJrG7OnJuEHJSumeXdniV/nMdRin0/jg1yvp0W6lHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727936; c=relaxed/simple;
	bh=4ArJY7PZnBnDWCMCM15GfOZS5AjpeHaFMcDoWz/RQU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfQUkfLrD+9g1Ym1y/38MlTVInuJKLKhSs9NwpFjC3Nxbx7p6okLe2r0xsllrSHSJ/SHjUY31wF7R4mXofs0b4a8VVVPqGRirWIijtIWwcIzl/CrYHw8YTeYZ7tvOZ9hkMO8+WG4JFrQJIlH9lZEnaujQm/5AjUuauoj5w5gZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fjCBSDLc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44390e328so1157370b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727934; x=1715332734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO5gNR3hr1OwBA2XPvPltsruJYPfqcocof4eacOx3kQ=;
        b=fjCBSDLcXrBjgqIArQB5S1METL2+kNVYqZnt3HiorwnY6cJ+xLt4Tb1SxeX0q8vcw/
         YC/30eNMNrnaKERQxsvfsZ5DErFgNdPnpMZW/mce0M1ia4LlXeiukzYC0BZoAQvuTQ1J
         SdOBabZYNf4JMjewO+JhJ4zt9A/Gbo5TFkLQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727934; x=1715332734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO5gNR3hr1OwBA2XPvPltsruJYPfqcocof4eacOx3kQ=;
        b=Ivl3QpPTwMq2LV8NPOgQ/teQ2lm7F4MbvqXk1yTlSag/amaMdn1dv0LDp7Skt0f0Vg
         vNrMdhLT0N6BA0QTtwsIOmhi4q2HWFlgpDhpw+Lhwj2QynMTNqG/hUOKnK/MtB1UJc7K
         /RwoawcxEON+n+rR7lI56b6wETe6bFeIBmR/JswUNFOrHt8QZrBRBrnNke3PP9lvsGwq
         TrX0cVyl4Q8w9Ve/Oi4xZNE338SLXf8tW50+Yf0Mb4CXEniDm/WQGxTodP9l4aW8lVql
         IiPDWZAUiFDE8OcNA5E4Ya9wxtUf+9icu6+v9Ir9srw8KwUYuAlXq64vHOvaMqr19ugk
         yntQ==
X-Gm-Message-State: AOJu0Yy8//BCWdzcuUJPkzs5s0PXvZVniIG9cuZD3+xHBwy5QtsjpTPY
	lRf/avhEbADgmQHxMP1s9G/AwYt1oaAiZLCukzauxTEKf3EyOp6qNwBkQ7A2rg==
X-Google-Smtp-Source: AGHT+IG4npoeCWRzW4EH6xMMRmxyJm0jnpgnxemDntXCzMN1NWwaqjbQjf5ya2v1snd9z3WPC+pxbA==
X-Received: by 2002:a05:6a00:2295:b0:6ea:f351:1df9 with SMTP id f21-20020a056a00229500b006eaf3511df9mr2343695pfe.23.1714727934592;
        Fri, 03 May 2024 02:18:54 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:18:54 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 08/14] zram: check that backends array has at least one backend
Date: Fri,  3 May 2024 18:17:33 +0900
Message-ID: <20240503091823.3616962-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503091823.3616962-1-senozhatsky@chromium.org>
References: <20240503091823.3616962-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that backends array has anything apart from the
sentinel NULL value.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 9fc5477a6259..fdf06fc6b364 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -205,6 +205,14 @@ struct zcomp *zcomp_create(const char *alg)
 	struct zcomp *comp;
 	int error;
 
+	/*
+	 * The backends array has a sentinel NULL value, so the minimum
+	 * size is 1. In order to be valid the array, apart from the
+	 * sentinel NULL element, should have at least one compression
+	 * backend selected.
+	 */
+	BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
+
 	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


