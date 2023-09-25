Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B43D7ADD4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjIYQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjIYQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:38:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D609BEE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:38:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-414ba610766so5211cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695659930; x=1696264730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AlhvEF45J/kzqFPyv16zMJewbGwMCQ7TmbM/YeOZsQ4=;
        b=F7R3ijAYDawkk0zgNrRNZ/WZ8O+4GlWY++5b/+5wWYSadhiRc4H5L+y/3KNrA3+YT2
         MonV/zBkjL7f9OS6RAZs5/nHf+6qlga2AfZDi7rXwV03YfTsF6TDAYaXgfp06fL79Ekm
         +6FFYcYNnXQoAtlheN/Sdq2DH8EzD91lp0sk34XdJzuXYp66OUY1y+HTz9xoe9WdmJBs
         2bpsIqLn0UTFY1SJvMULRUP29VwUkAvIUL3e44vj4LYmhNxa3Qgnt9Qb9cV3VXVyO6jK
         wyGU8CCraFuSKJiPIoPFVWvhg6GxRLfBf+BWhpAOSZ7MQk42F0r16KGFlZeVMH12EhKK
         fRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695659930; x=1696264730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlhvEF45J/kzqFPyv16zMJewbGwMCQ7TmbM/YeOZsQ4=;
        b=RFNWEut7s4smyLV5lli0EcW/NtmSgv2qIVhdrRmL2ftbpdOqr+Tnaa+Ys2uPNcWd7l
         yjZCoWFLad4uOivt8/fAo9oeYHQuixXTrHNw5WfpilpSIT6aNe3QaKd/TZjqxr/tV24C
         t67vrfyKiXeCvSWeAH2thRQ4nSKK1AOWbaxxJUxDfpOm/L+EOsxwjtLPNHxy38cT0G9X
         BVoO/NuvoCLMmdEaKgva+XAlZcMSBMZl5ukoeV1s5QS2BfGRiF/l7Ip7XEL6w7rZJDjR
         QssonhG90aJvd2iKvIfPPVkGhg5hKdcEoJbOW8TMKHxfsyyQCziZGbri+j6gnRTfBe/9
         gmpw==
X-Gm-Message-State: AOJu0Yzcv9UYhe6R+aV/u7vFGo/PytWloGZ4u0nbJ002J8rv3XPUFb+L
        yQ/NmWmI4QJDTMKEIaARJm19/77rYptbJOMbuEfSwg==
X-Google-Smtp-Source: AGHT+IEhPXRn/gDKwsc3Qo362Xr/B037jjFr0M1gqwePRZGkJwxcvHoviYxIe9lHHDiSBnLh12xvgjfkI7CIO/dFyl0=
X-Received: by 2002:ac8:5c0c:0:b0:410:9d31:68cd with SMTP id
 i12-20020ac85c0c000000b004109d3168cdmr487897qti.27.1695659929837; Mon, 25 Sep
 2023 09:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230922230535.296350-1-joshdon@google.com> <20230922230535.296350-2-joshdon@google.com>
 <ZRALk+fMpW5895fF@gmail.com>
In-Reply-To: <ZRALk+fMpW5895fF@gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 25 Sep 2023 09:38:39 -0700
Message-ID: <CABk29Ntm1aK-f5t8cDY5DoBc_LwYqymWkPau0mVAOOaO4Ac4hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: fix warning in bandwidth distribution
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When the warning hits, we don't have any other side-effects,
> such as bad behavior or data corruption, correct?

Correct, the warning is benign.

> Under that assumption I've queued your fix in tip:sched/core,
> for a v6.7 merge, and not in tip:sched/urgent for a v6.6 merge,
> but let me know if I'm reading the code wrong...

Thanks Ingo!
