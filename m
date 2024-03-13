Return-Path: <linux-kernel+bounces-101012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC28887A0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B11C209BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D720DDC;
	Wed, 13 Mar 2024 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BeGPxHsN"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B61F5FA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293133; cv=none; b=qHFSvCeX+aQ1NgwzIdAwng8s0rRX414VLPzPfIlV+jypIFMRmgAeb892upJWaHwzJXjCj/beIVuUzwWASsptxfn7C1RGwunt6k8nrK9B0JM4OZte1Ae84ZAzIVZUhRCeR085EYWvSvdLta0W7EFTD9lbK5VpxQapplEEt2GADzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293133; c=relaxed/simple;
	bh=QLdUMfFBHEXRelk3Gs5vH3ZclEOu/Hi8wJrg6o9Q3NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYYh3I0xxJMe3j+uIv0YFFe2lcjbejDWJgXhIwKb5fulI5C5k32KeXSqQQKhAxoEkdAoHhnVokJJacmLmcBstMFF8wQyRLt303i7g8QrcnCD6qIDvJY51ZJ2W0JX1f95Bc8WUoS5uTxID7b/29gQ/5pJtfO01+hUD4mgl3ahRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=BeGPxHsN; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a0599f647so5124657b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293130; x=1710897930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJpm5svSk0YcjafSF+vl5lrL0xoq62Q9LU01QDuwzgU=;
        b=BeGPxHsNZtmVeAp2A+d/KK0dd/+9vAIzAPsZcklZlNnYTwufbxwN0BRaFiOJHccvBy
         ZV9AiUqi9QoyfRAwca4SL4jhbwsX3HI6OqFJsQO/VMdm5B9cmK4TSs0TKsiAcvE+FgSY
         Usevbt11KmIY+NKzWCVBGDL1idmQx3Iz+jzPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293130; x=1710897930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJpm5svSk0YcjafSF+vl5lrL0xoq62Q9LU01QDuwzgU=;
        b=hZT8teP89eqJqi8vrEaehDMwBVet+baG1UpJ20iBVHck/va0xEqunix4MeTSa9pIMU
         fWqkyjrh4HxAJ8VxHo81TVK3684FvbM56VQWrH81gF5Qa8owj95hf7Wt6rAOiShzI+fP
         Q3KTEIGVS2e7OakJt6DB/zkHAY4hkiAcSIlBknWrKuL1gs637+6AQgRS/S94Y/tIAlMF
         Y6jos4eNEH6Dw7jr+R/eL/ai/pRKll1of//Aw69Cn8BKej3gA/I+phVR8AiPczf4FLYA
         5whuVaSwYmdViRmZ38ftLj5ALdEU/9LxI3JYi4BWKZBBdodQyX0FRtdhKTr84fQJ+yOo
         8MyQ==
X-Gm-Message-State: AOJu0YwAaDEZEqw2B+zsn2Es+W8ITh8dXEj2ggX0Q20XaELCMv9RCU59
	WOPnhe+7sgk5PEwXr4Ea4ltqQGeRUG7H3Rpc/oRPnLv2W4TdahKlUx53Kf1/8GmnwuFilEjMXtC
	v
X-Google-Smtp-Source: AGHT+IFYCSAEULJTqtEn0oYnVdABZeIOJE0FPOhc7DzvWAW+8IvxOF0ETtT2R4mXtSk8pc45IKRtIQ==
X-Received: by 2002:a25:6911:0:b0:dd1:21de:7454 with SMTP id e17-20020a256911000000b00dd121de7454mr1182621ybc.57.1710293129800;
        Tue, 12 Mar 2024 18:25:29 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:28 -0700 (PDT)
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
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v2 12/15] sched/deadline: Reverse args to dl_time_before in replenish
Date: Tue, 12 Mar 2024 21:24:48 -0400
Message-Id: <20240313012451.1693807-13-joel@joelfernandes.org>
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

From: Suleiman Souhlal <suleiman@google.com>

dl_time_before() seems to be incorrectly used, we need to check that the
0-laxity time is ahead of the rq_clock. Fix it.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1d54231fbaa6..dbba95d364e2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -914,7 +914,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * is in the future, throttle the server and arm the zero laxity timer.
 	 */
 	if (dl_se->dl_defer &&
-	    dl_time_before(dl_se->deadline - dl_se->runtime, rq_clock(rq))) {
+	    dl_time_before(rq_clock(rq), dl_se->deadline - dl_se->runtime)) {
 		if (!is_dl_boosted(dl_se)) {
 			dl_se->dl_defer_armed = 1;
 			dl_se->dl_throttled = 1;
-- 
2.34.1


