Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542AB7D1400
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377826AbjJTQbl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 12:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:31:40 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B2CCA;
        Fri, 20 Oct 2023 09:31:38 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-581e106fd25so57730eaf.0;
        Fri, 20 Oct 2023 09:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819498; x=1698424298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8cbask5PPgm23kmb/DbKZkHxKA+3OatK8d64IsUrco=;
        b=EY43uhOdMmuXzc64nDLDl3ZR7OyvrNv9aN8UHTVDSPpbR4f3CpN9b7uvLHf+l9gil5
         2oEG4gK8gV0FASRp5LkZtlafgX6r9koD7aKu4RZMOoAQ49Vy9KKK6vOXLyhnQpIJnVO1
         G+X9ODkjU27dNWNQqi5tB8KN7lluaAkggmTFX6KQ9Olil7cKr1Ub6HT1Xj16LMMzJV07
         huWDW9aU2Et1h90Z+PR/iPjUAr1Fh0Hto+gLdOodZY7cBLYZh5TQ3f+6yxHdwgiKh9Rq
         6TQRNT9L62M3pp2s041adS7r4ty6KW1WeOaiHnbkZOCLcAhKB/3wldyJxYIVPHS+hful
         8RNw==
X-Gm-Message-State: AOJu0YzbVEAFQOW9gsKqgrAvgwylFz+swQgoYAXpCvjr21Z93QKyUEV6
        N7boI9ufeoNg1Z9q5rLrWwOCYuOEoCtNI5vwvQU=
X-Google-Smtp-Source: AGHT+IHBw6VJbXTQqfWtWLEnFIHfnVfLb5Nymi/BoMA4w402mDiOQrUcF+R+vkhLL+vrsxcOajk8DSBoHzOvk7PMLUw=
X-Received: by 2002:a4a:bd84:0:b0:581:ed38:5505 with SMTP id
 k4-20020a4abd84000000b00581ed385505mr2576506oop.0.1697819497982; Fri, 20 Oct
 2023 09:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <13365827.uLZWGnKmhe@kreacher> <9177552.CDJkKcVGEf@kreacher> <da85e126-b909-4652-9961-ed6867dc0817@arm.com>
In-Reply-To: <da85e126-b909-4652-9961-ed6867dc0817@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Oct 2023 18:31:26 +0200
Message-ID: <CAJZ5v0j4V1nkb01N1BRX0quKM2GFmbO0=i-Ff6DY=11_wT5hmA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] thermal: gov_step_wise: Fold update_passive_instance()
 into its caller
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Fri, Oct 20, 2023 at 6:16 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 10/6/23 18:49, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Fold update_passive_instance() into thermal_zone_trip_update() that is
> > its only caller so as to make the code in question easeir to follow.
>
> s/easeir/easier/

I'll fix this in the tree.

> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/gov_step_wise.c |   28 ++++++++++------------------
> >   1 file changed, 10 insertions(+), 18 deletions(-)
> >
>
> other than that LGTM:
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you!
