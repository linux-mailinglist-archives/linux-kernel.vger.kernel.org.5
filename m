Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A23809719
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444162AbjLHAYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjLHAX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:23:59 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A601716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:24:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c05ce04a8so17827185e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995043; x=1702599843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwtZB8Hg/lOBqKmz0+dSFpJe0u9fDzGLjlhIcgb+tpk=;
        b=xj2HujGnKjGY973qXjrALFveNqg4JtB5WrFOCWE7ceaHSrGZv+iId/X7CpuyCnwoqW
         yiBzfntjMJqv8Z0/8oCviPo2TW0ubACokq78I+kvB1W4RNbGgpkGn3OVsYkvwjCdiXAh
         L1GQZIjb+6tTPNGF+/ZbLDAufX9G+l1R/HITvIrdkaKd0/aEiJbU7o32TrdscPQqKbMf
         /i/EfxPDBUmPRUbFH3c5KEl2oVepagtZfN4zqv9MB87Ua991MAz32nq6i+uxF/1ivMHK
         QHDTzgFLekdL6A1Cv5oBxp5ewIVpa+aqOmtc265EGi8HAwBdoyzEljTWoKjbjfZ4//Bc
         NNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995043; x=1702599843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwtZB8Hg/lOBqKmz0+dSFpJe0u9fDzGLjlhIcgb+tpk=;
        b=OPVcLJJZxXX7+3XqEwMbwqyJXTP09yjNb5n31t5oSH2sJ+d53K7KdktFUDwKChmtel
         so0ePdsYzYj3vPOsvz67MeeJ1wnrtpXwsz2floJt19CN4LVdU8IGFyc84dUqeVgD/sax
         m8eFx30OwGgAQ1fOLhR4Cx+m6Ru98MSxl+40LerIIvHusorbFXUrcAV5s0ReBVH9lrS9
         xAITXYSS86dlv9t49y5eeANAAi4EwOAmOdIJlkz+1qaG8tCt5NsGkSBSHZcTUIOFluac
         zwFQppJu9fmJ5F3z7KHTnApqnhh131ip4O4gKxCB/2LfHTxfaUDgbz+rgt0bScxlavN1
         iMlg==
X-Gm-Message-State: AOJu0Yxs9VzlQNvqA1n3PI3Eov/unxyWEIXnTZtm/PtOKpVlV78OG66j
        k7Dy9x9SgZlkxhc9IfzKEq6bgA==
X-Google-Smtp-Source: AGHT+IGVtKxjAQHmSHnL7qQgtAYyHt3gL7QtYpXDZBL7rGC1MYgIoikcqJ3lLQPOfBoqfLdZumfpWg==
X-Received: by 2002:a05:600c:4a12:b0:40b:5e59:f70d with SMTP id c18-20020a05600c4a1200b0040b5e59f70dmr989742wmp.127.1701995043482;
        Thu, 07 Dec 2023 16:24:03 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:24:03 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 1/8] cpufreq: Change default transition delay to 2ms
Date:   Fri,  8 Dec 2023 00:23:35 +0000
Message-Id: <20231208002342.367117-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208002342.367117-1-qyousef@layalina.io>
References: <20231208002342.367117-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10ms is too high for today's hardware, even low end ones. This default
end up being used a lot on Arm machines at least. Pine64, mac mini and
pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
it's too high for all of them.

Change the default to 2ms which should be 'pessimistic' enough for worst
case scenario, but not too high for platforms with fast DVFS hardware.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 934d35f570b7..9875284ca6e4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 		 * for platforms where transition_latency is in milliseconds, it
 		 * ends up giving unrealistic values.
 		 *
-		 * Cap the default transition delay to 10 ms, which seems to be
+		 * Cap the default transition delay to 2 ms, which seems to be
 		 * a reasonable amount of time after which we should reevaluate
 		 * the frequency.
 		 */
-		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
+		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
 	}
 
 	return LATENCY_MULTIPLIER;
-- 
2.34.1

