Return-Path: <linux-kernel+bounces-88300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985B186DFDA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C834D1C22D55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0EF6D1A6;
	Fri,  1 Mar 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgGBW+5g"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485C6CBF7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291403; cv=none; b=EGIrWIjknGiN5PlaHZL1YThM80VD8eDRvfke2s+e1VIIknG3vEnDpyPSQ+PuOJLsTf2ipOQEAMoBuWPdkuDDsijp6WkDrYDDlzRnELzaVdI8enXxeF+TRNdWtssihGsoFtbNcLad28aE99h8j430ILlyQ8w9S1rHxFObCL4Qrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291403; c=relaxed/simple;
	bh=25qFObja4ZHXiwqUDbfSYr1EcpHvXYlwGZ9JseGR6EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEWC1n3Qcwj72fRHZIUbNuSf183yQjgy46AnR7ItfmxhexNzS4fX0wU4tfcAEbxXSDta6f1Aub6vtXUpwo9v3eOPFPbeZdLNEf9/tiSZwCCvvIm4UdSqKTV3G9rBOynVnvif6i/ICKBRjwh/63BRGXvUjFBEsEmFgEkXP7dDFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgGBW+5g; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412b83cfb44so13122075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291400; x=1709896200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8fTQ+F8wbIR0pBCZ90+DSUH9EydgL03eONGv2AQpFQ=;
        b=RgGBW+5gtuYht/xRdLIpgr8Fajx4QQZ/HwNoCZRYO3tod0I8pYe9uIgCA0xo8LwwYw
         IeLuY0Td3LK6slawfIvmioVLkgWifGhGVJ5Fhu3lq55+Iqxcyog7BrgvCjFYpdq89CRG
         g3X1gE+wh6b7ZuD6YQF0v2LpoG65cgy3B6r+vrWslLL9N/jiew3MORceNCzzrxSh/kD6
         UNZ51pNGu10CON7gKphmdWlJ8cjNmx5wuQusgY7jw8iayk54e8vemv1ydBLEzYZkDRGo
         qdZRt8yXlUaf/5bj4O+GO4DHaUxF39dMh0LiITBlmfPw69PYt7E8/ItdOEX/069JGcTU
         4LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291400; x=1709896200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m8fTQ+F8wbIR0pBCZ90+DSUH9EydgL03eONGv2AQpFQ=;
        b=IW/2m//5DKXi9+T2u6BPRFGQ9lDKy27mJcWDzJZ7wm01xJm/IzyyOQPGVvdU2PUblm
         hWTfA+pTUl81uf443RMfxNPmKu/+l9z3iifTwRmqec3NVufjWvoD9ylTf8wQiChuy+LQ
         f7yOFMISh+rS3VsHHkSaKbvT6V5416A8qok1YOmAcBHoeCI0+C0YoxrnPicl5TTw9Co/
         YQfkwciwJZ8IFN8huGwYAqyxMk0oiZPWwQx6DlBrYgIiGt/B1GtJagUxLpHW+7qACbM5
         sKQl3M7MLyBk+i/qfklmTT2QYpN1tmiXVUm1qWTHkyr+NOViP1c8/t0ZsYwVC4z+GkFz
         wPqA==
X-Gm-Message-State: AOJu0Ywo3V7wy0aRlMxytfSKe0amfevij/l8hTIzR7viiNkdYuxkbb23
	8RLBkAnEWwOW/LLfj6Y0zlJvrOI4Pww8waDOaQ4ZOlzpFY2p8CtQ28rNsNw7nM4=
X-Google-Smtp-Source: AGHT+IHNDisWXxf+gqRVuS6xPxgcP7j2PAo3PCTzuFEvXmvHeZRueUpjcjFQdDDMhIpB/EnOxBIKWw==
X-Received: by 2002:a05:600c:4e11:b0:412:c855:b5b7 with SMTP id b17-20020a05600c4e1100b00412c855b5b7mr1103993wmq.21.1709291399512;
        Fri, 01 Mar 2024 03:09:59 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b00412cad66f8fsm490264wmq.44.2024.03.01.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:09:58 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 3/7] sched/balancing: Change comment formatting to not overlap Git conflict marker lines
Date: Fri,  1 Mar 2024 12:09:47 +0100
Message-Id: <20240301110951.3707367-4-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301110951.3707367-1-mingo@kernel.org>
References: <20240301110951.3707367-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So the scheduler has two such comment blocks, with '=' used as a double underline:

        /*
         * VRUNTIME
         * ========
         *

'========' also happens to be a Git conflict marker, throwing off a simple
search in an editor for this pattern.

Change them to '-------' type of underline instead - it looks just as good.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f11fc6dd39b1..934ace69eb30 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3679,7 +3679,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	/*
 	 * VRUNTIME
-	 * ========
+	 * --------
 	 *
 	 * COROLLARY #1: The virtual runtime of the entity needs to be
 	 * adjusted if re-weight at !0-lag point.
@@ -3762,7 +3762,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	/*
 	 * DEADLINE
-	 * ========
+	 * --------
 	 *
 	 * When the weight changes, the virtual time slope changes and
 	 * we should adjust the relative virtual deadline accordingly.
-- 
2.40.1


