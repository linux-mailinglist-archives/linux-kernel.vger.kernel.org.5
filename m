Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E912C75ECFB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjGXIAC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGXIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:00:00 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BE5B3;
        Mon, 24 Jul 2023 00:59:59 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-522205646fdso311113a12.0;
        Mon, 24 Jul 2023 00:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185598; x=1690790398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/5/ZrAR5ynowHVv8V89+f8F5Dt7dmAy2TN6zfb4m1Q=;
        b=FlyvR4GYAaipC0P1j74Hy2qEyqlxubQ77Vmk5DONYeGIXHzcN1y8aIf6X3flF0QXkp
         yFORFFlU0Xy8Qa/1ybw7a1i9bncnuFcnJU7GlPX1eyh3VQz7E50r8X3xrI9oVCyfcS5l
         rYF92nH9aqvTotwqqLQ9yWRBldi/7mpM7NM6r5JpP1q/KN2spNX9mrNjuhcPzsOfwC+g
         E9xnMwkuSzkB0VoRfncp/Zt49NIfI968dQ5juAYToSamB7eHp8WlRHbA6MkliiEA8RY3
         IVbMiI5ZHbG6ErNmK3NNsza0JloCufo1+u1uahYvlY500dP4bj+j5LN/rNs0KGil6zJ0
         KnxQ==
X-Gm-Message-State: ABy/qLaBV+aIugAQ3KiPU+SITWxpbl1r+Ui5MnsFFvI1Ohrr4zn356IF
        1KIUD1ZkJgyvcEnY0jbAtvvFNZr3pLZr20bn1DY=
X-Google-Smtp-Source: APBJJlGa3VLXPg293738Z5+iJqulgnrYSxN/fR8YIjxFGtrS9m9EWmlMmEkUJ8F7Dy4Ld0TOt+V4itWL/NZAtf2BSYY=
X-Received: by 2002:a17:906:74d4:b0:992:387:44d1 with SMTP id
 z20-20020a17090674d400b00992038744d1mr7537528ejl.7.1690185597476; Mon, 24 Jul
 2023 00:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <5710197.DvuYhMxLoT@kreacher> <2e0bf65f-0452-c859-d287-a9762bd965ef@linaro.org>
In-Reply-To: <2e0bf65f-0452-c859-d287-a9762bd965ef@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Jul 2023 09:59:43 +0200
Message-ID: <CAJZ5v0iQ207Xr3SXBedMkTeqcSN0cfkxicD+wZ6ETOq9E5vC3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] ACPI: thermal: Use trip point table to register
 thermal zones
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sun, Jul 23, 2023 at 12:19 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> could you wait before applying I would like to review the series but I'm
> OoO ATM, coming back next week?

Yes, I can wait.

Thanks!
