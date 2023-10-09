Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB77BD9CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346282AbjJILaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjJILaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:30:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BEEB4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:29:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6934202b8bdso3606914b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696850980; x=1697455780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA2GT8eqbiQpihVq6IatV7jxO70qnqwP/ImeaPQmFQY=;
        b=NkFyvWa7KgTZa/BEpeY42VOE6I8nTExNfU0a6kLUNHo63m1YsRGStUNwFtOmyDttbG
         OLQFPQlZAnjBv4mrps3iMFjTppd7VDVSPJSY6uLGmmkpgkd0dmsmD9UbKglXj2QpUCgU
         HyOdfcS8Z+pUFu62UsOAk+cIpE7zdkSUpwJy+AA/OfJZSQLpE0mQIedkXjN++iEV34nY
         o5xMxCBl05ls5DynBQXiSXK28ULjEthFBz4gSbhhxwXN2OpET0inMzFTsgTvZRqs29jM
         cSt+MVUmJSj7v5DtzUzYdATgxZ+Ctz92or106igs2z/OmO0iH9i9ZhqLhiGPqiTvb/nU
         geKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696850980; x=1697455780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA2GT8eqbiQpihVq6IatV7jxO70qnqwP/ImeaPQmFQY=;
        b=g10Xt5gbjxfE0atYL5xIq2tTSjSgeMV7bGiPM0bbWgXSsL5pwltLGhYiXmtu6D6mob
         nvynvg8JH7qkQSi4jwHVeF0OkCynxZnlXu7Dfhq17QOESzqS+QX9vY86UXYAdZHukqDe
         WZzZmomWL0mPjYU0NDwSRFY0N0M7wwe56LJHWc+30V9fkUER6Y1RzJI5lYFO231TIaQP
         Q7dFcsd8Xluzsnc+lee64PtA+VKrJHvYQ+Edn51vgL5Y0XTiPDB55QVyuuiPeKN9AZjc
         8ZLez4gHg78lPFlmQ3iJK3SIydniDc4/nT7kPQ6oQ3wXq5psyXm9kF+OEZ+RrdyjN3RI
         O4fA==
X-Gm-Message-State: AOJu0YzCBQiixdpunMZW1F0KE7PNXHvKsChfhGBWJBPv41YYE7tzR9zp
        UVT9O/P0jZT58rfTDs6CbK95KQ==
X-Google-Smtp-Source: AGHT+IGb6yho3N2vKqm69w/2J2A7jX8tPga8/bSYK0Z0iBic3N7lSd2HTvgeG7X2IAqd1oF0NoQoWA==
X-Received: by 2002:a05:6a00:22c9:b0:690:2ecd:a593 with SMTP id f9-20020a056a0022c900b006902ecda593mr19268889pfj.26.1696850980690;
        Mon, 09 Oct 2023 04:29:40 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id a21-20020a62bd15000000b00693498a846esm6129376pff.80.2023.10.09.04.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:29:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] xen: evtchn: Allow shared registration of IRQ handers
Date:   Mon,  9 Oct 2023 16:59:24 +0530
Message-Id: <8380c7b1c8cd9edb2e45e9a204650b34df3458a7.1696850733.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1696850733.git.viresh.kumar@linaro.org>
References: <cover.1696850733.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the handling of events is supported either in the kernel or
userspace, but not both.

In order to support fast delivery of interrupts from the guest to the
backend, we need to handle the Queue notify part of Virtio protocol in
kernel and the rest in userspace.

Update the interrupt handler registration flag to IRQF_SHARED for event
channels, which would allow multiple entities to bind their interrupt
handler for the same event channel port.

Also increment the reference count of irq_info when multiple entities
try to bind event channel to irqchip, so the unbinding happens only
after all the users are gone.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/xen/events/events_base.c | 3 ++-
 drivers/xen/evtchn.c             | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index c7715f8bd452..d72fb26cc051 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1238,7 +1238,8 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 		bind_evtchn_to_cpu(evtchn, 0, false);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
-		WARN_ON(info == NULL || info->type != IRQT_EVTCHN);
+		if (!WARN_ON(!info || info->type != IRQT_EVTCHN))
+			info->refcnt++;
 	}
 
 out:
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index c99415a70051..43f77915feb5 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -397,7 +397,7 @@ static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
 	if (rc < 0)
 		goto err;
 
-	rc = bind_evtchn_to_irqhandler_lateeoi(port, evtchn_interrupt, 0,
+	rc = bind_evtchn_to_irqhandler_lateeoi(port, evtchn_interrupt, IRQF_SHARED,
 					       u->name, evtchn);
 	if (rc < 0)
 		goto err;
-- 
2.31.1.272.g89b43f80a514

