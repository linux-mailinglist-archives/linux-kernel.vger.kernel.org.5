Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522A87B9DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjJEN42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244472AbjJENyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:54:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86620E44
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:25:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-693375d2028so676652b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696501521; x=1697106321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA2GT8eqbiQpihVq6IatV7jxO70qnqwP/ImeaPQmFQY=;
        b=x/K9iApUxwkXB/vLDWs/CxSrK/LUbB2/jskGhio1+iUtngaqZfQ+MSDiGARj/KNTpq
         Rp30KX//Z9EgZByU676bmmTgWEk2MYpCxZGeNTebEPPmz2Xm0StNPr0LND2a5TlVdjUV
         6x3Kc/A/NzhIDl7RkwZEpDYqWxiPuIdb2GlBw9L5UX6IVocEfr/p1TDnsCQLc/Wzdjwt
         uK/BPEI1Gq2TbRUl8xxOX+ROxdFKWjzB4tVVDsFcvYcpAOJrhLA8bSzSU7JLe3IAYqUQ
         /hesNFKUde5smcGUWMPFlROqD4kRNIsDL9DBZBZlbTQn98pFeZCDeXA12Js2iIs+wsdv
         NMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696501521; x=1697106321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA2GT8eqbiQpihVq6IatV7jxO70qnqwP/ImeaPQmFQY=;
        b=YDayjSJRFjqDExZxAzEL0Y9dgryOS9nFR5hov8KgyVrQBSQ7X5lZsIb1/R+wj9FfTK
         zik8s61qv4+NTqx58QOr6EzWpa8n1saE39NdtwTVPzj6s8OW9npewGpRfgNcicXuzhs7
         ChK9cb7HmLt70LVxYsBl80hxfG+ZzV0aErCN6NRulkoy4QifT8Aic5Q48MZQMjEd9hh3
         rdLpNVpPDPfAnv7QBfObcVrO8CCc5cWarSZT+gyE9x7RNKQE+N2bU2LKscISKS0M2+R3
         Ih5o9E2I0kKa16PzA9TcfFIksxlWr7/0bvP3KTDzFsGMpzhdoguGdHRx/yaQYnPihaKx
         p+NQ==
X-Gm-Message-State: AOJu0Yy5XWpMuzMuxU1o3yn22sTHQf0v7IgVpFbyO0v425BJGgkX/Mx+
        FiCCCl0JtdTcVpxIS8Cs/6qG0A==
X-Google-Smtp-Source: AGHT+IFVyZfwPYortU/vCd/KtcZf9ROm2DtiD8fm0D3u1191c/tmNd0xEGXS4Lh56+iNRP/lGDs57g==
X-Received: by 2002:a05:6a00:2d8d:b0:68e:236a:93d9 with SMTP id fb13-20020a056a002d8d00b0068e236a93d9mr5460543pfb.17.1696501521543;
        Thu, 05 Oct 2023 03:25:21 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b0068fe23b8792sm1055988pfh.176.2023.10.05.03.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:25:20 -0700 (PDT)
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
Subject: [PATCH V2 1/2] xen: evtchn: Allow shared registration of IRQ handers
Date:   Thu,  5 Oct 2023 15:55:11 +0530
Message-Id: <8380c7b1c8cd9edb2e45e9a204650b34df3458a7.1696500578.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1696500578.git.viresh.kumar@linaro.org>
References: <cover.1696500578.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

