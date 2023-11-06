Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598497E281F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjKFPF7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 10:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKFPF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:05:57 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076B4B6;
        Mon,  6 Nov 2023 07:05:52 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-587af6285c0so211343eaf.1;
        Mon, 06 Nov 2023 07:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699283151; x=1699887951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dEUZF52RI/QRjhcF4QMdSym8sksDkIk9tHK6KLTk+Q=;
        b=g0zc6BmUu3ycpd4iiOoqtxLfzxTD2PVRSuyIjhr9HcNVFKTnm860xq4BJUWvvcg+TH
         CFamJ9ts4Zc/O017QoZvoeBw1fqMfA+UqUUTwGiopJOVRTSnjVLNgjmyNS1HEA9dQiNa
         DEtGeCbPu/N4MO7BuoOQ9su+D1/auyG7tW0+p8QP+wxKDYZvlLQwvGah1+jKho5gKFIB
         JHbURADgxzRxQ+6dBzwByOuCiKzgMWuLP8h44y591adGUoX/M8FjGmBhGmOAd9Hzn6Da
         EFZ29E0lNG9oClSu3uCYI9fHmbUNEMxwdv+A++HCsX1yQlYLatTTixiDnPvwj9AMY9d/
         dU0w==
X-Gm-Message-State: AOJu0Yx2gjt7zYcVDS3ytqgGzdIICD15HltPlb/bxLr+UOF+mN0S7Imy
        KpOJn3x93I1vD7kFDKfKFHIWj5/iWp5SCSpxqAw=
X-Google-Smtp-Source: AGHT+IGGCBA6nX/+ccGweC9dgvfSJWYkcbzFNocL2GTLMEbee0tJSgbQo9CopLsI56Ggqd50LGU0xAC4s0H4pdsS8Os=
X-Received: by 2002:a4a:d8d1:0:b0:586:abc4:2c18 with SMTP id
 c17-20020a4ad8d1000000b00586abc42c18mr28471458oov.0.1699283151103; Mon, 06
 Nov 2023 07:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
In-Reply-To: <20231103131821.1176294-1-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Nov 2023 16:05:40 +0100
Message-ID: <CAJZ5v0g4N2UojiQqJn7fxWj2=h=6sgFfGEqEVx1wuh2VdvaH6Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Rework interface between scheduler and schedutil governor
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 2:18 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Following the discussion with Qais [1] about how to handle uclamp
> requirements and after syncing with him, we agreed that I should move
> forward on the patchset to rework the interface between scheduler and
> schedutil governor to provide more information to the latter. Scheduler
> (and EAS in particular) doesn't need anymore to guess estimate which
> headroom the governor wants to apply and will directly ask for the target
> freq. Then the governor directly gets the actual utilization and new
> minimum and maximum boundaries to select this target frequency and
> doesn't have to deal anymore with scheduler internals like uclamp when
> including iowait boost.
>
> [1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/
>
> Changes since v2:
> - remove useless target variable
>
> Changes since v1:
> - fix a bug (always set max even when returning early)
> - fix typos
>
> Vincent Guittot (2):
>   sched/schedutil: Rework performance estimation
>   sched/schedutil: Rework iowait boost
>
>  include/linux/energy_model.h     |  1 -
>  kernel/sched/core.c              | 82 ++++++++++++-------------------
>  kernel/sched/cpufreq_schedutil.c | 69 ++++++++++++++++----------
>  kernel/sched/fair.c              | 22 +++++++--
>  kernel/sched/sched.h             | 84 +++-----------------------------
>  5 files changed, 100 insertions(+), 158 deletions(-)
>
> --

For the schedutil changes in the series:

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and I'm assuming this series to be targeted at sched.
