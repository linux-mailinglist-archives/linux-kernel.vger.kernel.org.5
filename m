Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C178272F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHUKe2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjHUKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:34:23 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820C7E3;
        Mon, 21 Aug 2023 03:34:22 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6b9cd6876bbso914066a34.1;
        Mon, 21 Aug 2023 03:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692614062; x=1693218862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Re72V6BeZKtZ/a9D1veoORPiF+NDDFb8xZ/o+5KvXIM=;
        b=BxHqzrH0LQF6PABG0VrXpzwdL43C0Z+l04Q+Z3/hCtmVnm70JllBSishTfliH9jNZH
         FSBvHX4BVKi6a1nEfvDrAMDAEo326g34lM73FGLTlBEI2yJylRjdcnLc73ytx8HlUQOl
         rusTP9hd8+uqQPDbEQMwyop6O5cBVZP7v4bY2pEtGP9VmkSM++IdEaI7lHNUiaZZsndF
         SKsVRgfCEt/TrtzjeVXY6u+JVeYffvU6mRvo0h5v7kOoirKJM2EZGoVzOex224n0Z1xv
         p3g0Jr3eR0Y4ltlki5GeNMB6fj/dmPjOoD6bPM4ZXHfFErcdnv5oqTwCYlzrFKjuE1tN
         HA8Q==
X-Gm-Message-State: AOJu0YxFruZABK2uUPMIVBpVAxJXFyXh0cH12e8Zm3l1CDvTM4sGD4zD
        OKG/CKPsukcoUvfa0N56KXbH4naD/kNNmV2QqOw=
X-Google-Smtp-Source: AGHT+IEl8uJHZjylgJUYx/CkJvCBSBek95QEaUoSD0JiPf8+JDXWvz8jz9v3PmcUNRBF3ruNKHSF4hVq5so0j5VruNU=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr5753921oov.0.1692614061699; Mon, 21 Aug
 2023 03:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230820210640.585311-1-qyousef@layalina.io>
In-Reply-To: <20230820210640.585311-1-qyousef@layalina.io>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 12:34:06 +0200
Message-ID: <CAJZ5v0jjwKr0py8H34-8ZRS8xS455YUuew8GxBex13uRq7LBPQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix dvfs_headroom escaping uclamp constraints
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 11:08 PM Qais Yousef <qyousef@layalina.io> wrote:
>
> DVFS headroom, or map_util_perf(), is applied after uclamp restrictions are
> applied in effective_cpu_util(). This will lead to two problems for uclamp:
>
>         1. If util < uclamp_min, we'll run faster than uclamp_min. For example
>            util = 50, uclamp_min = 100. map_util_perf() = 125 instead of 100.
>
>         2. If util > uclamp_max, we'll run faster than uclamp_max. For example
>            util = 900, uclamp_max = 800, map_util_perf() = 1000.
>
> First patch rename the function to apply_dvfs_headroom() to reflect what it
> really does. It is not really mapping util, but provides some headroom for the
> util to grow. Provide a documentation for the function too.
>
> Second patch is the actual fix.
>
> Third patch moves apply_dvfs_headroom() to sched.h as there are no longer
> users outside the scheduler.
>
> Fourth patch is an RFC to redefine what the headroom means for RT, DL and IRQ
> pressures.
>
> Thanks!

For the first 3 patches in the series

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
