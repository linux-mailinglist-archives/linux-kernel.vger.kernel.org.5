Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E000D7A9E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjIUUAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjIUUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:00:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FB224878
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99de884ad25so148731166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316291; x=1695921091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vckO2Ou8wXEnI7d8lHB0QrnLKODbimrd2Exu1O4oi7I=;
        b=o1dh5FvyBZBP5N0vNBHuzJJFu8cUT9nEPtpulcQk0Bul4pGGipjkT1oYkUImeBoNUC
         VVj0Fn2dg6KtIbK+u9uPsnsdzNHVGYAwCRCFFFp1aK4iZoX1ap/Vo8CErJ5KP38WSqqg
         ZNaBcp8l7dSLA7v407Jj3t/LwtHZip72xvISC2TqYVepkAaIYZYhTvmEgUAucHTqi+b3
         wqWqpkVLGvVNYe1irfvXTm6sGxd1XCWUc+CYjSZUPMqLBkPIyZnYFJNH2a8y4lYyP5C2
         LKU8sL9gNXCS/ottcx2P42wglorP0MR+fhuw2/N26BwMFOKzlNeopyCcOLhKZM/W1oT6
         9Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316291; x=1695921091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vckO2Ou8wXEnI7d8lHB0QrnLKODbimrd2Exu1O4oi7I=;
        b=RcXclQrRoL+qTd0YDHXpLqEPePoeciqu4+g6INquiE4ZkKw039GH5jmrM/v9KjKisw
         DrxiyxHRNSP5NfZq1NPwcTQ9yY0p9eYHQ6gDgMrRER9gNXbHk3i1Zi2LclNUohdZTWg7
         5LDNAtqckTNYB6vM/38skf/HaxzAZDnsT2yMDOWeiQnZqXKHK9jlY+n3rb26X3nSX47T
         n1EX7yJcSE+0zY+q1GxuVC67lLP7q8grOXpVg01pAsBN0ioIBaqz8YEqd0ViJ8TkK1zQ
         GvupRD9SO0zT0lnFDdcm6/mAfPD++4foqvZAahYf8Sa67FD10t3N+ZlPfOaY6IKuQsCA
         ucTA==
X-Gm-Message-State: AOJu0YzMewYzflOoSZ0mWC5o9SoEFwnIXSR4E4YroFEjKAA61D9V1E5B
        C4vK0KG8ig3kdfGsv1DhKoF3r1OfeWHnDfbmK1kX14s+P0upQsBrjJVJpw==
X-Google-Smtp-Source: AGHT+IEfSM5McKsl77zEbSbSQ/62col2t+rBr/iYepzNVWwTMse0QnfUNVYb8moy61mVG36093h3Ze7co2vcfHeYDbI=
X-Received: by 2002:a05:6402:88e:b0:530:a19b:175 with SMTP id
 e14-20020a056402088e00b00530a19b0175mr5146291edy.2.1695306601856; Thu, 21 Sep
 2023 07:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org> <20230825112633.236607-7-ulf.hansson@linaro.org>
In-Reply-To: <20230825112633.236607-7-ulf.hansson@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 21 Sep 2023 16:29:44 +0200
Message-ID: <CAKohpo=1Pud8Hq-w0HOqz2TNE2gwMWFuv-DDRmb9q4W+fpEGtw@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 13:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The domain-id for the cpu_dev has already been parsed at the point when
> scmi_get_sharing_cpus() is getting called. Let's pass it as an in-parameter
> to avoid the unnecessary OF parsing.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - None.
>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
