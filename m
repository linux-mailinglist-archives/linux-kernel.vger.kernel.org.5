Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE607CA022
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjJPHL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjJPHLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:11:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99FED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:11:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso1668162b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697440311; x=1698045111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA2GT8eqbiQpihVq6IatV7jxO70qnqwP/ImeaPQmFQY=;
        b=c0cmlIbMULuVKRYc3sCOeVmPgo6C7gQDhRNtrKDRqAZWUQ7VbqG87GtMFKJY5i0Vt8
         6dC0dZGkYmSUhdjj6pFswkJXL//WqtYSA1jVINPB9mbmLG2OhJCdgevaMGX9UBiqHJ1Q
         e0IMn8hKO7XxANbzCr48H9ZpF85nzgtR1iXsJDtrAw9x5fBXSzC04w1dGf4i0BHgRM0m
         ketFLUPdNqdrgx6M+FEHdphDegFZQfc0iZoH/ZcZsfp3Aho+JKNe0Kv6NfebmfIoN6Qu
         yoCpVuNRRrsol9DdRSJcD8fOfly4Auv9hhfnVyhbZsJ22fpimrY7yVKiRWcg+1gigM38
         fNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440311; x=1698045111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA2GT8eqbiQpihVq6IatV7jxO70qnqwP/ImeaPQmFQY=;
        b=WHZdcwOLfpn+bSpQ7jexnOe3vOMoR4O6PTt14Xd5D/XHEUx0IsUsRZCKX5GKywdQ8u
         1qNFWpk7YUIvbi4gH7xVXOHH6LTmyx3Lv1nvZIxPqmBIZIKRdHrCmGc/nKEp7rUljPxB
         HYuVVXVp5D6DWi1LgM0wBYzipaEcp8XWMpor887ey7LtwyZxXi2JpLoAdRqIqyIanis3
         Cwdeq9522JIsUi54/UvxqFWQVbpnPuwoEi367lRWrbfRdcYe/qNhE/Xfvuy0UxzSK6Rn
         AMLDNZuNw34VfacIm682zIPllakhqq1m8pnle5RyiXy+0hPOY92S6vIl6mzeldPJFRl+
         ugjQ==
X-Gm-Message-State: AOJu0YzWkWbxPG+V+Axt6A3r4ih+Vj4Kt1RmcSOqdyJttx0Q7OyHLlrz
        1Q+7+a59GJjuwG8U+IDtIIO9qQ==
X-Google-Smtp-Source: AGHT+IG/g2mNU9z+9wRsIf1tsYOLUhccvghdEO7aXTxMy+dng7C4gaQ2AOy/3vVl1wB0/a7ioozUXg==
X-Received: by 2002:a05:6a00:23ce:b0:68e:3f0b:5e6f with SMTP id g14-20020a056a0023ce00b0068e3f0b5e6fmr35005262pfc.24.1697440311003;
        Mon, 16 Oct 2023 00:11:51 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79729000000b006bd6a0a4678sm2187567pfg.80.2023.10.16.00.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:11:50 -0700 (PDT)
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
        Arnd Bergmann <arnd@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/4] xen: evtchn: Allow shared registration of IRQ handers
Date:   Mon, 16 Oct 2023 12:41:26 +0530
Message-Id: <99b1edfd3147c6b5d22a5139dab5861e767dc34a.1697439990.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697439990.git.viresh.kumar@linaro.org>
References: <cover.1697439990.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

