Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A757D8755
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbjJZRL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJZRLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:11:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35427D43;
        Thu, 26 Oct 2023 10:11:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso844448b3a.1;
        Thu, 26 Oct 2023 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698340281; x=1698945081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFNvVAbx08/DrQAY4pWSijv9p7sBshq6k5IYqo9j+O0=;
        b=NWurleqA5jII/7qscyqKsFTPezSAeGgKz7rJMqdIYrzsFgGYkcHZT+DoUMQUYGJ0qA
         f7AOpwKHluFrZ3/e4r7eJYfUwl+crd7q0a9Scldj0D/YDnbl3q15vDSZitI0LMTY49DQ
         pXwhk03LEbgLPHbcTvoMFnx1tXlqqwg1grrM0C3LdGh88AROFxhiLq8Ik35g03/n8X7d
         ZdxdUbAJarZhe83sLJ1LfyMB/XqMZ2YBuw5IyXzuM5jRbwQpdKfXuflbyMGsHmxy486b
         5xkYFdpSgqTRFu0AAGFRUDGJfJTIFfKSQakjQZ8TD+1coJc+HmfGsza8d8D5wYPGAZ2c
         j4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340281; x=1698945081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KFNvVAbx08/DrQAY4pWSijv9p7sBshq6k5IYqo9j+O0=;
        b=XSNd+hKNf8fhuC0kXdYdWm16RaCw8nBNSd4TjOmN5d8mS1ZsTaYJDPwtW9Xbl7ZUF+
         oRfZOcybsBs0PFQf1P9OBaBXccuEvWYKBaTbbxJZp8rIg+06OpP7WH1Fex3yhrAqAcU6
         U8dKnoxBcd/5AbJLZL4Ffd3wvzdnkqHzhTwVmQ6Lu8RUzyg9oxMQl5d5vVj+L5w6G5sY
         VvnrM3J9yXcAV324hVmXbWawdO/jUDI2Tsxe6adCHjXu6imwvcGwfZQK7eOI6PSticPB
         JSexAZSlsZfaQORmHhFZAFLClJrEtIiV6wPpwXwcGMRefF/CP5iOC9lcNk3oZf6lI8pg
         MmFA==
X-Gm-Message-State: AOJu0YwtGQ2j83GcaPOhaYD3Txp8dtsTEMvBgA/+nEUTbkousc6apxVf
        tCjYYo3JE7cUH1mACfObtuLMc+6k2N8=
X-Google-Smtp-Source: AGHT+IH5ue2qCyCaQ8EWK2Mm2mpv6yJZ56Zy4N/See2pf6nmdZ5liva45zbhB9WlYRdLXAlzSUEY9w==
X-Received: by 2002:a05:6a00:1da4:b0:68f:a92a:8509 with SMTP id z36-20020a056a001da400b0068fa92a8509mr4303916pfw.7.1698340281582;
        Thu, 26 Oct 2023 10:11:21 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ec51:cb82:a169:2ada])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b00688965c5227sm11356315pfh.120.2023.10.26.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:11:21 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Nick Terrell <terrelln@fb.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>
Subject: Re: (subset) [PATCH v3 00/50] Improvements to memory use
Date:   Thu, 26 Oct 2023 10:11:09 -0700
Message-ID: <169833996405.1181734.469130152279733524.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
References: <20231024222353.3024098-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 15:23:03 -0700, Ian Rogers wrote:
> Fix memory leaks detected by address/leak sanitizer affecting LBR
> call-graphs, perf mem and BPF offcpu.
> 
> Make branch_type_stat in callchain_list optional as it is large and
> not always necessary - in particular it isn't used by perf top.
> 
> Make the allocations of zstd streams, kernel symbols and event copies
> lazier in order to save memory in cases like perf record.
> 
> [...]

Applied the first 11 patches to perf-tool-next, thanks!

