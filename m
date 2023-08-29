Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ABA78C443
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjH2MaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjH2M3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:29:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DADB9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:29:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdf4752c3cso25719475ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693312176; x=1693916976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKbwyfCALitLKoKlIDCh6sF2GuUR8Sqy+xkbEnTQwwU=;
        b=KdcpUBq2OTq/PnFjVlXJbCYFO77GkGucPveUjH0DVqOFDw+fgGsVKqxZUi0v2bU0WV
         VSAu9VOiNaH2BR+mQpfy2kJm+q+OofIt2DC2Ou6uQV1aAnCCsnd42N7LzpmuXbETP5t2
         f3ljXFEnBkrKBalr4UeQnrguDfRp5h2AjXOYnqCxbZ8+waeLvDjTJaDIsCYnZ9VSPtLC
         9KWwGdn4tO3sBxIQ3swZm1vmCNRuJGAjWl3vXzGu4eSkc+dPs8Z/HlyNQLfVW8orp3DJ
         wjYHQhTq+9ZDm4tEmJXoTgBfpMwKKVQiaw8Qb2ycAeMDZ/jEy6Pc6DWmW8+II4D3kxXF
         IteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693312176; x=1693916976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKbwyfCALitLKoKlIDCh6sF2GuUR8Sqy+xkbEnTQwwU=;
        b=GqQP/l+738pQfWpCY1gUA2msaSsQENC7uqOmYJAk8NKH99gfggn9ULY5H2o5Y1nOU0
         IxQIcIrkj6aCWyxc6IcePEOtEXbrqjUpP4sAZzJDJft+JvlasKbK7Di7FhHz30Vy6J6f
         pHCTqOS/rD7J46Ho2rPcCLeCcJhum8AtVKzyjGhEkD/EjP9ho0E6sEiW4ZU850RUKz94
         YqpH++JAAIkCaYRViVMXi2dDniDl9oYvdDyeSH2NkttvKq2aSGirCjBbT8HTHqJTS+kl
         QwC3fGtqbx8TwiFGX1bVpxOoM7mHLJJ/PbTbW6C561kR+M0obLatN6Oeu9heU5HCvUd4
         Np6g==
X-Gm-Message-State: AOJu0YxC/R0FmGrZRQ0NHTVf3hbW3ANEj1tNcQvk1PcEX3CoaCEUausR
        4JJ8vyIgjvPHrEjldS20xWgaVg==
X-Google-Smtp-Source: AGHT+IFdALvVH/LLFMq7HiI4jOkzdLWO6KSMfUWcATxGspR40vgDCT+XEqCh2JK3OtEhDSe9mzbx2g==
X-Received: by 2002:a17:902:efd3:b0:1bd:f7d7:3bcd with SMTP id ja19-20020a170902efd300b001bdf7d73bcdmr20457818plb.50.1693312176301;
        Tue, 29 Aug 2023 05:29:36 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001b890b3bbb1sm9283856plb.211.2023.08.29.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:29:35 -0700 (PDT)
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
Subject: [PATCH 1/2] xen: evtchn: Allow shared registration of IRQ handers
Date:   Tue, 29 Aug 2023 17:59:04 +0530
Message-Id: <fc6d47de76a8b77d0a1b4bc8204694c079715f2e.1693311370.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1693311370.git.viresh.kumar@linaro.org>
References: <cover.1693311370.git.viresh.kumar@linaro.org>
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
 drivers/xen/events/events_base.c | 1 +
 drivers/xen/evtchn.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index c7715f8bd452..0182680dab3a 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1239,6 +1239,7 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_EVTCHN);
+		info->refcnt++;
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

