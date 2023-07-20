Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3B75B5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGTRuJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jul 2023 13:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGTRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:50:07 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C92268F;
        Thu, 20 Jul 2023 10:50:06 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b9363d069bso3077211fa.0;
        Thu, 20 Jul 2023 10:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689875405; x=1690480205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGc1aqPPtyxg0PRnJa5Ahk+dl05+JvzfRAEGe6SQTJY=;
        b=Azwcdj7sKxa5DljBJ5aTk8edf8LbCuAR/NlUevsriOQgLfNAvHza8qj8H+xdRTwozM
         GXpc8B46+vYXcWWA56jPBMWvrZQkNJWj0pVcgC0Li2++5FCZyIC9htm75mPUPhXLxNzp
         xAnne8/1prZ0WLnBCnIVAmjKpJ1WN83QAZo0gMrNBeaVMLQwxB1wxIduyZ6/+EQSxZNy
         ANpUnAr/wwGQ+aT9RVpvxiRVRJzD1sT7KDytyWF+6JNtrplp2E4q8MiLM9U2Psj4+Xe0
         Bp8ZT+wXXs0e2TmgMjRVRvmsVjTPpANNafgCB8bsqsjObMr+mqPgRKH71n2UvwqL5Y2m
         V8NA==
X-Gm-Message-State: ABy/qLZTWSwn8R9PU3CNp2sB6MnSUES/nQrS/3Wz6jXkFb5q9jmykfqw
        /UzcCuPPA152z9mO+HsdMp4OEncCN9WhMRviVjUPUS21
X-Google-Smtp-Source: APBJJlHkUcpdCZU8rW/oi+Dw2XYYmLzOWcSzH1QNey2QWQ8sTjMRKS8EKZ1x/GjD10wtpEpDFaHXZurNt9/PzdUmmOY=
X-Received: by 2002:a2e:5455:0:b0:2b9:34b6:b47a with SMTP id
 y21-20020a2e5455000000b002b934b6b47amr2202129ljd.2.1689875405029; Thu, 20 Jul
 2023 10:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230713145741.30390-1-johan+linaro@kernel.org>
In-Reply-To: <20230713145741.30390-1-johan+linaro@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jul 2023 19:49:54 +0200
Message-ID: <CAJZ5v0gGPvvm-AyAb8QfZfkO5G4PL0T7NMHZ5xt_2KCC3wBB2A@mail.gmail.com>
Subject: Re: [PATCH 0/3] PM / wakeirq: fix wake irq arming
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org
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

On Thu, Jul 13, 2023 at 5:01 PM Johan Hovold <johan+linaro@kernel.org> wrote:
>
> When reviewing the Qualcomm serial-driver suspend implementation I
> noticed the odd runtime PM state update which had snuck in. Turns out it
> was added to work around a bug in PM core which prevented drivers not
> implementing runtime PM from using dedicated wake irqs.
>
> This series fixes the wake irq arming and drops the unused wake irq
> enable helpers before dropping the bogus runtime PM state update in the
> Qualcomm driver.
>
> I suggest that Rafael takes all of these through his tree.
>
> Johan
>
>
> Johan Hovold (3):
>   PM / wakeirq: fix wake irq arming
>   PM / wakeirq: drop unused enable helpers
>   serial: qcom-geni: drop bogus runtime pm state update

All applied and I'm inclined to push them as fixed for 6.5-rc, thanks!
