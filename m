Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F327D8872
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjJZShZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 14:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZShY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:37:24 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C971A5;
        Thu, 26 Oct 2023 11:37:22 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-581e106fd25so183173eaf.0;
        Thu, 26 Oct 2023 11:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698345441; x=1698950241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JI4dp+Kg7iVHX3cVBNafUR1doVjzD9jk5YuxgZ3wiM=;
        b=dL9bsiRezZjp2j1U55oB60d9nll0FYoAz25VXTobtq42eY1ICLC0F9nA/euChrn66V
         7Ibmyez0fLaAahVX958wyxDaCSZx1vEDJyXF14+l0t3kKvMW/ZltLCWdXVL41qeVxdpd
         SK8yKP2+1C6HaE8pPF07Q/VsSV03ujmCmXQmdu9G+EY+MQRDY6UqvVDq9Ps9+j5hk1a0
         9dicN1hHa2lS5lJdj5IIUdjWNF8o/hAaqCuYVGD0it1UWqcQtcH+20UyPcaQ35oQRTxS
         lGFtD9rr78DLzguXxbkK6YjrGW4QEs1ips1c6BGe+3Er4oTIBfYg8RmpkcQG7/OlfDXd
         h3BA==
X-Gm-Message-State: AOJu0Yycw5o4ZHeSJ1pbwdmRkZzinjXOYqpMwKjTlot8FNkD7j8W9L05
        eRwsDDZJcVQ1q3hUC1pB05ScdKr4PtQRJdKXPrk=
X-Google-Smtp-Source: AGHT+IFjM/1pDBDUCMZ9R0v8dzDFkHGQ9hszsOZuveH9Gi5y8aPW1ascpmLEFGb0yJPIBg2Rh4sROH6ooBgGQYpee+c=
X-Received: by 2002:a4a:c991:0:b0:586:7095:126d with SMTP id
 u17-20020a4ac991000000b005867095126dmr386761ooq.0.1698345441597; Thu, 26 Oct
 2023 11:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220715210911.714479-1-daniel.lezcano@linaro.org> <20220715210911.714479-4-daniel.lezcano@linaro.org>
In-Reply-To: <20220715210911.714479-4-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Oct 2023 20:37:10 +0200
Message-ID: <CAJZ5v0jjs=BVkc-xaVLJ8MQi2KcQiVaVW4Rcaaq95H7VBFrBeA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] thermal/core: Fix thermal trip cross point
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, quic_manafm@quicinc.com, rui.zhang@intel.com,
        amitk@kernel.org, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jul 15, 2022 at 11:09 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The routine doing trip point crossing the way up or down is actually
> wrong.
>
> A trip point is composed with a trip temperature and a hysteresis.
>
> The trip temperature is used to detect when the trip point is crossed
> the way up.
>
> The trip temperature minus the hysteresis is used to detect when the
> trip point is crossed the way down.
>
> |-----------low--------high------------|
>              |<--------->|
>              |    hyst   |
>              |           |
>              |          -|--> crossed the way up
>              |
>          <---|-- crossed the way down
>
> For that, there is a two point comparison: the current temperature and
> the previous temperature.
>
> The actual code assumes if the current temperature is greater than the
> trip temperature and the previous temperature was lesser, then the
> trip point is crossed the way up. That is true only if we crossed the
> way down the low temperature boundary from the previous temperature or
> if the hysteresis is zero. The temperature can decrease between the
> low and high, so the trip point is not crossed the way down and then
> increase again and cross the high temperature raising a new trip point
> crossed detection which is incorrect. The same scenario happens when
> crossing the way down.
>
> The trip point crossing the way up and down must act as parenthesis, a
> trip point down must close a trip point up. Today we have multiple
> trip point up without the corresponding trip point down.
>
> In order to fix that, we store the previous trip point which gives the
> information about the previous trip and we change the trip point
> browsing order depending on the temperature trend: in the ascending
> order when the temperature trend is raising, otherwise in the
> descending order.

There is an alternative way of addressing this problem which doesn't
require using information regarding the previous trip point and so it
would work even if the trips were not sorted.

Namely, for each trip there can be an effective threshold equal to
either its temperature. or its temperature minus its hysteresis (low
temperature).  If the initial zone temperature is below the trip's
temperature, the initial value of its threshold is equal to its
temperature.  Otherwise, the initial value of the trip's threshold is
its low temperature.

Then, if the zone temperature crosses the threshold (either up or
down), the trip crossing triggers and the threshold value is flipped
(that is, if it was equal to the trip's temperature, it becomes its
low temperature or the other way around).  [Note that if the threshold
value is equal to the trip temperature, it can only be crossed on the
way up, because it means that the zone temperature was below it at one
point and has not grown above it since then.  Conversely, if the
threshold value is equal to the low temperature of the trip, it can
only be crossed on the way down, because it means that the zone
temperature was above the trip temperature at one point and it has not
fallen below the trip's low temperature since then.]

This should not be hard to implement AFAICS and it should also work in
the cases when one trip is located in the hysteresis range of another
one.
