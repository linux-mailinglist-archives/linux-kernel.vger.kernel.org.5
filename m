Return-Path: <linux-kernel+bounces-90349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B8786FDF8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905BEB220F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799A0364B3;
	Mon,  4 Mar 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3MRVr1b"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C7A225A2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545729; cv=none; b=euitIx7i4q5mQX2mnCxXskJ+Gk3X/f3frYJ2q0+8tfyNU4iWzqkUgCR2xoItXIg7CAqmafWtY7uuygFSYAlN7HkDZGZQo5fv/v/L7aU97CfR/yritxTvGrP+SUkp1gAGSndIfdATkpPS1cv35rfgFfLgKYWx8XY2mDef/P6LjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545729; c=relaxed/simple;
	bh=25qFObja4ZHXiwqUDbfSYr1EcpHvXYlwGZ9JseGR6EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ji/MXSXkhlVQUl3z/4pW7kh1XHi2YDETrHlKoiukvPc4HTW1wKh+VbHeTpxxlCaD3p56HNfto30LRC6yU9nPNJRuHlq7Vc4PVBxqMtnNCKWUDyQxXphtpmnqpHxZs4daT3HyaHDWJSnyF34aN0EJ1bBLnS5kTrcViIk0loYaI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3MRVr1b; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso551281566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545726; x=1710150526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8fTQ+F8wbIR0pBCZ90+DSUH9EydgL03eONGv2AQpFQ=;
        b=T3MRVr1btKrUguAdiuNooYiB6ZAghYwKNCztLL45EfkoAtKdpuTtPI+mDGqgqw9flw
         xtp1XYQ4KCzsF43vcJsNik+uqAqgqHfFywlc54GzlSPRut6QsOXzSmYNz51PfyykqVlb
         EH6XgOvSH03zSeeR8IXC9Q2CZ/Mvix1GZlKAW5Jah73X3XyBVE1VeM7ofIC7tRhWrA1j
         oG+wdkH/hQw3/S+qiC7mWKepQN268kwt3RC0VwTno/q5K3FDxpe1alHDK9st0Xo6iUqW
         m+FNXuoCFsNPuoUFWSay1ikL9HVKWklruIg5+rS97q40qYxB8O3GyeujRpM2n1s8huV4
         LE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545726; x=1710150526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m8fTQ+F8wbIR0pBCZ90+DSUH9EydgL03eONGv2AQpFQ=;
        b=FSPBmMEelH7wCiullRyJB4+BqT47E8hGm7aYTTfINVrjHhcfchHKBpzRQ24XYCLqbO
         82K1a86+d6YItJP2zZpwE5YVcV+5xnVlz2VjSiiiO7AcQAF3eZxpjLXSHjo/2jQPOZP9
         zbnrKDr/yddF2EnbGvadPXErVLgXjQCTz0eBFDyHM8HOvhzhpPiv894xv7xtvlJzKeb3
         5kK4GZU6oI89KWxJSDqF2swnF5Acd8UqWSkU/eVgL1IMEPlLOy2OjijIipqp13RnytNW
         HCr7gFwb2ohaplvAq4qxmt6OXAkySff07UVjAeLMV3d0obAfYYGKnKcDU3JfSm2dn6Nh
         mu3Q==
X-Gm-Message-State: AOJu0YwfV9Zly3Cr+yrgL5uko33F7a4/1W00NHWt3eTy6WYiBbluhsY2
	ASyvLm+TUY6LhYZUk9hnTB9xpnBZB35gspKgXcJwnkM8J8kGydUTWow/MKu4dJk=
X-Google-Smtp-Source: AGHT+IF1FsxSvOKuqOF2NT31Ibw7qOiTD8cI3Sr3moOY5rR9+7kSDHylbfkPUsEZBe1RzLQq99Ap5Q==
X-Received: by 2002:a17:906:3642:b0:a45:122b:5637 with SMTP id r2-20020a170906364200b00a45122b5637mr2410198ejb.41.1709545726622;
        Mon, 04 Mar 2024 01:48:46 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:46 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 4/9] sched/balancing: Change comment formatting to not overlap Git conflict marker lines
Date: Mon,  4 Mar 2024 10:48:26 +0100
Message-Id: <20240304094831.3639338-5-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304094831.3639338-1-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
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


