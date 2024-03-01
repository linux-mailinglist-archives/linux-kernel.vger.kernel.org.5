Return-Path: <linux-kernel+bounces-88302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409CC86DFDC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F031C232A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1E66E2A3;
	Fri,  1 Mar 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRxinnnD"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2DC6CDD6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291405; cv=none; b=giVk3tWJ5PJ8dS+8VHsr3BtUkxkGemTcoc8tQt+Or2c19WWngcn6GnAX6Pu4jNZBzLaZkdi0875OzV54bKfiEaJjo0Wm6RPBTH79Y4FL5ibnq+x1ck9ofbI+Y6KUjCvjTdOcv0DxJXyEG9WpHiyouaIt+TRQa6gV1rBC4YdZpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291405; c=relaxed/simple;
	bh=LV1fyBSu3ZwpN4ZiEusmgcvF6MxivbLEh1Lghj2THIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDxE7sdY6WbYhxaz9NW/TZzS+1gUA7aVTjzJ8ZwzLM9eVecdNxP5xsUbcSpfTAX3/NAmUYNUJj8gF7py6oxy90hoxGZBV9peWz/JPq20xaF9p50DXZzoJ7tDUCP370q83uWvi1Jh24RYq6tNJtBA0pkVCujRPdfY/OBO7ATuCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRxinnnD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513230201b2so1822699e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291401; x=1709896201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYY5vhGREGmnIQ7NfihjkFOwl5i8Nexdj/rtVbJhxCk=;
        b=kRxinnnDoTzXlGHqXXGnPJ85UTCRw5YUg1vXk2Skn7hi1SGtRCCY+supBv6ivh9pJZ
         iLQCPijkLoXdfn9C4mUJONOp7nRDmz+YNDn9IhnvdGDRmlOOBNLCJrnlQLoPsJjGaHe7
         b+d8/nSgNyjpGq5nGurY1lQPokWx+fDslRVOt1A5zW36CwrZnK0c7hVn/emq6u6q7KAP
         53CmyTb9SIQpYe/9LhMh1UDtlbudEhtXLIyQr/vR5NvK+ma6dxIheO3YnYUb4Ksb+ZLg
         QlTED4yi1hUEUPULSmOKWXCo5jgyoLg11TxdWTRLWG6SiTjiLO0oJ/+LP2XAXBXEJS4k
         dcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291401; x=1709896201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYY5vhGREGmnIQ7NfihjkFOwl5i8Nexdj/rtVbJhxCk=;
        b=MB/PU4mq00KqB1oz+fxuz5SlbFcx/46/Dsak7V4C6o8C11NfME3gGInstu17qfzr0Y
         SFo9szWXSDY51yDQx0dmXg4r3uZPapsW9i+K29gNS/uTOaDoDuKS7Hr5mnu13tgbi+yn
         S3IuCz6nfO4HZfnCDf3pW83dvGhaVBTjkSOdu3PsDZlhknSv8M8vcj4CsLPNW40wwru+
         pUiSgU24EZeibFEUEaQuJRnPSWsXVH0j/uT/3+EaXXC6YC+7Mq5Xy1pOK6RsH4Bs0eCD
         PTqp6JvPFJL/XijRaf4LjG6vU7QxbUe7k6glOOVlJx3QOlAkKDOLViII6OFSwUoFHrcf
         nGYw==
X-Gm-Message-State: AOJu0YzRSzVPpEIJ+SV587HNV/7PqcdXcSfwTYEicUEQF2ho0E3i9XpP
	B5XtPWYz6XOk3OcpeanEGrWSN8dyC516OGdKQ/lL9l1UXro6dkmnNI1Q4f4FcFg=
X-Google-Smtp-Source: AGHT+IHx2omjBwV13BMAVRo0qLA80YK8oxD3iBNrU+OgrtEJ+EsjKczxiZhF+ZpPK05I0fb+A4lrAQ==
X-Received: by 2002:ac2:5b85:0:b0:512:bed5:3d87 with SMTP id o5-20020ac25b85000000b00512bed53d87mr982592lfn.23.1709291401482;
        Fri, 01 Mar 2024 03:10:01 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b00412cad66f8fsm490264wmq.44.2024.03.01.03.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:10:00 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 5/7] sched/balancing: Update run_rebalance_domains() comments
Date: Fri,  1 Mar 2024 12:09:49 +0100
Message-Id: <20240301110951.3707367-6-mingo@kernel.org>
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

The first sentence of the comment explaining run_rebalance_domains()
is historic and not true anymore:

    * run_rebalance_domains is triggered when needed from the scheduler tick.

.. contradicted/modified by the second sentence:

    * Also triggered for NOHZ idle balancing (with NOHZ_BALANCING_KICK set).

Avoid that kind of confusion straight away and explain from what
places sched_balance_softirq() is triggered.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 31838b9dcf36..0e13b0016f33 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12409,8 +12409,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 }
 
 /*
- * run_rebalance_domains is triggered when needed from the scheduler tick.
- * Also triggered for NOHZ idle balancing (with NOHZ_BALANCING_KICK set).
+ * The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
+ * from two places:
+ *
+ *  - the scheduler_tick(),
+ *
+ *  - from the SMP cross-call function nohz_csd_func(),
+ *    used by NOHZ idle balancing (with NOHZ_BALANCING_KICK set).
  */
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {
-- 
2.40.1


