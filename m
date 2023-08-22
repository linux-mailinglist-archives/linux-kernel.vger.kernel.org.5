Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD148784B57
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjHVUYj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 16:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHVUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:24:39 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455DCC;
        Tue, 22 Aug 2023 13:24:37 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1c0a4333e03so628685ad.0;
        Tue, 22 Aug 2023 13:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692735877; x=1693340677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRjwbC3faFyj1ntUMUYXl/W2oCQKNk5Ltvd5akdjB5M=;
        b=XBuqHbFeJBy9crGJX1IjvnCJJGZd/hhku/yc9USqPU+M7hDBulx3wP/qB2thW5RGpd
         D9pijijahwTw9BdvcutJv5iCA2snr8PnaiUJwlwKZw3mR/0y0QXBjCN3eU6y9v4vinli
         fF1lArKh5iMawBM53+wB0SCvwW1MGjejp3S2BXVFnUQTH5D4qMRLHGVVJXJJ/o2zqiqU
         7x97uF0SyjsFnY4yjbNSWKiEb7g05k4pOE7UFKj0l3MYBmyn/tiimqGPv7iZR0kRLZCR
         pXzkF6NegM/aVookEF/TlTIdNQzvXYj5syQSbmxOc2gD6BxqBZRZ1wNUNftivCkzSGmu
         9g6Q==
X-Gm-Message-State: AOJu0YzXMmG0u5vWSG6bjxWL8W8zu/ZnAVOep7ofrMF92FccGCOlY62R
        NAqewlzX6DqnrbIuGsIt4yH+h6AsCdq2bBvEKaNU7oWj
X-Google-Smtp-Source: AGHT+IGMUPtyUadxi5DFzNZrTXoyg21N2lb/li23jigebTRkrG58L2O8qutnwi/o7gn7wVUUP+rB4nTU99ifNDuI3pc=
X-Received: by 2002:a17:90a:64c9:b0:263:2312:60c2 with SMTP id
 i9-20020a17090a64c900b00263231260c2mr9571280pjm.3.1692735877175; Tue, 22 Aug
 2023 13:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230818114452.66780-1-swapnil.sapkal@amd.com>
In-Reply-To: <20230818114452.66780-1-swapnil.sapkal@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 22:24:25 +0200
Message-ID: <CAJZ5v0hH1iJ-QT+Sm32ESy_JstD+1TF=wV3FW7rnkCAiDjEeig@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] amd-pstate-ut: Fix issues observed after loading
 amd-pstate-ut driver
To:     Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc:     ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 1:45 PM Swapnil Sapkal <swapnil.sapkal@amd.com> wrote:
>
> This series fixes amd-pstate-ut which is currently failing for two
> reasons:
>
> 1) The code for amd-pstate-ut was written when CONFIG_X86_AMD_PSTATE
> was tristate config and amd_pstate can be built as module. In
> current implementation the driver is built-in and previous module
> parameters are removed. But amd-pstate-ut still try to read old module
> parameters. Therefore, test fails. First patch fixes this issue by
> removing those module parameter references.
>
> 2) In amd_pstate_ut_check_perf() and amd_pstate_ut_check_freq()
> functions, cpufreq_cpu_get() is called to get policy of the
> cpu and mark it as busy. In these functions cpufreq_cpu_put()
> should be used to release the policy. As cpufreq_cpu_put()
> is not used to release the policy, any other entity trying to
> access the policy is blocked indefinitely. One such scenario
> occurs when mode of amd-pstate is changed. Second patch fixes this
> by calling cpufreq_cpu_put() wherever necessary.
>
> Swapnil Sapkal (2):
>   amd-pstate-ut: Remove module parameter access from amd-pstate-ut
>   amd-pstate-ut: Fix kernel panic due to loading amd-pstate-ut driver
>
>  drivers/cpufreq/amd-pstate-ut.c | 46 +++++++++++++--------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)
>
> --

Both patches applied as 6.6 material with subjects adjusted to the
usual cpufreq patch naming pattern and some changelog edits.

Thanks!
