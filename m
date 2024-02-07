Return-Path: <linux-kernel+bounces-56047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8BC84C549
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1416B24BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD221F61F;
	Wed,  7 Feb 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LDJ07n8j"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEB1CF8A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289084; cv=none; b=dP/bUJBQtKeW74oYGd6P7MH6fB7xxwzwiBdtE8ehWrUmVO5kEQ+DHCeo77No8AGy+T5FyXR4ippMYuwqHwCbRsd6+9LM+qExStDFoXbWa72sU7SSMMgfn/Iq1yMDZ0rnZhE5l8+m5uXh4L2PbSxeh4DMlKfjm8BxoPAvYLQJE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289084; c=relaxed/simple;
	bh=v5LeFjZ/D+DaTKsnl4J5qcG/I8zC69+dw/jg0kjeUcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMaHEb3DrHmSB+f3/lkL+8NlQmuoCdq8r2w07o/lUcmtK1/CX2lMMDLfPGIsD9o2bOzN/cCs3zw8w8ySs3viFEO9qmUrvPLjvzmjMm+xM9C7sWPfk6OzfmG2FycaXsSRYvyGOeQivGVgtXW0eEyJ+lVc8bWGVgjOqiSVi83Wzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LDJ07n8j; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bfcbfbfd92so160387b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 22:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707289081; x=1707893881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF8DJPB95uBblxoCa1mRhbMMCPpx1zNPhn967dUKiP0=;
        b=LDJ07n8jVqD4skDOFWP86wWchOI0L0N9Jeh+kNBIeM4+/ZG0mUSAiGPhG64L2d2Bgc
         bVDyDs4gCxiuRZXKVL3NHa82LAWZlw+ze54OHH06HrXeSRAvl2u9a5koe+xghY/vpR40
         JSUPCdfATLlJI08Qpe4Psg1ZVWwCoZGn/NHQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707289081; x=1707893881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zF8DJPB95uBblxoCa1mRhbMMCPpx1zNPhn967dUKiP0=;
        b=o+BTZ8n9k+UKt92yrURht4aOqiM1xEoPzVz0SmvYVn+VoBlMm9ql4C9NWG5N6BvdO1
         V0w3c3cZqMIhWP6LbYbP/jqqHOkTNmDqvT0qkwICl/eDOIyqkKVbtTxXm4cLbjXVuUd6
         Cv5F5CCam0ZwmOI09cBX04jyCcMWQFwZzF6ysCZKUjox7ENcG9r5iZQZoQXlN4vVi62N
         bsEBwb2pwyrCwMAwzJbgKr5EKv5+RMykFaMONfUKr6hH5IQuCaBbk4/vfdu0xmHc6bhn
         o6uhIFXu7hZcWpM5Ih3IiWur8P6ULzszMuL+8tMZKoC9GkUHwHP5yKXDB2/Zn4s6vRM9
         hBmA==
X-Gm-Message-State: AOJu0YyBoVVU8WXNBlvB3WUCy1YEjnWHm8H8d81PQ2q4g/ErkrwXpQ1l
	RkWj+l4GqgFiG0J85abvpNzwxU50iLX+VuJHEgzGo+Q96X5yiEgZuFppPW/4vQ==
X-Google-Smtp-Source: AGHT+IEHekeImTPE9NRNwFrQZKoMYfTgezv+odH7iCMfoq3rY0u2xfsS0Fr4CgORLpMNIUrmFkW2cw==
X-Received: by 2002:a05:6808:398a:b0:3bf:e5bd:fc1b with SMTP id gq10-20020a056808398a00b003bfe5bdfc1bmr4815266oib.36.1707289081746;
        Tue, 06 Feb 2024 22:58:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLmrmWS/mMqY7L2YZEcevanmoauf9UvbeDLYH3u3rPdDH6h3skOTxnIMss+kgLRqMS+lVEbpLeX7+TP7nWlvGwQR3y+kHEdmu78wsfyYOaciYrSerUsRbQoNEDtFl8skHzyQwWJJMlB186V5h3UZd7JKuRaPhIMQuDmwimNjleg/Y=
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:aa4c:2868:935:7ac6])
        by smtp.gmail.com with ESMTPSA id jw15-20020a056a00928f00b006e03ac84d53sm672576pfb.193.2024.02.06.22.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 22:58:01 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH 1/2] zram: do not allocate buffer if crypto comp allocation failed
Date: Wed,  7 Feb 2024 15:57:11 +0900
Message-ID: <20240207065751.1908939-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240207065751.1908939-1-senozhatsky@chromium.org>
References: <20240207065751.1908939-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not allocate working buffer if we failed to lookup and
alloc crypto comp. User-space can request unsupported
compression algorithm.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 8237b08c49d8..d88954e8c7bf 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -50,12 +50,15 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
 static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
 {
 	zstrm->tfm = crypto_alloc_comp(comp->name, 0, 0);
+	if (IS_ERR_OR_NULL(zstrm->tfm))
+		return -EINVAL;
+
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
 	 * case when compressed size is larger than the original one
 	 */
 	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
-	if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
+	if (!zstrm->buffer) {
 		zcomp_strm_free(zstrm);
 		return -ENOMEM;
 	}
-- 
2.43.0.594.gd9cf4e227d-goog


