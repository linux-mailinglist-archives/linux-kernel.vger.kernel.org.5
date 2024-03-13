Return-Path: <linux-kernel+bounces-101014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010187A0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406652832E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E7225D5;
	Wed, 13 Mar 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vE27EaJg"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371B22331
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293137; cv=none; b=V3VYDdo2Waa/xPEURZaj3SGXQUKhMiI7lcAoMQCa1om8cUBosDw8lXXD/OK82WxhMbugAYzIvdNLqmrWTZvUAIFeIGhOkks9NsBp2InHmhiWRhFz+OwW2wqcGrOlJM5ZKRVMJwLpdZyXvjPvD9GwWfnVkD2K2JfUJlQpYsYFZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293137; c=relaxed/simple;
	bh=UK2WewGj1PIdmX5EoPv0UOW0uK+6Xcz9jOAYo7+Svic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYiemUW9qZEuIz5kU9IzhWTemqYK7ks6lAyHQ281vxqVnv3oChUdu4PV6MpfH4pKoWdcrcfXu75GY7SldbetllDvORuCBX8ZRMFB2kcoXUgPVPbOsAwOz8O2sqxok2HBJf2wT3/0LUdGPNNPJkDquZqJ+RaeCtgJcK5EnmcBa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=vE27EaJg; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-690cbf99143so17989276d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293134; x=1710897934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBjm0Ju7uUY9PPr2QBHaZ0I3rXA0RezNA7kWYg5Bv1Y=;
        b=vE27EaJg5k+F+H94r0qeBiIRrBSmi/JxDIqnsrqctOl0ibJaF7envW78FjgX6GQQcZ
         gPv5Elxl1iqTKoL+ozxBI1pEUm1XeXzn2+QpaX6qoidgCxQqVnkPZeikD7UCZFfPq/K5
         QqWEgs7vELBZwGs+hmTUp1Yqm2JYm4jMsEQu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293134; x=1710897934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBjm0Ju7uUY9PPr2QBHaZ0I3rXA0RezNA7kWYg5Bv1Y=;
        b=PxwUCvDyCN9o/uq+hffkZeBtlNzTe09fjOD43ns7//3F0Q+4fyGOxQNIr7D7gwEvcH
         qYn2qzXND5zOlRBVY3FJ7jS95Bs8DT6mqqpN7F55ZRCv7scesJEzd7AKuvDbNTg8J0oA
         YbGnxiap8NfZgqbvT5YFytK4MUt6eMAqPRqNmaWFAOXjdhHycWyjQGBQ1+q8w1S0mYsf
         Zjx9wortcJmB9urPB7QXGrQH5MMnoiRzHaowwYz5GPMeU4QmBTMfTn+2Etmksuaztmht
         kl/ZCImD9xWyA6zGYc99cHtTDh1F7jZCqj2qeK8wQRd/9bhncnJErcQOQeCQwx2O8MEL
         Tv4Q==
X-Gm-Message-State: AOJu0YwDoJxR/ZXspFtJHJEXXIkaEC1u5dmxqZbfPYcZY2ztGGPvfjCa
	p4knXBt4wsAxaoaGBf1f0d1WbggBeOZ/B2WeX61X5UaDYui4f0p+YdF+Z/iqLzbtfvVSherj+6j
	c
X-Google-Smtp-Source: AGHT+IH3s9mhqMJ/yNBnTRDu/1Dct/MaUOssMa5OV0jrVWSMhXTmX6uyDS1HQiGgrasxkfPj/T/M1A==
X-Received: by 2002:ad4:584d:0:b0:690:ca5c:ce9 with SMTP id de13-20020ad4584d000000b00690ca5c0ce9mr3320784qvb.58.1710293134227;
        Tue, 12 Mar 2024 18:25:34 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:33 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	David Vernet <void@manifault.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	joseph.salisbury@canonical.com,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 14/15] sched/deadline: Do not restart the DL server on replenish from timer
Date: Tue, 12 Mar 2024 21:24:50 -0400
Message-Id: <20240313012451.1693807-15-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313012451.1693807-1-joel@joelfernandes.org>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point in doing so if there are no CFS tasks to run. If there
were, we would be doing ENQUEUE_REPLENISH from the dl_task_timer,
instead of calling replenish_dl_entity(). Fix that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e978e299381c..179369d27f66 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -915,7 +915,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 */
 	if (dl_se->dl_defer &&
 	    dl_time_before(rq_clock(rq), dl_se->deadline - dl_se->runtime)) {
-		if (!is_dl_boosted(dl_se)) {
+		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
 			dl_se->dl_defer_armed = 1;
 			dl_se->dl_throttled = 1;
 			if (!start_dl_timer(dl_se)) {
-- 
2.34.1


