Return-Path: <linux-kernel+bounces-131040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D693089824C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EBD1F28F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217C5A7B9;
	Thu,  4 Apr 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ovVKSzL9"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52581CFBD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216320; cv=none; b=UJrFVD+cxOHz3820im+ZA2c3nGJvDxM69lZpzCiSTyEE7VCVb8FKejx3t3o3smjgzU2HbX/oC8M/iXm6aLfIkAmBcHwIbqqK2Hn4/WNhiX8pbhaYgFbJyRU5MulbF80QsrbODCB1Yd7Suwxlp20BOaw/zHxV77NfHMOyEuS3rvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216320; c=relaxed/simple;
	bh=mwnrrNbmJUysYtPcRMGd1FkeEzD0XnaYLTKkcCQREHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An48xFErWvhMUrV3DXpPel3E65XHUAN2YkYHucyfTxMuqG6FWsTe5OSOQuBNlyQTHh8oGmIVsIE9YfuoxVB/UCxIEXMgEVdAOZpiw4YWZDB8hfdewfkyXKBR7fUbC9rpMTJG8D2fwvXxcNbgwb6N2w5PuN5jIjkd7sR3M730OJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ovVKSzL9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a45f257b81fso85059866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 00:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712216317; x=1712821117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7ZOzx62lBX2D/0ppisXA1WsdAUT38r7ZPRqnfM8I1E=;
        b=ovVKSzL9mPaaODmNafq+xWjeRQZ3ogoNlQ4vmf2JoMKnAQK6JLhBLqao1OBj/rOQeO
         8gEd5QEt5xtLt79D6h9Pvtp4uqgdiUQSXFwydQo32YWEMvAyZA8ZVTENAZYdjVCxDMZY
         KdigY21dUKilhZiRRvHNOIb4Fnix8OoyU7lLporBqS5XmgmMUtQwxlrWVl/RWrctCot+
         su5PQhXDKYJBnD/bCYEbRGR4RZFEtYQLt3T2cb4ZySfxaQh4Y32YE/56bZ0uF/B43Lmv
         X2Vbg42jql1w7j0G6yUMHgnfH1eFnWqLfaa+gljDUOYjDTW1wdE9SBalR46iPKmLQxnh
         5ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712216317; x=1712821117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7ZOzx62lBX2D/0ppisXA1WsdAUT38r7ZPRqnfM8I1E=;
        b=IlxwCL+T0n+luA2iNJfzdu6VhQKMYAMOriMkfzVT9OkOvDe1z9uL2hcIuq2aHYHPHX
         /rVvRYUAyVY+TsHYtasIDPzBa9nc43U/nWYhQTB4+qtL3od9uRDdv2FblChN1atOFtS9
         Jqhu7ppTbNOL2vbvOL1fEceG3480/52lSF2Vq/EgU/D0rWLxR6I4yvZO1MJQ10DTCnlh
         14UeMs9t1fsjA9KsVUqpFc/4e+0WDEynYEhcBh9fThRmAYaj2hVZ8QnJa3wJBZcgBXD7
         oAh38SwcC5I9YdKeWaiijp8ywcNO8ac2q0+KWQPZxGi5ZZo/0rkcqGgb3prWguMwjhEm
         H7ag==
X-Forwarded-Encrypted: i=1; AJvYcCWhqw6GaltHRqmgrEeMKAby4mFrse6owTPWGF7w5SAwiOlDI8yV6MLBeAoi8r4GZ0c2pRr+dljvtDZ/cIzdWvbmhjursvI6G+EA5a7d
X-Gm-Message-State: AOJu0Yz9Qw04j8AwADL0jpFgHTHP+5HD6MY9P8wcNkEv25r6tYE/MV2/
	zBrUxdsaAcCU7ztWGiRIAc49vXWXsnb4vgXhXd3Gs1+dYYP9Xy4GX9pA3fzLtFc=
X-Google-Smtp-Source: AGHT+IEP8wVjv0PpnomH2Ts8LZZJnIG0TcRpbXLHOQPFOXvt0OF7I/576pGVcVUh+4g6faV/FkoEyQ==
X-Received: by 2002:a17:906:48d2:b0:a4d:f620:25e4 with SMTP id d18-20020a17090648d200b00a4df62025e4mr1158301ejt.66.1712216316791;
        Thu, 04 Apr 2024 00:38:36 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id ga13-20020a1709070c0d00b00a473f5ac943sm8633369ejc.37.2024.04.04.00.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:38:36 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jirislaby@kernel.org
Cc: chris@zankel.net,
	gregkh@linuxfoundation.org,
	jcmvbkbc@gmail.com,
	linux-kernel@vger.kernel.org,
	thorsten.blum@toblux.com
Subject: [PATCH v2] tty: xtensa/iss: Use min() to fix Coccinelle warning
Date: Thu,  4 Apr 2024 09:38:02 +0200
Message-ID: <20240404073801.5716-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <fba2102e-aefc-4be4-905a-57061c1f8cce@kernel.org>
References: <fba2102e-aefc-4be4-905a-57061c1f8cce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use unsigned size_t to improve len data type and min() to fix the
following Coccinelle/coccicheck warning reported by minmax.cocci:

	WARNING opportunity for min()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use min() instead of umin() as suggested by Jiri Slaby
---
 arch/xtensa/platforms/iss/console.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 8896e691c051..d2380767f3a4 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -167,8 +167,9 @@ late_initcall(rs_init);
 static void iss_console_write(struct console *co, const char *s, unsigned count)
 {
 	if (s && *s != 0) {
-		int len = strlen(s);
-		simc_write(1, s, count < len ? count : len);
+		size_t len = strlen(s);
+
+		simc_write(1, s, min(count, len));
 	}
 }
 
-- 
2.44.0


