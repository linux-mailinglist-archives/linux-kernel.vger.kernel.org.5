Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FF0754438
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGNVgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGNVgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:36:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0173585;
        Fri, 14 Jul 2023 14:36:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b9cdef8619so15618975ad.0;
        Fri, 14 Jul 2023 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689370578; x=1691962578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TmEIC2uOQWMGdSXi/s9FCQP4FKhvkW7TusIhlJLLWXA=;
        b=RRHAJcjIqpaMbbHPglhj4IAw2TVt8KST+G56PjDlPKo9u70i176XTpLLob2PbnY2sA
         /zXRb9AYgopppOD2jauRVQjPrc7OkN/0lQmAU1wxNhuFUCU4w0FjY5VlRLjYluTAK+gk
         peKikL7UaOqMVBKqKaeqox8WSnVfOYiD9ECmRGdaDk1vAmVenAgQTGXGwzIai33MuvO7
         MICx64BC75DxkFSUwSfP/hir+GrqrFSnGF6YgQ7R1iTbMDor1hSZU97FhKMZnZjsYmQm
         sjztv2zIOB73kaGQ+YnMh/ziHl3ae+8bVxJZikOVc9f9xNwFfVsqOxlkB+2tLX+SvEkq
         eFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689370578; x=1691962578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmEIC2uOQWMGdSXi/s9FCQP4FKhvkW7TusIhlJLLWXA=;
        b=NNkWPR06lbIydS5RRiYMTKPp8wOY5NOc55ft972xMobkrie0uLWTPUGkB/wAYy6Knu
         SM6PuZmaeLRrVmIlRixzJpJDeaNKCQOFWlmHTJvoW2e7qBEE6AY5OQ+r1mEUtmFm0llN
         05UCxG6dQGhXUANxM2WFHL7JpwlZ3Mfkeu6AYZye5y/kMxUVd2rb757kWAbZmX0uY1tC
         wBdipM3ezu/OVAUUxyHGVgLdF2OZO/cW7iw2dKJmXWzxLHganq6hmfrn4YukzW9yLmic
         pwiIR0Pny9RAB7x8VpcHfsLMZpaebt20ZXvHA2LXd/+ee19nOnU1d2BW1ZAbAxRfrtDz
         jSVA==
X-Gm-Message-State: ABy/qLapPIm3i//bFBw+vnep9htXuWrhDVQWau37ZIaIH/q51GXWXpAf
        LsuatMLPo0NbH/HCDDXjMAr0+sL2VgQOE/zO
X-Google-Smtp-Source: APBJJlHkV0nEMnJUoLk1MsdBUbdHqbDSejDQZIYTSxLEpA0TZlxFU41GHog+zkgBTM2Po/FDeVOC0g==
X-Received: by 2002:a17:902:c381:b0:1b8:9db5:2ec1 with SMTP id g1-20020a170902c38100b001b89db52ec1mr4133373plg.67.1689370577685;
        Fri, 14 Jul 2023 14:36:17 -0700 (PDT)
Received: from yoga ([2400:1f00:13:8030:52d1:71af:18b3:54f1])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b9c5e07bc3sm5865940plw.238.2023.07.14.14.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 14:36:17 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Sat, 15 Jul 2023 03:06:09 +0530
To:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, anupnewsmail@gmail.com
Subject: Re: [PATCH v3 0/6] Add support for Firefox's gecko profile format
Message-ID: <ZLG/yVndGkFTuA2o@yoga>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689024635.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 04:38:06AM +0530, Anup Sharma wrote:
> This patch series adds support for Firefox's gecko profile format.
> The format is documented here [1].
> 
> I have incorporated several changes based on feedback from the
> previous version of the patch. However, there are still a few
> remaining comments that I am currently addressing.
> 
> Additionally, I am still in the process of learning how to send
> patches in a series, so there may be some shortcomings in this
> particular series as well.
> 
> changes from v2:
> - renamed mod to func
> - removed unnessecary imports print_function
> - removed shebang python env declaration
> - changed _createtread to _createThread
> - Commits in better order.

Hello everyone, I wanted to express my gratitude for your support.
I recently received an email from GSoC admin informing me that I
have successfully passed my midterm evaluation. I am thrilled about
this news!. Ian, could you please provide some insights on the commit
arrangement in v3 compared to v2? I noticed in v3, on 1/6 you have
mentioned regarding the commit arrangement. I want to make sure I
haven't overlooked. Currently, I'm focusing on developing the next
version of patches, so having this information would be extremely
beneficial to me. Thank you in advance!

> [1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
> 
> Anup Sharma (6):
>   scripts: python: Add initial script file with imports.
>   scripts: python: Extact necessary information from process event
>   scripts: python: thread sample processing to create thread with
>     schemas
>   scripts: python: Add trace end processing and JSON output
>   scripts: python: Implement add sample function and return finish
>   scripts: python: implement get or create frame and stack function
> 
>  .../scripts/python/firefox-gecko-converter.py | 221 ++++++++++++++++++
>  1 file changed, 221 insertions(+)
>  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
> 
> -- 
> 2.34.1
> 
