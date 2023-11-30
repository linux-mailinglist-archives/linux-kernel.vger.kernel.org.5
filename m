Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF07D7FF058
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbjK3NjP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 08:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345612AbjK3NjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:39:13 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362B019F;
        Thu, 30 Nov 2023 05:39:18 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b83d207806so64825b6e.0;
        Thu, 30 Nov 2023 05:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351557; x=1701956357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5jyVOgN/zGkO95v6a4uyOCDdbZc7HWZPbityHquTEA=;
        b=FD0a6ZiSLwmiKV7YPr2+AjfNoHK4U+rRJ9l2K8CGq2v+cURoVJCVBiUHjHxBmCnoi5
         1EqYyClcvn9YB2fE7Mcdzs06xKglw/MITlzjhZ87EuYea7HtRWL9dkNepMzgZ0FEPhHF
         DvRw7q5ZmT4HnVa7xPzfWq/0d3J6EVg5a0WLEIkazPeUcjsOahF9x4ggU4AJsdvhpVU9
         rBcp/kE5m+cFINirAV0Q92QOATAN1YUGsDBndPgqiBR29czhGYRDRd1blnhuFTJsz2ab
         76A8PM3s9g5d0JK4bdlXGdzz48nQHaQl6kynkN/mWd59KvSJnxvKXHtTEXBEBO2gMjcp
         VP7A==
X-Gm-Message-State: AOJu0Yzq7Xx0jGfbw/LLU2HpOQ+EmWzNWbyBkLYXj3tA46nR6QH+cFEv
        pkr37W3a7bWiqvxHHR/FJxVcb+Yu369EFf6w5ZfrzxXG
X-Google-Smtp-Source: AGHT+IHJeN+FjoyeCIayi5/oWkUIz4lC81tQABwqzcd5GkTRjyzcNqVcpEDoFzSWzuSsy2JzfN8tPmQO2TLRef48wuA=
X-Received: by 2002:a05:6808:128d:b0:3b8:4478:8124 with SMTP id
 a13-20020a056808128d00b003b844788124mr28654805oiw.5.1701351557464; Thu, 30
 Nov 2023 05:39:17 -0800 (PST)
MIME-Version: 1.0
References: <12350772.O9o76ZdvQC@kreacher> <4897451.31r3eYUQgx@kreacher> <185c1c0e-c9f8-416b-8bcf-34070b1d8a37@linaro.org>
In-Reply-To: <185c1c0e-c9f8-416b-8bcf-34070b1d8a37@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Nov 2023 14:39:06 +0100
Message-ID: <CAJZ5v0gkFGJUgGpDSKeuYT5WQudTdAgDVMiygK8uFtyF8GioEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] thermal: trip: Drop a redundant check from thermal_zone_set_trip()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
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

On Wed, Nov 29, 2023 at 4:26 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2023 14:36, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After recent changes in the thermal framework, a trip points array is
> > required for registering a thermal zone that is not tripless, so the
> > tz->trips pointer in thermal_zone_set_trip() is never NULL and the
> > check involving it is redundant.  Drop that check.
> >
> > No functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied, thanks!
