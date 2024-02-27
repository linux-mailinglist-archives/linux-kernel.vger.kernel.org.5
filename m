Return-Path: <linux-kernel+bounces-84227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70F86A3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71F6283DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420D65646E;
	Tue, 27 Feb 2024 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="CmbxMUtl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869875644F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076901; cv=none; b=alNswBx+bjxrf9LGnX3MsXbilnCmM0Hl+7HBUrkjicPaxCGSIg+nnzM69a9gpOuWPjEoW5kqU87PT2UaHYlBpVgdXDmoxR6eEYkXfBJHt1jW0+g2/8L+Ukoj7HNE3SlCFHnOKbPX+yRZb6rj5OR5bGCKT7r2w594Ym8xnnAeprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076901; c=relaxed/simple;
	bh=gRC6j0K7LFqSQU/6DlrnOPqvA92Esl5PB0v8SpJNck4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1XmmRFlrjgySnk+to+Aq+CQP7kMp6eU0/+0l+IFpWiH7efnYpZQ86xg82OnjTPIojbz9EtTi3pkzIVnsL8Xj0tyKnFeHthsqVXHVirxuvRIj99tSH7aFS08h3J3ZxgpLHdpHzd2Sr8VwDQCaBtjob9Qrp6RjwNTE08Zq/ACYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=CmbxMUtl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412b434effaso79865e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709076898; x=1709681698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGIQk7rXip9tFvcYlcm0hZ25TTGnFG/+FGuOb/CLIyI=;
        b=CmbxMUtl/oc5YY4bbtYxNsqdh9qAfRL8e3u+xNX4TbtQasqC5OyvT/WrXuNMyUd1+5
         AzqViT0hENn8MCVD4oCfU32ED0/0tDUZ9zHCdkN68ZYO0PLj7sYOxg5nP9r0aD+WQVVd
         vGLu9UqFLgcLZCn6ZMlH7bttnqzM53yHkO4vo84xCilqItqf2qTby6XJGqht1XNnEY/Z
         LvYrzwHfDTQTF0gk0zpZQZf4B5AseEle0qUs7BN6EUV+pdidi3KaM0LPfdjDzLAVRUGM
         NNIht1+nIj7BHYeWzawh0vFIlAadhy6fXThdAJWOVgAusbKRvssG6BHLDi1CwIC3bgzH
         8THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076898; x=1709681698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGIQk7rXip9tFvcYlcm0hZ25TTGnFG/+FGuOb/CLIyI=;
        b=a9EAR7y7MP/QVuLE9ye9cwp7+vymc/fd/5yaFjpJk2xTsfOJkR8MbG2GEDICyItN9y
         ci4iIDl7YPJg7n0hYlHOCtn6YeSH0WDqscYjrSQR72TUjk63iowlcqMBHrfJGFVyohjI
         sSb8nji5yEYt9xBYzrW1Pat2byN9pk8aF7BKj95i+ZAAGGpgqxbq9lWDiSH/EmEnHIw/
         YiSMf1QRJ1W6HGnUWNObT+ToNXcjJviJ7MjCVRpk06v4T9edE3jhUSkw3585KcDkV2lE
         KulwEGXnc7M7edpTyYf9fdF0hOISxkS8NCm8n9sr18vb9Wh5t/+LYYVl4KtW5lFyLmaP
         RoaA==
X-Gm-Message-State: AOJu0YzelwNWngZm7pBiRYCNFvWKt+0t6zz5LSStWvFcr4JN85A/U3PC
	8gHFwhDfOl6/0fud3eXbnpilKtQocgZeeqBCE/6hUPEDcvmgPRoUnKHfwCkMhQA=
X-Google-Smtp-Source: AGHT+IGg1FSvvzccob9cPmft0pC6SQzWbuVqjhsNI3ds3NgQAIKqZvkwXFy5iTWYwDXmIfcb7BxZGg==
X-Received: by 2002:a05:600c:4f55:b0:412:880e:7659 with SMTP id m21-20020a05600c4f5500b00412880e7659mr8060055wmq.32.1709076897700;
        Tue, 27 Feb 2024 15:34:57 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b004126e26f756sm220756wmi.43.2024.02.27.15.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:34:57 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: [PATCH] cpufreq: Honour transition_latency over transition_delay_us
Date: Tue, 27 Feb 2024 23:34:52 +0000
Message-Id: <20240227233452.405852-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222233947.sl435tvhhpe5iqzw@airbuntu>
References: <20240222233947.sl435tvhhpe5iqzw@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms like Arm's Juno can have a high transition latency that
can be larger than the 2ms cap introduced. If a driver report
a transition_latency that is higher than the cap, then use it as-is.

Update comment s/10/2/ to reflect the new cap of 2ms.

Reported-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 drivers/cpufreq/cpufreq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66cef33c4ec7..926a51cb7e52 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -576,8 +576,17 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 
 	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
 	if (latency) {
+		unsigned int max_delay_us = 2 * MSEC_PER_SEC;
+
+		/*
+		 * If the platform already has high transition_latency, use it
+		 * as-is.
+		 */
+		if (latency > max_delay_us)
+			return latency;
+
 		/*
-		 * For platforms that can change the frequency very fast (< 10
+		 * For platforms that can change the frequency very fast (< 2
 		 * us), the above formula gives a decent transition delay. But
 		 * for platforms where transition_latency is in milliseconds, it
 		 * ends up giving unrealistic values.
@@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 		 * a reasonable amount of time after which we should reevaluate
 		 * the frequency.
 		 */
-		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2 * MSEC_PER_SEC));
+		return min(latency * LATENCY_MULTIPLIER, max_delay_us);
 	}
 
 	return LATENCY_MULTIPLIER;
-- 
2.34.1


