Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2D079142E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjIDI6g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 04:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbjIDI6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:58:32 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC70D133;
        Mon,  4 Sep 2023 01:58:16 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7a25184a648so363167241.2;
        Mon, 04 Sep 2023 01:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693817896; x=1694422696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNvuvCQg6I1mCa+hfsjZ+j7ixM+pQZ/tdnNCPg/yYZg=;
        b=FW3DX8YYVLZLBvlC2d7+oa8VRVxwX+GL55XHEvQGB+Vp0QTO5jWy0nRTsMUcMiNV2V
         MIfo6Sy0RvE/BwFSdKQk3oyukH2BkALHLzLtuJdjYAHhlTdOznCSmnNQ3cxX8HXPSbqO
         esZZYylvjPr8xsBi3XP9jhQt7g+RJaAA89iln9PmA7l9oT1Nw2wd8v1+CNvDWU5sMbqE
         uGccQjaz/Y7Eu2bNkMOL05SlSCMiZGOluWKJkKcl/OpbteUn8dkZnOEvhOU8lPkSyQb7
         oaZ7VoxEwkH1eq3JvzkPxb6nkd8Ccn3YwyA+5SHxzjvINH/ngd0KrD/CwPGqQ87RMNpj
         uGnw==
X-Gm-Message-State: AOJu0YxAG1RBQc8kI0c3+yozJ2YdGokdKGxBEMdWAcedsCRr8SfPxstA
        RENB7sXHINNagHwCfZnFbQJmMEwpfiileQ==
X-Google-Smtp-Source: AGHT+IH4xr2wYFy824wDQk808v1cROTJdpkukX2nqlA8IqligBAtZCTaK5ES9hqwPvbVkLn6XbvdsQ==
X-Received: by 2002:a05:6102:1354:b0:44d:476b:3bc0 with SMTP id j20-20020a056102135400b0044d476b3bc0mr8094372vsl.28.1693817895777;
        Mon, 04 Sep 2023 01:58:15 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id p9-20020a67e1c9000000b0044d4acde4bcsm1765168vsl.32.2023.09.04.01.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 01:58:15 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-48d0bfd352eso467154e0c.2;
        Mon, 04 Sep 2023 01:58:15 -0700 (PDT)
X-Received: by 2002:a1f:cd85:0:b0:48d:149e:1a41 with SMTP id
 d127-20020a1fcd85000000b0048d149e1a41mr7462346vkg.8.1693817895390; Mon, 04
 Sep 2023 01:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
In-Reply-To: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Sep 2023 10:58:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTQdj5OUHX7em3Zhiy1n935DVJBb0LKk1+_azmzQNxxg@mail.gmail.com>
Message-ID: <CAMuHMdVTQdj5OUHX7em3Zhiy1n935DVJBb0LKk1+_azmzQNxxg@mail.gmail.com>
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random changes
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openwrt-devel@lists.openwrt.org,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał,

On Mon, Sep 4, 2023 at 10:35 AM Rafał Miłecki <zajec5@gmail.com> wrote:
> 2. Clock (arm,armv7-timer)
>
> While comparing main clock in Broadcom's SDK with upstream one I noticed
> a tiny difference: mask value. I don't know it it makes any sense but
> switching from CLOCKSOURCE_MASK(56) to CLOCKSOURCE_MASK(64) in
> arm_arch_timer.c (to match SDK) increases average uptime (time before a
> hang/lockup happens) from 4 minutes to 36 minutes.

That code path is used only for type != ARCH_TIMER_TYPE_CP15,
but your kernel log

    arch_timer: cp15 timer(s) running at 0.03MHz (virt).

suggest that type == ARCH_TIMER_TYPE_CP15?!?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
