Return-Path: <linux-kernel+bounces-167446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CD58BA9B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575671F2452A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6FA1514E9;
	Fri,  3 May 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMc7wIC5"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4185152178
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727933; cv=none; b=GV13KdIumwj4TRUDJAL7oWxzmOwg3duUl0dsTUQ9xXa1fHB/kMATSFPyeNBdCAJfL5Aayuhvj09xKVoChJl/DTNNio484kbBdMGIrUKsQom5srzho72qpmocHZ1eyF5Z6pA0sHIWrAlVpfazorvQ+kuhEba67x6/CF263jA4An4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727933; c=relaxed/simple;
	bh=FRBhLTt/FHOdPdldPK2JgCScJh/quKT94FOX0NLvGcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMzwiA/zVf7S9ygLsgQiUEbxpifrw7uKL0YhIuOtoMhx6PDUmpfUrjvPo0qaOFnVBnRcLqRhQn44BaKp/U3oHBYFJmP6I8w0qsFYP8krDzp3K2Or7PVfzHLG2BpdWh2JpXpPpCJMFGOqq4JJ+TWMkeQDXd+hRbKbyoKi0CN3QTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EMc7wIC5; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23db0b5dd28so1267820fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727930; x=1715332730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EvmWJu/VXtBqzoQye3a2VzbJm8fhR7v5ZjISdbrAiY=;
        b=EMc7wIC5NUEBvoLR0RghV3ZC9TYqHnwzjIk5Dm6ARTzlnDAco3WSL1FEQ3E8ZDCdVG
         H1JxCVVRE9bt2MvNxIwk1phVZzUgdndZAyObXpS6ZIRvXYEdbeVb+zsiRQyn5ApjoNUG
         ai2CyJt+KrM5agpsJophSgiIY8HEfQun/5NI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727930; x=1715332730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EvmWJu/VXtBqzoQye3a2VzbJm8fhR7v5ZjISdbrAiY=;
        b=C2FSAzB/1n7sJrsA2jkSupfQPi4HeI1W+zK1gXPHNT/Qn60m2LUVU3ksBYJFEBXiR9
         jzzphqMBIIq9km/XFZ8pXEDzkV18NwBeQ5pyPvR5sPQnPzGOQ3yoZCofF8WowAXlBpDa
         vcnOFbYPIfqMVkvw9SxJu5zvwOgmAhdkrGbcauw+n+XjUrR66/lOVJr9DtGZSrtxtxxb
         q9KfIyrHjNw9gbkWdPt535gtsWkwKJcfgrVFKEun7ASpvZ9fmSg9jpo0ShTxuBKrJzER
         8AifON/W1+Cmu9+cgfqVfXjvUpwk3QKM81OrchEaKit1bnhJ1IS2CBiEjefNodbGV3Oi
         8uiA==
X-Gm-Message-State: AOJu0YyxCtL1kKHTpKpA6mzBUwxQ+9H8LHnqVgJs6QASXkUQ/tFWAkba
	ylLVDKR81AOtqUx5QSJG+cBHCbzNSFOOiG900QYez85/TULm6Gt8nMhfCUp95Q==
X-Google-Smtp-Source: AGHT+IGnK+gnZje9X1/6LlLksscKeRfA13xxM/lcnM8jorFHlscGGkr1Hyq2CL4aSNEn3iRHLZEmNg==
X-Received: by 2002:a05:6871:3a22:b0:23e:7432:6f12 with SMTP id pu34-20020a0568713a2200b0023e74326f12mr681914oac.45.1714727930031;
        Fri, 03 May 2024 02:18:50 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:18:49 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 06/14] zram: pass estimated src size hint to zstd
Date: Fri,  3 May 2024 18:17:31 +0900
Message-ID: <20240503091823.3616962-7-senozhatsky@chromium.org>
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

zram works with PAGE_SIZE buffers, so we always know exact
size of the source buffer and hence can pass estimated_src_size
to zstd_get_params().

This hint on x86_64, for example, reduces the size of the work
memory buffer from 1303520 bytes down to 90080 bytes. Given that
compression streams are per-CPU that's quite some memory saving.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 4da49626f110..4a7734aa1a8a 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -35,7 +35,7 @@ static void *zstd_create(void)
 		return NULL;
 
 	ctx->level = ZSTD_defaultCLevel();
-	params = zstd_get_params(ctx->level, 0);
+	params = zstd_get_params(ctx->level, PAGE_SIZE);
 	sz = zstd_cctx_workspace_bound(&params.cParams);
 	ctx->cctx_mem = vzalloc(sz);
 	if (!ctx->cctx_mem)
@@ -65,7 +65,7 @@ static int zstd_compress(void *ctx, const unsigned char *src,
 			 unsigned char *dst, size_t *dst_len)
 {
 	struct zstd_ctx *zctx = ctx;
-	const zstd_parameters params = zstd_get_params(zctx->level, 0);
+	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
 	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


