Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170C1776682
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjHIRhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHIRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:37:19 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C410C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:37:19 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6873a30d02eso2986b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691602638; x=1692207438;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yArT/awXRkYrPki92Zws/80hTWdY4r8NmlN6iV95PI=;
        b=jks9I40Mu3hsgme1eY9fqX8Uv4oV5A1l/I2D3q9XMC3+KCQDRaUE8TnTIkE+jQMa94
         F7a0p4U9TpkQswhPv9XyYLPxEVxRgZ7do8nadjop7mj1XvqxpY4ZEjm8ZAdKP6OgqYuM
         58s5eVTGm7lAJpqm17dKwyWkmraaNT2ENxfpBkRHbk1+OLG4X3vImO8bfS+rQJ4UlKxa
         V3llXeutWD/cKJa0pOYBCW3a0U5iaD8qeNOrRlRPlxrBsxwzDHVpsEW1efRFDRxBUEdo
         akXENIoMn69KesjUvSULvrihK/C4pvEM6y6O1eMQ4Ad+JMqMC8S6HSXVsuUqi1w0UP17
         rreA==
X-Gm-Message-State: AOJu0YxPIDnnz9aZrqGJuuDqkqfV6sXg/HBJKJb5yfRbtiey3jECiJyR
        aN6DCLb/7rkWzHnbuaE1T6aYIQ==
X-Google-Smtp-Source: AGHT+IEOe/X404gAnI9Qj8z0UDy2WHWR3jxWz9myYIGG/dCeUzQac/1bjO6kMws5dZZ6Ia4S1Lp7Bw==
X-Received: by 2002:a05:6a20:428a:b0:140:a25:1c1d with SMTP id o10-20020a056a20428a00b001400a251c1dmr3891567pzj.51.1691602638385;
        Wed, 09 Aug 2023 10:37:18 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id j21-20020a62b615000000b00687375d9135sm10158999pff.4.2023.08.09.10.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:37:17 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dhruva Gole <d-gole@ti.com>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend
 resume support
In-Reply-To: <20230809072330.GB11676@atomide.com>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
 <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
 <20230803155541.nwsfwobfkbpefoyw@dhruva>
 <8c330bd9-5f4e-8cd0-ed02-c3a696d7473a@ti.com>
 <20230803160815.yfpkdfssv75d4inf@dhruva> <7ho7jifrda.fsf@baylibre.com>
 <20230808115403.dkz6ev5vc6bhcmzh@dhruva> <7httt9dq2x.fsf@baylibre.com>
 <20230809072330.GB11676@atomide.com>
Date:   Wed, 09 Aug 2023 10:37:17 -0700
Message-ID: <7ho7jgdsmq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@kernel.org> [230809 00:20]:
>> To me, it sounds like you might want to use ->resume_early() or maybe
>> ->resume_noirq() in the pinctrl driver for this so that IO isolation can
>> be disabled sooner?
>
> For calls that need to happen just before the SoC is disabled or first
> thing on resume path, cpu_cluster_pm_enter() and cpu_cluster_pm_exit()
> notifiers work nice and allow distributing the code across the related
> SoC specific code and device drivers. See for example the usage in
> drivers/irqchip/irq-gic.c for CPU_CLUSTER_PM_ENTER.

Indeed, this is an option too, but for things that already have "full"
drivers (e.g. not an irqchip), they already have a full range of PM
callbacks, and adding another set of callbacks/notifiers for cpu_pm_* is
a bit clunky IMO.

That being said, for things like this IO isolation stuff that is
system-wide, and needs to happen very late in suspend (and/or very early
in suspend), cpu_pm_ is worth considering if the same cannot be done
with the normal PM callbacks.

Kevin

