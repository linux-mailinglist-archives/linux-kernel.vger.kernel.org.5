Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF57789B89
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjH0G0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjH0G00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 02:26:26 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF0B183;
        Sat, 26 Aug 2023 23:26:24 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bcac140aaaso1699659a34.2;
        Sat, 26 Aug 2023 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693117584; x=1693722384;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=is4hdEOI3RMC28ap7RXYRRn6XWAL9LuOlIIP2UK2EQk=;
        b=AjjdpOHvzg779w/Of0surKdzNRDpKMXy3ylVm6dM1w5Kz4JdNFUup9W7VPDvpHBFhd
         Ph/0bfvPoY5HRmfNIMS8oyhItl2/AljKrpmPAUJXUhZEIer8AAGq+E9bvd34pxA/T0eE
         x6WFG8iBVl7gm6XmhI8SPhU7HMxqcHTFirbQaGMGi4mlkGxsL9p5narZKuDcOu2vIKEs
         /HJxbkcvzIVd7xGlx/qe+y8XPkBA4cCBW9pAZWi3gy+FqW8v16FInYrS9TW4sHxRd0yC
         XzAPIksdEgk83r6Cbo60dB1fpHLCTjTg5JYmrPA27h/PtxoVxA7HuqrGAdagY+MxDOLN
         y8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693117584; x=1693722384;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=is4hdEOI3RMC28ap7RXYRRn6XWAL9LuOlIIP2UK2EQk=;
        b=M1EvBFbR1MUDK6T22JZwCThl4IFZLs81vX2/aUU5iEB/6NHipHZIXkIStHU/edy6ah
         R5GdsqOsFN4o9Gh+kZhI3sMJeVMTK1huyHdzjRWRKb5aZtI1y2CbkUaJIFmJgL1AeY97
         J+SU46uJ2BdDhYawnBYZreNEV0JvarIdxZpDKv38D9u0MHaFJrNdD4qae/3YeV7lJIk4
         Ib+9JmxLWlw3G3r90z6Wjxac1V3Auq+ioTa4/3ClZ2kSNXkcXHwNOWiWSnYXjyIbyNG6
         xVBAKpHsid8J29CZDP4iVHid/7WDF6y7YhmSgnXN5uips9fXHjA6UTxN8XcibmKJLnjr
         tl7w==
X-Gm-Message-State: AOJu0YxJVJ6cfJke1XwP/H7gD5UwjrTxf24SSAqETWCkHz2gsam+/2qv
        kBFFs3l2TZvxGa1sHVg1FGIoMa+TcQ5bxHO6
X-Google-Smtp-Source: AGHT+IGX6VzJTxTXQ9al6dPCPbl1CP2jEd1WjWsEJ289iODA18d7miCRF+f+vYUhxB/CrGwoToljDw==
X-Received: by 2002:a05:6830:45:b0:6b7:4a52:a33a with SMTP id d5-20020a056830004500b006b74a52a33amr9632937otp.14.1693117583908;
        Sat, 26 Aug 2023 23:26:23 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c560:3cd7:28f4:78dd:ed95])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709029b8100b001b86492d724sm244009plp.223.2023.08.26.23.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 23:26:23 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Sun, 27 Aug 2023 11:56:17 +0530
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anupnewsmail@gmail.com
Subject: [GSoC 23] Adding Support for Gecko Converter: Final Report
Message-ID: <ZOrsiZA+C0zbWEQS@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Perf Tool  Community,

I hope this email finds you well. I'm excited to share the final report
for the "Perf Data Converter" project, which I had the privilege to
work on as part of the Google Summer of Code 2023 program.
This project aimed to enhance the capabilities of the perf tool by adding
support for the Gecko converter, and I'm pleased to present the outcomes
of my efforts.

Project Title: Perf Data Converter
Organization: Linux Perf Tool, Linux Foundation, Google Summer of Code 2023
GitHub: https://github.com/TwilightTechie

Final Report Link: https://gist.github.com/TwilightTechie/94f6fc54413e7d88b751615ff280af17
Short Presentation: https://www.youtube.com/watch?v=kfQLnkX3U2Y
(will make it public very soon, looking for feedbacks).

Throughout the summer, I collaborated closely with you all and other
contributors to successfully integrate the Gecko converter into the
perf tool. This integration enables effortless analysis using the
Firefox profiler and streamlines the process of performance analysis.
Notably, the project includes the addition of support to launch the
profiler UI on the default browser, enhancing the user experience.

Key Achievements:

- Gecko Converter Integration
- Profiler UI Launch Support
- Comprehensive Testing and Test Coverage
- Command Line Flexibility
- Process Visualization Options

I invite you to read the detailed final report to learn more about
the project's achievements, contributions, and the next steps. Your
feedback and insights are highly valuable to me as I continue to
contribute to the Linux Perf Tool community.

I would like to express my gratitude to the entire community for the
support and guidance I received throughout this journey. Your contributions
and feedback have been instrumental in making this project a success.

I am thankful for the opportunity to be part of this dynamic and collaborative
community, and I look forward to your thoughts on the final report.

Best regards,
Anup Sharma
